//
//  ForecastCardView.swift
//  Weatherly
//
//  Created by Gurunarayanan Muthurakku on 09/03/25.
//

import SwiftUI

// MARK: - Small Forecast Card for Horizontal List
struct ForecastCardView: View {
    let weather: WeatherItem
    
    var body: some View {
        VStack {
            Text(weather.formattedShortDate) // Example: "10 Mar, 3:00 PM"
                .foregroundColor(.white)
                .font(.caption)
            
            Image(systemName: getWeatherIcon(for: weather.weather.first?.icon ?? ""))
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.yellow)
            
            Text("\(weather.main.temp.formatted(.number.precision(.fractionLength(1))))°C")
                .foregroundColor(.white)
                .bold()
        }
        .padding()
        .background(Color.blue.opacity(0.5))
        .cornerRadius(10)
    }
}
