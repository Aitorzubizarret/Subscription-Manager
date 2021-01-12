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
    
    // MARK: - Properties
    
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
    enum subscriptionCategory: String, CaseIterable {
        case none = "none"
        case video = "video"
        case music = "music"
        case software = "software"
        case gaming = "gaming"
        case news = "news"
        case ecommerce = "ecommerce"
        case phone = "phone"
        case internet = "internet"
        case rent = "rent"
        case gym = "gym"
    }
    
    // MARK: - Methods
    
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
    /// - Parameter name : The name of the subcription.
    /// - Parameter price : The price of the subscription.
    /// - Parameter category : The category of the subscription.
    /// - Parameter cycle : The payment cycle (every 2 weeks, monthly, every 3 months, ...) of the subscription.
    /// - Parameter rowColor : The color of the subscription in the list.
    /// - Parameter nextPayment : The date of the next payment.
    ///
    public func createNewSubscription(name: String, price: Float, category: subscriptionCategory, cycle: String, rowColor: subscriptionRowColor, nextPayment: Date) {
        let newSubscription: Subscription = Subscription(context: self.moc)
        newSubscription.id = UUID()
        newSubscription.name = name
        newSubscription.price = price
        newSubscription.payed = 0.0
        newSubscription.category = category.rawValue
        newSubscription.cycle = cycle
        newSubscription.rowColor = rowColor.rawValue
        newSubscription.nextPayment = nextPayment
        
        do {
            try self.moc.save()
            self.getSubscriptions()
        } catch {
            print("Error saving new subscription: \(error)")
        }
    }
    
    ///
    /// Updates data in the received subscription.
    /// - Parameter subcription : The subscription to update.
    /// - Parameter name : A  name for the subscription.
    /// - Parameter price : A  price for the subscription.
    /// - Parameter cycle : A  cycle for the subscription.
    /// - Parameter rowColor: A color for the subscription.
    /// - Parameter nextPayment : A  'nextPayment' date for the subscription.
    ///
    public func updateSubscription(subscription: Subscription, name: String?, price: Float?, category: subscriptionCategory?, cycle: String?, rowColor: subscriptionRowColor?, nextPayment: Date?) {
        // Check Name is not an optional.
        if let newName: String = name {
            subscription.name = newName
        }
        
        // Check Price is not an optional.
        if let newPrice: Float = price {
            subscription.price = newPrice
        }
        
        // Check Category is not an optional.
        if let newCategory: SubscriptionsViewModel.subscriptionCategory = category {
            subscription.category = newCategory.rawValue
        }
        
        // Check Cycle is not an optional.
        if let newCycle: String = cycle {
            subscription.cycle = newCycle
        }
        
        // Check Color is not an optional
        if let newRowColor: subscriptionRowColor = rowColor {
            subscription.rowColor = newRowColor.rawValue
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
    /// - Parameter subscription : The subscription to delete.
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
