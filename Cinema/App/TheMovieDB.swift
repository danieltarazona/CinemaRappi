//
//  TheMovieDB.swift
//  Cinema
//
//  Created by Daniel Tarazona on 2/13/20.
//  Copyright © 2020 Daniel Tarazona. All rights reserved.
//

import Foundation

struct TheMovieDB {
  static let apiKey = Bundle.main.object(forInfoDictionaryKey: "THE_MOVIE_DB_API_KEY") as? String
}
