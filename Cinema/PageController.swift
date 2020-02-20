//
//  ViewController.swift
//  Cinema
//
//  Created by Daniel Tarazona on 2/6/20.
//  Copyright © 2020 Daniel Tarazona. All rights reserved.
//

import UIKit
import CoreData
import InstantSearchClient
import InstantSearchCore

enum Category: String {
  case topRated
  case popular
  case upcoming
}

class PageController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var nextButton: UIButton!
  @IBOutlet weak var prevButton: UIButton!
  @IBOutlet weak var tvButton: UIButton!
  @IBOutlet weak var movieButton: UIButton!
  @IBOutlet weak var topRatedButton: UIButton!
  @IBOutlet weak var popularButton: UIButton!
  @IBOutlet weak var upcomingButton: UIButton!
  @IBOutlet weak var pageLabel: UILabel!
  @IBOutlet weak var navigationBar: UINavigationBar!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var insideView: UIView!

  let searchBarView = UISearchBar()
  let poster = UIImageView()
  let theMovieDB = API(URL: "https://api.themoviedb.org/3")
  let imageDB = API(URL: "https://image.tmdb.org/t/p/w500")
  let coreDataStack = CoreDataStack.shared

  var algoliaClient: Client!
  var moviesIndex: Index!
  var tvIndex: Index!
  var moviesSearcher: Searcher!
  var tvSearcher: Searcher!
  var movies: [Results] = []
  var algoliaMovies: [Results] = []
  var popularMovies: [Results] = []
  var actualPage = 1
  var popularPage = 1
  var topRatedPage = 1
  var upcomingPage = 1
  var tvTopRatedPage = 1
  var tvPopularPage = 1
  var totalPages = 2
  let theme: UIColor = .black
  let inverseTheme: UIColor = .white
  var upcoming: UIButton!
  var category: Category!
  var show = "movie"
  var lastCategory: Category!
  var lastTVCategory: Category!
  var videos: Videos!
  var movieDetails: MoviesDetails!
  var tvDetails: TVDetails!
  var isMoviesMode = true
  var isTVMode = false
  var posterPath = ""
  var isSearching = false

  /**
  - Description: Setup the some components before load the view.
  */
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    movieButton.isEnabled = false
    movieButton.layer.borderColor = UIColor.red.cgColor
    popularButton.layer.borderColor = UIColor.red.cgColor
    popularButton.isEnabled = false
    category = .popular
    lastCategory = .popular
    lastTVCategory = .topRated
    update()
    self.popularMovies = self.movies
  }

  /**
  - Description: Initial view setup.
  */
  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.delegate = self
    collectionView.dataSource = self

    dismissKeyboardApp()

    insideView.backgroundColor = theme
    view.backgroundColor = theme
    collectionView.backgroundColor = theme

    if AppDevices.iPhoneMaxPro {
      scrollView.isScrollEnabled = false
    }
    
    setupSearch()
    setupHeader()
    setupFooter()
    setupAlgolia()

    let selectedItem = collectionView.indexPathsForSelectedItems?.first

    DispatchQueue.main.async { [weak self] in
      guard let strongSelf = self else { return }
      strongSelf.collectionView.selectItem(
        at: selectedItem,
        animated: false,
        scrollPosition: .left
      )
    }
  }

  /**
  - Description: Setup the algolia index and default settings.
  */
  func setupAlgolia() {
    algoliaClient = Client(appID: AppAlgolia.appId!, apiKey: AppAlgolia.apiKey!)
    moviesIndex = algoliaClient.index(withName: AppAlgolia.moviesIndex!)
    tvIndex = algoliaClient.index(withName: AppAlgolia.tvIndex!)
    moviesIndex.setSettings(["attributesToHighlight": []])
    tvIndex.setSettings(["attributesToHighlight": []])
  }

  /**
  - Description: Refresh the data  and reload the collection view.
  */
  func update() {
    let parameters = ["page": "\(actualPage)"]

    theMovieDB.getPage(
      show: show,
      category: category!.rawValue,
      parameters: parameters,
      completion: { page in
        self.movies = page!.results?.allObjects as? [Results] ?? []

        if self.isMoviesMode {
          self.movies = self.movies.sorted {
            $0.releaseDate!.lowercased() > $1.releaseDate!.lowercased()
          }
        } else {
          self.movies = self.movies.sorted {
            $0.firstAirDate!.lowercased() > $1.firstAirDate!.lowercased()
          }
        }

        self.actualPage = page!.page
        self.totalPages = page!.totalPages
        self.pageLabel.text = "Page \(self.actualPage)/\(page!.totalPages)"
        self.collectionView.reloadData()
    })
  }

  /**
  - Description: Setup the search bar style.
  */
  func setupSearch() {
    searchBarView.setStyle(placeholder: "Search")
    searchBarView.delegate = self

    navigationBar?.setStyle()
    navigationBar?.backgroundColor = .black
    navigationBar?.topItem?.titleView = searchBarView

    navigationItem.titleView = searchBarView
    searchBarView.sizeToFit()
  }

  /**
  - Description: Setup the header bar and buttons styles.
  */
  func setupHeader() {
    movieButton.setStyle(title: "Movies")
    movieButton.addTarget(self, action: #selector(setMovie), for: .touchUpInside)

    tvButton.setStyle(title: "Series")
    tvButton.addTarget(self, action: #selector(setTV), for: .touchUpInside)

    topRatedButton.setStyle(title: "Top Rated")
    topRatedButton.addTarget(self, action: #selector(setTopRated), for: .touchUpInside)

    popularButton.setStyle(title: "Popular")
    popularButton.addTarget(self, action: #selector(setPopular), for: .touchUpInside)

    upcomingButton.setStyle(title: "Upcoming")
    upcomingButton.addTarget(self, action: #selector(setUpcoming), for: .touchUpInside)
  }

  /**
  - Description: Setup the footer bar and buttons styles.
  */
  func setupFooter() {
    pageLabel.textColor = .gray

    prevButton.setTitle("PREV", for: .normal)
    prevButton.titleLabel!.textAlignment = .left
    prevButton.setTitleColor(theme, for: .normal)
    prevButton.addTarget(self, action: #selector(prevPage), for: .touchUpInside)
    prevButton.isEnabled = false
    prevButton.isHidden = false

    nextButton.setTitle("NEXT", for: .normal)
    nextButton.layer.borderColor = UIColor.white.cgColor
    nextButton.setTitleColor(inverseTheme, for: .normal)
    nextButton.titleLabel!.textAlignment = .right
    nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
  }

  func unhideUpcoming() {
    upcomingButton.isEnabled = true
    upcomingButton.isHidden = false
  }

  func hideUpcoming() {
    upcomingButton.isEnabled = false
    upcomingButton.isHidden = true
  }

  // MARK: Navigation
  
  /**
  Description: Prepare to perform a segue to PosterDetailController.
  Prepare the data to pass to another viewControllers before the segues is triggered.
  - Parameter segue: The segue object containing information about the
  view controllers involved in the segue.
  - Parameter sender: The object that initiated the segue.
  You might use this parameter to perform different actions based on which control
  (or other object) initiated the segue.
  */
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == AppSegues.PosterDetailSegue {
      if let detailVC = segue.destination as? PosterDetailController {
        detailVC.videos = self.videos
        detailVC.posterPath = self.posterPath
        if isMoviesMode {
          detailVC.movie = self.movieDetails
          detailVC.isMovieMode = true
        } else {
          detailVC.tv = self.tvDetails
          detailVC.isTVMode = true
        }
      }
    }
  }
}

extension PageController {

  /**
  - Description: Setup the category top bar.
  */
  func setupCategory() {
    if isMoviesMode {
      if category == .popular {
        setPopular()
      } else if category == .topRated {
        setTopRated()
      } else if category == .upcoming {
        setUpcoming()
      }
    } else if isTVMode {
      if lastTVCategory == .popular {
        setPopular()
      } else if lastTVCategory == .topRated {
        setTopRated()
      }
    }
  }

  /**
  - Description: Set the movie mode and performs setup.
  */
  @objc func setMovie() {
    if !isMoviesMode {
      isMoviesMode = true
      isTVMode = false
      show = "movie"
      movieButton.isEnabled = false
      movieButton.layer.borderColor = UIColor.red.cgColor
      tvButton.layer.borderColor = UIColor.white.cgColor
      tvButton.isEnabled = true
      category = lastCategory
      setupCategory()
      unhideUpcoming()
    }
  }

  /**
  - Description: Set the TV mode and performs setup.
  */
  @objc func setTV() {
    if !isTVMode {
      isMoviesMode = false
      isTVMode = true
      show = "tv"
      tvButton.isEnabled = false
      tvButton.layer.borderColor = UIColor.red.cgColor
      movieButton.layer.borderColor = UIColor.white.cgColor
      movieButton.isEnabled = true
      category = lastTVCategory
      setupCategory()
      hideUpcoming()
    }
  }

  /**
  - Description: Go to the next page.
  */
  @objc func nextPage() {
    if category == .upcoming {
      upcomingPage += 1
    }

    if isMoviesMode {
      if category == .topRated {
        topRatedPage += 1
      } else if category == .popular {
        popularPage += 1
      }
    } else {
      if category == .topRated {
        tvTopRatedPage += 1
      } else if category == .popular {
        tvPopularPage += 1
      }
    }

    actualPage += 1
    update()

    if actualPage == totalPages {
      nextButton.isEnabled = false
    }

    if actualPage > 1 {
      prevButton.isEnabled = true
      prevButton.setTitleColor(inverseTheme, for: .normal)
    }

    let indexPath = IndexPath(item: 0, section: 0)
    collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    collectionView.reloadData()
  }

  /**
  - Description: Go to the previous page.
  */
  @objc func prevPage() {
    if category == .upcoming {
      upcomingPage -= 1
    }

    if isMoviesMode {
      if category == .topRated {
        topRatedPage -= 1
      } else if category == .popular {
        popularPage -= 1
      }
    } else {
      if category == .topRated {
        tvTopRatedPage -= 1
      } else if category == .popular {
        tvPopularPage -= 1
      }
    }

    if actualPage > 1 && actualPage <= totalPages {
      actualPage -= 1
    }

    if actualPage < totalPages {
      nextButton.isEnabled = true
      prevButton.setTitleColor(inverseTheme, for: .normal)
    }

    if actualPage == 1 {
      prevButton.isEnabled = false
      prevButton.setTitleColor(theme, for: .normal)
    }

    update()
  }

  /**
  - Description: Set the top rated category.
  */
  @objc func setTopRated() {
    category = .topRated

    if isMoviesMode {
      actualPage = topRatedPage
      lastCategory = category
    } else {
      actualPage = tvTopRatedPage
      lastTVCategory = category
    }

    popularButton.layer.borderColor = UIColor.white.cgColor
    topRatedButton.layer.borderColor = UIColor.red.cgColor
    upcomingButton.layer.borderColor = UIColor.white.cgColor

    topRatedButton.isEnabled = false
    popularButton.isEnabled = true
    upcomingButton.isEnabled = true

    if topRatedPage == 1 {
      prevButton.isEnabled = false
      prevButton.setTitleColor(theme, for: .normal)
    } else {
      prevButton.isEnabled = true
      prevButton.setTitleColor(.white, for: .normal)
    }

    update()
  }

  /**
  - Description: Set the popular category.
  */
  @objc func setPopular() {
    category = .popular

    if isMoviesMode {
      actualPage = popularPage
      lastCategory = category
    } else {
      actualPage = tvPopularPage
      lastTVCategory = category
    }

    popularButton.layer.borderColor = UIColor.red.cgColor
    topRatedButton.layer.borderColor = UIColor.white.cgColor
    upcomingButton.layer.borderColor = UIColor.white.cgColor

    popularButton.isEnabled = false
    upcomingButton.isEnabled = true
    topRatedButton.isEnabled = true

    if popularPage == 1 {
      prevButton.isEnabled = false
      prevButton.setTitleColor(theme, for: .normal)
    } else {
      prevButton.isEnabled = true
      prevButton.setTitleColor(.white, for: .normal)
    }

    update()
  }

  /**
  - Description: Set the upcoming category only as movie mode.
  */
  @objc func setUpcoming() {
    if category != .upcoming && isMoviesMode {

      upcomingButton.isHidden = false
      actualPage = upcomingPage
      category = .upcoming
      lastCategory = category

      upcomingButton.layer.borderColor = UIColor.red.cgColor
      popularButton.layer.borderColor = UIColor.white.cgColor
      topRatedButton.layer.borderColor = UIColor.white.cgColor

      upcomingButton.isEnabled = false
      popularButton.isEnabled = true
      topRatedButton.isEnabled = true

      if upcomingPage == 1 {
        prevButton.isEnabled = false
        prevButton.setTitleColor(theme, for: .normal)
      } else {
        prevButton.isEnabled = true
        prevButton.setTitleColor(.white, for: .normal)
      }

      update()
    } else {
      upcomingButton.isHidden = true
    }
  }
}

extension PageController: UICollectionViewDelegate,
UICollectionViewDataSource {

  /**
  - Description: Clear movies array and reload collection data.
  */
  func reloadCollectionView(movies: [Results]) {
    self.movies = []
    self.movies = movies
    self.collectionView.reloadData()
  }

  /**
  - Description: Get the movie or tv detail and rerforms a programmatic segue to detail view.
   */
  // MARK: - UICollectionViewDelegate
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if isMoviesMode {
      let movie = movies[indexPath.item]
      self.posterPath = movie.posterPath!
      theMovieDB.getMovieDetail(id: movie.id) { (detail) in
        self.movieDetails = detail
        self.theMovieDB.getVideos(show: "movie", id: movie.id) { (videos) in
          self.videos = videos
          self.performSegue(withIdentifier: AppSegues.PosterDetailSegue, sender: nil)
        }
      }
    } else if isTVMode {
      let serie = movies[indexPath.item]
      self.posterPath = serie.posterPath!
      theMovieDB.getTVDetail(id: serie.id) { (detail) in
        self.tvDetails = detail
        self.theMovieDB.getVideos(show: "tv", id: serie.id) { (videos) in
          self.videos = videos
          self.performSegue(withIdentifier: AppSegues.PosterDetailSegue, sender: nil)
        }
      }
    }
  }

  /**
  - Description: Set the number of sections in collection view.
  */
  // MARK: UICollectionViewDataSource
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  /**
  - Description: Set the number of items by section.
  */
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int) -> Int {
    return movies.count
  }

  /**
  - Description: Setup the cell for item in collection view.
  */
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: AppIdentifiers.PosterCellReuseIdentifier,
      for: indexPath
      ) as? PosterCellView

    let movie = movies[indexPath.item]

    let moviePosterPath = movie.posterPath
    let backdropPath = movie.backdropPath

    guard moviePosterPath != nil else {
      cell!.poster.image = UIImage(named: "Logo")
      return cell!
    }

    guard backdropPath != nil else {
      cell!.poster.image = UIImage(named: "Logo")
      return cell!
    }

    imageDB.getImage(imagePath: moviePosterPath!) { (image) in
      guard let image = image else {
        return
      }
      cell!.poster.image = image
      self.poster.image = image
    }

    cell?.configure(movie: movie, show: show)

    return cell!
  }
}

extension PageController: UISearchBarDelegate {

  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    isSearching = false
    self.movies = popularMovies
  }

  /**
   - Description: The actions to execute when the user start to editing the text inside SearchBar.
   Change the background color of the SearchBar to AppColors.formsBackground.
   - Parameter searchBar: The UISearchBar to interact.
   */
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    isSearching = true
  }

  /**
   - Description: The actions to execute when the user stop editing the text inside SearchBar.
   Change the background color of the SearchBar to the background again.
   - Parameter searchBar: The UISearchBar to interact.
   */
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    isSearching = false
    self.movies = popularMovies
  }

  /**
   - Description: The actions to execute when the user change the text in SearchBar.
   Search again when the SearchBar changes.
   - Parameter searchBar: The UISearchBar to interact.
   - Parameter searchText: The text that change inside the SearchBar.
   */
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if isMoviesMode {
      moviesIndex.search(Query(query: searchText), completionHandler: { (content, error) -> Void in
          if error == nil {
            let decoder = JSONDecoder()
            decoder.userInfo[CodingUserInfoKey.context!] =
              self.coreDataStack.persistentContainer.viewContext
            let searchResults = try? decoder.decode(SearchResults.self, withJSONObject: content!)

            let movies = searchResults!.hits

            let moviesFound = movies.compactMap { (json) -> Results? in
              let movie = try? decoder.decode(Results.self, from: Data(json.debugDescription.utf8))
              return movie
            }

            if moviesFound.count == 0 {
              return
            } else {
              DispatchQueue.main.async {
                self.reloadCollectionView(movies: moviesFound)
              }
            }
          }
      })
    } else if isTVMode {
      tvIndex.search(Query(query: searchText), completionHandler: { (content, error) -> Void in
          if error == nil {
            let decoder = JSONDecoder()
            decoder.userInfo[CodingUserInfoKey.context!] =
              self.coreDataStack.persistentContainer.viewContext
            let searchResults = try? decoder.decode(SearchResults.self, withJSONObject: content!)

            let movies = searchResults!.hits

            let moviesFound = movies.compactMap { (json) -> Results? in
              let movie = try? decoder.decode(Results.self, from: Data(json.debugDescription.utf8))
              return movie
            }

            if moviesFound.count == 0 {
              return
            } else {
              DispatchQueue.main.async {
                self.reloadCollectionView(movies: moviesFound)
              }
            }
          }
      })
    }
  }
}
