//
//  ManageData.swift
//  CourseWork
//
//  Created by Andrew Landiak on 12.05.2022.
//

import Foundation
import UIKit
import CoreData

public class ManageData {
    
    static let shared = ManageData(moc: NSManagedObjectContext.current)
    
    var managedContext: NSManagedObjectContext
    
    private init(moc: NSManagedObjectContext) {
        self.managedContext = moc
    }
    
    func getAnimals() -> [Animal] {
        var animals = [Animal]()
        let bdRequest: NSFetchRequest<Animal> = Animal.fetchRequest()
        do {
            animals = try self.managedContext.fetch(bdRequest)
        } catch {
            print(error)
        }
        return animals
    }

    func addAnimal(id: UUID, name: String, origin: String, info: String, youtube: URL, size: String, classtype: String, age: String, weight: Double) {
        let an = Animal(context: self.managedContext)
        an.id = id
        an.name = name
        an.origin = origin
        an.info = info
        an.youtube = youtube
        an.classtype = classtype
        an.age = age
        an.weight = weight
        do {
            try self.managedContext.save()
        } catch {
            print(error)
        }
    }
    
    func removeAnimal(id: UUID) {
        let fetchRequest: NSFetchRequest<Animal> = Animal.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id=%@", id.uuidString)
        do {
            let deleteAnimal = try self.managedContext.fetch(fetchRequest)
            for deletedAnimal in deleteAnimal {
                self.managedContext.delete(deletedAnimal)
            }
            try self.managedContext.save()
        } catch {
          print(error)
        }
    }
    
    func updateAnimal(id: UUID, name: String, origin: String, info: String, youtube: URL, size: String, classtype: String, age: String, weight: Double) {
        let fetchRequest: NSFetchRequest<Animal> = Animal.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id=%@", id.uuidString)
        do {
            let animals = try self.managedContext.fetch(fetchRequest).first
            animals?.name = name
            animals?.origin = origin
            animals?.info = info
            animals?.youtube = youtube
            animals?.size = size
            animals?.classtype = classtype
            animals?.age = age
            animals?.weight = weight
            try self.managedContext.save()
        } catch {
            print(error)
        }
    }
    
}

extension NSManagedObjectContext {
    static var current: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
