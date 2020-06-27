//
//  MusicDetailView.swift
//  ItunesAPIAssignment
//
//  Created by Rishabh Raj on 25/06/20.
//  Copyright © 2020 rishstudios. All rights reserved.
//

import SwiftUI

struct MusicDetailView : View {
    var song : SongModel
    var body: some View {
        HStack {
            VStack(alignment : .leading) {
                AsyncImage(URL(string:song.artworkUrl100 ?? "https://images.ctfassets.net/hrltx12pl8hq/5596z2BCR9KmT1KeRBrOQa/4070fd4e2f1a13f71c2c46afeb18e41c/shutterstock_451077043-hero1.jpg?fit=fill&w=480&h=400")!, errorView: { error in
                    Text(error.localizedDescription)
                }, imageView: { image in
                    image
                        .cornerRadius(12)
                    
                }, loadingView: {
                    Text("Loading")
                })
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("Artist Name :\(song.artistName ?? "")")
                        .font(.largeTitle)
                    Text("Track Name: \(song.trackName ?? "No Name")")
                    Text("Genre: \(song.primaryGenreName ?? "No Name")")
                    Text("Track Duration: \((song.trackTimeMillis ?? 0).minuteSecondMS)")
                    Text("Price : \(String(format: "%.2f" , song.trackPrice ?? 0))")
                    Text("Currency : \(song.currency ?? "")")
                        
                        .navigationBarTitle(Text(song.trackName ?? ""))
                }
                Spacer()
            }
            Spacer()
        }.padding()
    }
}
