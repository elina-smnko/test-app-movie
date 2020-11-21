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
                self.directorsLabel.text?.append("\(c.name) ")
            }
        }else {
            self.directorsLabel.text?.append("Unknown company")
        }
        
        
        self.relDateLabel.text = "Release date: "
        self.relDateLabel.text?.append("\(movie.release_date ?? "Unknown")")
        
        self.genresLabel.text = "Genre: "
        if let genr = movie.genres {
            for g in genr {
                print(g)
                self.genresLabel.text?.append("\(g.name) ")
            }
        }
        guard let path = movie.poster_path else {
            return
        }
        self.posterView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(path)"), placeholderImage: UIImage(named: "img"))
    }
    

}
