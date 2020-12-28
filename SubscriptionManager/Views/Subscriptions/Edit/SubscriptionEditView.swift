//
//  SubscriptionEditView.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 20/10/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct SubscriptionEditView: View {
    
    // MARK: - Properties
    
    @Binding var isPresented: Bool
    @EnvironmentObject var subscriptionsViewModel: SubscriptionsViewModel
    @State private var textFieldSubscriptionName: String = ""
    @State private var textFieldSubscriptionPrice: String = ""
    @State private var textCycle: String = ""
    @State private var selectedColor: SubscriptionsViewModel.subscriptionRowColor
    @State private var nextPayment: Date = Date()
    @State private var showingAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    var subscription: Subscription
    
    // MARK: - Methods
    
    init(isPresented: Binding<Bool>, subscription: Subscription) {
        self._isPresented = isPresented
        self.subscription = subscription
        self._selectedColor = State(wrappedValue: .blue)
        
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
        
        // Color.
        let rowColor: String = subscription.rowColor
        var subscriptionRowColor: SubscriptionsViewModel.subscriptionRowColor = .blue
        switch rowColor {
        case SubscriptionsViewModel.subscriptionRowColor.blue.rawValue:
            subscriptionRowColor = .blue
        case SubscriptionsViewModel.subscriptionRowColor.blueDark.rawValue:
            subscriptionRowColor = .blueDark
        case SubscriptionsViewModel.subscriptionRowColor.green.rawValue:
            subscriptionRowColor = .green
        case SubscriptionsViewModel.subscriptionRowColor.greenDark.rawValue:
            subscriptionRowColor = .greenDark
        case SubscriptionsViewModel.subscriptionRowColor.mango.rawValue:
            subscriptionRowColor = .mango
        case SubscriptionsViewModel.subscriptionRowColor.orange.rawValue:
            subscriptionRowColor = .orange
        case SubscriptionsViewModel.subscriptionRowColor.orangeDark.rawValue:
            subscriptionRowColor = .orangeDark
        case SubscriptionsViewModel.subscriptionRowColor.pistachio.rawValue:
            subscriptionRowColor = .pistachio
        case SubscriptionsViewModel.subscriptionRowColor.red.rawValue:
            subscriptionRowColor = .red
        case SubscriptionsViewModel.subscriptionRowColor.yellow.rawValue:
            subscriptionRowColor = .yellow
        default:
            subscriptionRowColor = .blue
        }
        self._selectedColor = State(wrappedValue: subscriptionRowColor)
        
        // Next Payment.
        self._nextPayment = State(wrappedValue: subscription.nextPayment)
    }
    
    ///
    /// Saves the changes in the subscription.
    /// - Returns : True if the changes have been saved.
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
        
        // RowColor.
        let selectedRowColor: SubscriptionsViewModel.subscriptionRowColor = self.selectedColor
        
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
            self.subscriptionsViewModel.updateSubscription(subscription: self.subscription, name: subscriptionName, price: formattedSubscriptionPrice, cycle: subscriptionCycle, rowColor: selectedRowColor, nextPayment: subscriptionNextPayment)
        }
        
        return saveStatus
    }
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            ScrollView {
                EditableField(title: "Name", value: self.$textFieldSubscriptionName, keyboardType: UIKeyboardType.alphabet)
                EditableField(title: "Price", value: self.$textFieldSubscriptionPrice, keyboardType: UIKeyboardType.decimalPad)
                CycleField(title: "Cycle", value: self.$textCycle)
                ColorsField(title: "Color", value: self.$selectedColor)
                CalendarField(title: "Next Payment", value: self.$nextPayment)
            }
            .gesture(
                // Detects the scrollview moving and hides the keyboard.
                DragGesture().onChanged({ _ in
                    self.hideKeyboard()
                })
            )
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
