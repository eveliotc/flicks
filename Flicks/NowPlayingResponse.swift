//
//  NowPlayingResponse.swift
//  Flicks
//
//  Created by Evelio Tarazona on 10/15/16.
//  Copyright © 2016 Evelio Tarazona. All rights reserved.
//

import Foundation
import Mapper

struct NowPlayingResponse: Mappable {
    
    public let movies: [Movie]
    
    init(map: Mapper) throws {
        try movies = map.from("results")
    }
}
