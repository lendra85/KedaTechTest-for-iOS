//
//  ProductRowView.swift
//  KedaTechTest
//
//  Created by Sailendra Salsabil on 22/06/23.
//

import SwiftUI

struct ProductRowView: View {
    @State var model: Product
    @State var isFavorite: Bool
    
    init(model: Product) {
        self.model = model
        if let id = model.id {
            isFavorite = DataManager.shared.getFavoriteStatus(productId: String(id))
        } else {
            isFavorite = false
        }
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            ImageLoaderView(imageUrl: model.thumbnail ?? "",
                             imageSize: CGSize(width: 100, height: 80),
                             radius: 5)
            VStack(alignment: .leading) {
                Text(model.title ?? "").font(.headline)
                Text(model.description ?? "").font(.subheadline)
            }.frame(maxWidth: .infinity)
            FavoriteButton(isFavorite: isFavorite) {
                isFavorite.toggle()
                if let id = model.id {
                    DataManager.shared.setFavoriteStatus(productId: String(id), status: isFavorite)
                }
            }.frame(maxWidth: 30)
        }.padding().fixedSize(horizontal: false, vertical: true)
    }
}
