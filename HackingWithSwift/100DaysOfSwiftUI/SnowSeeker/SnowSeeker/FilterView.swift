//
//  FilterView.swift
//  SnowSeeker
//
//  Created by Andrei Chenchik on 7/7/21.
//

import SwiftUI


struct FilterView: View {
    let sortingTypes = ["Default", "Name", "Country", "Runs"]
    
    var resortsCount: Int
    var filteredCount: Int
    
    @Binding var selectedSorting: String
    @Binding var countriesFilter: [String: Bool]
    @Binding var priceFilter: [Int: Bool]
    @Binding var sizeFilter: [Int: Bool]
    @Binding var onlyFavorites: Bool
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Sort")) {
                    Picker("Sorting by", selection: $selectedSorting) {
                        ForEach(sortingTypes, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Toggle("Only favorites", isOn: self.$onlyFavorites)
                
                Section(header: Text("Countries")) {
                    ForEach(countriesFilter.keys.sorted(), id: \.self) { country in
                        Toggle(country, isOn: self.countryBinding(for: country))
                    }
                }
                
                Section(header: Text("Size")) {
                    ForEach(sizeFilter.keys.sorted(), id: \.self) { size in
                        Toggle(getResortSize(for: size), isOn: self.sizeBinding(for: size))
                    }
                }
                
                Section(header: Text("Price")) {
                    ForEach(priceFilter.keys.sorted(), id: \.self) { price in
                        Toggle(getResortPrice(for: price), isOn: self.priceBinding(for: price))
                    }
                }
                
                Section(header: Text("Selected \(filteredCount) of \(resortsCount) Resorts")) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .navigationTitle("Sort & Filter")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: dismiss) {
                        Image(systemName: "xmark")
                    }
                    .contentShape(Rectangle())
                }
            }
        }
    }
    
    func getResortSize(for number: Int) -> String {
        switch number {
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }
    
    func getResortPrice(for number: Int) -> String {
        String(repeating: "$", count: number)
    }

    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    private func countryBinding(for key: String) -> Binding<Bool> {
        return .init(
            get: { self.countriesFilter[key, default: false] },
            set: { self.countriesFilter[key] = $0 })
    }
    
    private func priceBinding(for key: Int) -> Binding<Bool> {
        return .init(
            get: { self.priceFilter[key, default: false] },
            set: { self.priceFilter[key] = $0 })
    }
    
    private func sizeBinding(for key: Int) -> Binding<Bool> {
        return .init(
            get: { self.sizeFilter[key, default: false] },
            set: { self.sizeFilter[key] = $0 })
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(resortsCount: 2, filteredCount: 1, selectedSorting: .constant("Country"), countriesFilter: .constant(["France": true]), priceFilter: .constant([2: true]), sizeFilter: .constant([3: true]), onlyFavorites: .constant(true))
    }
}
