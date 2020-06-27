//
//  AsyncImage.swift
//  ItunesAPIAssignment
//
//  Created by Rishabh Raj on 27/06/20.
//  Copyright © 2020 rishstudios. All rights reserved.
//

import SwiftUI
import Combine

enum ImageState {
    case error(_ error: Error)
    case image(_ image: UIImage)
    case loading
}

enum ImageError : Error {
    case imageFormatIssue
}

extension ImageError : LocalizedError {
    var errorDescription: String? {
        return "Unable to load"
    }
}

struct AsyncImage<ErrorView : View, ImageView : View, LoadingView: View> : View {
    private let url : URL
    private let errorView : (Error) -> ErrorView
    private let imageView : (Image) -> ImageView
    private let loadingView: () -> LoadingView
    
    @ObservedObject private var service = ImageService()
    
    init(_ url : URL, @ViewBuilder errorView : @escaping (Error) -> ErrorView, @ViewBuilder imageView : @escaping (Image) -> ImageView, @ViewBuilder loadingView : @escaping () -> LoadingView) {
        self.url = url
        self.errorView = errorView
        self.imageView = imageView
        self.loadingView = loadingView
    }
    
    
    
    var body: AnyView {
        switch service.state {
        case .error(let error):
            return AnyView(errorView(error))
        case .image(let image):
            return AnyView(imageView(Image(uiImage: image)))
        case .loading:
            return AnyView(
                loadingView()
                    .onAppear(perform: {
                        self.service.loadImage(url: self.url)
                    })
            )
        }
    }
    
}
