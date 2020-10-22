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
    @Binding var isPresented: Bool
    @EnvironmentObject var subscriptionsViewModel: SubscriptionsViewModel
    @State private var textFieldSubscriptionName: String = ""
    @State private var textFieldSubscriptionPrice: String = ""
    @State private var selectionCycleValue: Int = 1
    @State private var selectionCycleUnit: Int = 2
    @State private var subscriptionNextPaymentDate: Date = Date().addingTimeInterval(86400)
    @State private var showingAlert: Bool = false
    var subscriptionCycle: String {
        var text: String = ""
        if self.selectionCycleValue != 1 {
            text = text + "\(self.selectionCycleValue) \(self.subscriptionsViewModel.subscriptionCycleUnitOptions[self.selectionCycleUnit])s"
        } else {
            text = text + "\(self.subscriptionsViewModel.subscriptionCycleUnitOptions[self.selectionCycleUnit])"
        }
        return text
    }
    var tomorrowDate: Date = Date().addingTimeInterval(86400)
    private let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    
    //MARK: - Methods
    ///
    /// Adds a new subscription to the subscriptions list.
    ///
    private func addNewSubscription() -> Bool {
        // Check important properties (name and price) are not empty.
        guard (self.textFieldSubscriptionName != "")&&(self.textFieldSubscriptionPrice != "") else { return false }
        
        // Price formatter.
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let price = numberFormatter.number(from: self.textFieldSubscriptionPrice) else { return false }
        let formattedSubscriptionPrice = price.floatValue
        
        // Save the new subscription in Core Data.
        self.subscriptionsViewModel.createNewSubscription(name: self.textFieldSubscriptionName, price: formattedSubscriptionPrice, cycle: self.subscriptionCycle, nextPayment: self.subscriptionNextPaymentDate)
        
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
                    TextField("Enter name ...", text: $textFieldSubscriptionName)
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(5.0)
                        .keyboardType(UIKeyboardType.alphabet)
                }
                .padding(EdgeInsets(top: 20, leading: 15, bottom: 10, trailing: 15))
                .onTapGesture {
                    self.hideKeyboard()
                }
                VStack(alignment: .leading) {
                    Text("Price")
                        .font(.callout)
                        .bold()
                    TextField("Enter price ...", text: self.$textFieldSubscriptionPrice)
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(5.0)
                        .keyboardType(UIKeyboardType.decimalPad)
                }
                .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                .onTapGesture {
                    self.hideKeyboard()
                }
                VStack(alignment: .leading) {
                    Text("Cycle")
                        .font(.callout)
                        .bold()
                    HStack {
                        Text("Every \(self.subscriptionCycle)")
                        Spacer()
                        Text("\(self.selectionCycleValue)")
                            .padding(EdgeInsets(top: 7, leading: 18, bottom: 7, trailing: 18))
                            .background(lightGreyColor)
                            .cornerRadius(5.0)
                        Stepper("", value: $selectionCycleValue, in: 1...10)
                            .frame(width: 100, height: 50)
                    }
                    Picker("", selection: self.$selectionCycleUnit) {
                        ForEach(0 ..< self.subscriptionsViewModel.subscriptionCycleUnitOptions.count) { index in
                            Text(self.subscriptionsViewModel.subscriptionCycleUnitOptions[index])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                VStack(alignment: .leading) {
                    Text("Next Payment")
                        .font(.callout)
                        .bold()
                    DatePicker("", selection: $subscriptionNextPaymentDate, in: self.tomorrowDate..., displayedComponents: .date)
                }
                .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
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

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct NewSubscriptionForm_Previews: PreviewProvider {
    
    static var previews: some View {
        NewSubscriptionForm(isPresented: .constant(false)).environmentObject(SubscriptionsViewModel())
    }
}
