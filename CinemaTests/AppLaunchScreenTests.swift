//
//  AppLaunchScreenUnitTests.swift
//  CinemaTests
//
//  Created by Daniel Tarazona on 2/17/20.
//  Copyright © 2020 Daniel Tarazona. All rights reserved.
//

import XCTest
@testable import Cinema

class AppLaunchScreenTests: XCTestCase {

  override func setUp() {
  }

  override func tearDown() {
  }

  /**
  - Description: This test checks if the LaunchScreen.storyboard file exists
   and if loaded when the app is launched.
   */
  func testLaunchScreen() {
    let window = UIWindow(frame: UIScreen.main.bounds)
    let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)

    XCTAssertTrue(Bundle.main.isLoaded)
    XCTAssertNil(window.rootViewController, "Root Controller is Nil")
    XCTAssertNotNil(storyboard, "LaunchScreen.storyboard File Exists")

    window.rootViewController = UIStoryboard(name: "LaunchScreen", bundle: nil)
      .instantiateInitialViewController()

    window.makeKeyAndVisible()
    XCTAssertTrue(window.rootViewController!.isViewLoaded, "The Root Controller is Load")
  }

  /*
   Measure the time to set the initial controller
   */
  func testPerformanceLaunchScreen() {
    self.measure {
      testLaunchScreen()
    }
  }

}
