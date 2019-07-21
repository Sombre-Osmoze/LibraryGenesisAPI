//
//  LibGenTests.swift
//  LibGenAPITests
//
//  Created by Marcus Florentin on 05/06/2019.
//

import XCTest
@testable import LibGenAPI

class LibGenTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testDecodable() {
		guard let url = Bundle(for: Self.self).url(forResource: "LibGen", withExtension: "json") else {
			XCTFail("Can't file json test file")
			return
		}

		guard let data = try? Data(contentsOf: url) else {
			XCTFail("Can't extract data file")
			return
		}

		XCTAssertNoThrow(try JSONDecoder().decode(Book.self, from: data))
	}

}
