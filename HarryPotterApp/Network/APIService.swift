//
//  APIService.swift
//  HarryPotterApp
//
//  Created by Luis Felipe on 21/12/22.
//

import Foundation

public final class APIService {
    
    private let baseURL = "https://hp-api.onrender.com/api/"
    
    var session: URLSession
    var decoder: JSONDecoder
    
    var dataTask: URLSessionDataTask?
    
    init(session: URLSession = URLSession.shared,
         decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }
    
    public func getRequest<T: Codable>(endpoint: Endpoint, type: T.Type, completionHandler: @escaping (Result<T, Error>) -> Void) {

        dataTask?.cancel()
        
        let uri = URL(string: "\(baseURL)\(endpoint)")!
                
        dataTask = session.dataTask(with: uri) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
                return
            }
            
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                DispatchQueue.main.async {
                    completionHandler(.failure(error!))
                }
                return
            }
            
            do {
                let results = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(.success(results))
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
        }
        dataTask?.resume()
    }
}
