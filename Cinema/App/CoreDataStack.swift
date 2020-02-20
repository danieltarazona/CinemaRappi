//
//  CoreDataStack.swift
//  Cinema
//
//  Created by Daniel Tarazona on 2/6/20.
//  Copyright © 2020 Daniel Tarazona. All rights reserved.
//

import CoreData

class CoreDataStack {

  private init() {}
  static let shared = CoreDataStack()

  // MARK: - Core Data stack

  lazy var persistentContainer: NSPersistentContainer = {

    let container = NSPersistentContainer(name: "Cinema")

    container.loadPersistentStores(completionHandler: { (_, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })

    return container
  }()

  lazy var context = persistentContainer.viewContext

  // MARK: - Core Data Saving support

  func save () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }

  // MARK: - Core Data Fetch support

  func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {

    let entityName = String(describing: objectType)
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)

    do {
      let fetchedObjects = try context.fetch(fetchRequest) as? [T]
      return fetchedObjects ?? [T]()
    } catch {
      return [T]()
    }
  }

  static func deleteAllData(_ entity: String) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    fetchRequest.returnsObjectsAsFaults = false
    do {
      let context = CoreDataStack.shared.persistentContainer.viewContext
      let results = try context.fetch(fetchRequest)
      for object in results {
        guard let objectData = object as? NSManagedObject else {continue}
        context.delete(objectData)
      }
    } catch let error {
      print("COREDATA Error ", error)
    }
  }
}

// MARK: CodingUserInfoKey

extension CodingUserInfoKey {
  static let context = CodingUserInfoKey(rawValue: "context")
}
