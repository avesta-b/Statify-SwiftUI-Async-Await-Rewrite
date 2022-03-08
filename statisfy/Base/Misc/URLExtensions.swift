//
//  URLExtensions.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-06.
//

import Foundation

enum HTTPMethod: String {
    
    case get    = "GET"
    
    case post   = "POST"
    
    case put    = "PUT"
    
    case delete = "DELETE"
    
    case patch  = "PATCH"
}

extension URLRequest {
    
    /// Init a request with method and headers
    init(url: URL,
         method: HTTPMethod,
         headers: [String: Any?]) {
        self.init(url: url)
        
        self.httpMethod = method.rawValue
        
        headers.forEach { (key, value) in
            guard let value = value as? String else { return }
            self.setValue(value, forHTTPHeaderField: key)
        }
    }
}

extension URL {
    
    /// Initialize a URL with query Parameters
    static func generate(url: String,
                         with queryParameters: [String: Any?]) -> URL? {
        
        var components = URLComponents(string: url)
        
        components?.queryItems = queryParameters.compactMap({ (key, value) in
            URLQueryItem(name: key, value: value as? String)
        })
        
        return components?.url
    }
}


// Mark: - Loosely couples code and can now be mocked very easily
protocol URLSessionDataFetcher {
    
    func fetchData(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionDataFetcher {
    
    func fetchData(for request: URLRequest, delegate: URLSessionTaskDelegate? = nil) async throws -> (Data, URLResponse) {
        return try await self.data(for: request, delegate: delegate)
    }
    
}
