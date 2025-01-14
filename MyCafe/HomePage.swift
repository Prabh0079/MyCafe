//
//  HomePage.swift
//  MyCafe
//
//  Created by User on 07/01/2025.
//

import SwiftUI
import FirebaseAuth

struct HomePage: View {
    
    @State private var searchText = ""
    @State private var selectedTab = 0
    @StateObject var cartManager = CartManager()
    let currentDate = Date()
    
    @State var userName: String = ""
    @State var sessionManager = SessionManager.shared
    @State var navigateToSignIn: Bool = false
    
    let hotCoffees = [
        CoffeeType(name: "Espresso", imageName: "Espresso", price: 2.99),
        CoffeeType(name: "Cappuccino", imageName: "cappicino", price: 3.99),
        CoffeeType(name: "Latte", imageName: "latte", price: 4.99),
        CoffeeType(name: "Macchiato", imageName: "mocha", price: 5.99)
    ]
    let coldCoffees = [
        CoffeeType(name: "Iced-Coffe", imageName: "IceCafe", price: 2.99),
        CoffeeType(name: "Ice-Latte", imageName: "IceLatte", price: 4.29),
        CoffeeType(name: "Cold Brew", imageName: "ColdBrew", price: 4.59),
        CoffeeType(name: "Iced Mocha", imageName: "IcedMocha", price: 6.99)
    ]
    
    var filteredCoffees: [CoffeeType] {
        let coffees = selectedTab == 0 ? hotCoffees : coldCoffees
        if searchText.isEmpty {
            return coffees
        } else {
            return coffees.filter{ $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack{
            VStack {
                let currentUser = sessionManager.getCurrentUser()
                HStack {
                    Text(formattedDate(currentDate))
                    Spacer()
                    Text(formattedTime(currentDate))
                }
                .padding()
                .bold()
                
                Text("Welcome \(currentUser?.username ?? " " )")
                    .font(.title)
                    .bold()
                Text("It's a Great Day for Coffee..")
                    .font(.subheadline)
                    .bold()
                
                HStack {
                    TextField("Search for your Favourite Coffee..", text: $searchText)
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
                
                Picker("Coffee Type", selection: $selectedTab) {
                    Text("Hot Coffee").tag(0)
                    Text("Cold Coffee").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .padding(.top, 10)
                
                ScrollView {
                    LazyVGrid(columns: gridItems, spacing: 20) {
                        ForEach(filteredCoffees) { coffee in
                            
                            NavigationLink(destination: CoffeeDetailView())
                            {
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
            }
        }
    }
    
    func formattedDate(_ date: Date) -> String {
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "dd MMM"
            let dateString = dateFormatter.string(from: date)
            
            return "\(dateString)"
        }
    func formattedTime(_ date: Date) -> String {
            let dateFormatter = DateFormatter()

            dateFormatter.dateFormat = "hh:mm "
            let timeString = dateFormatter.string(from: date)
            
            return "\(timeString)"
        }
}

#Preview {
    HomePage()
}
