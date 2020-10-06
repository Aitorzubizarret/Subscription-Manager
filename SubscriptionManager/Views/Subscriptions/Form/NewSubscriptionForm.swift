//
//  NewSubscriptionForm.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 30/09/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct NewSubscriptionForm: View {
    
    //MARK: - Properties
    @EnvironmentObject var subscriptionsViewModel: SubscriptionsViewModel
    @State private var subscriptionName: String = ""
    @State private var subscriptionCompany: String = ""
    @State private var subscriptionAccountEmail: String = ""
    @State private var isSubscriptionTypeTrial: Bool = false
    @State private var subscriptionPrice: String = ""
    @State private var subscriptionStartDate: Date = Date()
    @State private var subscriptionEndDate: Date = Date()
    @State private var showingAlert: Bool = false
    @Binding var isPresented: Bool
    
    //MARK: - Methods
    ///
    /// Adds a new subscription to the subscriptions list.
    ///
    private func addNewSubscription() -> Bool {
        
        // Check important properties are not empty.
        guard (self.subscriptionName != "") else { return false }
        
        // Start and End dates.
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let startDate: String = dateFormatter.string(from: subscriptionStartDate)
        let endDate: String = dateFormatter.string(from: subscriptionEndDate)
        
        // Subscription Type.
        var subscriptionType: SubscriptionType?
        if isSubscriptionTypeTrial {
            subscriptionType = SubscriptionType.trial
        } else {
            subscriptionType = SubscriptionType.pay
        }
        
        // Price.
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let price = numberFormatter.number(from: self.subscriptionPrice) else { return false }
        
        // Sends data to the ViewModel to create the new subscription.
        self.subscriptionsViewModel.addNewSubscription(name: self.subscriptionName, company: self.subscriptionCompany, type: subscriptionType!, period: "One Year", dayStart: startDate, dayEnd: endDate, price: Float(truncating: price), accountEmail: self.subscriptionAccountEmail)
        
        return true
    }
    
    //MARK: - View
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    TextField("Name", text: $subscriptionName)
                        .keyboardType(UIKeyboardType.alphabet)
                        
                    TextField("Company", text: $subscriptionCompany)
                    TextField("AccountEmail", text: $subscriptionAccountEmail)
                    Toggle(isOn: $isSubscriptionTypeTrial) {
                        Text("Trial version")
                    }
                    TextField("Price", text: self.$subscriptionPrice)
                        .keyboardType(UIKeyboardType.decimalPad)
                }
                Section {
                    Text("Period")
                    DatePicker(selection: $subscriptionStartDate, displayedComponents: DatePickerComponents.date) { Text("Start Date")}
                    DatePicker(selection: $subscriptionEndDate, displayedComponents: DatePickerComponents.date) { Text("End Date")}
                }
            }
            .navigationBarTitle(Text("New Subscription"), displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    if self.addNewSubscription() {
                        // Dismiss the view.
                        self.isPresented = false
                    } else {
                        // Show alert view.
                        self.showingAlert = true
                    }
                }) {
                    Text("Add")
                }.alert(isPresented: self.$showingAlert, content: {
                    Alert(title: Text("Empty fields"), message: Text("Name and price fields are required and price only allows numbers."), dismissButton: Alert.Button.default(Text("OK")))
                })
            )
        }
    }
}

struct NewSubscriptionForm_Previews: PreviewProvider {
    
    static var previews: some View {
        NewSubscriptionForm(isPresented: .constant(false))
    }
}
