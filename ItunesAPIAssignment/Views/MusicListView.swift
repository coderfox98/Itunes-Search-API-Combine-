//
//  ContentView.swift
//  ItunesAPIAssignment
//
//  Created by Rishabh Raj on 25/06/20.
//  Copyright © 2020 rishstudios. All rights reserved.
//

import SwiftUI

struct MusicListView: View {
    @ObservedObject private var searchListVM = SearchListViewModel()
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchListVM.searchText, onSearchButtonChanged: {
                    self.searchListVM.getSearchResults()
                })
                List(searchListVM.searchResults, id: \.trackId) { searchResult in
                    NavigationLink(destination: MusicDetailView(song: searchResult)) {
                        HStack {
                            AsyncImage(URL(string:searchResult.artworkUrl60)!, errorView: { (error) in
                                Text(error.localizedDescription)
                            }, imageView: { image  in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(25)
                            }) {
                                Text("Loading")
                            }
                            VStack(alignment: .leading) {
                                
                                Text("Artist Name:\(searchResult.artistName ?? "No Name")")
                                Text("Track Name: \(searchResult.trackName ?? "No Name")")
                                Text("Genre: \(searchResult.primaryGenreName ?? "No Name")")
                                Text("Track Duration: \((searchResult.trackTimeMillis ?? 0).minuteSecondMS)")
                                Text("Price : \(String(format: "%.2f" , searchResult.trackPrice ?? 0))")
                            }
                        }.padding(.vertical)
                    }
                }
            }.navigationBarTitle(Text("Itunes Songs API"))
        }
    }
}

struct MusicListView_Previews: PreviewProvider {
    static var previews: some View {
        MusicListView()
    }
}
