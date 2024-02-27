//
//  NetworkManeger.swift
//  Test4RedpeadTest1
//
//  Created by Богдан Бончев on 24.02.2024.
//

import UIKit

enum NetworkError:  Error{
    case invalidUrl
    case noData
    case unknown(String)
}

protocol NemworkManagerProtocol {
    func fetchData (url: URL, completion: @escaping (Result<Data, NetworkError>)-> Void)
}

class NetworkManager: NemworkManagerProtocol{
    func fetchData(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) {data,_,error in
            if let error {
                completion(.failure(.unknown(error.localizedDescription)))
                return
            }
            guard let data else {
                completion(.failure(.noData))
                return
            }
            completion(.success(data))
        }.resume()
    }
}
