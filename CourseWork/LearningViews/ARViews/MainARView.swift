//
//  MainARView.swift
//  CourseWork
//
//  Created by Andrew Landiak on 03.05.2022.
//

import SwiftUI
import RealityKit
import ARKit
import FocusEntity

struct MainARView : View {
    @State private var isPlacementEnabled = false
    @State private var selectedModel: Model?
    @State private var modelConfirmedForPlacement: Model?
    
    private var models: [Model] = {
        let filemanager = FileManager.default
        guard let path = Bundle.main.resourcePath, let files = try? filemanager.contentsOfDirectory(atPath: path) else {
            return []
        }
        var availableModels: [Model] = []
        for filename in files where
            filename.hasSuffix("usdz") {
                let modelname = filename.replacingOccurrences(of: ".usdz", with: "")
                let model = Model(modelName: modelname)
                availableModels.append(model)
        }
        return availableModels
    }()
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer(selectedModel: $selectedModel, modelConfirmedForPlacement: $modelConfirmedForPlacement)
            if self.isPlacementEnabled {
                ButtonPlacementView(isPlacementEnabled: self.$isPlacementEnabled, selectedModel: $selectedModel, modelConfirmedForPlacement: $modelConfirmedForPlacement)
            } else {
                ModelPickerView(isPlacementEnabled: self.$isPlacementEnabled, selectedModel: $selectedModel, models: self.models)
            }
        }.navigationBarTitleDisplayMode(.inline)
        .background(Color(red: 0.9843113725490196, green: 0.9294117647058824, blue: 0.8470588235294118))
    }
}


struct ARViewContainer: UIViewRepresentable {
    @Binding var selectedModel: Model?
    @Binding var modelConfirmedForPlacement: Model?
    func makeUIView(context: Context) -> CustomARView {
        let arView = CustomARView(frame: .zero)
        arView.sceneObserver = arView.scene.subscribe(to: SceneEvents.Update.self, { (event) in
        updateScene(for: arView)
        })
        return arView
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {}
    private func updateScene(for arView: CustomARView) {
        arView.focusEntity?.isEnabled = selectedModel != nil
        if let confirmedModel = modelConfirmedForPlacement, let modelEntity = confirmedModel.modelEntity {
            self.place(modelEntity, in: arView)
            self.modelConfirmedForPlacement = nil
        }
    }
    private func place(_ modelEntity: ModelEntity, in arView: ARView) {
        let clonedEntity = modelEntity.clone(recursive: true)
        clonedEntity.generateCollisionShapes(recursive: true)
        arView.installGestures([.translation, .rotation, .scale], for: clonedEntity)
        let anchorEntity = AnchorEntity(plane: .any)
        anchorEntity.addChild(clonedEntity)
        anchorEntity.name = "MyAnchor"
        
        arView.scene.addAnchor(anchorEntity)
        arView.enableObjectDeletion()
    }

}

class SceneManager: ObservableObject {
    @Published var isPersistenceAvailable: Bool = false
    @Published var anchorEntities: [AnchorEntity] = [] // Keeps track of anchorEntities (w/ modelEntities) in the scene.
    
    var shouldSaveSceneToFilesystem: Bool = false // Flag to trigger save scene to filesystem function
    var shouldLoadSceneFromFilesystem: Bool = false // Flag to trigger load scene from filesystem function
    
    lazy var persistenceUrl: URL = {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("arf.persistence")
        } catch {
            fatalError("Unable to get persistence URL: \(error.localizedDescription)")
        }
    }()
    
    // Verify that scene data can be loaded from filesystem
    var scenePersistenceData: Data? {
        return try? Data(contentsOf: persistenceUrl)
    }
}

extension ARView {
    func enableObjectDeletion() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recognizer:)))
        self.addGestureRecognizer(longPressGesture)
    }

    @objc func handleLongPress(recognizer: UILongPressGestureRecognizer) {
        let location = recognizer.location(in: self)
        if let entity = self.entity(at: location) {
            if let anchorEntity = entity.anchor, anchorEntity.name == "MyAnchor"{
                anchorEntity.removeFromParent()
            }
        }
    }
}
