//
//  BeerMedia.swift
//  FractalAPI
//
//  Created by Alexandre  Machado on 28/01/24.
//

import Foundation

struct BeerMedia: Codable {
    let id: Int
    let name: String
    let tagline: String
    let image_url: String
    let description: String
    
    func toData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    static func fromData(_ data: Data) throws -> BeerMedia {
        return try JSONDecoder().decode(BeerMedia.self, from: data)
    }
    
    init(data: Data) throws {
        self = try JSONDecoder().decode(BeerMedia.self, from: data)
    }
}
