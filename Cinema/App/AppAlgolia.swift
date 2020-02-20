//  AppAlgolia.swift
//  Cinema
//
//  Created by Daniel Tarazona on 2/18/20.
//  Copyright © 2020 Daniel Tarazona. All rights reserved.
//

import Foundation

struct AppAlgolia {
  static let apiKey = Bundle.main.object(forInfoDictionaryKey: "ALGOLIA_API_KEY") as? String
  static let appId = Bundle.main.object(forInfoDictionaryKey: "ALGOLIA_APP_ID") as? String
  static let moviesIndex = Bundle.main.infoDictionary?[ "ALGOLIA_MOVIES_INDEX"] as? String
  static let tvIndex = Bundle.main.infoDictionary?[ "ALGOLIA_TV_INDEX"] as? String
}
