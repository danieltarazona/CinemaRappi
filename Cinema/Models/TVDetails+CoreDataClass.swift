//
//  TVDetails+CoreDataClass.swift
//  Cinema
//
//  Created by Daniel Tarazona on 2/6/20.
//  Copyright © 2020 Daniel Tarazona. All rights reserved.
//

import Foundation
import CoreData

// MARK: - TVDetails
@objcMembers class TVDetails: NSObject, Codable {
  let backdropPath: String?
  let createdBy: [CreatedBy]?
  let episodeRunTime: [Int]?
  let firstAirDate: String?
  let genres: [Genre]?
  let homepage: String?
  let id: Int?
  let inProduction: Bool?
  let languages: [String]?
  let lastAirDate: String?
  let lastEpisodeToAir: LastEpisodeToAir?
  let name: String?
  let nextEpisodeToAir: JSONNull?
  let networks: [Network]?
  let numberOfEpisodes: Int?
  let numberOfSeasons: Int?
  let originCountry: [String]?
  let originalLanguage: String?
  let originalName: String?
  let overview: String?
  let popularity: Double?
  let posterPath: String?
  let productionCompanies: [Network]?
  let seasons: [Season]?
  let status: String?
  let type: String?
  let voteAverage: Double?
  let voteCount: Int?

  enum CodingKeys: String, CodingKey {
    case backdropPath = "backdrop_path"
    case createdBy = "created_by"
    case episodeRunTime = "episode_run_time"
    case firstAirDate = "first_air_date"
    case genres = "genres"
    case homepage = "homepage"
    case id = "id"
    case inProduction = "in_production"
    case languages = "languages"
    case lastAirDate = "last_air_date"
    case lastEpisodeToAir = "last_episode_to_air"
    case name = "name"
    case nextEpisodeToAir = "next_episode_to_air"
    case networks = "networks"
    case numberOfEpisodes = "number_of_episodes"
    case numberOfSeasons = "number_of_seasons"
    case originCountry = "origin_country"
    case originalLanguage = "original_language"
    case originalName = "original_name"
    case overview = "overview"
    case popularity = "popularity"
    case posterPath = "poster_path"
    case productionCompanies = "production_companies"
    case seasons = "seasons"
    case status = "status"
    case type = "type"
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }

  init(
    backdropPath: String?,
    createdBy: [CreatedBy]?,
    episodeRunTime: [Int]?,
    firstAirDate: String?,
    genres: [Genre]?,
    homepage: String?,
    id: Int?,
    inProduction: Bool?,
    languages: [String]?,
    lastAirDate: String?,
    lastEpisodeToAir: LastEpisodeToAir?,
    name: String?,
    nextEpisodeToAir: JSONNull?,
    networks: [Network]?,
    numberOfEpisodes: Int?,
    numberOfSeasons: Int?,
    originCountry: [String]?,
    originalLanguage: String?,
    originalName: String?,
    overview: String?,
    popularity: Double?,
    posterPath: String?,
    productionCompanies: [Network]?,
    seasons: [Season]?,
    status: String?,
    type: String?,
    voteAverage: Double?,
    voteCount: Int?
  ) {
    self.backdropPath = backdropPath
    self.createdBy = createdBy
    self.episodeRunTime = episodeRunTime
    self.firstAirDate = firstAirDate
    self.genres = genres
    self.homepage = homepage
    self.id = id
    self.inProduction = inProduction
    self.languages = languages
    self.lastAirDate = lastAirDate
    self.lastEpisodeToAir = lastEpisodeToAir
    self.name = name
    self.nextEpisodeToAir = nextEpisodeToAir
    self.networks = networks
    self.numberOfEpisodes = numberOfEpisodes
    self.numberOfSeasons = numberOfSeasons
    self.originCountry = originCountry
    self.originalLanguage = originalLanguage
    self.originalName = originalName
    self.overview = overview
    self.popularity = popularity
    self.posterPath = posterPath
    self.productionCompanies = productionCompanies
    self.seasons = seasons
    self.status = status
    self.type = type
    self.voteAverage = voteAverage
    self.voteCount = voteCount
  }
}

// MARK: TVDetails convenience initializers and mutators

extension TVDetails {
  convenience init(data: Data) throws {
    let me = try newJSONDecoder().decode(TVDetails.self, from: data)
    self.init(
      backdropPath: me.backdropPath,
      createdBy: me.createdBy,
      episodeRunTime: me.episodeRunTime,
      firstAirDate: me.firstAirDate,
      genres: me.genres,
      homepage: me.homepage,
      id: me.id,
      inProduction: me.inProduction,
      languages: me.languages,
      lastAirDate: me.lastAirDate,
      lastEpisodeToAir: me.lastEpisodeToAir,
      name: me.name,
      nextEpisodeToAir: me.nextEpisodeToAir,
      networks: me.networks,
      numberOfEpisodes: me.numberOfEpisodes,
      numberOfSeasons: me.numberOfSeasons,
      originCountry: me.originCountry,
      originalLanguage: me.originalLanguage,
      originalName: me.originalName,
      overview: me.overview,
      popularity: me.popularity,
      posterPath: me.posterPath,
      productionCompanies: me.productionCompanies,
      seasons: me.seasons,
      status: me.status,
      type: me.type,
      voteAverage: me.voteAverage,
      voteCount: me.voteCount
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
    backdropPath: String?? = nil,
    createdBy: [CreatedBy]?? = nil,
    episodeRunTime: [Int]?? = nil,
    firstAirDate: String?? = nil,
    genres: [Genre]?? = nil,
    homepage: String?? = nil,
    id: Int?? = nil,
    inProduction: Bool?? = nil,
    languages: [String]?? = nil,
    lastAirDate: String?? = nil,
    lastEpisodeToAir: LastEpisodeToAir?? = nil,
    name: String?? = nil,
    nextEpisodeToAir: JSONNull?? = nil,
    networks: [Network]?? = nil,
    numberOfEpisodes: Int?? = nil,
    numberOfSeasons: Int?? = nil,
    originCountry: [String]?? = nil,
    originalLanguage: String?? = nil,
    originalName: String?? = nil,
    overview: String?? = nil,
    popularity: Double?? = nil,
    posterPath: String?? = nil,
    productionCompanies: [Network]?? = nil,
    seasons: [Season]?? = nil,
    status: String?? = nil,
    type: String?? = nil,
    voteAverage: Double?? = nil,
    voteCount: Int?? = nil
  ) -> TVDetails {
    return TVDetails(
      backdropPath: backdropPath ?? self.backdropPath,
      createdBy: createdBy ?? self.createdBy,
      episodeRunTime: episodeRunTime ?? self.episodeRunTime,
      firstAirDate: firstAirDate ?? self.firstAirDate,
      genres: genres ?? self.genres,
      homepage: homepage ?? self.homepage,
      id: id ?? self.id,
      inProduction: inProduction ?? self.inProduction,
      languages: languages ?? self.languages,
      lastAirDate: lastAirDate ?? self.lastAirDate,
      lastEpisodeToAir: lastEpisodeToAir ?? self.lastEpisodeToAir,
      name: name ?? self.name,
      nextEpisodeToAir: nextEpisodeToAir ?? self.nextEpisodeToAir,
      networks: networks ?? self.networks,
      numberOfEpisodes: numberOfEpisodes ?? self.numberOfEpisodes,
      numberOfSeasons: numberOfSeasons ?? self.numberOfSeasons,
      originCountry: originCountry ?? self.originCountry,
      originalLanguage: originalLanguage ?? self.originalLanguage,
      originalName: originalName ?? self.originalName,
      overview: overview ?? self.overview,
      popularity: popularity ?? self.popularity,
      posterPath: posterPath ?? self.posterPath,
      productionCompanies: productionCompanies ?? self.productionCompanies,
      seasons: seasons ?? self.seasons,
      status: status ?? self.status,
      type: type ?? self.type,
      voteAverage: voteAverage ?? self.voteAverage,
      voteCount: voteCount ?? self.voteCount
    )
  }

  func jsonData() throws -> Data {
    return try newJSONEncoder().encode(self)
  }

  func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
    return String(data: try self.jsonData(), encoding: encoding)
  }
}

// MARK: - CreatedBy
@objcMembers class CreatedBy: NSObject, Codable {
  let id: Int?
  let creditid: String?
  let name: String?
  let gender: Int?
  let profilePath: String?

  enum CodingKeys: String, CodingKey {
    case id = "id"
    case creditid = "credit_id"
    case name = "name"
    case gender = "gender"
    case profilePath = "profile_path"
  }

  init(id: Int?, creditid: String?, name: String?, gender: Int?, profilePath: String?) {
    self.id = id
    self.creditid = creditid
    self.name = name
    self.gender = gender
    self.profilePath = profilePath
  }
}

// MARK: CreatedBy convenience initializers and mutators

extension CreatedBy {
  convenience init(data: Data) throws {
    let me = try newJSONDecoder().decode(CreatedBy.self, from: data)
    self.init(
      id: me.id,
      creditid: me.creditid,
      name: me.name,
      gender: me.gender,
      profilePath: me.profilePath
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
    id: Int?? = nil,
    creditid: String?? = nil,
    name: String?? = nil,
    gender: Int?? = nil,
    profilePath: String?? = nil
  ) -> CreatedBy {
    return CreatedBy(
      id: id ?? self.id,
      creditid: creditid ?? self.creditid,
      name: name ?? self.name,
      gender: gender ?? self.gender,
      profilePath: profilePath ?? self.profilePath
    )
  }

  func jsonData() throws -> Data {
    return try newJSONEncoder().encode(self)
  }

  func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
    return String(data: try self.jsonData(), encoding: encoding)
  }
}

// MARK: - LastEpisodeToAir
@objcMembers class LastEpisodeToAir: NSObject, Codable {
  let airDate: String?
  let episodeNumber: Int?
  let id: Int?
  let name: String?
  let overview: String?
  let productionCode: String?
  let seasonNumber: Int?
  let showid: Int?
  let stillPath: String?
  let voteAverage: Double?
  let voteCount: Int?

  enum CodingKeys: String, CodingKey {
    case airDate = "air_date"
    case episodeNumber = "episode_number"
    case id = "id"
    case name = "name"
    case overview = "overview"
    case productionCode = "production_code"
    case seasonNumber = "season_number"
    case showid = "show_id"
    case stillPath = "still_path"
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }

  init(
    airDate: String?,
    episodeNumber: Int?,
    id: Int?,
    name: String?,
    overview: String?,
    productionCode: String?,
    seasonNumber: Int?,
    showid: Int?,
    stillPath: String?,
    voteAverage: Double?,
    voteCount: Int?
  ) {
    self.airDate = airDate
    self.episodeNumber = episodeNumber
    self.id = id
    self.name = name
    self.overview = overview
    self.productionCode = productionCode
    self.seasonNumber = seasonNumber
    self.showid = showid
    self.stillPath = stillPath
    self.voteAverage = voteAverage
    self.voteCount = voteCount
  }
}

// MARK: LastEpisodeToAir convenience initializers and mutators

extension LastEpisodeToAir {
  convenience init(data: Data) throws {
    let me = try newJSONDecoder().decode(LastEpisodeToAir.self, from: data)
    self.init(
      airDate: me.airDate,
      episodeNumber: me.episodeNumber,
      id: me.id,
      name: me.name,
      overview: me.overview,
      productionCode: me.productionCode,
      seasonNumber: me.seasonNumber,
      showid: me.showid,
      stillPath: me.stillPath,
      voteAverage: me.voteAverage,
      voteCount: me.voteCount
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
    episodeNumber: Int?? = nil,
    id: Int?? = nil,
    name: String?? = nil,
    overview: String?? = nil,
    productionCode: String?? = nil,
    seasonNumber: Int?? = nil,
    showid: Int?? = nil,
    stillPath: String?? = nil,
    voteAverage: Double?? = nil,
    voteCount: Int?? = nil
  ) -> LastEpisodeToAir {
    return LastEpisodeToAir(
      airDate: airDate ?? self.airDate,
      episodeNumber: episodeNumber ?? self.episodeNumber,
      id: id ?? self.id,
      name: name ?? self.name,
      overview: overview ?? self.overview,
      productionCode: productionCode ?? self.productionCode,
      seasonNumber: seasonNumber ?? self.seasonNumber,
      showid: showid ?? self.showid,
      stillPath: stillPath ?? self.stillPath,
      voteAverage: voteAverage ?? self.voteAverage,
      voteCount: voteCount ?? self.voteCount
    )
  }

  func jsonData() throws -> Data {
    return try newJSONEncoder().encode(self)
  }

  func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
    return String(data: try self.jsonData(), encoding: encoding)
  }
}

// MARK: - Network
@objcMembers class Network: NSObject, Codable {
  let name: String?
  let id: Int?
  let logoPath: String?
  let originCountry: String?

  enum CodingKeys: String, CodingKey {
    case name = "name"
    case id = "id"
    case logoPath = "logo_path"
    case originCountry = "origin_country"
  }

  init(name: String?, id: Int?, logoPath: String?, originCountry: String?) {
    self.name = name
    self.id = id
    self.logoPath = logoPath
    self.originCountry = originCountry
  }
}

// MARK: Network convenience initializers and mutators

extension Network {
  convenience init(data: Data) throws {
    let me = try newJSONDecoder().decode(Network.self, from: data)
    self.init(name: me.name, id: me.id, logoPath: me.logoPath, originCountry: me.originCountry)
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
    name: String?? = nil,
    id: Int?? = nil,
    logoPath: String?? = nil,
    originCountry: String?? = nil
  ) -> Network {
    return Network(
      name: name ?? self.name,
      id: id ?? self.id,
      logoPath: logoPath ?? self.logoPath,
      originCountry: originCountry ?? self.originCountry
    )
  }

  func jsonData() throws -> Data {
    return try newJSONEncoder().encode(self)
  }

  func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
    return String(data: try self.jsonData(), encoding: encoding)
  }
}

// MARK: - URLSession response handlers

extension URLSession {
  fileprivate func codableTask<T: Codable>(
    with url: URL,
    completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
    return self.dataTask(with: url) { data, response, error in
      guard let data = data, error == nil else {
        completionHandler(nil, response, error)
        return
      }
      completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
    }
  }

  func tVDetailsTask(
    with url: URL,
    completionHandler: @escaping (TVDetails?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
    return self.codableTask(with: url, completionHandler: completionHandler)
  }
}
