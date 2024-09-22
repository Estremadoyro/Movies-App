//
//  CDMovie+CoreDataClass.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//
//

import CoreData
import Foundation

@objc(CDMovie)
public class CDMovie: NSManagedObject {
    convenience init(context: NSManagedObjectContext, movie: Movie) {
        self.init(context: context)
        self.uniqueId = movie.id
        self.title = movie.title
        self.posterPath = movie.posterPath
        self.backdropPath = movie.backdropPath
        if let voteAverage = movie.voteAverage {
            self.voteAverage = NSNumber(floatLiteral: voteAverage)
        }
        self.releaseDateStr = movie.releaseDate
        self.overview = movie.overview
        if let runtime = movie.runtime {
            self.runtime = NSNumber(integerLiteral: runtime)
        }
        self.genres = movie.genres.toData()
        self.video = movie.videos?.first?.toData()
        self.saveDate = .now
    }

    func toMovie() -> Movie {
        var voteDouble: Double?
        if let voteAverage {
            voteDouble = voteAverage.doubleValue
        }

        var runtimeInt: Int?
        if let runtime {
            runtimeInt = runtime.intValue
        }
        return Movie(
            id: uniqueId,
            title: title,
            posterPath: posterPath,
            backdropPath: backdropPath,
            voteAverage: voteDouble,
            releaseDate: releaseDateStr,
            overview: overview,
            runtime: runtimeInt,
            genres: try? genres?.toModel([MovieGenre].self),
            videos: try? video?.toModel([MovieVideo].self)
        )
    }
}
