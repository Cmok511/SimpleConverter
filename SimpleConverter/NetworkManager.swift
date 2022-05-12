//
//  NetworkManager.swift
//  SimpleConverter
//
//  Created by Денис Чупров on 06.05.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func getData(url: String, complition: @escaping (Money?) -> (Void)) {
        guard let url = URL(string: url) else {return}
    
    let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            do {
                let json = try JSONDecoder().decode(Money.self, from: data)
                complition(json)
            }
            catch {
                print(error.localizedDescription)
                
            }
            
        }.resume()
    
    }
}
