//
//  RefreshAccessTokenService.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-08.
//

import Foundation

protocol RefreshAccessTokenServicing {
    
    func refreshAccessToken()
}

struct RefreshAccessTokenService: RefreshAccessTokenServicing {
    
    func refreshAccessToken() {
        <#code#>
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
            "Authorization": "Basic "
        ]
    }
    
    
}
