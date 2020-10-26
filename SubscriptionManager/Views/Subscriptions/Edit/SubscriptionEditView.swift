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
    @State private var textCycleValue: String = "0"
    @State private var selectionCycleUnit: Int = 2
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
        let cycleComponents: [String] = subscription.cycle.components(separatedBy: "-")
        if cycleComponents.count == 2 {
            self._textCycleValue = State(wrappedValue: cycleComponents[0])
            
            switch cycleComponents[1] {
            case "d":
                self._selectionCycleUnit = State(wrappedValue: 0)
            case "w":
                self._selectionCycleUnit = State(wrappedValue: 1)
            case "m":
                self._selectionCycleUnit = State(wrappedValue: 2)
            case "y":
                self._selectionCycleUnit = State(wrappedValue: 3)
            default:
                self._selectionCycleUnit = State(wrappedValue: 3)
            }
        }
        
        // Next Payment.
        self._nextPayment = State(wrappedValue: subscription.nextPayment)
    }
    
    ///
    /// Increases the value by 1.
    ///
    private func increaseValue() {
        let value: Int? = Int(self.textCycleValue)
        if let intValue = value {
            if intValue < 10 {
                self.textCycleValue = "\(intValue + 1)"
            }
        }
    }
    
    ///
    /// Decreases the value by 1.
    ///
    private func decreaseValue() {
        let value: Int? = Int(self.textCycleValue)
        if let intValue = value {
            if intValue > 1 {
                self.textCycleValue = "\(intValue - 1)"
            }
        }
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
        var subscriptionCycleUnit: String = ""
        switch self.selectionCycleUnit {
        case 0:
            subscriptionCycleUnit = "d"
        case 1:
            subscriptionCycleUnit = "w"
        case 2:
            subscriptionCycleUnit = "m"
        case 3:
            subscriptionCycleUnit = "y"
        default:
            subscriptionCycleUnit = "¿?"
        }
        let subscriptionCycle: String = "\(self.textCycleValue)-\(subscriptionCycleUnit)"
        
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
                HStack {
                    Text("Name :")
                        .fontWeight(Font.Weight.bold)
                        .font(Font.system(size: 14))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .frame(width: 60, height: 50, alignment: .leading)
                    Spacer()
                    TextField("Enter name ...", text: $textFieldSubscriptionName)
                        .padding()
                        .background(Color.customLightGrey)
                        .foregroundColor(Color.customDarkText)
                        .cornerRadius(5.0)
                        .keyboardType(UIKeyboardType.alphabet)
                }
                .padding(EdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15))
                .onTapGesture { self.hideKeyboard() }
                Divider()
                HStack {
                    Text("Price :")
                        .fontWeight(Font.Weight.bold)
                        .font(Font.system(size: 14))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .frame(width: 60, height: 50, alignment: .leading)
                    Spacer()
                    TextField("Enter price ...", text: $textFieldSubscriptionPrice)
                        .padding()
                        .background(Color.customLightGrey)
                        .foregroundColor(Color.customDarkText)
                        .cornerRadius(5.0)
                        .keyboardType(UIKeyboardType.decimalPad)
                }
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                .onTapGesture { self.hideKeyboard() }
                Divider()
                HStack {
                    Text("Cycle :")
                        .fontWeight(Font.Weight.bold)
                        .font(Font.system(size: 14))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .frame(width: 60, height: 50, alignment: .leading)
                    Spacer()
                    Button(action: {
                        self.decreaseValue()
                    }) {
                        Text("-")
                            .fontWeight(Font.Weight.bold)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            .frame(width: 50, height: 50, alignment: .center)
                            .background(Color.customLightGrey)
                            .foregroundColor(Color.black)
                            .cornerRadius(6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.customLightGrey, lineWidth: 2)
                            )
                            .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
                    }
                    Text(self.textCycleValue)
                        .fontWeight(Font.Weight.bold)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .frame(width: 100, height: 50, alignment: .center)
                    Button(action: {
                        self.increaseValue()
                    }) {
                        Text("+")
                            .fontWeight(Font.Weight.bold)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            .frame(width: 50, height: 50, alignment: .center)
                            .background(Color.customLightGrey)
                            .foregroundColor(Color.black)
                            .cornerRadius(6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.customLightGrey, lineWidth: 2)
                            )
                            .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
                        }
                    }
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                .onTapGesture { self.hideKeyboard() }
                HStack {
                    Picker("", selection: self.$selectionCycleUnit) {
                        ForEach(0 ..< self.subscriptionsViewModel.subscriptionCycleUnitOptions.count) { index in
                            Text(self.subscriptionsViewModel.subscriptionCycleUnitOptions[index])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
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
