//
//  BeerDetailedViewModel.swift
//  FractalAPI
//
//  Created by Alexandre  Machado on 29/01/24.
//

import Foundation

class BeerDetailedViewModel {
    
    private var beerMedia: BeerMedia
    var isFavorited: Bool
    
    init(beerMedia:BeerMedia, isFavorited: Bool) {
        self.beerMedia = beerMedia
        self.isFavorited = isFavorited
    }
    
    public func getBeerMedia() -> BeerMedia{
        return beerMedia
    }
    
    public func favorited() {
        if isFavorited {
            
            var favorites: [Data] = UserDefaults.standard.array(forKey: "Favorites") as? [Data] ?? []
            do {
                let data = try beerMedia.toData()
                favorites.append(data)
            } catch {
                print("Erro ao converter o objeto para Data:", error)
            }
            UserDefaults.standard.set(favorites, forKey: "Favorites")
            
            
        } else {
            var favorites: [Data] = UserDefaults.standard.array(forKey: "Favorites") as? [Data] ?? []
            do {
                let data = try beerMedia.toData()
                favorites.removeAll{ $0 == data }
                UserDefaults.standard.set(favorites, forKey: "Favorites")
                
            } catch {
                print("Erro ao converter o objeto para Data:", error)
            }
            
        }
    }
    
}
