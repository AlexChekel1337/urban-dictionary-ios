//
//  PersistenceService.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 02.09.2023.
//  Copyright © 2023 Alexander Chekel. All rights reserved.
//

import CoreData

class PersistenceService {
    static let shared = PersistenceService()

    let container: NSPersistentCloudKitContainer

    private init() {
        container = NSPersistentCloudKitContainer(name: "UrbanDictionary")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
