//
//  ProductViewModel.swift
//  KedaTechTest
//
//  Created by Sailendra Salsabil on 22/06/23.
//

import Foundation

class ProductListViewModel: ObservableObject {
    var products = [Product]()
    @Published var listRows = [Product]()
    @Published var isLoading = false
    @Published var isOnFavorited = false {
        didSet {
            performFilterAndSearch()
        }
    }
    @Published var searchText: String = "" {
        didSet {
            performFilterAndSearch()
        }
    }
    
    @MainActor
    func fetchListRows() async {
        isLoading = true
        NetworkManager.shared.fetchProducts { [weak self] result in
            switch result {
            case .success(let response):
                response?.products?.forEach { [weak self] product in
                    self?.products.append(product)
                    self?.listRows.append(product)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            self?.isLoading = false
        }
    }
    
    func performFilterAndSearch() {
        if isOnFavorited {
            var savedItems = [Int?]()
            products.forEach {
                if let id = $0.id, DataManager.shared.getFavoriteStatus(productId: String(id)) {
                    savedItems.append(id)
                }
            }
            listRows = listRows.filter { savedItems.contains($0.id) }
        } else {
            listRows = products
        }
        if !searchText.isEmpty {
            listRows = listRows.filter { $0.title?.lowercased().contains(searchText.lowercased()) == true || $0.description?.lowercased().contains(searchText.lowercased()) == true }
        }
    }
}

