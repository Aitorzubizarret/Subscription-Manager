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
    @State private var subscriptionPrice: String = ""
    @State private var showingAlert: Bool = false
    @Binding var isPresented: Bool
    
    //MARK: - Methods
    ///
    /// Adds a new subscription to the subscriptions list.
    ///
    private func addNewSubscription() -> Bool {
        // Check important properties (name and price) are not empty.
        guard (self.subscriptionName != "")&&(self.subscriptionPrice != "") else { return false }
        
        // Price formatter.
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let price = numberFormatter.number(from: self.subscriptionPrice) else { return false }
        let subscriptionPrice = price.floatValue
        
        // Save the new subscription in Core Data.
        self.subscriptionsViewModel.createNewSubscription(name: self.subscriptionName, price: subscriptionPrice)
        
        return true
    }
    
    //MARK: - View
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    TextField("Name", text: $subscriptionName)
                        .keyboardType(UIKeyboardType.alphabet)
                    TextField("Price", text: self.$subscriptionPrice)
                        .keyboardType(UIKeyboardType.decimalPad)
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
