//
//  SearchBar.swift
//  ItunesAPIAssignment
//
//  Created by Rishabh Raj on 25/06/20.
//  Copyright © 2020 rishstudios. All rights reserved.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    var onSearchButtonChanged: (() -> Void)? = nil
    
    class Coordinator: NSObject, UISearchBarDelegate {
        let searchBarView: SearchBar
        private var timer = Timer()
        init(_ searchBar: SearchBar) {
            self.searchBarView = searchBar
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            timer.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
                self.searchBarView.text = searchText
                self.searchBarView.onSearchButtonChanged?()
            })
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBarView.onSearchButtonChanged?()
            searchBar.resignFirstResponder()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        searchBar.delegate = context.coordinator
        
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = self.text
    }
}
