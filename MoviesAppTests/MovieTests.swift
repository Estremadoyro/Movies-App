//
//  MovieTests.swift
//  MoviesAppTests
//
//  Created by Leonardo on 9/22/24.
//

import XCTest

@testable import MoviesApp

final class MovieTests: XCTestCase {
    var movie: Movie?

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        movie = nil
        super.tearDown()
    }

    func testPosterURL() {
        /// # GIVEN
        movie = Movie(id: UUID().uuidString, posterPath: "/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg")
        /// # WHEN
        let posterFullPath = "https://image.tmdb.org/t/p/w300/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg"
        /// # THEN
        XCTAssert(movie?.posterURL?.absoluteString == posterFullPath, "URL concatenation incorrect.")
    }

    func testBackdropURL() {
        /// # GIVEN
        movie = Movie(id: UUID().uuidString, backdropPath: "/yDHYTfA3R0jFYba16jBB1ef8oIt.jpg")
        /// # WHEN
        let backdropFullPath = "https://image.tmdb.org/t/p/w780/yDHYTfA3R0jFYba16jBB1ef8oIt.jpg"
        /// # THEN
        XCTAssert(movie?.backdropURL?.absoluteString == backdropFullPath, "URL concatenation incorrect.")
    }

    func testYoutubeURL() {
        /// # GIVEN
        let video = MovieVideo(id: UUID().uuidString, youtubeKey: "tlFyyzXVEMk")
        movie = Movie(id: UUID().uuidString, videos: [video])
        /// # WHEN
        let youtubeVideoFullPath = "https://www.youtube.com/watch?v=tlFyyzXVEMk"
        /// # THEN
        XCTAssert(movie?.youtubeURL?.absoluteString == youtubeVideoFullPath, "Youtube link not formatted correctly.")
    }

    func testDateYearOnly() {
        /// # GIVEN
        let date = "1999-01-16"
        movie = Movie(id: UUID().uuidString, releaseDate: date)
        /// # WHEN
        let dateYearOnly = movie?.dateYearOnly
        /// # THEN
        XCTAssert(dateYearOnly == "1999", "Extraction of year incorrect.")
    }

    func testScoreParsed() {
        /// # GIVEN
        let voteAverage = 455.892
        movie = Movie(id: UUID().uuidString, voteAverage: voteAverage)
        /// # WHEN
        let scoreParsedAndRounded = movie?.scoreParsed
        /// # THEN
        XCTAssert(scoreParsedAndRounded == "455.9", "String formatting is incorrect.")
    }
}
