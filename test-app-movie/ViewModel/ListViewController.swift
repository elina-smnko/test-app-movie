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
    var movie = false
    var search = false
    var keyword = ""
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        navigationController?.navigationBar.isHidden = true
        if !search {
            storage.movies.removeAll()
            let url = Utilities().formURL(path: .trendingpath, id: nil, parameters: [.apikey:Utilities.apikey])
            storage.getMovies(name: nil, id: nil, url: url) { (comp) in
                if comp {
                    DispatchQueue.main.async {
                            self.collectionView.reloadData()
                    }
                }
            }
        }else {
            let url = Utilities().formURL(path: .namepath, id: nil, parameters: [.apikey:Utilities.apikey, .query : keyword])
            self.search = true
            storage.movies.removeAll()
            storage.getMovies(name: keyword, id: nil, url: url) { (comp) in
                if comp {
                    self.movie = true
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
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
        
        let url = Utilities().formURL(path: .trendingpath, id: nil, parameters: [.apikey:Utilities.apikey])
        storage.getMovies(name: nil, id: nil, url: url) { (comp) in
            if comp {
                let movieid = self.storage.movies[indexPath.row].id
                self.storage.movies.removeAll()
                let url = Utilities().formURL(path: .detailspath, id: movieid, parameters: [.apikey:Utilities.apikey])
                self.storage.getMovies(name: nil, id: movieid, url: url) { (comp) in
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
        guard let k = keyword else {
            return
        }
        if k.isEmpty || k.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {return}
        self.keyword = k
        let url = Utilities().formURL(path: .namepath, id: nil, parameters: [.apikey:Utilities.apikey, .query : k])
        self.search = true
        storage.getMovies(name: keyword, id: nil, url: url) { (comp) in
            if comp {
                self.movie = true
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}
