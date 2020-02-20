//
//  Images+CoreDataClass.swift
//  Cinema
//
//  Created by Daniel Tarazona on 2/6/20.
//  Copyright © 2020 Daniel Tarazona. All rights reserved.
//

import Foundation
import CoreData
import UIKit

// MARK: - Images
@objc(Images)
public class Images: NSManagedObject, Codable {

  enum CodingKeys: String, CodingKey {
    case image
    case path
  }

  required convenience public init(from decoder: Decoder) throws {

    guard let contextUserInfoKey = CodingUserInfoKey.context,
      let managedObjectContext =
      decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
      let entity =
      NSEntityDescription.entity(
        forEntityName: "Images",
        in: managedObjectContext) else {
          fatalError("Failed to decode Images!")
    }

    self.init(entity: entity, insertInto: managedObjectContext)

    let values = try decoder.container(keyedBy: CodingKeys.self)
    image = try values.decodeIfPresent(Data.self, forKey: .image)
    path = try values.decodeIfPresent(String.self, forKey: .path) ?? ""
  }

  public func encode(to encode: Encoder) throws {
    var container = encode.container(keyedBy: CodingKeys.self)
    try container.encodeIfPresent(image, forKey: .image)
    try container.encodeIfPresent(path, forKey: .path)
  }

  convenience init(image: Data, path: String) {
    self.init()
    self.path = path
    self.image = image
  }

}

extension Images {

  @nonobjc public class func fetchRequest() -> NSFetchRequest<Images> {
    return NSFetchRequest<Images>(entityName: "Images")
  }

  @NSManaged public var image: Data?
  @NSManaged public var path: String?

}
