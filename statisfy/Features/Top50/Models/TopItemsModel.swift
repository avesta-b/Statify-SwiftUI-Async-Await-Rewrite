//
//  TopArtistModel.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-07.
//

import Foundation

// MARK: - Shared

// This enum determines which state we are in
// The Model translates to the same ViewModel, therefore, we need to create a protocol that returns the ViewModel from the model
enum TopItemType {
    case artists
    case tracks
}

// Now we make each Model conform to this protocol
protocol TopItemsModel {
    var topItemsViewModel: [TopItemViewModel] { get }
}


// MARK: - Top Artists

// MARK: - TopArtistsModel
struct TopArtistsModel: Codable {
    let items: [ArtistItem]?
    let total, limit, offset: Int?
    let href: String?
}

// MARK: - ArtistItem
struct ArtistItem: Codable {
    let externalUrls: ExternalUrls?
    let followers: Followers?
    let genres: [String]?
    let href: String?
    let id: String?
    let images: [SpotifyImage]?
    let name: String?
    let popularity: Int?
    let type: TypeEnum?
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers, genres, href, id, images, name, popularity, type, uri
    }
}

// MARK: - ExternalUrls
struct ExternalUrls: Codable {
    let spotify: String?
}

// MARK: - Followers
struct Followers: Codable {
    let total: Int?
}

// MARK: - SpotifyImage
struct SpotifyImage: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}

enum TypeEnum: String, Codable {
    case artist = "artist"
    case album = "album"
    case track = "track"
}


// MARK: - Top Tracks

// MARK: - TopTracksModel
struct TopTracksModel: Codable {
    let items: [TrackItem]?
    let total, limit, offset: Int?
    let href: String?
}

// MARK: - Item
struct TrackItem: Codable {
    let album: AlbumItem?
    let artists: [TrackArtistItem]?
    let availableMarkets: [String]?
    let discNumber, durationMS: Int?
    let explicit: Bool?
    let externalIDS: ExternalIDS?
    let externalUrls: ExternalUrls?
    let href: String?
    let id: String?
    let isLocal: Bool?
    let name: String?
    let popularity: Int?
    let previewURL: String?
    let trackNumber: Int?
    let type: TypeEnum?
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case album, artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case externalIDS = "external_ids"
        case externalUrls = "external_urls"
        case href, id
        case isLocal = "is_local"
        case name, popularity
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type, uri
    }
}

// MARK: - AlbumItem
struct AlbumItem: Codable {
    let albumType: String?
    let artists: [TrackArtistItem]?
    let availableMarkets: [String]?
    let externalUrls: ExternalUrls?
    let href: String?
    let id: String?
    let images: [SpotifyImage]?
    let name, releaseDate, releaseDatePrecision: String?
    let totalTracks: Int?
    let type: TypeEnum?
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case artists
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href, id, images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case totalTracks = "total_tracks"
        case type, uri
    }
}

// MARK: - TrackArtistItem
struct TrackArtistItem: Codable {
    let externalUrls: ExternalUrls?
    let href: String?
    let id, name: String?
    let type: TypeEnum?
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href, id, name, type, uri
    }
}

// MARK: - ExternalIDS
struct ExternalIDS: Codable {
    let isrc: String?
}



// MARK: - Extensions & Protocol Conformances

// MARK: - TopArtistsModel conforming to TopItemModel
extension TopArtistsModel: TopItemsModel {
    
    var topItemsViewModel: [TopItemViewModel] {
        var i = 0
        var res: [TopItemViewModel] = []
        self.items?.forEach({ artistItem in
            let imageURL = artistItem.images?.last(where: { image in
                image.url != nil && image.width ?? 0 >= 200
            })
            let viewModel = TopItemViewModel(text: artistItem.name ?? "NO NAME",
                                             rank: i,
                                             imageURL: imageURL?.url)
            i += 1
            res.append(viewModel)
        })
        
        return res
    }

}

extension TopTracksModel: TopItemsModel {
    
    var topItemsViewModel: [TopItemViewModel] {
        var i = 0
        var res: [TopItemViewModel] = []
        self.items?.forEach({ trackItem in
            let imageURL = trackItem.album?.images?.last(where: { image in
                image.url != nil && image.width ?? 0 >= 200
            })
            let viewModel = TopItemViewModel(text: trackItem.name ?? "NO NAME",
                                             rank: i,
                                             imageURL: imageURL?.url)
            i += 1
            res.append(viewModel)
        })
        
        return res
    }
}
