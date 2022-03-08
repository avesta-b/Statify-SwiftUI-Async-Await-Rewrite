//
//  TopItemsService.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-07.
//

import Foundation

// To write tests, session can be mocked or injected with factory pattern
@MainActor
class TopItemsService: ObservableObject {
    
    private let session: URLSessionDataFetcher = URLSession(configuration: URLSessionConfiguration.default)
    
    enum ViewState {
        case loading
        case loaded
        case error
    }
    
    @Published private(set) var topItems: [TopItemViewModel] = []
    
    @Published private(set) var state: ViewState = .loading
    
    private var model: TopItemsModel?
    
    let topItemType: TopItemType
    
    let timeRange: TopItemTimeRange
    
    
    init(topItemType: TopItemType,
         timeRange: TopItemTimeRange) {
        self.topItemType = topItemType
        self.timeRange = timeRange
    }
    
    
    // TO DO: leverage URLExtensions to make the appropriate HTTP requests, put each case into it's own HTTP request too
    func fetch() async {
        let request = topItemsRequest
        state = .loading
        
        guard let (responseData, response) = try? await session.fetchData(for: request, delegate: nil),
              let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            state = .error
            return
        }
        
        switch topItemType {
        case .artists:
            handleHttpData(data: responseData)
        case .tracks:
            handleHttpData(data: responseData)
        }
            
        
    }
    
}

extension TopItemsService {
    
    private func handleHttpData(data: Data) {
        
        let model: TopItemsModel?
        
        switch topItemType {
        case .artists:
            guard let modelDecoded = try? JSONDecoder().decode(TopArtistsModel.self, from: data) else {
                state = .error
                return
            }
            model = modelDecoded
        case .tracks:
            guard let modelDecoded = try? JSONDecoder().decode(TopTracksModel.self, from: data) else {
                state = .error
                return
            }
            model = modelDecoded
        }
        
        topItems = model?.topItemsViewModel ?? []
        state = .loading
        
    }
    
    private var topItemsRequest: URLRequest {
        let queryParameters: [String: Any?] = [
            "limit"         : "50",
            "offset"        : "0",
            "time_range"    : timeRange.rawValue
        ]

        let apiURL = URL.generate(url: topItemURL,
                                  with: queryParameters)!
        
        let headers: [String: Any?] = [
            ContentType.rawValue    : ContentType.jsonApplication,
            "Authorization"         : UserDefaultsConstants.Values.bearerAccessToken
        ]
        
        let request = URLRequest(url: apiURL,
                                 method: .get,
                                 headers: headers)
        return request
    }
    
    private var topItemURL: String {
        return CommonURLs.apiURL + "/me/top/" + topItemType.rawValue
    }
}
