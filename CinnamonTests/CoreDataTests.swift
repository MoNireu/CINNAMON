//
//  CoreDataTests.swift
//  CinnamonTests
//
//  Created by MoNireu on 2022/04/05.
//

import XCTest
@testable import Cinnamon

class CoreDataTests: XCTestCase {

    let recipeStorage = ExtractRecipeDAO()
    let recipe = ExtractRecipeDummyData.extractRecipeList[0]
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExtractRecipeSave() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        XCTAssertTrue(recipeStorage.save(recipe: recipe))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testExtractRecipeDelete() throws {
        let deleteResult = recipeStorage.delete(recipe: recipe)
        print(recipeStorage.fetch())
        print(recipeStorage.fetch2())
        XCTAssertTrue(deleteResult)
    }

}
