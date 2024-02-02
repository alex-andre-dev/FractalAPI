//
//  BeersCollectionViewModel.swift
//  FractalAPI
//
//  Created by Alexandre  Machado on 28/01/24.
//

import Foundation

class BeersCollectionViewModel {
    
    private let api = APIAccess.shared
    private var beerMedias: [BeerMedia] = []
    private var filteredBeerMedias: [BeerMedia] = []
    
    var numberOfBeersFiltered: Int {
        return filteredBeerMedias.count
    }
    
    func fetchMedias(completion:  @escaping (Error?) -> Void) {
        api.posts { [weak self] result in
            switch result {
            case .success(let items):
                print(items)
                self?.beerMedias = items
                completion(nil)
            case .failure(let error):
                print(error)
                completion(error)
            }
        }
    }
    
    public func beerMedia(at index: Int) -> BeerMedia {
        return filteredBeerMedias[index]
    }
    
    public func getAllBeers() -> [BeerMedia] {
        return beerMedias
    }
    
    public func setAllBeers(beerMedias: [BeerMedia]) {
        self.beerMedias = beerMedias
    }
    
    public func getFilteredBeers() -> [BeerMedia] {
        return filteredBeerMedias
    }
    
    public func setFilteredBeers(beerMedias: [BeerMedia]) {
        self.filteredBeerMedias = beerMedias
    }
    
    public func setAllfilteredBeers(){
        self.filteredBeerMedias = beerMedias
    }
}
