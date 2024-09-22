//
//  CollectionExtensionsTests.swift
//  MoviesAppTests
//
//  Created by Leonardo on 9/22/24.
//

import XCTest

@testable import MoviesApp

final class CollectionExtensionsTests: XCTestCase {
    func testSafeSubscript() {
        /// # GIVEN
        let array = [1, 2, 3, 4, 5]
        /// # WHEN
        let i2 = array[safe: 2]
        let nilInt = array[safe: 5]
        /// # THEN
        XCTAssertEqual(i2, 3)
        XCTAssertNil(nilInt)
    }

    func testUnique() {
        /// # GIVEN
        struct Person: Hashable {
            let id: Int
            let name: String
        }
        let name = "leonardo"
        let people = [
            Person(id: 1, name: "\(name)-1"),
            Person(id: 2, name: "\(name)-2"),
            Person(id: 1, name: "\(name)-3")
        ]
        /// # WHEN
        let uniquePeople = people.unique { $0.id }
        /// # THEN
        XCTAssertEqual(uniquePeople.count, 2)
        XCTAssertEqual(uniquePeople.map { $0.name }, ["\(name)-1", "\(name)-2"])
    }

    func testSafeMutableSubscript() {
        /// # GIVEN
        var array = [1, 2, 3, 4, 5]
        /// # WHEN
        array[safe: 1] = 10
        /// # THEN
        XCTAssertEqual(array[1], 10)

        /// # WHEN
        array[safe: 5] = 20
        /// # THEN
        XCTAssertEqual(array, [1, 10, 3, 4, 5])
    }

    func testUpdateIdentifiableElement() {
        /// # GIVEN
        struct Person: Identifiable {
            let id: Int
            var name: String
        }
        var people = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob")
        ]
        /// # WHEN
        let updateWrapper = UpdateWrapper(property: \Person.name, newValue: "Charlie")
        let personToUpdate = Person(id: 1, name: "Alice")
        people.update(element: personToUpdate, update: updateWrapper)
        /// # THEN
        XCTAssertEqual(people[0].name, "Charlie")
    }
}
