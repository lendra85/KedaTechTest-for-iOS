//
//  DataManager.swift
//  KedaTechTest
//
//  Created by Sailendra Salsabil on 22/06/23.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private init() {}
    
    private let userDefaults = UserDefaults.standard
    
    func setFavoriteStatus(productId: String, status: Bool) {
        userDefaults.set(status, forKey: productId)
    }
    
    func getFavoriteStatus(productId: String) -> Bool {
        userDefaults.bool(forKey: productId)
    }
}
