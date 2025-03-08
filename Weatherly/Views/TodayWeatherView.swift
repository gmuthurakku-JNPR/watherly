//
//  TodayWeatherView.swift
//  Weatherly
//
//  Created by Gurunarayanan Muthurakku on 09/03/25.
//

import SwiftUI

// MARK: - Today's Full-Screen Weather View
struct TodayWeatherView: View {
    let weather: WeatherItem
    let cityName: String
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Weather in \(cityName)")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
            
            Text(weather.formattedDate)
                .foregroundColor(.white.opacity(0.8))
            
            Image(systemName: getWeatherIcon(for: weather.weather.first?.icon ?? ""))
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.yellow)
            
            Text("\(weather.main.temp.formatted(.number.precision(.fractionLength(1))))°C")
                .font(.system(size: 64))
                .bold()
                .foregroundColor(.white)
            
            Text(weather.weather.first?.description.capitalized ?? "")
                .font(.title2)
                .foregroundColor(.white.opacity(0.9))
            
            HStack {
                WeatherDetailView(icon: "thermometer", label: "Feels like", value: "\(weather.main.feels_like.formatted(.number.precision(.fractionLength(1))))°C")
                WeatherDetailView(icon: "humidity.fill", label: "Humidity", value: "\(weather.main.humidity)%")
                WeatherDetailView(icon: "wind", label: "Wind", value: "\(weather.wind.speed.formatted(.number.precision(.fractionLength(1)))) m/s")
            }
            .padding()
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(20)
    }
}
