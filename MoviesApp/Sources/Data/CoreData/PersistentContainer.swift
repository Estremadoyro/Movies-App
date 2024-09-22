//
//  PersistentContainer.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import CoreData

final class PersistentContainer: NSPersistentContainer, CoreDataContainable {
    private var context: NSManagedObjectContext { viewContext }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func getAll<T: NSManagedObject>(type: T.Type, filterBy ids: [String] = [], matchId: String = "uniqueId") -> [T] {
        let request = T.fetchRequest()
        request.predicate = ids.isEmpty ? nil : NSPredicate(format: "\(matchId) IN %@", ids)

        do {
            return try context.fetch(request) as? [T] ?? []
        } catch {
            Logger.log(.coreData, .error, msg: String(describing: error))
            return []
        }
    }

    func findFirst<T: NSManagedObject>(type: T.Type, uniqueId: String, matchId: String = "uniqueId") -> T? {
        let request = T.fetchRequest()
        request.predicate = NSPredicate(format: "\(matchId) == %@", uniqueId)
        do {
            return try context.fetch(request).first as? T
        } catch {
            Logger.log(.coreData, .error, msg: String(describing: error))
            return nil
        }
    }

    func delete<T: NSManagedObject>(objects: [T]) {
        for object in objects {
            context.delete(object)
        }
        saveContext()
    }
}
