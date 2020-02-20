//
//  API.swift
//  Cinema
//
//  Created by Daniel Tarazona on 2/6/20.
//  Copyright © 2020 Daniel Tarazona. All rights reserved.
//

import Foundation
import UIKit
import InstantSearchClient

typealias JSON = String

class API {
  let URL: String
  private let apiKey: String = TheMovieDB.apiKey!
  var lang: String = "es-ES"
  let imageCache = NSCache<NSURL, UIImage>()
  let pageCache =  NSCache<NSURL, Pages>()
  let detailTVCache = NSCache<NSURL, TVDetails>()
  let detailMoviesCache = NSCache<NSURL, MoviesDetails>()
  let videosCache = NSCache<NSURL, Videos>()
  let coreDataStack = CoreDataStack.shared
  var algoliaClient: Client!
  var moviesIndex: Index!
  var tvIndex: Index!

  init(URL: String) {
    self.URL = URL
    self.algoliaClient = Client(appID: AppAlgolia.appId!, apiKey: AppAlgolia.apiKey!)
    self.moviesIndex = algoliaClient.index(withName: AppAlgolia.moviesIndex!)
    self.tvIndex = algoliaClient.index(withName: AppAlgolia.tvIndex!)
  }

  /**
  - Description: Parse the parameters and formatted.
  - Parameter parameters: Dictionary as type [String: String].
  - Returns: The arguments for query.
  */
  func parse(parameters: [String: String]) -> String {

    var args: String = "?"

    if parameters.count > 0 {
      for parameter in parameters {
        args += parameter.key + "=" + parameter.value
        args += "&"
      }
      args += "language=\(lang)&"
    }
    return args
  }

  /**
  - Description: Get the page of API.
  - Parameter show: The type of show movie or tv as string.
  - Parameter category: The category popular, topRated or upcoming as string.
  - Parameter parameters: The parameters formatted.
  - Returns: An optional Pages object..
  */
  func getPage(
    show: String,
    category: String,
    parameters: [String: String],
    completion: (@escaping (Pages?) -> Void )) {

    var category = category
    if category == "topRated" {
      category = "top_rated"
    }

    let endpoint = "/\(show)/\(category)"
    let args = parse(parameters: parameters)
    let url = NSURL(string: "\(URL)\(endpoint)\(args)api_key=\(apiKey)")!

    // Cache
    let pageCache = self.pageCache.object(forKey: url)

    if pageCache == nil {

      URLSession.shared.dataTask(with: url as URL) { (data, response, error) in

        let response = response as? HTTPURLResponse

        DispatchQueue.main.async {
          if error == nil {
            if data != nil && response?.statusCode == 200 {
              // Decode
              let decoder = JSONDecoder()
              decoder.userInfo[CodingUserInfoKey.context!] =
                self.coreDataStack.persistentContainer.viewContext

              let page = try? decoder.decode(Pages.self, from: data!)

              let movies = page?.results?.allObjects as? [Results]

              // Algolia
              var moviesArray = [[String: Any]]()

              for movie in movies! {
                let movieDict = try? movie.asDictionary()
                moviesArray.append(movieDict!)
              }

              if show == "movie" {
                self.moviesIndex.addObjects(moviesArray) { (_, error) in
                  if error == nil {

                  }
                }
              } else {
                self.tvIndex.addObjects(moviesArray) { (_, error) in
                  if error == nil {

                  }
                }
              }

              // Cache
              self.pageCache.setObject(page!, forKey: url)

              // CoreData
              self.coreDataStack.save()

              completion(page)
            }
          }
        }
      }.resume()
    } else {
      completion(pageCache)
    }
  }

  /**
  - Description: Get all the poster images for a given page.
  - Parameter page: The page object.
  */
  func downloadAllImages(page: Pages) {
    let results = page.results?.allObjects as? [Results]

    for result in results! {
      _ = getImage(imagePath: result.posterPath!, completion: { image in
        _ = image
      })
    }
  }

  /**
  - Description: Get the image give a given URL path.
  - Parameter imagePath: The URL path.
  - Returns: The image as UIImage from UIKit.
  */
  func getImage(imagePath: String, completion: (@escaping (UIImage?) -> Void )) {
    let url = NSURL(string: "\(URL)\(imagePath)")!
    let directory =
      NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

    let imageDocumentPath = "\(directory)\(imagePath)"
    let imageURL = NSURL(fileURLWithPath: imageDocumentPath) as URL

    if FileManager.default.fileExists(atPath: imageDocumentPath),
      let imageData = try? Data(contentsOf: imageURL),
      let image = UIImage(data: imageData) {
      completion(image)
    } else {
      let imageCache = self.imageCache.object(forKey: url)
      if imageCache == nil {

        URLSession.shared.dataTask(with: url as URL) { (data, response, error) in

          let response = response as? HTTPURLResponse

          DispatchQueue.main.async {

            if error == nil {
              if data != nil && response?.statusCode == 200 {

                let image = UIImage(data: data!)

                _ = try? image!.pngData()?.write(to: imageURL)

                let context = self.coreDataStack.persistentContainer.viewContext
                let decoder = JSONDecoder()
                decoder.userInfo[CodingUserInfoKey.context!] = context
                let json = "{ \"path\" : \"\(imagePath)\" }"

                let entity = try? decoder.decode(
                  Images.self,
                  from: json.data(using: .utf8)!
                )
                entity?.path = imagePath
                entity?.image = data!

                self.imageCache.setObject(image!, forKey: url)

                self.coreDataStack.save()

                completion(image)
              }
            }
          }
        }.resume()
      } else {
        completion(imageCache)
      }
    }
  }

  /**
  - Description: Get the movie detail passing the id as string.
  - Parameter id: The movie id as string.
  - Returns: The MovieDetails object.
  */
  func getMovieDetail(
    id: Int,
    completion: (@escaping (MoviesDetails?) -> Void )) {

    let endpoint = "/movie/\(id)?language=\(lang)&"
    let url = NSURL(string: "\(URL)\(endpoint)api_key=\(apiKey)")!

    // Cache
    let detailMovieCache = self.detailMoviesCache.object(forKey: url)

    if detailMovieCache == nil {

      URLSession.shared.dataTask(with: url as URL) { (data, response, error) in

        let response = response as? HTTPURLResponse

        DispatchQueue.main.async {
          if error == nil {
            if data != nil && response?.statusCode == 200 {
              // Decode
              let decoder = newJSONDecoder()
              decoder.userInfo[CodingUserInfoKey.context!] =
                self.coreDataStack.persistentContainer.viewContext

              let detail = try? decoder.decode(MoviesDetails.self, from: data!)

              // Cache
              self.detailMoviesCache.setObject(detail!, forKey: url)

              // CoreData
              self.coreDataStack.save()

              completion(detail)
            }
          }
        }
      }.resume()
    } else {
      completion(detailMovieCache)
    }
  }

  /**
  - Description: Get the tv detail passing the id as string.
  - Parameter id: The tv id as string.
  - Returns: The TVDetails object.
  */
  func getTVDetail(
    id: Int,
    completion: (@escaping (TVDetails?) -> Void )) {

    let endpoint = "/tv/\(id)?language=\(lang)"
    let url = NSURL(string: "\(URL)\(endpoint)&api_key=\(apiKey)")!

    // Cache
    let detailCache = self.detailTVCache.object(forKey: url)

    if detailCache == nil {

      URLSession.shared.dataTask(with: url as URL) { (data, response, error) in

        let response = response as? HTTPURLResponse

        DispatchQueue.main.async {
          if error == nil {
            if data != nil && response?.statusCode == 200 {

              // Decode
              let decoder = JSONDecoder()
              decoder.userInfo[CodingUserInfoKey.context!] =
                self.coreDataStack.persistentContainer.viewContext
              let detail = try? decoder.decode(TVDetails.self, from: data!)

              // Cache
              self.detailTVCache.setObject(detail!, forKey: url)

              // CoreData
              self.coreDataStack.save()

              completion(detail)
            }
          }
        }
      }.resume()
    } else {
      completion(detailCache)
    }
  }

  /**
  - Description: Get the videos of a movie or tv.
  - Parameter show: The type of show movie or tv as string.
  - Parameter id: The tv id or movide id as string.
  - Returns: The Video object.
  */
  func getVideos(
    show: String,
    id: Int,
    completion: (@escaping (Videos?) -> Void )) {

    let endpoint = "/\(show)/\(id)/videos?language=\(lang)"

    let url = NSURL(string: "\(URL)\(endpoint)&api_key=\(apiKey)")!

    // Cache
    let videosCache = self.videosCache.object(forKey: url)

    if videosCache == nil {

      URLSession.shared.dataTask(with: url as URL) { (data, response, error) in

        let response = response as? HTTPURLResponse

        DispatchQueue.main.async {
          if error == nil {
            if data != nil && response?.statusCode == 200 {

              // Decode
              let decoder = JSONDecoder()
              decoder.userInfo[CodingUserInfoKey.context!] =
                self.coreDataStack.persistentContainer.viewContext

              let videos = try? decoder.decode(Videos.self, from: data!)

              self.videosCache.setObject(videos!, forKey: url)

              // CoreData
              self.coreDataStack.save()

              completion(videos)
            }
          }
        }
      }.resume()
    } else {
      completion(videosCache)
    }
  }
}
