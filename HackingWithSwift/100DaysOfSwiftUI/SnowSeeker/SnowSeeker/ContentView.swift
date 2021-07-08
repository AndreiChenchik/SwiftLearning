//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Andrei Chenchik on 7/7/21.
//

import SwiftUI



struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @ObservedObject var favorites = Favorites()
    
    @State private var isShowingFilterView = false
    @State private var selectedSorting = "Default"
    @State private var onlyFavorites = false
    @State private var countriesFilter = [String: Bool]()
    @State private var sizeFilter = [1: true, 2: true, 3: true]
    @State private var priceFilter = [1: true, 2: true, 3: true]
    
    var filteredResorts: [Resort] {
        let filtered = resorts.filter { resort in
            let selectedCountries = countriesFilter.filter{ $0.value }.keys
            let selectedSizes = sizeFilter.filter{ $0.value }.keys
            let selectedPrices = priceFilter.filter{ $0.value }.keys
           
            
            return selectedCountries.contains(resort.country)
                    && selectedSizes.contains(resort.size)
                    && selectedPrices.contains(resort.price)
                    && (!onlyFavorites || (onlyFavorites && favorites.contains(resort)))
        }
        
        let sorted: [Resort]
        
        switch selectedSorting {
        case "Runs":
            sorted = filtered.sorted { $0.runs > $1.runs }
        case "Name":
            sorted = filtered.sorted { $0.name < $1.name }
        case "Country":
            sorted = filtered.sorted { $0.country < $1.country }
        case "Price":
            sorted = filtered.sorted { $0.price < $1.price }
        default:
            sorted = filtered
        }
        
        return sorted
    }
    
    var countries: [String] {
        let allCountries = resorts.map { resort in
            resort.country
        }
        
        return Array(Set(allCountries))
    }
    
    func fillCountryFilter() {
        if countriesFilter.isEmpty {
            countriesFilter = countries.reduce([String: Bool]()) { (dict, country) in
                var dict = dict
                dict[country] = true
                
                return dict
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    ZStack {
                        HStack {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.black, lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(resort.name).lineLimit(1)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    Spacer()
                    }
                    if self.favorites.contains(resort) {
                        HStack {
                    Spacer()
                        Image(systemName: "heart.fill")
                        .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)
                        }
                    }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .sheet(isPresented: $isShowingFilterView) {
                FilterView(resortsCount: resorts.count, filteredCount: filteredResorts.count, selectedSorting: $selectedSorting, countriesFilter: $countriesFilter, priceFilter: $priceFilter, sizeFilter: $sizeFilter, onlyFavorites: $onlyFavorites)
            }
            .navigationTitle("Resorts")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Sort & Filter") {
                        self.isShowingFilterView = true
                    }
                }
                ToolbarItem(placement: .status) {
                    Text("Showing \(filteredResorts.count) of \(resorts.count), sorted by \(selectedSorting.lowercased()).")
                }
            }
            
            WelcomeView()
        }
        .onAppear(perform: fillCountryFilter)
        .environmentObject(favorites)

        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
