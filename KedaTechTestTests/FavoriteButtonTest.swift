//
//  FavoriteButtonTest.swift
//  KedaTechTestTests
//
//  Created by Sailendra Salsabil on 23/06/23.
//

import SwiftUI
import XCTest
import ViewInspector
@testable import KedaTechTest

final class FavoriteButtonTest: XCTestCase {

    func testDefaultButton() throws {
        var isFavorite = false
        let favoriteButton = FavoriteButton(isFavorite: isFavorite) {
            isFavorite = true
        }
        let button = try favoriteButton.inspect().button()
        XCTAssertFalse(isFavorite)
        try button.tap()
        XCTAssertTrue(isFavorite)
    }
    
    func testFavoritedButton() throws {
        let favoriteButton = FavoriteButton(isFavorite: true) { }
        let foregroundColor = try favoriteButton.inspect().find(ViewType.Image.self).foregroundColor()
        XCTAssertEqual(foregroundColor, Color.red)
    }
}
