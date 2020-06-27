//
//  SearchListViewModel.swift
//  ItunesAPIAssignment
//
//  Created by Rishabh Raj on 25/06/20.
//  Copyright © 2020 rishstudios. All rights reserved.
//

import Combine

class SearchListViewModel : ObservableObject {
    
    @Published var searchResults = [SongModel]()
    
    @Published var searchText = ""
    
    private var cancellable : AnyCancellable?
    
    
    func getSearchResults() {
        self.cancellable = WebService.shared.getSearchResults(searchTerm:  searchText)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("OK")
                case .failure(let error):
                    print(error)
                }
        }) { result in
            self.searchResults = result.results
        }
    }
}
