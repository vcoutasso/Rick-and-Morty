//
//  RickAndMortyUITests.swift
//  RickAndMortyUITests
//
//  Created by Vinícius Couto on 14/10/21.
//

import XCTest

class RickAndMortyUITests: XCTestCase {
    private let app = XCUIApplication()

    // MARK: - Test lifecycle

    override func setUpWithError() throws {
        continueAfterFailure = false

        app.launchArguments.append("--uitesting")
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNavBarAndTableShouldExist() {
        XCTAssert(app.navigationBars.element.exists)
        XCTAssert(app.tables.element.exists)
    }

    // FIXME: Doesn't check if the activity indicator appears/disappears
    func testRefreshOnPull() {
        let firstCell = app.cells.firstMatch
        XCTAssert(firstCell.waitForExistence(timeout: 30))

        let start = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 6))
        start.press(forDuration: 1, thenDragTo: finish)
    }

    func testShouldShowDetailViewWhenCellTapped() throws {
        let name = "Abradolf Lincler"
        let abradolfCell = app.cells[name].firstMatch
        XCTAssert(abradolfCell.waitForExistence(timeout: 30))

        abradolfCell.tap()

        XCTAssert(app.otherElements[name].exists)
    }

    func testLaunchPerformance() throws {
        if #available(iOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
