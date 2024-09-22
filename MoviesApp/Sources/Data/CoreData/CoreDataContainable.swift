//
//  CoreDataContainable.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import CoreData

protocol CoreDataContainable: NSPersistentContainer {}

extension CoreDataContainable {
    func saveContext(_ bgContext: NSManagedObjectContext? = nil) {
        let context = bgContext ?? viewContext
        guard context.hasChanges else {
            Logger.log(.coreData, .other, msg: "Tried to update context but there were no changes.")
            return
        }

        do {
            try context.save()
        } catch let error as NSError {
            Logger.log(.coreData, .error, msg: "\(error), \(error.userInfo)")
        }
    }
}
