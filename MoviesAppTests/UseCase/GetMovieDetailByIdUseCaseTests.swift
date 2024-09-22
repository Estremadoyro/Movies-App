//
//  GetMovieDetailByIdUseCaseTests.swift
//  MoviesAppTests
//
//  Created by Leonardo on 9/22/24.
//

import Combine
import XCTest

@testable import MoviesApp

final class GetMovieDetailByIdUseCaseTests: XCTestCase {
    var useCase: GetMovieDetailByIdUseCase?
    var cancellable: AnyCancellable?

    override func setUp() {
        super.setUp()
        useCase = GetMovieDetailByIdUseCase(repository: MoviesRemoteRepositoryMock())
    }

    override func tearDown() {
        useCase = nil
        cancellable = nil
        super.tearDown()
    }

    func testMovieDetailHasAdditionalProperties() {
        guard let useCase else { XCTFail("UseCase cannot be nil"); return }
        /// # GIVEN
        let expectation = self.expectation(description: "Detailed movie should contain additional properties.")
        /// # WHEN
        cancellable = useCase.execute(movieId: 999)
            .sink { (completion) in
                guard case .failure = completion else { return }
                XCTFail("Error reading mock file")
            } receiveValue: { (detailedMovie) in
                /// # THEN
                XCTAssertTrue(
                    detailedMovie.genres.isNotNil
                        || detailedMovie.runtime.isNotNil
                        || detailedMovie.videos.isNotNil,
                    "The detailed movie does not contain additional properties :("
                )
                expectation.fulfill()
            }
        waitForExpectations(timeout: 3, handler: nil)
    }
}
