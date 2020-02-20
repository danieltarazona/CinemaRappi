//
//  Videos+CoreDataClass.swift
//  Cinema
//
//  Created by Daniel Tarazona on 2/16/20.
//  Copyright © 2020 Daniel Tarazona. All rights reserved.
//

import Foundation

// MARK: - Videos
@objcMembers class Videos: NSObject, Codable {
  let id: Int?
  let results: [VideoResults]?

  enum CodingKeys: String, CodingKey {
    case id
    case results
  }

  init(id: Int?, results: [VideoResults]?) {
    self.id = id
    self.results = results
  }
}

// MARK: Videos convenience initializers and mutators

extension Videos {
  convenience init(data: Data) throws {
    let me = try newJSONDecoder().decode(Videos.self, from: data)
    self.init(id: me.id, results: me.results)
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
    id: Int?? = nil,
    results: [VideoResults]?? = nil
  ) -> Videos {
    return Videos(
      id: id ?? self.id,
      results: results ?? self.results
    )
  }

  func jsonData() throws -> Data {
    return try newJSONEncoder().encode(self)
  }

  func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
    return String(data: try self.jsonData(), encoding: encoding)
  }
}

// MARK: - Result
@objcMembers class VideoResults: NSObject, Codable {

  let id: String?
  let iso639_1: String?
  let iso3166_1: String?
  let key: String?
  let name: String?
  let site: String?
  let size: Int64?
  let type: String?

  enum CodingKeys: String, CodingKey {
    case id = "id"
    case iso639_1 = "iso_639_1"
    case iso3166_1 = "iso_3166_1"
    case key = "key"
    case name = "name"
    case site = "site"
    case size = "size"
    case type = "type"
  }

  init(
    id: String?,
    iso639_1: String?,
    iso3166_1: String?,
    key: String?,
    name: String?,
    site: String?,
    size: Int64?,
    type: String?
  ) {
    self.id = id
    self.iso639_1 = iso639_1
    self.iso3166_1 = iso3166_1
    self.key = key
    self.name = name
    self.site = site
    self.size = size
    self.type = type
  }
}

// MARK: Result convenience initializers and mutators

extension VideoResults {
  convenience init(data: Data) throws {
    let me = try newJSONDecoder().decode(VideoResults.self, from: data)
    self.init(
      id: me.id,
      iso639_1: me.iso639_1,
      iso3166_1: me.iso3166_1,
      key: me.key,
      name: me.name,
      site: me.site,
      size: me.size,
      type: me.type
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
    id: String?? = nil,
    iso639_1: String?? = nil,
    iso3166_1: String?? = nil,
    key: String?? = nil,
    name: String?? = nil,
    site: String?? = nil,
    size: Int64?? = nil,
    type: String?? = nil
  ) -> VideoResults {
    return VideoResults(
      id: id ?? self.id,
      iso639_1: iso639_1 ?? self.iso639_1,
      iso3166_1: iso3166_1 ?? self.iso3166_1,
      key: key ?? self.key,
      name: name ?? self.name,
      site: site ?? self.site,
      size: size ?? self.size,
      type: type ?? self.type
    )
  }

  func jsonData() throws -> Data {
    return try newJSONEncoder().encode(self)
  }

  func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
    return String(data: try self.jsonData(), encoding: encoding)
  }
}
