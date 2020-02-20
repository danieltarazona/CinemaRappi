//
//  MoviesDetails+CoreDataClass.swift
//  Cinema
//
//  Created by Daniel Tarazona on 2/6/20.
//  Copyright © 2020 Daniel Tarazona. All rights reserved.
//

import Foundation
import CoreData

// MARK: - MoviesDetails
@objcMembers class MoviesDetails: NSObject, Codable {
  let adult: Bool?
  let backdropPath: String?
  let belongsToCollection: BelongsToCollection?
  let budget: Int?
  let genres: [Genre]?
  let homepage: String?
  let id: Int?
  let imdbid: String?
  let originalLanguage: String?
  let originalTitle: String?
  let overview: String?
  let popularity: Double?
  let posterPath: String?
  let productionCompanies: [ProductionCompany]?
  let productionCountries: [ProductionCountry]?
  let releaseDate: String?
  let revenue: Int?
  let runtime: Int?
  let spokenLanguages: [SpokenLanguage]?
  let status: String?
  let tagline: String?
  let title: String?
  let video: Bool?
  let voteAverage: Double?
  let voteCount: Int?

  enum CodingKeys: String, CodingKey {
    case adult = "adult"
    case backdropPath = "backdrop_path"
    case belongsToCollection = "belongs_to_collection"
    case budget = "budget"
    case genres = "genres"
    case homepage = "homepage"
    case id = "id"
    case imdbid = "imdb_id"
    case originalLanguage = "original_language"
    case originalTitle = "original_title"
    case overview = "overview"
    case popularity = "popularity"
    case posterPath = "poster_path"
    case productionCompanies = "production_companies"
    case productionCountries = "production_countries"
    case releaseDate = "release_date"
    case revenue = "revenue"
    case runtime = "runtime"
    case spokenLanguages = "spoken_languages"
    case status = "status"
    case tagline = "tagline"
    case title = "title"
    case video = "video"
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }

  init(
    adult: Bool?,
    backdropPath: String?,
    belongsToCollection: BelongsToCollection?,
    budget: Int?,
    genres: [Genre]?,
    homepage: String?,
    id: Int?,
    imdbid: String?,
    originalLanguage: String?,
    originalTitle: String?,
    overview: String?,
    popularity: Double?,
    posterPath: String?,
    productionCompanies: [ProductionCompany]?,
    productionCountries: [ProductionCountry]?,
    releaseDate: String?,
    revenue: Int?,
    runtime: Int?,
    spokenLanguages: [SpokenLanguage]?,
    status: String?,
    tagline: String?,
    title: String?,
    video: Bool?,
    voteAverage: Double?,
    voteCount: Int?
  ) {
    self.adult = adult
    self.backdropPath = backdropPath
    self.belongsToCollection = belongsToCollection
    self.budget = budget
    self.genres = genres
    self.homepage = homepage
    self.id = id
    self.imdbid = imdbid
    self.originalLanguage = originalLanguage
    self.originalTitle = originalTitle
    self.overview = overview
    self.popularity = popularity
    self.posterPath = posterPath
    self.productionCompanies = productionCompanies
    self.productionCountries = productionCountries
    self.releaseDate = releaseDate
    self.revenue = revenue
    self.runtime = runtime
    self.spokenLanguages = spokenLanguages
    self.status = status
    self.tagline = tagline
    self.title = title
    self.video = video
    self.voteAverage = voteAverage
    self.voteCount = voteCount
  }
}

// MARK: MoviesDetails convenience initializers and mutators

extension MoviesDetails {
  convenience init(data: Data) throws {
    let me = try newJSONDecoder().decode(MoviesDetails.self, from: data)
    self.init(
      adult: me.adult,
      backdropPath: me.backdropPath,
      belongsToCollection: me.belongsToCollection,
      budget: me.budget,
      genres: me.genres,
      homepage: me.homepage,
      id: me.id,
      imdbid: me.imdbid,
      originalLanguage: me.originalLanguage,
      originalTitle: me.originalTitle,
      overview: me.overview,
      popularity: me.popularity,
      posterPath: me.posterPath,
      productionCompanies: me.productionCompanies,
      productionCountries: me.productionCountries,
      releaseDate: me.releaseDate,
      revenue: me.revenue,
      runtime: me.runtime,
      spokenLanguages: me.spokenLanguages,
      status: me.status,
      tagline: me.tagline,
      title: me.title,
      video: me.video,
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
    adult: Bool?? = nil,
    backdropPath: String?? = nil,
    belongsToCollection: BelongsToCollection?? = nil,
    budget: Int?? = nil,
    genres: [Genre]?? = nil,
    homepage: String?? = nil,
    id: Int?? = nil,
    imdbid: String?? = nil,
    originalLanguage: String?? = nil,
    originalTitle: String?? = nil,
    overview: String?? = nil,
    popularity: Double?? = nil,
    posterPath: String?? = nil,
    productionCompanies: [ProductionCompany]?? = nil,
    productionCountries: [ProductionCountry]?? = nil,
    releaseDate: String?? = nil,
    revenue: Int?? = nil,
    runtime: Int?? = nil,
    spokenLanguages: [SpokenLanguage]?? = nil,
    status: String?? = nil,
    tagline: String?? = nil,
    title: String?? = nil,
    video: Bool?? = nil,
    voteAverage: Double?? = nil,
    voteCount: Int?? = nil
  ) -> MoviesDetails {
    return MoviesDetails(
      adult: adult ?? self.adult,
      backdropPath: backdropPath ?? self.backdropPath,
      belongsToCollection: belongsToCollection ?? self.belongsToCollection,
      budget: budget ?? self.budget,
      genres: genres ?? self.genres,
      homepage: homepage ?? self.homepage,
      id: id ?? self.id,
      imdbid: imdbid ?? self.imdbid,
      originalLanguage: originalLanguage ?? self.originalLanguage,
      originalTitle: originalTitle ?? self.originalTitle,
      overview: overview ?? self.overview,
      popularity: popularity ?? self.popularity,
      posterPath: posterPath ?? self.posterPath,
      productionCompanies: productionCompanies ?? self.productionCompanies,
      productionCountries: productionCountries ?? self.productionCountries,
      releaseDate: releaseDate ?? self.releaseDate,
      revenue: revenue ?? self.revenue,
      runtime: runtime ?? self.runtime,
      spokenLanguages: spokenLanguages ?? self.spokenLanguages,
      status: status ?? self.status,
      tagline: tagline ?? self.tagline,
      title: title ?? self.title,
      video: video ?? self.video,
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

// MARK: - BelongsToCollection
@objcMembers class BelongsToCollection: NSObject, Codable {
  let id: Int?
  let name: String?
  let posterPath: String?
  let backdropPath: String?

  enum CodingKeys: String, CodingKey {
    case id = "id"
    case name = "name"
    case posterPath = "poster_path"
    case backdropPath = "backdrop_path"
  }

  init(id: Int?, name: String?, posterPath: String?, backdropPath: String?) {
    self.id = id
    self.name = name
    self.posterPath = posterPath
    self.backdropPath = backdropPath
  }
}

// MARK: BelongsToCollection convenience initializers and mutators

extension BelongsToCollection {
  convenience init(data: Data) throws {
    let me = try newJSONDecoder().decode(BelongsToCollection.self, from: data)
    self.init(id: me.id, name: me.name, posterPath: me.posterPath, backdropPath: me.backdropPath)
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
    name: String?? = nil,
    posterPath: String?? = nil,
    backdropPath: String?? = nil
  ) -> BelongsToCollection {
    return BelongsToCollection(
      id: id ?? self.id,
      name: name ?? self.name,
      posterPath: posterPath ?? self.posterPath,
      backdropPath: backdropPath ?? self.backdropPath
    )
  }

  func jsonData() throws -> Data {
    return try newJSONEncoder().encode(self)
  }

  func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
    return String(data: try self.jsonData(), encoding: encoding)
  }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.genreTask(with: url) { genre, response, error in
//     if let genre = genre {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Genre
@objcMembers class Genre: NSObject, Codable {
  let id: Int?
  let name: String?

  enum CodingKeys: String, CodingKey {
    case id
    case name
  }

  init(id: Int?, name: String?) {
    self.id = id
    self.name = name
  }
}

// MARK: Genre convenience initializers and mutators

extension Genre {
  convenience init(data: Data) throws {
    let me = try newJSONDecoder().decode(Genre.self, from: data)
    self.init(id: me.id, name: me.name)
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
    name: String?? = nil
  ) -> Genre {
    return Genre(
      id: id ?? self.id,
      name: name ?? self.name
    )
  }

  func jsonData() throws -> Data {
    return try newJSONEncoder().encode(self)
  }

  func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
    return String(data: try self.jsonData(), encoding: encoding)
  }
}

// MARK: - ProductionCompany
@objcMembers class ProductionCompany: NSObject, Codable {
  let id: Int?
  let logoPath: String?
  let name: String?
  let originCountry: String?

  enum CodingKeys: String, CodingKey {
    case id = "id"
    case logoPath = "logo_path"
    case name = "name"
    case originCountry = "origin_country"
  }

  init(id: Int?, logoPath: String?, name: String?, originCountry: String?) {
    self.id = id
    self.logoPath = logoPath
    self.name = name
    self.originCountry = originCountry
  }
}

// MARK: ProductionCompany convenience initializers and mutators

extension ProductionCompany {
  convenience init(data: Data) throws {
    let me = try newJSONDecoder().decode(ProductionCompany.self, from: data)
    self.init(id: me.id, logoPath: me.logoPath, name: me.name, originCountry: me.originCountry)
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
    logoPath: String?? = nil,
    name: String?? = nil,
    originCountry: String?? = nil
  ) -> ProductionCompany {
    return ProductionCompany(
      id: id ?? self.id,
      logoPath: logoPath ?? self.logoPath,
      name: name ?? self.name,
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

// MARK: - ProductionCountry
@objcMembers class ProductionCountry: NSObject, Codable {
  let iso3166_1: String?
  let name: String?

  enum CodingKeys: String, CodingKey {
    case iso3166_1 = "iso_3166_1"
    case name = "name"
  }

  init(iso3166_1: String?, name: String?) {
    self.iso3166_1 = iso3166_1
    self.name = name
  }
}

// MARK: ProductionCountry convenience initializers and mutators

extension ProductionCountry {
  convenience init(data: Data) throws {
    let me = try newJSONDecoder().decode(ProductionCountry.self, from: data)
    self.init(iso3166_1: me.iso3166_1, name: me.name)
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
    iso3166_1: String?? = nil,
    name: String?? = nil
  ) -> ProductionCountry {
    return ProductionCountry(
      iso3166_1: iso3166_1 ?? self.iso3166_1,
      name: name ?? self.name
    )
  }

  func jsonData() throws -> Data {
    return try newJSONEncoder().encode(self)
  }

  func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
    return String(data: try self.jsonData(), encoding: encoding)
  }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.spokenLanguageTask(with: url) { spokenLanguage, response, error in
//     if let spokenLanguage = spokenLanguage {
//       ...
//     }
//   }
//   task.resume()

// MARK: - SpokenLanguage
@objcMembers class SpokenLanguage: NSObject, Codable {
  let iso639_1: String?
  let name: String?

  enum CodingKeys: String, CodingKey {
    case iso639_1 = "iso_639_1"
    case name = "name"
  }

  init(iso639_1: String?, name: String?) {
    self.iso639_1 = iso639_1
    self.name = name
  }
}

// MARK: SpokenLanguage convenience initializers and mutators

extension SpokenLanguage {
  convenience init(data: Data) throws {
    let me = try newJSONDecoder().decode(SpokenLanguage.self, from: data)
    self.init(iso639_1: me.iso639_1, name: me.name)
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
    iso639_1: String?? = nil,
    name: String?? = nil
  ) -> SpokenLanguage {
    return SpokenLanguage(
      iso639_1: iso639_1 ?? self.iso639_1,
      name: name ?? self.name
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

  func moviesDetailsTask(
    with url: URL,
    completionHandler: @escaping (MoviesDetails?,
    URLResponse?,
    Error?) -> Void) -> URLSessionDataTask {
    return self.codableTask(with: url, completionHandler: completionHandler)
  }
}
