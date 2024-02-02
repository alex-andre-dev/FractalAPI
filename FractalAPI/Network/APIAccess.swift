//
//  APIAccess.swift
//  FractalAPI
//
//  Created by Alexandre  Machado on 28/01/24.
//

import Foundation

class APIAccess {
    
    enum NetworkError: Error {
        case badResponse(URLResponse?)
        case badData
    }
    
    static var shared = APIAccess()
    
    let session: URLSession
    
    private let baseUrl = "https://api.punkapi.com/v2/beers"
    
    init(){
        session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    private func request(url: URL) -> URLRequest{
        let request = URLRequest(url: url)
        return request
    }
    
    func posts(completion: @escaping (Result<[BeerMedia], Error>) -> Void){
        guard let url = URL(string: baseUrl) else { return }
        let req = request(url: url)
        
        let task = session.dataTask(with: req) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.badResponse(response)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.badData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode([BeerMedia].self, from: data)
                completion(.success(response))
            } catch let error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
