//
//  CoreDataManager.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import CoreData
import Foundation

final class CoreDataManager {
    let container: PersistentContainer

    static let shared = CoreDataManager()

    init() {
        container = PersistentContainer(name: AppConfig.coreDataName)
        container.loadPersistentStores { (desc, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            } else {
                Logger.log(.coreData, .success, msg: "Loaded store @ \(desc.url?.absoluteString ?? .empty)")
            }
        }
    }
}
