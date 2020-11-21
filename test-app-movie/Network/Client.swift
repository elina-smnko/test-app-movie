//
//  Client.swift
//  test-app-movie
//
//  Created by Элина on 19.11.2020.
//  Copyright © 2020 Элина. All rights reserved.
//

import Foundation

class Client {
    
    class func get(name: String?, id: Int?, url: URL?, completion: @escaping ([Movie]) -> ()) {
        var one = false
        if let id = id {
            one = true
        }
        if let url = url {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                 print(error.localizedDescription)
                 return
                }
                if let data = data {
                    do {
                        if one {
                            let result = try JSONDecoder().decode(Movie.self, from: data)
                            completion([result])
                        }
                        else{
                            print("else")
                        let result = try JSONDecoder().decode(Movies.self, from: data)
                            completion(result.results)
                        }
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
