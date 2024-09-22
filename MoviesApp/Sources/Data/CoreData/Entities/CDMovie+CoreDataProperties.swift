//
//  CDMovie+CoreDataProperties.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//
//

import CoreData
import Foundation

public extension CDMovie {
    @nonobjc class func fetchRequest() -> NSFetchRequest<CDMovie> {
        return NSFetchRequest<CDMovie>(entityName: "CDMovie")
    }

    @NSManaged var uniqueId: String
    @NSManaged var title: String?
    @NSManaged var voteAverage: NSNumber?
    @NSManaged var releaseDateStr: String?
    @NSManaged var overview: String?
    @NSManaged var posterPath: String?
    @NSManaged var backdropPath: String?
    @NSManaged var runtime: NSNumber?
    @NSManaged var genres: Data?
    @NSManaged var video: Data?
    @NSManaged var saveDate: Date
}

extension CDMovie: Identifiable {}
