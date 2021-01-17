//
//  SubscriptionDetail.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 30/09/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct SubscriptionDetailView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var subscriptionsViewModel: SubscriptionsViewModel
    @State private var showingAlert: Bool = false
    @State private var deleteInProcess: Bool = false
    @State private var showingSubscriptionEditView: Bool = false
    var subscription: Subscription
    private var price: String = ""
    private var cycle: String = ""
    private var backgroundColor: Color = Color.red
    private var nextPayment: String = ""
    
    // MARK: - Methods
    
    init(subscription: Subscription) {
        self.subscription = subscription
        
        // Price.
        self.price = String(format: "%.2f €", subscription.price)
        
        // Cycle.
        self.cycle = "Every "
        let cycleComponents: [String] = subscription.cycle.components(separatedBy: "-")
        if cycleComponents.count == 2 {
            if cycleComponents[0] == "1" {
                switch cycleComponents[1] {
                case "d":
                    self.cycle = self.cycle + "day" // Day.
                case "w":
                    self.cycle = self.cycle + "week" // Week.
                case "m":
                    self.cycle = self.cycle + "month" // Month.
                case "y":
                    self.cycle = self.cycle + "year" // Year.
                default:
                    self.cycle = self.cycle + "¿?" // Unknow.
                }
            } else {
                switch cycleComponents[1] {
                case "d":
                    self.cycle = self.cycle + "\(cycleComponents[0]) " + "days" // Day.
                case "w":
                    self.cycle = self.cycle + "\(cycleComponents[0]) " + "weeks" // Week.
                case "m":
                    self.cycle = self.cycle + "\(cycleComponents[0]) " + "months" // Month.
                case "y":
                    self.cycle = self.cycle + "\(cycleComponents[0]) " + "years" // Year.
                default:
                    self.cycle = self.cycle + "\(cycleComponents[0]) " + "¿?" // Unknow.
                }
            }
        }
        
        // Color.
        let color = subscription.rowColor
        switch color {
        case SubscriptionsViewModel.subscriptionRowColor.blue.rawValue:
            self.backgroundColor = Color.customRowBlue
        case SubscriptionsViewModel.subscriptionRowColor.blueDark.rawValue:
            self.backgroundColor = Color.customRowBlueDark
        case SubscriptionsViewModel.subscriptionRowColor.green.rawValue:
            self.backgroundColor = Color.customRowGreen
        case SubscriptionsViewModel.subscriptionRowColor.greenDark.rawValue:
            self.backgroundColor = Color.customRowGreenDark
        case SubscriptionsViewModel.subscriptionRowColor.pistachio.rawValue:
            self.backgroundColor = Color.customRowPistachio
        case SubscriptionsViewModel.subscriptionRowColor.yellow.rawValue:
            self.backgroundColor = Color.customRowYellow
        case SubscriptionsViewModel.subscriptionRowColor.mango.rawValue:
            self.backgroundColor = Color.customRowMango
        case SubscriptionsViewModel.subscriptionRowColor.orange.rawValue:
            self.backgroundColor = Color.customRowOrange
        case SubscriptionsViewModel.subscriptionRowColor.orangeDark.rawValue:
            self.backgroundColor = Color.customRowOrangeDark
        case SubscriptionsViewModel.subscriptionRowColor.red.rawValue:
            self.backgroundColor = Color.customRowRed
        default:
            self.backgroundColor = Color.customRowBlue
        }
    }
    
    ///
    /// Deletes the subscription.
    ///
    private func deleteSubscription() {
        self.deleteInProcess = true
        self.subscriptionsViewModel.deleteSubscription(subscription: self.subscription)
    }
    
    // MARK: - View
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    SubscriptionLogoTitleField(title: subscription.name, category: subscription.category, backgroundColor: self.backgroundColor)
                    VStack(spacing: 8) {
                        SubscriptionDataField(title: "Price", value: self.price, backgroundColor: self.backgroundColor)
                        SubscriptionDataField(title: "Cycle", value: self.cycle, backgroundColor: self.backgroundColor)
                        // Avoids unknown error with dateFormatter when deleting the Subscription.
                        if !self.deleteInProcess {
                            SubscriptionDataField(title: "Next Payment", value: self.subscription.nextPayment.getYearMonthDay(), backgroundColor: self.backgroundColor)
                        }
                        SubscriptionDataField(title: "Total", value: "\(subscription.payed) €", backgroundColor: self.backgroundColor)
                        SubscriptionDataField(title: "Created", value: "\(subscription.created.getYearMonthDay())", backgroundColor: self.backgroundColor)
                    }
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .background(self.backgroundColor)
                }
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.white, lineWidth: 2)
                )
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                Button(action: {
                    self.showingSubscriptionEditView.toggle()
                }) {
                    BigButton(style: BigButton.Style.edit, title: "Edit Subscription")
                }.sheet(isPresented: $showingSubscriptionEditView) {
                    SubscriptionEditView(isPresented: self.$showingSubscriptionEditView, subscription: self.subscription)
                        .environmentObject(self.subscriptionsViewModel)
                }
                .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                Button(action: {
                    self.showingAlert = true
                }) {
                    BigButton(style: BigButton.Style.delete, title: "Delete Subscription")
                }.alert(isPresented: self.$showingAlert, content: {
                    Alert(title: Text("Delete Subscription"), message: Text("This action can’t be undone. Are you sure?") ,primaryButton: Alert.Button.destructive(Text("Delete"), action: {
                        self.deleteSubscription()
                    }), secondaryButton: Alert.Button.cancel(Text("No")))
                })
                .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
            }
            
        }
        .navigationBarTitle("\(subscription.name)", displayMode: .inline)
    }
}

struct SubscriptionDetail_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let subscription: Subscription = Subscription(context: context)
        subscription.name = "Test"
        subscription.price = 9
        subscription.cycle = "1-m"
        subscription.nextPayment = Date()
        subscription.created = Date()
        subscription.category = "video"
        
        return SubscriptionDetailView(subscription: subscription)
    }
}
