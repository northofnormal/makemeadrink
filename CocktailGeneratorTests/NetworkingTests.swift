//
//  NetworkingTests.swift
//  CocktailGenerator
//
//  Created by Anne Cahalan on 10/31/17.
//  Copyright © 2017 Anne Cahalan. All rights reserved.
//

import OHHTTPStubs
import XCTest

@testable import CocktailGenerator

class Networking: XCTestCase {
    
    // it's cool to force unwrap this, we make a new one with every test in setUp()
    var jsonParser: JSONParser!
    
    override func setUp() {
        super.setUp()
        
        jsonParser = JSONParser()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    // starts with test, reference the method under test and what exactly we're testing
    func testFetchIndexFetchesTheDrinkIndex() {
        stub(condition: isHost("www.thecocktaildb.com")) { _ in
            let indexFilePath = OHPathForFile("indexResponse", type(of: self))
        
            return fixture(filePath: indexFilePath!, headers: nil)
        }
        
        let testExpectation = expectation(description: "Fetch completes")
        
        jsonParser.fetchIndex() { result in
            testExpectation.fulfill()
            
            XCTAssertEqual(result?.count, 64)
            
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
}
