//
//  GetMoviesByCategoryUseCaseTests.swift
//  MoviesAppTests
//
//  Created by Leonardo on 9/22/24.
//

import Combine
import XCTest

@testable import MoviesApp

final class GetMoviesByCategoryUseCaseTests: XCTestCase {
    var useCase: GetMoviesByCategoryUseCase?
    var cancellable: AnyCancellable?

    override func setUp() {
        super.setUp()
        useCase = GetMoviesByCategoryUseCase(repository: MoviesRemoteRepositoryMock())
    }

    override func tearDown() {
        useCase = nil
        cancellable = nil
        super.tearDown()
    }

    func testCategoryNowPlayingPrefix6() {
        guard let useCase else { XCTFail("UseCase cannot be nil"); return }
        /// # GIVEN
        let expectation = self.expectation(description: "Fetch Now playing movies up to 6 elements")
        /// # WHEN
        cancellable = useCase.execute(category: .nowPlaying, page: 1)
            .sink { (completion) in
                guard case .failure = completion else { return }
                XCTFail("Error reading mock file")
            } receiveValue: { (movies) in
                /// # THEN
                guard movies.count <= 6 else {
                    XCTFail("More than 6 items returned")
                    return
                }
                expectation.fulfill()
            }
        waitForExpectations(timeout: 3, handler: nil)
    }

    func testCategoryPopularNotEmpty() {
        guard let useCase else { XCTFail("UseCase cannot be nil"); return }
        /// # GIVEN
        let expectation = self.expectation(description: "Fetch Now playing movies up to 6 elements")
        /// # WHEN
        cancellable = useCase.execute(category: .popular, page: 1)
            .sink { (completion) in
                guard case .failure = completion else { return }
                XCTFail("Error reading mock file")
            } receiveValue: { (movies) in
                /// # THEN
                XCTAssert(!movies.isEmpty, "Category cannot be empty")
                expectation.fulfill()
            }
        waitForExpectations(timeout: 3, handler: nil)
    }
}
