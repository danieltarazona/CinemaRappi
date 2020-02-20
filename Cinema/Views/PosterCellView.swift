//
//  PosterCellView.swift
//  Cinema
//
//  Created by Daniel Tarazona on 2/6/20.
//  Copyright © 2020 Daniel Tarazona. All rights reserved.
//

import UIKit

class PosterCellView: UICollectionViewCell {

  @IBOutlet weak var poster: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var overviewTextView: UITextView!

  /**
    - Description: Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file.
   */
  override func awakeFromNib() {
    super.awakeFromNib()

    titleLabel.textColor = .white
    titleLabel.textAlignment = .center

    overviewTextView.textAlignment = .center
    overviewTextView.textColor = .white
    overviewTextView.backgroundColor = .black

    poster.contentMode = .scaleAspectFill
    poster.layer.borderColor = .none
    poster.layer.borderWidth = 0
    poster.layer.cornerRadius = 0
  }

  /**
  - Description: Configure the cell with data.
  - Parameter movies: The movie object or tv as Results type.
  - Parameter show: The type of show movie or tv as string.
  */
  func configure(movie: Results, show: String) {
    if show == "movie" {
      titleLabel.text = movie.title
    } else {
      titleLabel.text = movie.name
    }

    overviewTextView.text = movie.overview
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  /**
  - Description: Prepare the cell for reuse.
  */
  override func prepareForReuse() {
    super.prepareForReuse()
    titleLabel.text = ""
    overviewTextView.text = ""
    poster.image = nil
  }
}
