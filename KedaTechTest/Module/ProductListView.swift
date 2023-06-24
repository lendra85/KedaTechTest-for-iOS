//
//  ProductListView.swift
//  KedaTechTest
//
//  Created by Sailendra Salsabil on 22/06/23.
//

import SwiftUI

struct ProductListView: View {
    @StateObject var viewModel = ProductListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Favorited")
                    .fontWeight(viewModel.isOnFavorited ? .bold : .regular)
                    .encapulate(borderColor: viewModel.isOnFavorited ? .black : .gray)
                    .onTapGesture {
                        withAnimation() {
                            viewModel.isOnFavorited.toggle()
                        }
                    }.padding(.bottom, 7)
                ZStack {
                    if viewModel.isLoading {
                        ProgressView()
                    }
                    List(viewModel.listRows, id: \.title) { item in
                        ProductRowView(model: item)
                            .listRowInsets(EdgeInsets())
                    }
                    .navigationBarTitle("Products")
                }
            }
            .task {
                await viewModel.fetchListRows()
            }
        }
        .searchable(text: $viewModel.searchText)
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
