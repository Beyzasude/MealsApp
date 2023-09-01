//
//  NetworkManager.swift
//  Meals
//
//  Created by Beyza Sude Erol on 29.08.2023.
//

import Foundation

enum Path {
    case search(searchText: String)
    case detail(mealId: Int)
    
    var path: URL {
        switch self {
        case .search(let searchText):
            return URL(string: "\(baseUrl)/api/json/v1/1/search.php?s=\(searchText)")!
        case .detail(let mealId):
            return URL(string: "\(baseUrl)/api/json/v1/1/lookup.php?i=\(mealId)")!
        }
    }
    
    var baseUrl: String {
        return "https://www.themealdb.com"
    }
}

struct Resource<T: Decodable> {
    var url: Path
}


final class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchMeals<T: Decodable>(resource: Resource<T>, completion: @escaping (Result<T, Error>) -> ()) {
        
        URLSession.shared.dataTask(with: resource.url.path) { data, response, error in
            
            if let error {
                completion(.failure(error))
            }
            
            guard let data else {
                completion(.failure(NSError(domain: "Data Error", code: 0)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(NSError(domain: "Decode Error", code: 0)))
            }
            
        }.resume()
    }
}



///*basit network katmanı

/*final class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchMeals<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) ->()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error {
                completion(.failure(error))
            }
            
            guard let data else {
                completion(.failure(NSError(domain: "Data Error", code: 0)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            }catch {
                completion(.failure(NSError(domain: "Data Error", code: 0)))
            }
        }.resume()
        
    }
    
}
*/
