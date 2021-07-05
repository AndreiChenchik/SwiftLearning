//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Andrei Chenchik on 5/7/21.
//

import SwiftUI
import CodeScanner
import UserNotifications

struct ProspectsView: View {
    @EnvironmentObject var prospects: Prospects
    
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    enum SortType {
        case name, recent
    }
    
    let filter: FilterType
    
    @State private var sorting: SortType = .name
    
    var filteredProspects: [Prospect] {
        var people = prospects.people
        
        switch filter {
        case .none:
            break
        case .contacted:
            people = people.filter { $0.isContacted }
        case .uncontacted:
            people = people.filter { !$0.isContacted }
        }
        
        switch sorting {
        case .name:
            people.sort { $0.name < $1.name }
        case .recent:
            people.sort { $0.dateAdded > $1.dateAdded }
        }
        
        return people
    }
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    @State private var isShowingScanner = false
    @State private var isShowingSortingSheet = false
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            
            self.prospects.add(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = .default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            center.add(request)
        }
        
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack {
                        if filter == .none {
                            Image(systemName: prospect.isContacted ? "checkmark.circle" : "questionmark.diamond")
                                .foregroundColor(prospect.isContacted ? .green : /*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                        
                    }
                    
                    .contextMenu {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
                            self.prospects.toggle(prospect)
                        }
                        
                        if !prospect.isContacted {
                            Button("Remind Me") {
                                self.addNotification(for: prospect)
                            }
                        }
                    }
                }
            }
            .navigationTitle(title)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.isShowingScanner = true
                    }, label: {
                        Image(systemName: "qrcode.viewfinder")
                        Text("Scan")
                    })
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.isShowingSortingSheet = true
                    }, label: {
                        HStack {
                            Image(systemName: "arrow.up.arrow.down.square")
                            Text(self.sorting == .name ? "Name" : "Recent")
                        }
                    })
                }
            })
            .sheet(isPresented: $isShowingScanner, content: {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Andrey Chenchik\nandrei@chenchik.me", completion: self.handleScan)
            })
            .actionSheet(isPresented: $isShowingSortingSheet, content: {
                ActionSheet(title: Text("Select sorting"), buttons: [
                    .default(Text("By Name")) { self.sorting = .name },
                    .default(Text("By Recent")) { self.sorting = .recent }
                ])
            })
        }
        
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
