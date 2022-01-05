//
//  OEDTests.swift
//  TyperaTests
//
//  Created by Hunter Holland on 12/31/21.
//

import XCTest
@testable import Typera

class OEDTests: XCTestCase {
    
    func testSetup() throws {
//        let fetcher = OEDWordFetcher()
        // TODO: Implement me!
    }
    
    func testCreateURL() throws {
        // TODO: Implement me!
    }
    
    func testFetchWordData() throws {
        let fetcher = OEDWordFetcher()
        fetcher.fetch(word: "banana")
    }
    
}
