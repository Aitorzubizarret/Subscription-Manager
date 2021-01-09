//
//  NewSubscriptionForm.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 30/09/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct NewSubscriptionForm: View {
    
    // MARK: - Properties
    
    @Binding var isPresented: Bool
    @EnvironmentObject var subscriptionsViewModel: SubscriptionsViewModel
    @State private var textFieldSubscriptionName: String = ""
    @State private var textFieldSubscriptionPrice: String = ""
    @State private var selectedCategory: SubscriptionsViewModel.subscriptionCategory = SubscriptionsViewModel.subscriptionCategory.none
    @State private var textCycle: String = "1-m"
    @State private var subscriptionNextPaymentDate: Date = Date().addingTimeInterval(86400)
    @State private var selectedColor: SubscriptionsViewModel.subscriptionRowColor = SubscriptionsViewModel.subscriptionRowColor.blue
    @State private var showingAlert: Bool = false
    
    // MARK: - Methods
    
    ///
    /// Adds a new subscription to the subscriptions list.
    /// - Returns: True if the important properties are not empty.
    ///
    private func addNewSubscription() -> Bool {
        // Check important properties (name and price) are not empty, and the category is not "none".
        guard (self.textFieldSubscriptionName != "")&&(self.textFieldSubscriptionPrice != "")&&(self.selectedCategory != SubscriptionsViewModel.subscriptionCategory.none) else { return false }
        
        // Price formatter.
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let price = numberFormatter.number(from: self.textFieldSubscriptionPrice) else { return false }
        let formattedSubscriptionPrice = price.floatValue
        
        // Cycle.
        let cycle: String = self.textCycle
        
        // RowColor.
        let selectedRowColor: SubscriptionsViewModel.subscriptionRowColor = self.selectedColor
        
        // Category.
        let selectedCategory: SubscriptionsViewModel.subscriptionCategory = self.selectedCategory
        
        // Save the new subscription in Core Data.
        self.subscriptionsViewModel.createNewSubscription(name: self.textFieldSubscriptionName, price: formattedSubscriptionPrice, category: selectedCategory, cycle: cycle, rowColor: selectedRowColor, nextPayment: self.subscriptionNextPaymentDate)
        
        return true
    }
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            ScrollView {
                EditableField(title: "Name", value: self.$textFieldSubscriptionName, keyboardType: UIKeyboardType.alphabet)
                EditableField(title: "Price", value: self.$textFieldSubscriptionPrice, keyboardType: UIKeyboardType.decimalPad)
                CategoryField(title: "Category", value: self.$selectedCategory)
                CycleField(title: "Cycle", value: self.$textCycle)
                ColorsField(title: "Color", value: self.$selectedColor)
                CalendarField(title: "Next Payment", value: self.$subscriptionNextPaymentDate)
            }
            .gesture(
                // Detects the scrollview moving and hides the keyboard.
                DragGesture().onChanged({ _ in
                    self.hideKeyboard()
                })
            )
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
                    Alert(title: Text("Empty fields"), message: Text("Name and price fields are required and price only allows numbers. Remember to choose a category for your subscription too."), dismissButton: Alert.Button.default(Text("OK")))
                })
            )
        }
    }
}

struct NewSubscriptionForm_Previews: PreviewProvider {
    
    static var previews: some View {
        NewSubscriptionForm(isPresented: .constant(false)).environmentObject(SubscriptionsViewModel())
    }
}
