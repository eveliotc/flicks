//
//  Movie.swift
//  Flicks
//
//  Created by Evelio Tarazona on 10/15/16.
//  Copyright © 2016 Evelio Tarazona. All rights reserved.
//

import Foundation
import Mapper

struct Movie: Mappable {
    
    public let title: String
    public let overview: String
    public let poster: MovieImageURL
    public let backdrop: MovieImageURL
    public let releaseDate: Date?
    public let voteAverage: Float?
    
    init(map: Mapper) throws {
        title = map.optionalFrom("title") ?? ""
        overview = map.optionalFrom("overview") ?? ""
        let posterPath: String = map.optionalFrom("poster_path") ?? ""
        let backdropPath = map.optionalFrom("backdrop_path") ?? posterPath
        poster = MovieImageURL(posterPath)
        backdrop = MovieImageURL(backdropPath)
        releaseDate = map.optionalFrom("release_date")
        voteAverage = map.optionalFrom("vote_average")
    }
}

extension Date: Convertible {
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }

    public static func fromMap(_ value: Any) throws -> Date {
        return dateFormatter.date(from: value as! String)!
    }
}
