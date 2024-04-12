//
//  NetworkManager.swift
//  NewsWire
//
//  Created by Simranjeet Kaur on 12/04/24.
//

import Foundation

class Manager {
    
    static let shared = Manager()
    
    func sendGetRequestWithURLSession<T: Decodable>(url: URL, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {

        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                let errorMessage = error?.localizedDescription ?? "Unknown error"
                print(errorMessage)
                completion(.failure(errorMessage as! Error))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                print(String(data: data, encoding: .utf8)!)
                completion(.success(decodedData))
            } catch {
                let errorMessage = error.localizedDescription
                print(String(describing: errorMessage))
                completion(.failure(URLError(.cancelled)))
            }
        }.resume()
    }
    
}
