//
//  ModelCountry.swift
//  Test4RedpeadTest1
//
//  Created by Богдан Бончев on 23.02.2024.
//

import UIKit

//MARK: URL for parsing

struct Country: Codable {
    let name: Name?
    let region: String?
    let subregion: String?
    let languages: [String: String]?
    let flags: Flags?
    let maps: Maps?
    let coatOfArms: CoatOfArms?
    let population: Int?
    let continents: [String?]
    let area: Double?
    let fifa: String?
    let postalCode: PostalCode?
    let altSpellings: [String]
    let translations: [String: Translation]
    let capitalInfo: CapitalInfo?
    let unMember: Bool
    let borders: [String]?
    let independent: Bool?
    let capital: [String]?
    let status: String?
    
    
}
//MARK: Flags

struct Flags: Codable{
    let png: String?
    let svg: String?
    let alt: String?
}

// MARK: - CapitalInfo

struct CapitalInfo: Codable {
    let latlng: [Double]?
}

struct Side: Codable {
    let sideLeft: String?
    let sideRight: String?
}

// MARK: - CoatOfArms

struct CoatOfArms: Codable {
    let png: String?
    let svg: String?
}

// MARK: - Idd

struct Idd: Codable {
    let root: String?
    let suffixes: [String]?
}

// MARK: - Maps

struct Maps: Codable {
    let googleMaps, openStreetMaps: String
}

// MARK: - Name

struct Name: Codable {
    let common, official: String
    let nativeName: [String: Translation]?
}

// MARK: - Translation

struct Translation: Codable {
    let official: String?
    let common: String?
}

// MARK: - PostalCode

struct PostalCode: Codable {
    let format: String
    let regex: String?
}

//MARK: StartOfWeek

struct StartOfWeek: Codable {
    let  monday: String?
    let saturday: String?
    let sunday: String?
}

//MARK: Status

struct Status: Codable {
    let officiallyAssigned: String?
    let userAssigned: String?
}

