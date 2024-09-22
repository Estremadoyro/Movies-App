//
//  ComponentsTests.swift
//  MoviesAppTests
//
//  Created by Leonardo on 9/22/24.
//

import XCTest

@testable import MoviesApp
final class ComponentsTests: XCTestCase {
    func testFileReader() {
        /// # GIVEN
        let fileName = "movies-popular"
        let fileExtension = "txt"
        /// # WHEN
        let rawFile: String? = FileReader.read(filename: fileName, type: fileExtension)
        /// # THEN
        XCTAssertNotNil(rawFile)
    }
}
