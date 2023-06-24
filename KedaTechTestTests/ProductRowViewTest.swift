//
//  ProductRowViewTest.swift
//  KedaTechTestTests
//
//  Created by Sailendra Salsabil on 23/06/23.
//

import SwiftUI
import XCTest
import ViewInspector
@testable import KedaTechTest

final class ProductRowViewTest: XCTestCase {
    
    func testProductWhenNil() throws {
        let product = Product(id: nil, title: nil, description: nil, price: nil, discountPercentage: nil, rating: nil, stock: nil, brand: nil, category: nil, thumbnail: nil, images: nil)
        let rowView = ProductRowView(model: product)
        let imageLoaderView = try rowView.inspect().hStack().find(ImageLoaderView.self).actualView()
        let favoriteButton = try rowView.inspect().hStack().find(FavoriteButton.self).actualView()
        let defaultColor = try favoriteButton.inspect().find(ViewType.Image.self).foregroundColor()
        try favoriteButton.inspect().button().tap()
        
        XCTAssertEqual(defaultColor, Color.gray)
        
        XCTAssertEqual(imageLoaderView.imageUrl, "")
    }
    
    func testProductWhenNotNil() throws {
        let id = 111122
        let imageUrl = "https://example.com"
        let title = "Ini titlenya"
        let description = "Ini descriptionnya"
        DataManager.shared.setFavoriteStatus(productId: String(id), status: true)
        let product = Product(id: id, title: title, description: description, price: nil, discountPercentage: nil, rating: nil, stock: nil, brand: nil, category: nil, thumbnail: imageUrl, images: nil)
        let rowView = ProductRowView(model: product)
        let imageLoaderView = try rowView.inspect().hStack().find(ImageLoaderView.self).actualView()
        let favoriteButton = try rowView.inspect().hStack().find(FavoriteButton.self).actualView()
        let defaultColor = try favoriteButton.inspect().find(ViewType.Image.self).foregroundColor()
        let vstack = try rowView.inspect().hStack().find(ViewType.VStack.self)
        let titleText = try vstack.text(0).string()
        let descriptionText = try vstack.text(1).string()
        try favoriteButton.inspect().button().tap()
        
        XCTAssertEqual(defaultColor, Color.red)
        XCTAssertEqual(imageLoaderView.imageUrl, imageUrl)
        XCTAssertEqual(titleText, title)
        XCTAssertEqual(descriptionText, description)
        
        UserDefaults.standard.removeObject(forKey: String(id))
    }
}
