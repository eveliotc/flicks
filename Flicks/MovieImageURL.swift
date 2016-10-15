//
//  MovieImageURL.swift
//  Flicks
//
//  Created by Evelio Tarazona on 10/15/16.
//  Copyright © 2016 Evelio Tarazona. All rights reserved.
//

import Foundation

private let kBaseURL = "https://image.tmdb.org/t/p/"
private let kLowResPath = "w45/"
private let kMediumResPath = "w342/"
private let kOriginalPath = "original/"

struct MovieImageURL {
    private let path : String
    
    var lowResolutionURL: URL {
        get {
            return URL(string: kBaseURL + kLowResPath + path)!
        }
    }
    var mediumResolutionURL: URL {
        get {
            return  URL(string: kBaseURL + kMediumResPath + path)!
        }
    }
    var originalURL: URL {
        get {
            return  URL(string: kBaseURL + kOriginalPath + path)!
        }
    }
    
    init(_ imagePath : String) {
        path = imagePath
    }
}
