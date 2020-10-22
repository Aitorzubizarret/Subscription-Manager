//
//  SubscriptionsViewModel.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 02/10/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData

class SubscriptionsViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var subscriptions: [Subscription] = []
    private var moc: NSManagedObjectContext
    public var subscriptionCycleUnitOptions: [String] = ["day", "week", "month", "year"]
    
    //MARK: - Methods
    init() {
        moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.getSubscriptions()
    }
    
    ///
    /// Gets subscriptions from CoreData and saves them in the property 'subscriptions'.
    ///
    private func getSubscriptions() {
        let request = Subscription.fetchRequest()
        
        do {
            self.subscriptions = try self.moc.fetch(request) as! [Subscription]
        } catch {
            print("getSubscriptions Error: \(error)")
        }
    }
    
    ///
    /// Creates and saves a new subscription in Core Data.
    ///
    public func createNewSubscription(name: String, price: Float, cycle: String, nextPayment: Date) {
        let newSubscription: Subscription = Subscription(context: self.moc)
        newSubscription.id = UUID()
        newSubscription.name = name
        newSubscription.price = price
        newSubscription.cycle = cycle
        newSubscription.nextPayment = nextPayment
        
        do {
            try self.moc.save()
            self.getSubscriptions()
        } catch {
            print("Error saving new subscription: \(error)")
        }
    }
    
    ///
    /// Deletes the received subcripcion from Core Data.
    ///
    public func deleteSubscription(subscription: Subscription) {
        
        self.moc.delete(subscription)
        
        do {
            try self.moc.save()
            self.getSubscriptions()
        } catch {
            print("Error deleting a subscription: \(error)")
        }
    }
}
