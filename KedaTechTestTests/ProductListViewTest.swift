//
//  ProductListViewTest.swift
//  KedaTechTestTests
//
//  Created by Sailendra Salsabil on 24/06/23.
//

import SwiftUI
import XCTest
import ViewInspector
@testable import KedaTechTest

final class ProductListViewTest: XCTestCase {
    
    func testIsOnFavritedEnabled() throws {
        let viewModel = ProductListViewModel()
        viewModel.isOnFavorited = true
        let view = ProductListView(viewModel: viewModel)
        let vstack = try view.inspect().navigationView().find(ViewType.VStack.self)
        let titleText = try vstack.text(0)
        XCTAssertEqual(try titleText.string(), "Favorited")
        XCTAssertEqual(try titleText.attributes().fontWeight(), .bold)
    }
    
    func testIsOnFavritedDisabled() throws {
        let viewModel = ProductListViewModel()
        viewModel.isOnFavorited = false
        let view = ProductListView(viewModel: viewModel)
        let vstack = try view.inspect().navigationView().find(ViewType.VStack.self)
        let titleText = try vstack.text(0)
        XCTAssertEqual(try titleText.string(), "Favorited")
        XCTAssertEqual(try titleText.attributes().fontWeight(), .regular)
    }
    
    func testIsOnFavoritedTapped() throws {
        let viewModel = ProductListViewModel()
        viewModel.isOnFavorited = true
        let view = ProductListView(viewModel: viewModel)
        let vstack = try view.inspect().navigationView().find(ViewType.VStack.self)
        try vstack.text(0).callOnTapGesture()
        XCTAssertFalse(viewModel.isOnFavorited)
    }
    
    func testIsLoading() throws {
        let viewModel = ProductListViewModel()
        viewModel.isLoading = true
        let view = ProductListView(viewModel: viewModel)
        let zstack = try view.inspect().navigationView().find(ViewType.VStack.self).find(ViewType.ZStack.self)
        let progressView = try? zstack.find(ViewType.ProgressView.self)
        XCTAssertNotNil(progressView)
    }
    
    func testIsNotLoading() throws {
        let viewModel = ProductListViewModel()
        viewModel.isLoading = false
        let view = ProductListView(viewModel: viewModel)
        let zstack = try view.inspect().navigationView().find(ViewType.VStack.self).find(ViewType.ZStack.self)
        let progressView = try? zstack.find(ViewType.ProgressView.self)
        XCTAssertNil(progressView)
    }
    
    func testListRow() throws {
        let viewModel = ProductListViewModel()
        let product = Product(id: nil, title: nil, description: nil, price: nil, discountPercentage: nil, rating: nil, stock: nil, brand: nil, category: nil, thumbnail: nil, images: nil)
        viewModel.listRows = [product]
        let view = ProductListView(viewModel: viewModel)
        let list = try view.inspect().navigationView().find(ViewType.VStack.self).find(ViewType.ZStack.self).list(1).find(ProductRowView.self)
        XCTAssertEqual(list.count, 1)
    }
}
