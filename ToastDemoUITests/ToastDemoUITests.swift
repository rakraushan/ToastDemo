//
//  ToastDemoUITests.swift
//  ToastDemoUITests
//
//  Created by Raushan, Rakesh Kumar on 23/02/26.
//

import XCTest

final class ToastDemoUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
    
    @MainActor
    func testWelcomeToastAppearsOnLaunch() async throws {
        let app = XCUIApplication()
        app.launch()

        let welcome = app.staticTexts["Welcome to Toast Demo!"]
        XCTAssertTrue(welcome.waitForExistence(timeout: 3.0))
    }

    @MainActor
    func testSuccessToastShows() async throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons["✅ Success Toast"].tap()
        let toast = app.staticTexts["Operation completed successfully!"]
        XCTAssertTrue(toast.waitForExistence(timeout: 2.0))
    }

    @MainActor
    func testErrorToastShows() async throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons["❌ Error Toast"].tap()
        let toast = app.staticTexts["Something went wrong!"]
        XCTAssertTrue(toast.waitForExistence(timeout: 2.0))
    }

    @MainActor
    func testWarningToastShows() async throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons["⚠️ Warning Toast"].tap()
        let toast = app.staticTexts["Please check your input"]
        XCTAssertTrue(toast.waitForExistence(timeout: 2.0))
    }

    @MainActor
    func testInfoToastShows() async throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons["ℹ️ Info Toast"].tap()
        let toast = app.staticTexts["Here's some useful information"]
        XCTAssertTrue(toast.waitForExistence(timeout: 2.0))
    }

    @MainActor
    func testCustomMessageToast() async throws {
        let app = XCUIApplication()
        app.launch()

        let textField = app.textFields["Enter custom message"]
        XCTAssertTrue(textField.waitForExistence(timeout: 2.0))
        textField.tap()
        textField.typeText("Hello from Swift Testing")

        app.buttons["Show Custom Toast"].tap()
        
        let keyboard = app.keyboards.element
        if keyboard.exists {
            let returnKey = keyboard.buttons["Return"]
            if returnKey.exists { returnKey.tap() }
        }

        let customToast = app.staticTexts["Hello from Swift Testing"]
        XCTAssertTrue(customToast.waitForExistence(timeout: 2.0))
    }
}
