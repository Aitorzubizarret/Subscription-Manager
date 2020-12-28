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
            VStack(spacing: 8) {
                SubscriptionLogoTitleField(title: subscription.name, category: subscription.category)
                CustomDivider()
                VStack(spacing: 8) {
                    SubscriptionDataField(title: "Price", value: self.price)
                    Divider()
                    SubscriptionDataField(title: "Cycle", value: self.cycle)
                    Divider()
                    // Avoids unknown error with dateFormatter when deleting the Subscription.
                    if !self.deleteInProcess {
                        SubscriptionDataField(title: "Next Payment", value: self.subscription.nextPayment.getYearMonthDay())
                    }
                    Divider()
                    SubscriptionDataField(title: "Total", value: "1350 €")
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                CustomDivider()
                Button(action: {
                    self.showingSubscriptionEditView.toggle()
                }) {
                    BigButton(style: BigButton.Style.edit, title: "Edit Subscription")
                }.sheet(isPresented: $showingSubscriptionEditView) {
                    SubscriptionEditView(isPresented: self.$showingSubscriptionEditView, subscription: self.subscription)
                        .environmentObject(self.subscriptionsViewModel)
                }
                Button(action: {
                    self.showingAlert = true
                }) {
                    BigButton(style: BigButton.Style.delete, title: "Delete Subscription")
                }.alert(isPresented: self.$showingAlert, content: {
                    Alert(title: Text("Delete Subscription"), message: Text("This action can’t be undone. Are you sure?") ,primaryButton: Alert.Button.destructive(Text("Delete"), action: {
                        self.deleteSubscription()
                    }), secondaryButton: Alert.Button.cancel(Text("No")))
                })
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
        
        return SubscriptionDetailView(subscription: subscription)
    }
}
