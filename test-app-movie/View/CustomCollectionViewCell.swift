//
//  CustomCollectionViewCell.swift
//  test-app-movie
//
//  Created by Элина on 20.11.2020.
//  Copyright © 2020 Элина. All rights reserved.
//

import UIKit
import SDWebImage

class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movie: Movie? {
           didSet {
            self.titleLabel.text = movie?.title
            self.descriptionLabel.text? = movie?.overview ?? "Short description"
            guard let path = movie?.poster_path else {
                return
            }
            self.poster.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(path)"), placeholderImage: UIImage(named: "img"))
            
           }
       }
}
