//
//  WeatherResponse.swift
//  Weatherly
//
//  Created by Gurunarayanan Muthurakku on 09/03/25.
//


import Foundation

// MARK: - Weather Data Models
struct WeatherResponse: Codable {
    let list: [WeatherItem]
    let city: City
}

struct WeatherItem: Codable, Identifiable {
    let id = UUID()
    let dt_txt: String
    let main: MainWeather
    let weather: [Weather]
    let wind: Wind
    let clouds: Clouds
    
    enum CodingKeys: String, CodingKey {
        case dt_txt, main, weather, wind, clouds
    }
    
    // Formatted date for today's forecast
    var formattedDate: String {
        formatDate(input: dt_txt, format: "EEEE, MMMM d, yyyy")  // "Sunday, March 10, 2025"
    }
    
    // Formatted short date for forecast list
    var formattedShortDate: String {
        formatDate(input: dt_txt, format: "d MMM, h:mm a")  // "10 Mar, 3:00 PM"
    }
}

struct MainWeather: Codable {
    let temp: Double
    let feels_like: Double
    let humidity: Int
}

struct Weather: Codable {
    let description: String
    let icon: String
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct Clouds: Codable {
    let all: Int
}

struct City: Codable {
    let name: String
    let country: String
}
