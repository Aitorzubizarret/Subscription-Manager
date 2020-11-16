//
//  SubscriptionEditView.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 20/10/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct SubscriptionEditView: View {
    
    //MARK: - Properties
    
    @Binding var isPresented: Bool
    @EnvironmentObject var subscriptionsViewModel: SubscriptionsViewModel
    @State private var textFieldSubscriptionName: String = ""
    @State private var textFieldSubscriptionPrice: String = ""
    @State private var textCycle: String = ""
    @State private var nextPayment: Date = Date()
    @State private var showingAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    var subscription: Subscription
    
    //MARK: - Methods
    
    init(isPresented: Binding<Bool>, subscription: Subscription) {
        self._isPresented = isPresented
        self.subscription = subscription
        
        self.configureUIElements()
    }
    
    ///
    /// Gets the subscription values and loads them in the UI elements.
    ///
    private mutating func configureUIElements() {
        // Name.
        self._textFieldSubscriptionName = State(wrappedValue: subscription.name)
        
        // Price.
        self._textFieldSubscriptionPrice = State(wrappedValue: "\(subscription.price)")
        
        // Cycle.
        self._textCycle = State(wrappedValue: subscription.cycle)
        
        // Next Payment.
        self._nextPayment = State(wrappedValue: subscription.nextPayment)
    }
    
    ///
    /// Saves the changes in the subscription.
    ///
    private func saveChanges() -> Bool {
        var saveStatus: Bool = true
        self.alertTitle = "Error"
        self.alertMessage = "Please check: "
        
        // Name.
        let subscriptionName: String = self.textFieldSubscriptionName
        if subscriptionName == "" {
            saveStatus = false
            self.alertMessage = self.alertMessage + "Name is empty. "
        }
        
        // Price formatter.
        var formattedSubscriptionPrice: Float = 0
        self.textFieldSubscriptionPrice = self.textFieldSubscriptionPrice.replacingOccurrences(of: ".", with: ",")
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        if let price = numberFormatter.number(from: self.textFieldSubscriptionPrice) {
            formattedSubscriptionPrice = price.floatValue
        } else {
            saveStatus = false
            self.alertMessage = self.alertMessage + "Price can't be empty and has to be a valid number. "
        }
        
        // Cycle.
        let subscriptionCycle: String = self.textCycle
        
        // Next payment Date.
        var components = DateComponents()
        components.second = 0
        components.minute = 0
        components.hour = 1
        components.day = Date().getDayNumber()
        components.month = Date().getMonthNumber()
        components.year = Date().getYearNumber()
        
        if let tomorrow = Calendar.current.date(from: components) {
            if self.nextPayment < tomorrow {
                saveStatus = false
                self.alertMessage = self.alertMessage + "Next Payment Date must be after today. "
            }
        } else {
            saveStatus = false
            self.alertMessage = self.alertMessage + "Next Payment Date must be after today. "
        }
        
        let subscriptionNextPayment: Date = self.nextPayment
        
        if saveStatus {
            // Updates the subscription information using the view model.
            self.subscriptionsViewModel.updateSubscription(subscription: self.subscription, name: subscriptionName, price: formattedSubscriptionPrice, cycle: subscriptionCycle, nextPayment: subscriptionNextPayment)
        }
        
        return saveStatus
    }
    
    //MARK: - View
    
    var body: some View {
        NavigationView {
            ScrollView {
                EditableField(title: "Name", value: self.$textFieldSubscriptionName, keyboardType: UIKeyboardType.alphabet)
                EditableField(title: "Price", value: self.$textFieldSubscriptionPrice, keyboardType: UIKeyboardType.decimalPad)
                CycleField(title: "Cycle", value: self.$textCycle)
                CalendarField(title: "Next Payment", value: self.$nextPayment)
            }
            .navigationBarTitle(Text("Edit Subscription"), displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    if self.saveChanges() {
                        // Back to detail view.
                        self.isPresented.toggle()
                    } else {
                        self.showingAlert = true
                    }
                }) {
                    Text("Save")
                }.alert(isPresented: self.$showingAlert, content: {
                    Alert(title: Text(self.alertTitle), message: Text(self.alertMessage), dismissButton: Alert.Button.cancel(Text("OK")))
                })
            )
        }
    }
}

struct SubscriptionEditView_Previews: PreviewProvider {

    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let subscription: Subscription = Subscription(context: context)
        subscription.name = "Test"
        subscription.price = 9
        subscription.cycle = "month"
        subscription.nextPayment = Date()
        
        return SubscriptionEditView(isPresented: .constant(false), subscription: subscription).environmentObject(SubscriptionsViewModel())
    }
}
