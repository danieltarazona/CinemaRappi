//
//  PosterDetailController.swift
//  Cinema
//
//  Created by Daniel Tarazona on 2/6/20.
//  Copyright © 2020 Daniel Tarazona. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import youtube_ios_player_helper

class PosterDetailController: UIViewController {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var overview: UITextView!
  @IBOutlet weak var poster: UIImageView!
  @IBOutlet weak var YTPlayer: YTPlayerView!
  var movie: MoviesDetails?
  var tv: TVDetails?
  var isMovieMode: Bool! = false
  var isTVMode: Bool! = false
  var videos: Videos!
  var posterPath: String!

  let imageDB = API(URL: "https://image.tmdb.org/t/p/original")

  /**
  - Description: Setup the video player with first video.
  */
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let firstVideo = self.videos.results?.first
    let urlKey = firstVideo?.key
    YTPlayer.load(withVideoId: urlKey ?? "Xb3E8eWZ1mk")
    YTPlayer.playVideo()
  }

  /**
  - Description: Setup the view and set an alternative image.
  */
  override func viewDidLoad() {
    super.viewDidLoad()

    YTPlayer.layer.backgroundColor = UIColor.black.cgColor
    YTPlayer.webView?.backgroundColor = .black
    YTPlayer.inputView?.backgroundColor = .black
    YTPlayer.backgroundColor = .black
    YTPlayer.layer.cornerRadius = 10

    YTPlayer.webView?.window?.backgroundColor = .black

    if isMovieMode {
      titleLabel.text = movie?.title
      overview.text = movie?.overview
    } else {
      titleLabel.text = tv?.name
      titleLabel.text = tv?.overview
    }

    guard posterPath! != "" else {
      poster.image = UIImage(named: "Logo")
      return
    }

    imageDB.getImage(imagePath: self.posterPath) { (image) in
      guard let image = image else {
        return
      }
      self.poster.image = image
    }

    poster.contentMode = .scaleAspectFill

    titleLabel.textColor = .white
    titleLabel.textAlignment = .center

    overview.backgroundColor = .none
    overview.textAlignment = .center
    overview.textColor = .white
  }

  /**
  - Description: Check if movie detail has not videos and hide the player.
  */
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    if videos.results!.count > 0 {
      YTPlayer.isHidden = false
    }
  }

}
