//
//  LoginManager.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-06.
//

import Foundation

enum NetworkError: Error {
    case failedToMakeURL
    case failedToUrlFormEncode
    case failedToMakeData
    case invalidResponse
    
    case decodingFailed
    
    case authError
    case badRequest
    case outdated
    case failed
    
    static func fetchError(from statusCode: Int) -> NetworkError? {
        switch statusCode {
        case 401...500:
            return .authError
        case 501...599:
            return .badRequest
        case 600:
            return .outdated
        default:
            return nil
        }
    }
}

enum ExtractCodeError: Error {
    case noItems
    case accessDenied
    case noCode
}

/// Protocol that generates LoginURL, can be swapped out at runtime for unit tests and mocks
/// Use LoginURLGenerator.generate to retrieve the appropriate loginURLGenerator
protocol LoginManager {
    var loginRequest: URLRequest { get }
    
    func extractCode(url: URL) -> Result<String, ExtractCodeError>
    
    func tradeCodeForToken(with code: String) async throws -> ResponseAccessTokenModel
}

struct ProductionLoginManager: LoginManager {
    
    
    let session: URLSession
    
    private let decoder = JSONDecoder()
    
    var loginRequest: URLRequest {
        // Force unwrap URL
        let url = URL.generate(url: "https://accounts.spotify.com/authorize",
                               with: [
                                "client_id"     : LoginSensitiveInfo.clientId,
                                "redirect_uri"  : LoginSensitiveInfo.redirectURI,
                                "response_type" : "code",
                                "show_dialog"   : "true",
                                "scope"         : "user-top-read,user-read-recently-played,user-read-private,user-read-email"
                               ])!
        let request = URLRequest(url: url)
        return request
    }
    
    // Write unit test for this
    func extractCode(url: URL) -> Result<String, ExtractCodeError> {
        guard let queryItems = URLComponents(string: url.absoluteString)?
                .queryItems else {
                    return .failure(.noItems)
                }
        
        // Make sure access was granted
        guard queryItems
                .contains(where: {$0.value != "access_denied"}) != false else {
                    // Handle access being denied here
                    return .failure(.accessDenied)
                }
        
        guard let item = queryItems
                .first(where: { $0.name == "code"} ),
              let code = item.value else {
                    // Handle no code here
                  return .failure(.noCode)
                }
        
        return .success(code)
    }
    
    func tradeCodeForToken(with code: String) async throws -> ResponseAccessTokenModel {
        let request = try generateRequest(code: code)
        let (responseData, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        // If the error is not nil, throw the error
        let error = NetworkError.fetchError(from: httpResponse.statusCode)
        guard error == nil else {
            throw error!
        }
        
        do {
            let responseModel = try decoder.decode(ResponseAccessTokenModel.self, from: responseData)
            return responseModel
        } catch {
            throw NetworkError.decodingFailed
        }
        
    }
    
}

// Todo: unit test this logic
extension ProductionLoginManager {
    
    // Write unit test for this
    func makeHttpBodyFromCode(code: String) throws -> Data {
        let requestBody = RequestAccessTokenModelTemp(code: code)
        let postBody: [String: String] = [
            RequestAccessTokenModelTemp.CodingKeys.clientId.rawValue    : requestBody.clientId,
            RequestAccessTokenModelTemp.CodingKeys.code.rawValue        : code,
            RequestAccessTokenModelTemp.CodingKeys.clientSecret.rawValue: requestBody.clientSecret,
            RequestAccessTokenModelTemp.CodingKeys.redirectURI.rawValue : requestBody.redirectURI,
            RequestAccessTokenModelTemp.CodingKeys.grantType.rawValue   : requestBody.grantType
        ]
        var components = URLComponents()
        components.queryItems = postBody.map({ (key, value) in
            URLQueryItem(name: key, value: value)
        })
        let requestBodyEncoded = components.query
        
        guard let requestBodyString = requestBodyEncoded else {
            throw NetworkError.failedToUrlFormEncode
        }
        
        guard let data = requestBodyString.data(using: .utf8) else {
            throw NetworkError.failedToMakeData
        }
        
        return data
        
    }
    
    // Write unit test for this
    func generateRequest(code: String) throws -> URLRequest {
        guard let url = URL(string: CommonURLs.tokenURL) else { throw NetworkError.failedToMakeURL }
        var request = URLRequest(url: url,
                                 method: .post,
                                 headers: [
                                    ContentType.rawValue : ContentType.urlFormEncoding
                                 ])
        request.timeoutInterval = 30
        request.httpBody = try makeHttpBodyFromCode(code: code)
        return request
    }
}
