//
//  AppHelpers.swift
//  Cinema
//
//  Created by Daniel Tarazona on 2/16/20.
//  Copyright © 2020 Daniel Tarazona. All rights reserved.
//

import Foundation

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
  let decoder = JSONDecoder()
  decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
    let container = try decoder.singleValueContainer()
    let dateStr = try container.decode(String.self)

    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
    if let date = formatter.date(from: dateStr) {
      return date
    }
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
    if let date = formatter.date(from: dateStr) {
      return date
    }
    throw DecodingError.typeMismatch(
      Date.self,
      DecodingError.Context(
        codingPath: decoder.codingPath,
        debugDescription: "Could not decode date"
      )
    )
  })
  return decoder
}

func newJSONEncoder() -> JSONEncoder {
  let encoder = JSONEncoder()
  let formatter = DateFormatter()
  formatter.calendar = Calendar(identifier: .iso8601)
  formatter.locale = Locale(identifier: "en_US_POSIX")
  formatter.timeZone = TimeZone(secondsFromGMT: 0)
  formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
  encoder.dateEncodingStrategy = .formatted(formatter)
  return encoder
}

// MARK: - Encode/decode helpers

@objcMembers class JSONNull: NSObject, Codable {

  public static func isEqual(lhs: JSONNull, rhs: JSONNull) -> Bool {
    return lhs.isEqual(rhs)
  }

  override public init() {}

  public required init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if !container.decodeNil() {
      throw DecodingError.typeMismatch(
        JSONNull.self,
        DecodingError.Context(
          codingPath: decoder.codingPath,
          debugDescription: "Wrong type for JSONNull"
        )
      )
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encodeNil()
  }
}

extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(
      with: data,
      options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}
