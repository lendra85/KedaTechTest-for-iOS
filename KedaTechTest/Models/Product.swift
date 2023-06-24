//
//  Product.swift
//  KedaTechTest
//
//  Created by Sailendra Salsabil on 22/06/23.
//

import Foundation

struct Product: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let price: Int?
    let discountPercentage: Double?
    let rating: Double?
    let stock: Int?
    let brand: String?
    let category: String?
    let thumbnail: String?
    let images: [String]?
    var isFavorite = false

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case price = "price"
        case discountPercentage = "discountPercentage"
        case rating = "rating"
        case stock = "stock"
        case brand = "brand"
        case category = "category"
        case thumbnail = "thumbnail"
        case images = "images"
    }
}

struct ProductResponse: Codable {
    let products: [Product]?
    let total: Int?
    let skip: Int?
    let limit: Int?

    private enum CodingKeys: String, CodingKey {
        case products = "products"
        case total = "total"
        case skip = "skip"
        case limit = "limit"
    }
}
