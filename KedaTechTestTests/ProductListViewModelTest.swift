//
//  ProductListViewModelTest.swift
//  KedaTechTestTests
//
//  Created by Sailendra Salsabil on 24/06/23.
//

import XCTest
@testable import KedaTechTest

final class ProductListViewModelTest: XCTestCase {
    
    func testPerformFilterOnFavorited() {
        let id = 99
        let viewModel = ProductListViewModel()
        let product = Product(id: id, title: nil, description: nil, price: nil, discountPercentage: nil, rating: nil, stock: nil, brand: nil, category: nil, thumbnail: nil, images: nil)
        DataManager.shared.setFavoriteStatus(productId: String(id), status: true)
        viewModel.products = [product]
        viewModel.listRows = [product]
        viewModel.isOnFavorited = true
        XCTAssertEqual(viewModel.listRows.count, 1)
        
        UserDefaults.standard.removeObject(forKey: String(id))
    }
    
    func testPerformFilterOnFavoritedEmpty() {
        let id = 99
        let viewModel = ProductListViewModel()
        let product = Product(id: id, title: nil, description: nil, price: nil, discountPercentage: nil, rating: nil, stock: nil, brand: nil, category: nil, thumbnail: nil, images: nil)
        UserDefaults.standard.removeObject(forKey: String(id))
        viewModel.products = [product]
        viewModel.listRows = [product]
        viewModel.isOnFavorited = true
        XCTAssertEqual(viewModel.listRows.count, 0)
    }
    
    func testPerformFilterOnFavoritedFalse() {
        let id = 99
        let viewModel = ProductListViewModel()
        let product = Product(id: id, title: nil, description: nil, price: nil, discountPercentage: nil, rating: nil, stock: nil, brand: nil, category: nil, thumbnail: nil, images: nil)
        UserDefaults.standard.removeObject(forKey: String(id))
        viewModel.products = [product]
        viewModel.listRows = [product]
        viewModel.isOnFavorited = false
        XCTAssertEqual(viewModel.listRows.count, 1)
    }
    
    func testPerformSearchText() {
        let keyword = "Ini keyword nya"
        let viewModel = ProductListViewModel()
        let product = Product(id: nil, title: keyword, description: nil, price: nil, discountPercentage: nil, rating: nil, stock: nil, brand: nil, category: nil, thumbnail: nil, images: nil)
        viewModel.products = [product]
        viewModel.listRows = [product]
        viewModel.searchText = keyword
        XCTAssertEqual(viewModel.listRows.count, 1)
    }
    
    func testPerformSearchTextNotFound() {
        let viewModel = ProductListViewModel()
        let product = Product(id: nil, title: "keyword", description: nil, price: nil, discountPercentage: nil, rating: nil, stock: nil, brand: nil, category: nil, thumbnail: nil, images: nil)
        viewModel.products = [product]
        viewModel.listRows = [product]
        viewModel.searchText = "Ini keyword nya"
        XCTAssertEqual(viewModel.listRows.count, 0)
    }
    
    func testFetchData() {
        let viewModel = ProductListViewModel()
        let exp = expectation(description: "")
        Task {
            await viewModel.fetchListRows()
            XCTAssertTrue(viewModel.isLoading)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                exp.fulfill()
            }
        }
        waitForExpectations(timeout: 5)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.products.isEmpty)
        XCTAssertFalse(viewModel.listRows.isEmpty)
    }
}
