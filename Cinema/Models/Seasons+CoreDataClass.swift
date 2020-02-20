//
//  Seasons+CoreDataClass.swift
//  Cinema
//
//  Created by Daniel Tarazona on 2/6/20.
//  Copyright © 2020 Daniel Tarazona. All rights reserved.
//

import Foundation
import CoreData

// MARK: - Season
@objcMembers class Season: NSObject, Codable {
  let airDate: String?
  let episodeCount: Int?
  let id: Int?
  let name: String?
  let overview: String?
  let posterPath: String?
  let seasonNumber: Int?

  enum CodingKeys: String, CodingKey {
    case airDate = "air_date"
    case episodeCount = "episode_count"
    case id = "id"
    case name = "name"
    case overview = "overview"
    case posterPath = "poster_path"
    case seasonNumber = "season_number"
  }

  init(
    airDate: String?,
    episodeCount: Int?,
    id: Int?,
    name: String?,
    overview: String?,
    posterPath: String?,
    seasonNumber: Int?
  ) {
    self.airDate = airDate
    self.episodeCount = episodeCount
    self.id = id
    self.name = name
    self.overview = overview
    self.posterPath = posterPath
    self.seasonNumber = seasonNumber
  }
}

// MARK: Season convenience initializers and mutators

extension Season {
  convenience init(data: Data) throws {
    let me = try newJSONDecoder().decode(Season.self, from: data)
    self.init(
      airDate: me.airDate,
      episodeCount: me.episodeCount,
      id: me.id,
      name: me.name,
      overview: me.overview,
      posterPath: me.posterPath,
      seasonNumber: me.seasonNumber
    )
  }

  convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
    guard let data = json.data(using: encoding) else {
      throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
    }
    try self.init(data: data)
  }

  convenience init(fromURL url: URL) throws {
    try self.init(data: try Data(contentsOf: url))
  }

  func with(
    airDate: String?? = nil,
    episodeCount: Int?? = nil,
    id: Int?? = nil,
    name: String?? = nil,
    overview: String?? = nil,
    posterPath: String?? = nil,
    seasonNumber: Int?? = nil
  ) -> Season {
    return Season(
      airDate: airDate ?? self.airDate,
      episodeCount: episodeCount ?? self.episodeCount,
      id: id ?? self.id,
      name: name ?? self.name,
      overview: overview ?? self.overview,
      posterPath: posterPath ?? self.posterPath,
      seasonNumber: seasonNumber ?? self.seasonNumber
    )
  }

  func jsonData() throws -> Data {
    return try newJSONEncoder().encode(self)
  }

  func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
    return String(data: try self.jsonData(), encoding: encoding)
  }
}
