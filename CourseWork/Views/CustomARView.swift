//
//  FocusARView.swift
//  CourseWork
//
//  Created by Andrew Landiak on 02.05.2022.
//

import RealityKit
import FocusEntity
import Combine
import ARKit

class CustomARView: ARView {
    var sceneObserver: Cancellable?
    var focusEntity: FocusEntity?
    
    required init(frame: CGRect) {
        super.init(frame: frame)
        self.focusEntity = FocusEntity(on: self, focus: .classic)
        self.configure()
    }
    
    required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }
        self.session.run(config)
    }
}

