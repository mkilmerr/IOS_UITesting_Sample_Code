//
//  IOS_UITestingUITests.swift
//  IOS UITestingUITests
//
//  Created by Marcos Kilmer on 15/05/20.
//  Copyright © 2020 mkilmer. All rights reserved.
//

import XCTest

class IOS_UITestingUITests: XCTestCase {
    
    override func setUp(){
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        XCUIApplication().launch()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testValidLoginSuccess(){
        
        let app = XCUIApplication()
        
       
        
        let validPassword = "abc123"
        let validUsername = "CodePro"
        
        let profileNavBarButton =  app.navigationBars["Mockify Music"].buttons["Profile"]
        
        profileNavBarButton.tap()
        
        
        let usernameTextField =  app.textFields["Username"]
        XCTAssertTrue(usernameTextField.exists)
        usernameTextField.tap()
        
        usernameTextField.typeText(validUsername)
        
        
        let passwordTextField =   app.secureTextFields["Password"]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        
        passwordTextField.typeText(validPassword)
        
        app/*@START_MENU_TOKEN@*/.staticTexts["Login"]/*[[".buttons[\"Login\"].staticTexts[\"Login\"]",".staticTexts[\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let downloadCell = app.tables.staticTexts["My Downloads"]
        
        expectation(for: NSPredicate(format:"exists ==1 "), evaluatedWith: downloadCell, handler: nil)
        
        waitForExpectations(timeout: 5, handler: nil)
        
        downloadCell.tap()
        
    }
    
    func testInvalidLogin_missingCredentialsAlertIsShow(){
        
        let app = XCUIApplication()
        
     
        
        app.navigationBars["Mockify Music"].buttons["Profile"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Login"]/*[[".buttons[\"Login\"].staticTexts[\"Login\"]",".staticTexts[\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let missingAlert = app.alerts["Missing Credentials"]
        
        
        XCTAssertTrue(missingAlert.exists)
        
    }
    
    func testInvalidLogin_wrongPasswordAndUsername(){
        let app = XCUIApplication()
        
        let invalidPassword = "invalid"
        let invalidUsername = "invalid"
        
    
        
        
        
        app.navigationBars["Mockify Music"].buttons["Profile"].tap()
        let usernameTextField = app.textFields["Username"]
        
        XCTAssertTrue(usernameTextField.exists)
        
        usernameTextField.tap()
        
        usernameTextField.typeText(invalidUsername)
        
        let passwordTextField =   app.secureTextFields["Password"]
        XCTAssertTrue(passwordTextField.exists)
        
        passwordTextField.tap()
        
        passwordTextField.typeText(invalidPassword)
        
        app/*@START_MENU_TOKEN@*/.staticTexts["Login"]/*[[".buttons[\"Login\"].staticTexts[\"Login\"]",".staticTexts[\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let invalidCredentialsAlert =  app.alerts["Invalid Credentials"]
        
        //        expectation(for: NSPredicate(format:"exists == 1"), evaluatedWith: invalidCredentialsAlert, handler: nil)
        //
        //        waitForExpectations(timeout: 2, handler: nil)
        
        XCTAssertTrue(invalidCredentialsAlert.exists)
        
    }
    
    
    
    //    func testExample() throws {
    //        // UI tests must launch the application that they test.
    //        let app = XCUIApplication()
    //        app.launch()
    //
    //        // Use recording to get started writing UI tests.
    //        // Use XCTAssert and related functions to verify your tests produce the correct results.
    //    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
