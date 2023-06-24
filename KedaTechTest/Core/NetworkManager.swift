//
//  NetworkManager.swift
//  KedaTechTest
//
//  Created by Sailendra Salsabil on 22/06/23.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchProducts(completion: @escaping (Result<ProductResponse?, Error>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    private let apiUrl = "https://dummyjson.com/products"
    
    func fetchProducts(completion: @escaping (Result<ProductResponse?, Error>) -> Void) {
        
        guard let url = URL(string: apiUrl) else { return }
    
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            var result: Result<ProductResponse?, Error>
            
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            if let error = error {
                result = .failure(error)
            }
            
            guard let data = data else {
                result = .success(nil)
                return
            }
        
            do {
                let products = try JSONDecoder().decode(ProductResponse.self, from: data)
                result = .success(products)
            }
            catch let error {
                result = .failure(error)
            }
            
        }.resume()
    }
}
