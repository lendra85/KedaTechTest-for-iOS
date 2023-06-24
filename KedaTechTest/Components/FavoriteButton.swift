//
//  FavoriteButton.swift
//  KedaTechTest
//
//  Created by Sailendra Salsabil on 22/06/23.
//

import SwiftUI

struct FavoriteButton: View {
    var isFavorite: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(isFavorite ? .red : .gray)
        }
    }
}

