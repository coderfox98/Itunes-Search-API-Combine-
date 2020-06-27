//
//  SongModel.swift
//  ItunesAPIAssignment
//
//  Created by Rishabh Raj on 25/06/20.
//  Copyright © 2020 rishstudios. All rights reserved.
//

import Foundation

struct SearchResults: Decodable {
    let resultCount: Int
    let results: [SongModel]
}

struct SongModel : Decodable {
    let trackId : Int64
    let artistName : String?
    let collectionName : String?
    let artworkUrl60 : String
    let artworkUrl100 : String?
    let trackName : String?
    let primaryGenreName : String?
    let trackTimeMillis : TimeInterval?
    let trackPrice : Float?
    let currency : String?
    let trackExplicitness : String?
}
