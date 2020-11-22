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
    enum subscriptionRowColor: String, CaseIterable {
        case blue = "customRowBlue"
        case blueDark = "customRowBlueDark"
        case green = "customRowGreen"
        case greenDark = "customRowGreenDark"
        case pistachio = "customRowPistachio"
        case yellow = "customRowYellow"
        case mango = "customRowMango"
        case orange = "customRowOrange"
        case orangeDark = "customRowOrangeDark"
        case red = "customRowRed"
    }
    
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
    public func createNewSubscription(name: String, price: Float, cycle: String, nextPayment: Date, rowColor: subscriptionRowColor) {
        let newSubscription: Subscription = Subscription(context: self.moc)
        newSubscription.id = UUID()
        newSubscription.name = name
        newSubscription.price = price
        newSubscription.cycle = cycle
        newSubscription.nextPayment = nextPayment
        newSubscription.rowColor = rowColor.rawValue
        
        do {
            try self.moc.save()
            self.getSubscriptions()
        } catch {
            print("Error saving new subscription: \(error)")
        }
    }
    
    ///
    /// Updates data in the received subscription.
    /// - Parameter subcription :The subscription to update.
    /// - Parameter name : A new name for the subscription.
    /// - Parameter price : A new price for the subscription.
    /// - Parameter cycle : A new cycle for the subscription.
    /// - Parameter nextPayment : A new 'nextPayment' date for the subscription.
    ///
    public func updateSubscription(subscription: Subscription, name: String?, price: Float?, cycle: String?, nextPayment: Date?) {
        // Check Name is not an optional.
        if let newName: String = name {
            subscription.name = newName
        }
        
        // Check Price is not an optional.
        if let newPrice: Float = price {
            subscription.price = newPrice
        }
        
        // Check Cycle is not an optional.
        if let newCycle: String = cycle {
            subscription.cycle = newCycle
        }
        
        // Check Next Payment date is not an optional.
        if let newNextPayment: Date = nextPayment {
            subscription.nextPayment = newNextPayment
        }
        
        // Updates the subscription.
        self.moc.refresh(subscription, mergeChanges: true)
        
        // Saves the subscription.
        do {
            try self.moc.save()
            self.getSubscriptions()
        } catch {
            print("Error updating a subscription: \(error)")
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
