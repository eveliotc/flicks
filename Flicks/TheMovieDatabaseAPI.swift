//
//  TheMovieDatabaseAPI.swift
//  Flicks
//
//  Created by Evelio Tarazona on 10/15/16.
//  Copyright © 2016 Evelio Tarazona. All rights reserved.
//

import Foundation
import Alamofire

private let kBaseURL = "https://api.themoviedb.org/3/movie"
private let kAPIKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
private let kRequestTimeout = 12.0
private let kValidMIMETypes = ["application/json"]


public enum MovieSource {
    case nowPlaying
    case topRated
    
    var endpoint: String {
        switch self {
        case .nowPlaying:
            return "/now_playing"
        case .topRated:
            return "/top_rated"
        }
    }
}

public struct TheMovieDatabaseAPI {
    
    static func getMovies(_ source: MovieSource, failure: ((Error) -> ())? = nil, success: @escaping ([Movie]) -> ()) {
        let parameters: Parameters = ["api_key": kAPIKey]
        Alamofire.request(kBaseURL + source.endpoint, method: .get, parameters: parameters)
            .validate(contentType: kValidMIMETypes)
            .validate(statusCode: 200 ..< 300)
            .responseJSON { response in
                switch response.result {
                case .success:
                    var movies: [Movie] = []
                    if let json = response.result.value as? NSDictionary {
                        movies = NowPlayingResponse.from(json)?.movies ?? []
                    }
                    success(movies)
                case .failure(let error):
                    failure?(error)
                }
            }
    }
}
