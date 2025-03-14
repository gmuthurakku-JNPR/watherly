//
//  APIRepository.swift
//  Weatherly
//
//  Created by Gurunarayanan Muthurakku on 14/03/25.
//


import Foundation

protocol WebRepository {
    func get<T: Decodable>(url: String, completion: @escaping (Result<T, Error>) -> Void)
    func post<T: Decodable>(url: String, body: Data?, completion: @escaping (Result<T, Error>) -> Void)
    func put<T: Decodable>(url: String, body: Data?, completion: @escaping (Result<T, Error>) -> Void)
    func delete<T: Decodable>(url: String, completion: @escaping (Result<T, Error>) -> Void)
}

class APIRepository: WebRepository {
    static let shared = APIRepository() // Singleton instance
    
    private init() {}

    private func request<T: Decodable>(url: String, method: String, body: Data? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                completion(.failure(APIError.decodingError(error)))
            }
        }.resume()
    }
    
    func get<T: Decodable>(url: String, completion: @escaping (Result<T, Error>) -> Void) {
        request(url: url, method: "GET", completion: completion)
    }
    
    func post<T: Decodable>(url: String, body: Data?, completion: @escaping (Result<T, Error>) -> Void) {
        request(url: url, method: "POST", body: body, completion: completion)
    }
    
    func put<T: Decodable>(url: String, body: Data?, completion: @escaping (Result<T, Error>) -> Void) {
        request(url: url, method: "PUT", body: body, completion: completion)
    }
    
    func delete<T: Decodable>(url: String, completion: @escaping (Result<T, Error>) -> Void) {
        request(url: url, method: "DELETE", completion: completion)
    }
}

// MARK: - API Errors
enum APIError: Error {
    case invalidURL
    case noData
    case decodingError(Error)
}
