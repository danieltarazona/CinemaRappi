//
//  Pages+CoreDataClass.swift
//  Cinema
//
//  Created by Daniel Tarazona on 2/6/20.
//  Copyright © 2020 Daniel Tarazona. All rights reserved.
//

import Foundation
import CoreData

// MARK: - Pages
@objc(Pages)
public class Pages: NSManagedObject, Codable {

  enum CodingKeys: String, CodingKey {
    case page = "page"
    case totalResults = "total_results"
    case totalPages = "total_pages"
    case results = "results"
  }

  required convenience public init(from decoder: Decoder) throws {

    guard let contextUserInfoKey = CodingUserInfoKey.context,
      let managedObjectContext =
      decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
      let entity =
      NSEntityDescription.entity(forEntityName: "Pages", in: managedObjectContext)
      else {
        fatalError("Failed to decode Pages!")
    }

    self.init(entity: entity, insertInto: managedObjectContext)

    let values = try decoder.container(keyedBy: CodingKeys.self)
    page = try values.decodeIfPresent(Int.self, forKey: .page) ?? 1
    totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults) ?? 0
    totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages) ?? 0
    results = NSSet(array: try values.decodeIfPresent([Results].self, forKey: .results)!)
  }

  public func encode(to encode: Encoder) throws {
    var container = encode.container(keyedBy: CodingKeys.self)
    try container.encode(page, forKey: .page)
    try container.encode(totalResults, forKey: .totalResults)
    try container.encode(totalPages, forKey: .totalPages)
  }
}

extension Pages {

  @nonobjc public class func fetchRequest() -> NSFetchRequest<Pages> {
    return NSFetchRequest<Pages>(entityName: "Pages")
  }

  @NSManaged public var page: Int
  @NSManaged public var totalResults: Int
  @NSManaged public var totalPages: Int
  @NSManaged public var results: NSSet?

  convenience init(page: Int, totalResults: Int, totalPages: Int, results: NSSet?) {
    self.init()
    self.page = page
    self.totalResults = totalResults
    self.totalPages = totalPages
    self.results = results as NSSet?
  }

  convenience init(data: Data) throws {
    let data = try JSONDecoder().decode(Pages.self, from: data)
    self.init(
      page: Int(data.page),
      totalResults: Int(data.totalResults),
      totalPages: Int(data.totalPages),
      results: data.results! as NSSet?
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
