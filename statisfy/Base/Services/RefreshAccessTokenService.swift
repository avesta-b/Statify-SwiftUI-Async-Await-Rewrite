//
//  RefreshAccessTokenService.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-08.
//

import Foundation

protocol RefreshAccessTokenServicing {
    
    func refreshAccessToken() async
}

struct RefreshAccessTokenService: RefreshAccessTokenServicing {
    
    let session: URLSessionDataFetcher = URLSession(configuration: .default)
    
    func refreshAccessToken() async {
        var request = URLRequest.init(url: url,
                                      method: .post,
                                      headers: headers)
        request.httpBody = httpBody
        
        guard let (data, response) = try? await session.fetchData(for: request, delegate: nil) else {
            debugPrint("Couldnt refresh token")
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
                  debugPrint("Couldnt get response")
                  return
                  
              }
        
        guard let model = try? JSONDecoder().decode(ResponseRefreshAccessTokenModel.self, from: data) else {
            debugPrint("Could not decode data")
            return
        }
        
        DispatchQueue.main.async {
            UserDefaults.standard.set(model.accessToken,
                                      forKey: UserDefaultsConstants.Keys.accessTokenKey)
            
            // EDIT THIS TO model.expiresIn
            UserDefaults.standard.set(600 + Int(Date().timeIntervalSince1970),
                                      forKey: UserDefaultsConstants.Keys.expiryDateKey)
            
        }
        
    }
    
    private var url: URL {
        let urlString = CommonURLs.tokenURL
        return URL(string: urlString)!
    }
    
    private var httpBody: Data {
        let parameters: [String: String] = [
            "grant_type"    : "refresh_token",
            "refresh_token" : UserDefaultsConstants.Values.refreshToken
        ]
        var components = URLComponents()
        components.queryItems = parameters.map({ (key, value) in
            URLQueryItem(name: key, value: value)
        })
        
        let queryString = components.query ?? ""
        return queryString.data(using: .utf8) ?? Data()
    }
    
    private var headers: [String: String] {
        let headers: [String: String] = [
            ContentType.rawValue: ContentType.urlFormEncoding,
            "Authorization": "Basic \(LoginSensitiveInfo.base64EncodedClientInfo)"
        ]
        return headers
    }
    
    
}
