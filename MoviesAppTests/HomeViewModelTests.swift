//
//  HomeViewModelTests.swift
//  MoviesAppTests
//
//  Created by Leonardo on 9/22/24.
//

import XCTest

@testable import MoviesApp

final class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel?
    
    override func setUp() {
        super.setUp()
        let useCase = GetMoviesByCategoryUseCase(repository: MoviesRemoteRepositoryMock())
        viewModel = HomeViewModel(getMoviesByCategoryUseCase: useCase)
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testFilterCorrectly() {
        guard let viewModel else { XCTFail("ViewModel cannot be nil"); return }
        /// # GIVEN
        guard let principalSection = viewModel.sections.first(where: { $0.type == .principal }),
              let popularCategory = principalSection.movieGroups.first(where: { $0.category == .popular }) else { return }
        let expectation = XCTestExpectation(description: "Did load movies")
        let timeInSeconds: Double = 3
        DispatchQueue.main.asyncAfter(deadline: .now() + timeInSeconds) {
            expectation.fulfill()
        }
        /// # WHEN
        viewModel.loadMovies(homeSection: principalSection, homeCategory: popularCategory)
        wait(for: [expectation], timeout: timeInSeconds + 1)
        viewModel.input = "wolverine"
        /// # THEN
        guard let movie = viewModel.visibleMovies.first else { XCTFail("Movies cannot be empty"); return }
        XCTAssert(viewModel.visibleMovies.count == 1)
        XCTAssert(movie.movie.title == "Deadpool & Wolverine")
    }
}
