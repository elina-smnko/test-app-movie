//
//  Client.swift
//  test-app-movie
//
//  Created by Элина on 19.11.2020.
//  Copyright © 2020 Элина. All rights reserved.
//

import Foundation

class Client {
    
    class func get(name: String?, id: Int?, completion: @escaping ([Movie]) -> ()) {
        var url : URL?
        var one = false
        if let name = name{
            if name != ""{
                url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=95217d31a2a874647ed506649cde5eb5&query=\(name)&page=1")
            } else {
                url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=95217d31a2a874647ed506649cde5eb5")
            }
        }else{
            url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=95217d31a2a874647ed506649cde5eb5")}
        
        if let id = id {
            one = true
            url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=95217d31a2a874647ed506649cde5eb5")
        }
        if let url = url {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                 print(error.localizedDescription)
                 return
                }
                if let data = data {
                    do {
                        if one {let result = try JSONDecoder().decode(Movie.self, from: data)
                            print("res")
                            print(result.production_companies)
                            completion([result])}
                        else{
                        let result = try JSONDecoder().decode(Movies.self, from: data)
                            completion(result.results)}
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            task.resume()
        }else {
            print("invalid url")
            return
        }
    }
}
