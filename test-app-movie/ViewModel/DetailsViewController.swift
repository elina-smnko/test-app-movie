//
//  DetailsViewController.swift
//  test-app-movie
//
//  Created by Элина on 19.11.2020.
//  Copyright © 2020 Элина. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var directorsLabel: UILabel!
    @IBOutlet weak var relDateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    
    var movie = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        showMovie(movie: movie)
    }
    
    func showMovie(movie: Movie){
        self.titleLabel.text = movie.title
        self.descriptionLabel.text = movie.overview
        self.directorsLabel.text = "By: "
        if let comp = movie.production_companies {
            for c in comp {
                self.directorsLabel.text?.append(c.name)
            }
        }
        
        
        self.relDateLabel.text = "Release date: \(movie.release_date)"
        if let genr = movie.genre_ids {
            for g in genr {
                self.genresLabel.text?.append("\(Utilities.genres[g]!) ")
            }
        }
        guard let path = movie.poster_path else {
            return
        }
        self.posterView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(path)"), placeholderImage: UIImage(named: "img"))
    }
    

}
