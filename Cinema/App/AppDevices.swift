//
//  AppDevices.swift
//  Cinema
//
//  Created by Daniel Tarazona on 2/13/20.
//  Copyright © 2020 Daniel Tarazona. All rights reserved.
//

import Foundation
import UIKit

struct AppDevices {
  static let Height = Int(UIScreen.main.bounds.height)

  static var iPhoneSE: Bool {
    if Height <= 600 {
      return true
    }
    return false
  }

  static var iPhoneX: Bool {
    if Height > 600 && Height < 812 {
      return true
    }
    return false
  }

  static var iPhoneMaxPro: Bool {
    if Height >= 812 {
      return true
    }
    return false
  }
}
