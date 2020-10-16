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
    private let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    
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
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Name")
                        .font(.callout)
                        .bold()
                    TextField("Enter name ...", text: $subscriptionName)
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(5.0)
                        .keyboardType(UIKeyboardType.alphabet)
                }.padding(EdgeInsets(top: 20, leading: 15, bottom: 10, trailing: 15))
                VStack(alignment: .leading) {
                    Text("Price")
                        .font(.callout)
                        .bold()
                    TextField("Enter price ...", text: self.$subscriptionPrice)
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(5.0)
                        .keyboardType(UIKeyboardType.decimalPad)
                }.padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
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
