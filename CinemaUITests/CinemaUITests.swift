//
//  CinemaUITests.swift
//  CinemaUITests
//
//  Created by Daniel Tarazona on 2/6/20.
//  Copyright © 2020 Daniel Tarazona. All rights reserved.
//

import XCTest

class CinemaUITests: XCTestCase {

  let app = XCUIApplication()

  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    app.launch()
  }

  override func tearDown() {

  }

  func testMoviesCategories() {
    let elementsQuery = app.scrollViews.otherElements

    let topRatedButton = elementsQuery.buttons["Top Rated"]
    topRatedButton.tap()

    let popularButton = elementsQuery.buttons["Popular"]
    popularButton.tap()

    let upcomingButton = elementsQuery.buttons["Upcoming"]
    upcomingButton.tap()
  }

  func testSeriesCategories() {
    let elementsQuery = XCUIApplication().scrollViews.otherElements
    elementsQuery.buttons["Series"].tap()
    elementsQuery.buttons["Popular"].tap()
    elementsQuery.buttons["Top Rated"].tap()
  }

  func testSearchBar() {
    let staticTextsQuery = app.navigationBars.staticTexts
    staticTextsQuery.otherElements.children(matching: .searchField).element.tap()
    app.scrollViews.otherElements.buttons["Movies"].tap()
    staticTextsQuery.children(matching: .other).element.tap()
  }

  func testNextBackButton() {
    app.staticTexts["Page 1/500"].tap()

    let nextButton = app.buttons["NEXT"]
    nextButton.tap()
    nextButton.tap()
    nextButton.tap()
    nextButton.tap()
    app.staticTexts["Page 5/500"].tap()

    let prevButton = app.buttons["PREV"]
    prevButton.tap()
    prevButton.tap()
    prevButton.tap()
    prevButton.tap()

    app.staticTexts["Page 1/500"].tap()
  }

  func testPages() {
    let elementsQuery = app.scrollViews.otherElements

    let topRatedButton = elementsQuery.buttons["Top Rated"]
    topRatedButton.tap()
    let nextButton = app.buttons["NEXT"]
    nextButton.tap()

    let popularButton = elementsQuery.buttons["Popular"]
    popularButton.tap()
    nextButton.tap()
    nextButton.tap()
    nextButton.tap()

    let upcomingButton = elementsQuery.buttons["Upcoming"]
    upcomingButton.tap()
    nextButton.tap()
    nextButton.tap()
    nextButton.tap()
    nextButton.tap()
    nextButton.tap()

    topRatedButton.tap()
    app.staticTexts["Page 2/345"].tap()
    popularButton.tap()
    app.staticTexts["Page 4/500"].tap()
    upcomingButton.tap()
    app.staticTexts["Page 6/21"].tap()
  }

  func testLaunchPerformance() {
    if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
      // This measures how long it takes to launch your application.
      measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
        XCUIApplication().launch()
      }
    }
  }
}
