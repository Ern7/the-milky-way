//
//  NasaResponse.swift
//  TheMilkyWay
//
//  Created by Ernest Nyumbu on 2021/11/22.
//

import Foundation


// MARK: - NasaResponse
struct NasaResponse: Codable {
    let collection: Collection
}

// MARK: - Collection
struct Collection: Codable {
    let version: String
    let href: String
    let items: [Item]
    let metadata: Metadata
    let links: [CollectionLink]
}

// MARK: - Item
struct Item: Codable {
    let href: String
    let data: [Datum]
    let links: [ItemLink]
}

// MARK: - Datum
struct Datum: Codable {
    let center: Center
    let title: String
    let photographer: String?
    let keywords: [String]?
    let nasaID: String
    let mediaType: MediaType
    let dateCreated: String
    let datumDescription: String
    let description508, secondaryCreator, location: String?
    let album: [String]?    

    enum CodingKeys: String, CodingKey {
        case center, title, photographer, keywords
        case nasaID = "nasa_id"
        case mediaType = "media_type"
        case dateCreated = "date_created"
        case datumDescription = "description"
        case description508 = "description_508"
        case secondaryCreator = "secondary_creator"
        case location, album
    }
}

enum Center: String, Codable {
    case arc = "ARC"
    case gsfc = "GSFC"
    case hq = "HQ"
    case jpl = "JPL"
    case jsc = "JSC"
    case ksc = "KSC"
}

enum MediaType: String, Codable {
    case image = "image"
    case video = "video"
}

// MARK: - ItemLink
struct ItemLink: Codable {
    let href: String
    let rel: Rel
    let render: MediaType?
}

enum Rel: String, Codable {
    case captions = "captions"
    case preview = "preview"
}

// MARK: - CollectionLink
struct CollectionLink: Codable {
    let rel, prompt: String
    let href: String
}

// MARK: - Metadata
struct Metadata: Codable {
    let totalHits: Int

    enum CodingKeys: String, CodingKey {
        case totalHits = "total_hits"
    }
}



extension NasaResponse {
    
    static var all: Resource<NasaResponse> = {
        
        guard let url = URL(string: "https://images-api.nasa.gov/search?q=%22%22") else {
            fatalError("URL is incorrect!")
        }
        
        var resource = Resource<NasaResponse?>(url: url)
        
        return Resource<NasaResponse>(url: url)
    }()
}
