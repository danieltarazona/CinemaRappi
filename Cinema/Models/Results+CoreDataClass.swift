//
//  Results.swift
//  Cinema
//
//  Created by Daniel Tarazona on 2/6/20.
//  Copyright © 2020 Daniel Tarazona. All rights reserved.
//

import Foundation
import CoreData

// MARK: - Result
@objc(Results)
public class Results: NSManagedObject, Codable {

  enum CodingKeys: String, CodingKey {
    case voteCount = "vote_count"
    case id = "id"
    case video = "video"
    case voteAverage = "vote_average"
    case title = "title"
    case popularity = "popularity"
    case posterPath = "poster_path"
    case objectId = "objectID"
    case originalTitle = "original_title"
    case backdropPath = "backdrop_path"
    case adult = "adult"
    case overview = "overview"
    case releaseDate = "release_date"
    case firstAirDate = "first_air_date"
    case name = "name"
  }

  required convenience public init(from decoder: Decoder) throws {

    guard let contextUserInfoKey = CodingUserInfoKey.context,
      let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
      let entity = NSEntityDescription.entity(forEntityName: "Results", in: managedObjectContext)
      else {
        fatalError("Fail Decode Results!")
    }

    self.init(entity: entity, insertInto: managedObjectContext)

    let values = try decoder.container(keyedBy: CodingKeys.self)

    voteCount = try values.decode(Int.self, forKey: .voteCount)
    id = try values.decode(Int.self, forKey: .id)
    video = try values.decodeIfPresent(Bool.self, forKey: .video) ?? false
    voteAverage = try values.decode(Double.self, forKey: .voteAverage)
    title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
    popularity = try values.decode(Double.self, forKey: .popularity)
    posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
    originalTitle = try values.decodeIfPresent(String.self, forKey: .originalTitle) ?? ""
    backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath) ?? ""
    objectId = try values.decodeIfPresent(String.self, forKey: .objectId) ?? ""
    adult = try values.decodeIfPresent(Bool.self, forKey: .adult) ?? false
    overview = try values.decodeIfPresent(String.self, forKey: .overview) ?? ""
    releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
    firstAirDate = try values.decodeIfPresent(String.self, forKey: .firstAirDate) ?? ""
    name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
  }

  public func encode(to encode: Encoder) throws {
    var container = encode.container(keyedBy: CodingKeys.self)
    try container.encode(voteCount, forKey: .voteCount)
    try container.encode(id, forKey: .id)
    try container.encode(video, forKey: .video)
    try container.encode(voteAverage, forKey: .voteAverage)
    try container.encode(title, forKey: .title)
    try container.encode(popularity, forKey: .popularity)
    try container.encode(posterPath, forKey: .posterPath)
    try container.encode(originalTitle, forKey: .originalTitle)
    try container.encode(backdropPath, forKey: .backdropPath)
    try container.encode(adult, forKey: .adult)
    try container.encode(overview, forKey: .overview)
    try container.encode(releaseDate, forKey: .releaseDate)
    try container.encode(firstAirDate, forKey: .firstAirDate)
    try container.encode(name, forKey: .name)
    try container.encode(objectId, forKey: .objectId)
  }
}

// MARK: Results convenience initializers and mutators

extension Results {

  @nonobjc public class func fetchRequest() -> NSFetchRequest<Results> {
    return NSFetchRequest<Results>(entityName: "Results")
  }

  @NSManaged public var voteCount: Int
  @NSManaged public var id: Int
  @NSManaged public var video: Bool
  @NSManaged public var voteAverage: Double
  @NSManaged public var popularity: Double
  @NSManaged public var title: String?
  @NSManaged public var posterPath: String?
  @NSManaged public var originalTitle: String?
  @NSManaged public var backdropPath: String?
  @NSManaged public var adult: Bool
  @NSManaged public var objectId: String?
  @NSManaged public var overview: String?
  @NSManaged public var releaseDate: String?
  @NSManaged public var firstAirDate: String?
  @NSManaged public var name: String?

  convenience init(
    voteCount: Int,
    id: Int,
    video: Bool,
    voteAverage: Double,
    title: String,
    popularity: Double,
    posterPath: String,
    objectId: String,
    originalTitle: String,
    backdropPath: String,
    adult: Bool,
    overview: String,
    releaseDate: String,
    firstAirDate: String,
    name: String
  ) {
    self.init()
    self.voteCount = voteCount
    self.id = id
    self.video = video
    self.voteAverage = voteAverage
    self.title = title
    self.popularity = popularity
    self.posterPath = posterPath
    self.objectId = objectId
    self.originalTitle = originalTitle
    self.backdropPath = backdropPath
    self.adult = adult
    self.overview = overview
    self.releaseDate = releaseDate
    self.firstAirDate = firstAirDate
    self.name = name
  }

  convenience init(data: Data) throws {
    let decode = try JSONDecoder().decode(Results.self, from: data)
    self.init(
      voteCount: decode.voteCount,
      id: decode.id,
      video: decode.video,
      voteAverage: decode.voteAverage,
      title: decode.title!,
      popularity: decode.popularity,
      posterPath: decode.posterPath!,
      objectId: decode.objectId!,
      originalTitle: decode.originalTitle!,
      backdropPath: decode.backdropPath!,
      adult: decode.adult,
      overview: decode.overview!,
      releaseDate: decode.releaseDate!,
      firstAirDate: decode.firstAirDate!,
      name: decode.name!
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

  func jsonData() throws -> Data {
    return try JSONEncoder().encode(self)
  }

  func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
    return String(data: try self.jsonData(), encoding: encoding)
  }
}
