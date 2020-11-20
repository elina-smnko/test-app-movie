//
//  Utilities.swift
//  test-app-movie
//
//  Created by Элина on 20.11.2020.
//  Copyright © 2020 Элина. All rights reserved.
//

//trending:
 //https://api.themoviedb.org/3/trending/movie/day?api_key=95217d31a2a874647ed506649cde5eb5
 //find by name:
 //https://api.themoviedb.org/3/search/movie?api_key=95217d31a2a874647ed506649cde5eb5&query=mulan&page=1
 //details:
 //https://api.themoviedb.org/3/movie/590706?api_key=95217d31a2a874647ed506649cde5eb5

import Foundation

class Utilities {
    static let apikey = "95217d31a2a874647ed506649cde5eb5"
    static let genres = [28 : "Action", 12 : "Adventure", 16 : "Animation", 35 : "Comedy", 80 : "Crime", 99 : "Documentary", 18 : "Drama", 10751 : "Family", 14 : "Fantasy", 36 : "History", 27 : "Horror", 10402 : "Music", 9648 : "Mystery", 10749 : "Romance", 878 : "Science Fiction", 10770 : "TV Movie", 53 : "Thriller", 10752 : "War", 37 : "Western"]
    
    func formURL(path: Path, parameters: [Parameters:String]) -> URL? {
           var urlComponents = URLComponents()
           urlComponents.scheme = Components.scheme.url
           urlComponents.host = Components.moviehost.url
           urlComponents.path = path.url
           urlComponents.queryItems = [URLQueryItem]()
           for (param, value) in parameters {
               urlComponents.queryItems?.append(URLQueryItem(name: param.url, value: value))
           }
       return urlComponents.url
       }
}


enum Components {
        case scheme, moviehost
        var url: String {
            switch self {
            case .scheme:
                return "https"
            case .moviehost:
                return "api.themoviedb.org"
        }
    }
}
enum Path {
    case trendingpath, namepath, detailspath
    var url: String {
        switch self{
        case .trendingpath:
            return "/3/trending/movie/day?"
        case .namepath:
            return "/3/search/movie?"
        case .detailspath:
            return "/3/movie/"
        }
    }
}

enum Parameters {
    case apikey, query, page
    var url: String {
     switch self{
     case .apikey:
         return "api_key"
     case .query:
         return "query"
     case .page:
         return "page"
        }
    }
}

    

