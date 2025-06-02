//
//  LocationModel.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 02/06/2025.
//

public struct LocationIQResult: Codable {
    let lat: String
    let lon: String
    let display_name: String
}

public struct LocationIQReverseResult: Codable {
    let display_name: String
}
