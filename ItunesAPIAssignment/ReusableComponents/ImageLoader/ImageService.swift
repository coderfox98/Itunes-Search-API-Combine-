//
//  ImageService.swift
//  ItunesAPIAssignment
//
//  Created by Rishabh Raj on 27/06/20.
//  Copyright © 2020 rishstudios. All rights reserved.
//
import SwiftUI
import Combine

class ImageService : ObservableObject {
    /// Combine to update Image View Every time state is changed
    @Published var state : ImageState = .loading
    
    private var cancellable : AnyCancellable?
    
    /// Using Caching to avoid redundant image loads
    static let cache = NSCache<NSURL, UIImage>()
    
    func loadImage(url : URL) {
        
        cancellable?.cancel()
        
        if let image = ImageService.cache.object(forKey: url as NSURL) {
            state = .image(image)
            return
        }
        
        let urlSession = URLSession.shared
        let urlRequest = URLRequest(url: url)
        
        cancellable = urlSession.dataTaskPublisher(for: urlRequest)
            .map{UIImage(data: $0.data)}
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .failure(let failure):
                    self.state = .error(failure)
                case .finished :
                    break
                }
            }, receiveValue: { image in
                if let image = image {
                    ImageService.cache.setObject(image, forKey: url as NSURL)
                    self.state = .image(image)
                }else {
                    self.state = .error(ImageError.imageFormatIssue)
                }
            })
        
    }
}
