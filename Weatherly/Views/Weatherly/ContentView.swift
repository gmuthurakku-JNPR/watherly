import SwiftUI


// MARK: - Main ContentView
struct ContentView: View {
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let today = viewModel.forecasts.first {
                    TodayWeatherView(weather: today, cityName: viewModel.cityName)
                }
                
                Text("Upcoming Forecast")
                    .font(.headline)
                    .padding(.top, 10)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(viewModel.forecasts.dropFirst()) { forecast in
                            NavigationLink(destination: LoginView()) {
                                ForecastCardView(weather: forecast)
                            }
                        }
                    }
                    .padding()
                }
            }
            .onAppear {
                viewModel.fetchWeather()
            }
        }
    }
}
