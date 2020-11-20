//
//  ListViewController.swift
//  test-app-movie
//
//  Created by Элина on 19.11.2020.
//  Copyright © 2020 Элина. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let storage = Storage.shared
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        navigationController?.navigationBar.isHidden = true
        storage.movies.removeAll()
        storage.getMovies(name: nil, id: nil) { (comp) in
            if comp {
                DispatchQueue.main.async {
                        self.collectionView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        navigationController?.navigationBar.isHidden = true
        storage.movies.removeAll()
        storage.getMovies(name: nil, id: nil) { (comp) in
            if comp {
                DispatchQueue.main.async {
                        self.collectionView.reloadData()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storage.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCollectionViewCell
            cell.movie = storage.movies[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as! DetailsViewController
        
        
        storage.getMovies(name: nil, id: nil) { (comp) in
            if comp {
                let movie = self.storage.movies[indexPath.row]
                self.storage.movies.removeAll()
                self.storage.getMovies(name: nil, id: movie.id) { (comp) in
                           if comp {
                            detailVC.movie = self.storage.movies[0]
                            DispatchQueue.main.async {
                            self.navigationController?.show(detailVC, sender: self)
                            }
                           }
                       }
            }
        }

        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var keyword = searchBar.text
        keyword =  keyword?.replacingOccurrences(of: " ", with: "%20")
        storage.movies.removeAll()
        storage.getMovies(name: keyword, id: nil) { (comp) in
            if comp {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}
