//
//  ImageLoaderView.swift
//  KedaTechTest
//
//  Created by Sailendra Salsabil on 22/06/23.
//

import SwiftUI

struct ImageLoaderView: View {
    let imageUrl: String
    let imageSize: CGSize
    let radius: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Image(systemName: "photo")
            } else {
                ProgressView()
            }
        }
        .frame(width: imageSize.width, height: imageSize.height)
        .cornerRadius(radius)
    }
}

