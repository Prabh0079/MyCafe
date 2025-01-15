import SwiftUI
import Firebase
import FirebaseAuth

struct HomePage: View {
    @StateObject private var coffeeViewModel = CoffeeViewModel()
    @StateObject var cartManager = CartManager()
    
    var gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    
    @State private var temperature: String? = nil
    @State private var errorMessage: String? = nil
    
    private let apiKey = "f64bf0682e08dc140031412b5a1c04ff"
    
    var body: some View {
        NavigationView {
            VStack {
                    HStack {
                        Text(.now, style: .time)
                            .padding()
                        Spacer()
                        if let temp = temperature {
                            Text(temp)
                                .font(.subheadline)
                                .padding()
                        }
                    }
                    
                    Text("It's a Great Day for Coffee..")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    
                    HStack {
                        TextField("Search for your Favourite Coffee..", text: $coffeeViewModel.searchText)
                            .foregroundColor(.brown)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.vertical, 10)
                            .padding(.leading)
                        
                        Image(systemName: "magnifyingglass")
                            .padding(.trailing)
                    }
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
                    .padding()
                    
                    // Coffee Picker (Hot or Cold)
                    Picker("Coffee Type", selection: $coffeeViewModel.selectedTab) {
                        Text("Hot Coffee").tag(0)
                        Text("Cold Coffee").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // Coffee Grid
                    ScrollView {
                        LazyVGrid(columns: gridItems, spacing: 20) {
                            ForEach(coffeeViewModel.filteredCoffees) { coffee in
                                NavigationLink(destination: CoffeeDetailView(coffee: coffee, cartManager: cartManager)) {
                                    VStack {
                                        Image(coffee.imageName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 120, height: 120)
                                            .cornerRadius(8)
                                        
                                        Text(coffee.name)
                                            .font(.headline)
                                            .padding(.top, 8)
                                            .foregroundColor(.brown)
                                        
                                        Text(String(format: "$%.2f", coffee.price))
                                            .font(.subheadline)
                                            .foregroundColor(.brown)
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                        .padding(.top, 10)
                    }
                    .navigationTitle("")
              
            }
            .onAppear {
                fetchWeatherData(for: "Montreal")
            }
        }
    }
    
    private func fetchWeatherData(for location: String) {
        let apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=\(location)&appid=\(apiKey)"
        
        guard let url = URL(string: apiUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data else {
                    errorMessage = "No data received from the server."
                    return
                }
                
                do {
                    // Parse the JSON response
                    let weatherData = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    let temp = weatherData.main.temp - 273.15 // Convert from Kelvin to Celsius
                    temperature = String(format: "%.0f °C", temp)
                    errorMessage = nil
                } catch {
                    errorMessage = "Failed to parse weather data."
                }
            }
        }
        .resume()
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}

class CoffeeViewModel: ObservableObject {
    @Published var hotCoffees: [CoffeeType] = [
        CoffeeType(name: "Espresso", imageName: "Espresso", price: 2.99),
        CoffeeType(name: "Cappuccino", imageName: "cappicino", price: 3.99),
        CoffeeType(name: "Latte", imageName: "latte", price: 4.99),
        CoffeeType(name: "Macchiato", imageName: "mocha", price: 5.99)
    ]
    
    @Published var coldCoffees: [CoffeeType] = [
        CoffeeType(name: "Iced-Coffe", imageName: "IceCafe", price: 2.99),
        CoffeeType(name: "Ice-Latte", imageName: "IceLatte", price: 4.29),
        CoffeeType(name: "Cold Brew", imageName: "ColdBrew", price: 4.59),
        CoffeeType(name: "Iced Mocha", imageName: "IcedMocha", price: 6.99)
    ]
    
    @Published var searchText: String = ""
    @Published var selectedTab: Int = 0

    // Computed property to get filtered coffee list
    var filteredCoffees: [CoffeeType] {
        let coffees = selectedTab == 0 ? hotCoffees : coldCoffees
        return searchText.isEmpty ? coffees : coffees.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    // Method to change the selected tab
    func switchTab(to tab: Int) {
        selectedTab = tab
    }
    
    // Method to update the search text
    func updateSearchText(_ text: String) {
        searchText = text
    }
}

struct WeatherResponse: Codable {
    let main: Main
}

struct Main: Codable {
    let temp: Double
}
