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
    @State private var subscriptionPrice: Float = 0
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
        
        // Sends data to the ViewModel to create the new subscription.
        self.subscriptionsViewModel.addNewSubscription(name: self.subscriptionName, company: self.subscriptionCompany, type: subscriptionType!, period: "One Year", dayStart: startDate, dayEnd: endDate, price: self.subscriptionPrice, accountEmail: self.subscriptionAccountEmail)
        
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
                    TextField("Price", value: $subscriptionPrice, formatter: NumberFormatter()).keyboardType(UIKeyboardType.decimalPad)
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
                    Alert(title: Text("Empty fields"), message: Text("Name field is required."), dismissButton: Alert.Button.default(Text("OK")))
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
