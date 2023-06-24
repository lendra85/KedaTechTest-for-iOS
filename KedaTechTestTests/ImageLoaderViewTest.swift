//
//  ImageLoaderViewTest.swift
//  KedaTechTestTests
//
//  Created by Sailendra Salsabil on 23/06/23.
//

import SwiftUI
import XCTest
import ViewInspector
@testable import KedaTechTest

final class ImageLoaderViewTest: XCTestCase {

    func testUrlNotCorrect() throws {
        let imageLoader = ImageLoaderView(imageUrl: "",
                                          imageSize: CGSize(width: 100, height: 80),
                                          radius: 5)
        let asyncImage = try imageLoader.inspect().find(ViewType.AsyncImage.self)
        let url = try asyncImage.url()
        let exp = expectation(description: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            exp.fulfill()
        }
        waitForExpectations(timeout: 1.1)
        let image = try asyncImage.find(ViewType.Image.self)
        XCTAssertNil(url?.absoluteString)
        XCTAssertEqual(try image.actualImage(), Image(systemName: "photo"))
    }

    func testUrlCorrect() throws {
        let imageLoader = ImageLoaderView(imageUrl: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
                                          imageSize: CGSize(width: 100, height: 80),
                                          radius: 5)
        let asyncImage = try imageLoader.inspect().find(ViewType.AsyncImage.self)
        let url = try asyncImage.url()
        let exp = expectation(description: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            exp.fulfill()
        }
        waitForExpectations(timeout: 5.1)
        let image = try asyncImage.find(ViewType.Image.self)
        let progressView = try asyncImage.find(ViewType.ProgressView.self)
        
        XCTAssertNotNil(url?.absoluteString)
        XCTAssertNotNil(image)
        XCTAssertNotNil(progressView)
    }
}
