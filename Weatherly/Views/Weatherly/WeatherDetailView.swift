//
//  WeatherDetailView.swift
//  Weatherly
//
//  Created by Gurunarayanan Muthurakku on 09/03/25.
//
import SwiftUI

// MARK: - Weather Detail Small View
struct WeatherDetailView: View {
    let icon: String
    let label: String
    let value: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.white)
            Text(label)
                .foregroundColor(.white.opacity(0.8))
                .font(.caption)
            Text(value)
                .bold()
                .foregroundColor(.white)
        }
        .frame(width: 100)
    }
}
