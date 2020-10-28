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
    private func saveChanges() {
        // Name.
        let subscriptionName: String = self.textFieldSubscriptionName
        
        // Price formatter.
        self.textFieldSubscriptionPrice = self.textFieldSubscriptionPrice.replacingOccurrences(of: ".", with: ",")
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let price = numberFormatter.number(from: self.textFieldSubscriptionPrice) else { return }
        let formattedSubscriptionPrice = price.floatValue
        
        // Cycle.
        let subscriptionCycle: String = self.textCycle
        
        // Next payment.
        let subscriptionNextPayment: Date = self.nextPayment
        
        // Updates the subscription information using the view model.
        self.subscriptionsViewModel.updateSubscription(subscription: self.subscription, name: subscriptionName, price: formattedSubscriptionPrice, cycle: subscriptionCycle, nextPayment: subscriptionNextPayment)
        
        // Back to detail view.
        self.isPresented.toggle()
    }
    
    //MARK: - View
    
    var body: some View {
        NavigationView {
            ScrollView {
                EditableField(title: "NAME", value: self.$textFieldSubscriptionName, keyboardType: UIKeyboardType.alphabet)
                EditableField(title: "PRICE", value: self.$textFieldSubscriptionPrice, keyboardType: UIKeyboardType.decimalPad)
                CycleField(title: "Cycle", value: self.$textCycle)
                Divider()
                HStack {
                    DatePicker("Date", selection: $nextPayment, in: self.nextPayment..., displayedComponents: .date)
                }
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
            }
            .navigationBarTitle(Text("Edit Subscription"), displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.saveChanges()
                }) {
                    Text("Save")
                }
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
