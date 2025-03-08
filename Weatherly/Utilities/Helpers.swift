//
//  Helpers.swift
//  Weatherly
//
//  Created by Gurunarayanan Muthurakku on 09/03/25.
//

import Foundation


// MARK: - Function to Convert Date Format
func formatDate(input: String, format: String) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    inputFormatter.timeZone = TimeZone.current
    
    if let date = inputFormatter.date(from: input) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = format
        outputFormatter.timeZone = TimeZone.current
        return outputFormatter.string(from: date)
    }
    
    return input
}

// MARK: - Function to Get Weather Icon
func getWeatherIcon(for icon: String) -> String {
    switch icon {
    case "01d": return "sun.max.fill"
    case "01n": return "moon.fill"
    case "02d", "02n": return "cloud.sun.fill"
    case "03d", "03n": return "cloud.fill"
    case "04d", "04n": return "smoke.fill"
    case "09d", "09n": return "cloud.rain.fill"
    case "10d", "10n": return "cloud.heavyrain.fill"
    case "11d", "11n": return "cloud.bolt.fill"
    case "13d", "13n": return "snow"
    case "50d", "50n": return "cloud.fog.fill"
    default: return "questionmark"
    }
}

