//
//  LocalStorageTests.swift
//  MoviesAppTests
//
//  Created by Leonardo on 9/22/24.
//

import Foundation
import XCTest

@testable import MoviesApp

final class LocalStorageTests: XCTestCase {
    @LocalStorage(\.testKey) var testValue: String?
    
    override func setUp() {
        super.setUp()
        UserDefaults.standard.removeObject(forKey: LocalKeys().testKey)
    }
    
    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: LocalKeys().testKey)
        super.tearDown()
    }
    
    func testLoadReturnsNilForMissingValue() {
        /// # GIVEN
        let value = testValue
        XCTAssertNil(value, "Should be nil as no value has been set to it.")
    }

    func testSaveAndLoadStringValue() {
        /// # GIVEN
        let stringToSave = "water-works"
        /// # WHEN
        testValue = stringToSave
        /// # THEN
        let loadedValue = testValue
        XCTAssertEqual(loadedValue, stringToSave, "Value not the same as stored.")
    }
    
    func testSaveNilClearsValue() {
        /// # GIVEN
        let stringToSave = "temporal"
        testValue = stringToSave
        /// # WHEN
        testValue = nil
        /// # THEN
        let loadedValue = testValue
        XCTAssertNil(loadedValue, "Should be nil.")
    }
    
    func testInvalidTypeLoadReturnsNil() {
        /// # GIVEN
        let invalidValue = 12345
        UserDefaults.standard.set(invalidValue, forKey: LocalKeys().testKey)
        
        /// # WHEN
        let loadedValue = testValue
        
        /// #THEN
        XCTAssertNil(loadedValue, "Should be nil as the key's value differ.")
    }
}
