//
//  WeatherModel.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 30/05/2025.
//

import Foundation

struct WeatherResponse: Codable {
    let properties: Properties
}

// MARK: - Properties
struct Properties: Codable {
    let timeseries: [TimeSeries]
}

// MARK: - TimeSeries
struct TimeSeries: Codable {
    let time: String
    let data: TimeSeriesData
    var date: Date {
        ISO8601DateFormatter().date(from: time) ?? Date.distantPast
    }
}

// MARK: - TimeSeriesData
struct TimeSeriesData: Codable {
    let instant: InstantData
    let next_1_hours: NextHourData?
    let next_6_hours: NextHourData?
    let next_12_hours: NextHourData?
}

// MARK: - InstantData
struct InstantData: Codable {
    let details: WeatherDetails
}

// MARK: - WeatherDetails
struct WeatherDetails: Codable {
    let air_temperature: Double?
    let relative_humidity: Double?
    let wind_speed: Double?
    let wind_speed_of_gust: Double?
    let wind_from_direction: Double?
}

// MARK: - NextHourData (symbol + opad)
struct NextHourData: Codable {
    let summary: WeatherSummary?
    let details: PrecipitationDetails?
}

struct WeatherSummary: Codable {
    let symbol_code: String
}

struct PrecipitationDetails: Codable {
    let precipitation_amount: Double?
}

struct PhotoshootEventWeatherData {
    let temperature: Double
    let rain: Double
    let wind: Double
    let symbolName: String
}
