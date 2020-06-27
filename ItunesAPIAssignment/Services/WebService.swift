//
//  WebService.swift
//  ItunesAPIAssignment
//
//  Created by Rishabh Raj on 25/06/20.
//  Copyright © 2020 rishstudios. All rights reserved.
//

import Foundation
import Combine

class WebService {
    private let baseURL = "https://itunes.apple.com/search"
    
    private init () { }
    
    static let shared = WebService()
    
    func getSearchResults(searchTerm: String) -> AnyPublisher<SearchResults,Error> {
        
        var urlCom = URLComponents(string: baseURL)!
        
        urlCom.queryItems = [
            URLQueryItem(name: "term", value: searchTerm),
            URLQueryItem(name: "media", value: "music")
        ]

        urlCom.percentEncodedQuery = urlCom.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        guard let url = urlCom.url else { fatalError("URL Invalid") }
        
        let urlRequest = URLRequest(url: url)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                }
                return element.data
        }
        .receive(on: RunLoop.main)
        .decode(type: SearchResults.self, decoder: JSONDecoder())
        .catch { error in
            Empty<SearchResults,Error>()
        }
        .eraseToAnyPublisher()
    }
}

