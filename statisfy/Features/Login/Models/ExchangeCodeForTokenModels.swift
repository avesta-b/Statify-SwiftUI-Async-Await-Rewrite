//
//  RequestAccessTokenModel.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-06.
//

import Foundation

struct RequestAccessTokenModel: Encodable {
    
    let grantType: String   = "authorization_code"
    let redirectURI: String = LoginSensitiveInfo.redirectURI
    let code: String
    
    enum CodingKeys: String, CodingKey {
        case grantType      = "grant_type"
        case redirectURI    = "redirect_uri"
        case code
    }
}

struct RequestAccessTokenModelTemp: Encodable {
    
    let grantType: String       = "authorization_code"
    let redirectURI: String     = LoginSensitiveInfo.redirectURI
    let clientId: String        = LoginSensitiveInfo.clientId
    let clientSecret: String    = LoginSensitiveInfo.clientSecret
    let code: String
    
    enum CodingKeys: String, CodingKey {
        case grantType      = "grant_type"
        case redirectURI    = "redirect_uri"
        case clientId       = "client_id"
        case clientSecret   = "client_secret"
        case code
    }
}

struct ResponseAccessTokenModel: Decodable {
    
    let accessToken: String
    let tokenType: String
    let scope: String
    let expiresIn: Int
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken    = "access_token"
        case tokenType      = "token_type"
        case scope
        case expiresIn      = "expires_in"
        case refreshToken   = "refresh_token"
    }
}
