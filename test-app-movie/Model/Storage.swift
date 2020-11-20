//
//  Storage.swift
//  test-app-movie
//
//  Created by Элина on 20.11.2020.
//  Copyright © 2020 Элина. All rights reserved.
//

import Foundation

class Storage {
    static let shared = Storage()
    var movies = [Movie]()
    
    func getMovies(name: String?, id: Int?, completion: @escaping (Bool) -> ()){
        Client.get(name: name, id: id) { (res) in
            for m in res {
                self.movies.append(m)
            }
            if !self.movies.isEmpty{completion(true)}
            completion(false)
        }
    }
}
