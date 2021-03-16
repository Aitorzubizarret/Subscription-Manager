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
    private var nameText: String = ""
    private var priceText: String = ""
    private var categoryText: String = ""
    private var cycleText: String = ""
    private var colorText: String = ""
    private var nextPaymentText: String = ""
    private var newSubscriptionText: String = ""
    private var addText: String = ""
    private var emptyFieldsText: String = ""
    private var emptyFieldsMessageDescription: String = ""
    private var okText: String = ""
    
    // MARK: - Methods
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
        
        self.localizeText()
    }
    
    ///
    /// Localize UI text elements.
    ///
    private mutating func localizeText() {
        // Get strings from localizable.
        self.nameText = NSLocalizedString("name", comment: "")
        self.priceText = NSLocalizedString("price", comment: "")
        self.categoryText = NSLocalizedString("category", comment: "")
        self.cycleText = NSLocalizedString("cycle", comment: "")
        self.colorText = NSLocalizedString("color", comment: "")
        self.nextPaymentText = NSLocalizedString("nextPayment", comment: "")
        self.newSubscriptionText = NSLocalizedString("newSubscription", comment: "")
        self.addText = NSLocalizedString("add", comment: "")
        self.emptyFieldsText = NSLocalizedString("emptyFields", comment: "")
        self.emptyFieldsMessageDescription = NSLocalizedString("emptyFieldsMessageDescription", comment: "")
        self.okText = NSLocalizedString("ok", comment: "")
    }
    
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
                EditableField(title: self.nameText, value: self.$textFieldSubscriptionName, keyboardType: UIKeyboardType.alphabet)
                EditableField(title: self.priceText, value: self.$textFieldSubscriptionPrice, keyboardType: UIKeyboardType.decimalPad)
                CategoryField(title: self.categoryText, value: self.$selectedCategory)
                ColorsField(title: self.colorText, value: self.$selectedColor)
                CycleField(title: self.cycleText, value: self.$textCycle)
                CalendarField(title: self.nextPaymentText, value: self.$subscriptionNextPaymentDate)
            }
            .gesture(
                // Detects the scrollview moving and hides the keyboard.
                DragGesture().onChanged({ _ in
                    self.hideKeyboard()
                })
            )
            .navigationBarTitle(Text(self.newSubscriptionText), displayMode: .inline)
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
                    Text(self.addText)
                }.alert(isPresented: self.$showingAlert, content: {
                    Alert(title: Text(self.emptyFieldsText),
                          message: Text(self.emptyFieldsMessageDescription),
                          dismissButton: Alert.Button.default(Text(self.okText)))
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
