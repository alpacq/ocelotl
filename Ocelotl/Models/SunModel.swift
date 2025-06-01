//
//  SunModel.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 31/05/2025.
//

import Foundation

struct SunResponse: Codable {
    let results: SunResults
}

struct SunResults: Codable {
    let sunrise: String
    let sunset: String
    let civil_twilight_begin: String
    let civil_twilight_end: String
}
