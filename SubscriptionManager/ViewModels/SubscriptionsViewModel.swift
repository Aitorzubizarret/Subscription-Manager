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
    @Published var payments: [Payment] = []
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
        
        ///
        /// Converts the String value to Color value.
        ///
        func convertFromStringToColor() -> Color {
            var color: Color
            
            switch self {
            case .blue:
                color = Color.customRowBlue
            case .blueDark:
                color = Color.customRowBlueDark
            case .green:
                color = Color.customRowGreen
            case .greenDark:
                color = Color.customRowGreenDark
            case .pistachio:
                color = Color.customRowPistachio
            case .yellow:
                color = Color.customRowYellow
            case .mango:
                color = Color.customRowMango
            case .orange:
                color = Color.customRowOrange
            case .orangeDark:
                color = Color.customRowOrangeDark
            case .red:
                color = Color.customRowRed
            }
            return color
        }
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
        case education = "education"
        
        func getSFSymbolImageString() -> String {
            var imageString = ""
            
            switch self {
            case .none:
                imageString = "questionmark"
            case .video:
                imageString = "play.tv"
            case .music:
                imageString = "music.note"
            case .software:
                imageString = "desktopcomputer"
            case .gaming:
                imageString = "gamecontroller"
            case .news:
                imageString = "newspaper"
            case .ecommerce:
                imageString = "cart"
            case .phone:
                imageString = "phone"
            case .internet:
                imageString = "globe"
            case .rent:
                imageString = "house"
            case .gym:
                imageString = "figure.walk" // flame
            case .education:
                imageString = "book"
            }
            
            return imageString
        }
    }
    
    // MARK: - Methods
    
    init() {
        moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.getSubscriptions()
        self.getPayments()
    }
    
    ///
    /// Gets subscriptions from CoreData and saves them in the property 'subscriptions'.
    /// It also checks the nextPaymentDate, and updates it in case the date is earlier than today. (Outdated).
    ///
    private func getSubscriptions() {
        let request = Subscription.fetchRequest()
        
        do {
            var fetchedSubscriptions: [Subscription] = []
            fetchedSubscriptions = try self.moc.fetch(request) as! [Subscription]
            
            // Check the nextPayment date of subscriptions and updates them if the date is old. (Outdated).
            for subscription in fetchedSubscriptions {
                if subscription.nextPayment.isOlderThan(date: Date()) {
                    self.updateOldPaymentDate(subscription: subscription)
                }
            }
            
            self.subscriptions = fetchedSubscriptions
        } catch {
            print("getSubscriptions Error: \(error)")
        }
    }
    
    ///
    /// Gets payments from Core Data and saves them in the property 'payments'.
    ///
    private func getPayments() {
        let request = Payment.fetchRequest()
        
        do {
            var fechedPayments: [Payment] = []
            fechedPayments = try self.moc.fetch(request) as! [Payment]
            
            self.payments = fechedPayments
        } catch {
            print("Error : getPayments \(error)")
        }
    }
    
    ///
    /// Returns a list of payments that are due to the current month, but between the current day until the end of the month.
    /// - Returns: A Payment list.
    ///
    public func getPaymentsDueToThisMonth() -> [Payment] {
        // Create an empty list.
        var result: [Payment] = []
        
        // Save in result the payments that their date is in range between today and the end of the month.
        result = self.payments.filter { payment in
            return payment.date.isInRangeBetweenTodayAndEndOfCurrentMonth()
        }
        
        // Order the "result" Payments list by date ascendent.
        let resultOrdered: [Payment] = result.sorted { $0.date < $1.date }
        result = resultOrdered
        
        // Return the payments list.
        return result
    }
    
    ///
    /// Updates the old payment date from a Subscription.
    /// - Parameter subscription : The subscription that has an old (outdated) nextPaymentDate.
    ///
    private func updateOldPaymentDate(subscription: Subscription) {
        // Get payment cycle.
        let paymentCycle: String = subscription.cycle
        let cycleComponents: [String] = paymentCycle.components(separatedBy: "-")
                
        // Update nextPayment date.
        if cycleComponents.count == 2 {
            
            // Get the old nextPayment date.
            var oldNextPaymentDate: Date = subscription.nextPayment
            
            // Create the new nextPayment date.
            var newNextPaymentDate: Date = Date()
            
            // Calculate the new nextPayment date.
            switch cycleComponents[1] {
            case "d":
                repeat {
                    // Add a date component to add x days.
                    var dateComponent = DateComponents()
                    dateComponent.day = Int(cycleComponents[0]) ?? 1
                    
                    // Create the newNextPaymentDate and update the oldNextPaymentDate.
                    newNextPaymentDate = Calendar.current.date(byAdding: dateComponent, to: oldNextPaymentDate) ?? Date()
                    oldNextPaymentDate = newNextPaymentDate
                    
                    // Add the amount payed to the total.
                    subscription.payed = subscription.payed + subscription.price
                    
                    // Create a new Payment object.
                    self.createNewPayment(subscription_id: subscription.id, subscription_name: subscription.name, subscription_category: subscription.category, amount: subscription.price, date: newNextPaymentDate)
                } while newNextPaymentDate.isOlderThan(date: Date())
            case "w":
                repeat {
                    // Add a date component to add x weeks.
                    var dateComponent = DateComponents()
                    if let weeks: Int = Int(cycleComponents[0]) {
                        dateComponent.day = weeks * 7
                    } else {
                        dateComponent.day = 1
                    }
                    
                    // Create the newNextPaymentDate and update the oldNextPaymentDate.
                    newNextPaymentDate = Calendar.current.date(byAdding: dateComponent, to: oldNextPaymentDate) ?? Date()
                    oldNextPaymentDate = newNextPaymentDate
                    
                    // Add the amount payed to the total.
                    subscription.payed = subscription.payed + subscription.price
                    
                    // Create a new Payment object.
                    self.createNewPayment(subscription_id: subscription.id, subscription_name: subscription.name, subscription_category: subscription.category, amount: subscription.price, date: newNextPaymentDate)
                } while newNextPaymentDate.isOlderThan(date: Date())
            case "m":
                repeat {
                    // Add a date component to add x months.
                    var dateComponent = DateComponents()
                    dateComponent.month = Int(cycleComponents[0]) ?? 1
                    
                    // Create the newNextPaymentDate and update the oldNextPaymentDate.
                    newNextPaymentDate = Calendar.current.date(byAdding: dateComponent, to: oldNextPaymentDate) ?? Date()
                    oldNextPaymentDate = newNextPaymentDate
                    
                    // Add the amount payed to the total.
                    subscription.payed = subscription.payed + subscription.price
                    
                    // Create a new Payment object.
                    self.createNewPayment(subscription_id: subscription.id, subscription_name: subscription.name, subscription_category: subscription.category, amount: subscription.price, date: newNextPaymentDate)
                } while newNextPaymentDate.isOlderThan(date: Date())
            case "y":
                repeat {
                    // Add a date component to add x years.
                    var dateComponent = DateComponents()
                    dateComponent.year = Int(cycleComponents[0]) ?? 1
                    
                    // Create the newNextPaymentDate and update the oldNextPaymentDate.
                    newNextPaymentDate = Calendar.current.date(byAdding: dateComponent, to: oldNextPaymentDate) ?? Date()
                    oldNextPaymentDate = newNextPaymentDate
                    
                    // Add the amount payed to the total.
                    subscription.payed = subscription.payed + subscription.price
                    
                    // Create a new Payment object.
                    self.createNewPayment(subscription_id: subscription.id, subscription_name: subscription.name, subscription_category: subscription.category, amount: subscription.price, date: newNextPaymentDate)
                } while newNextPaymentDate.isOlderThan(date: Date())
            default:
                print("Error updating the old nextPayment date to a subscription.")
            }
            
            // Update the new nexPayment date.
            subscription.nextPayment = newNextPaymentDate
            
            // Updates the subscription.
            self.moc.refresh(subscription, mergeChanges: true)
            
            // Saves the subscription.
            do {
                try self.moc.save()
            } catch {
                print("Error updating a subscription: \(error)")
            }
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
        // Create the new Subscription object.
        let newSubscription: Subscription = Subscription(context: self.moc)
        newSubscription.id = UUID()
        newSubscription.name = name
        newSubscription.price = price
        newSubscription.payed = 0.0
        newSubscription.category = category.rawValue
        newSubscription.cycle = cycle
        newSubscription.rowColor = rowColor.rawValue
        newSubscription.nextPayment = nextPayment
        newSubscription.created = Date()
        
        // Create the payment
        self.createNewPayment(subscription_id: newSubscription.id, subscription_name: newSubscription.name, subscription_category: newSubscription.category, amount: newSubscription.price, date: newSubscription.nextPayment)
        
        // Save it in Core Data and update the subscriptions property.
        do {
            try self.moc.save()
            self.getSubscriptions()
        } catch {
            print("Error creating and saving a new Subscription object (createNewSubscription): \(error)")
        }
    }
    
    ///
    /// Creates and saves a new payment in Core Data.
    ///
    private func createNewPayment(subscription_id: UUID, subscription_name: String, subscription_category: String, amount: Float, date: Date) {
        // Create the new Payment object.
        let newPayment: Payment = Payment(context: self.moc)
        newPayment.id = UUID()
        newPayment.subscription_id = subscription_id
        newPayment.subscription_name = subscription_name
        newPayment.subscription_category = subscription_category
        newPayment.amount = amount
        newPayment.date = date
        
        // Save it in Core Data and update the payments property.
        do {
            try self.moc.save()
            self.getPayments()
        } catch {
            print("Error creating and saving a new Payment object (createNewPayment) : \(error)")
        }
    }
    
    ///
    /// Updates data in the received subscription.
    /// - Parameter subscription : The subscription to update.
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
        
        // Updates all payments of the subscription.
        self.updatePayments(subscription: subscription)
    }
    
    ///
    /// Updates all the Payments from the received subscription.
    /// - Parameter subscription : The subscription
    ///
    private func updatePayments(subscription: Subscription) {
        // Search Payments with the same "subscription_id" to update their data (name & category).
        for payment in self.payments {
            if payment.subscription_id == subscription.id {
                payment.subscription_name = subscription.name
                payment.subscription_category = subscription.category
                
                // Update Payment.
                self.moc.refresh(payment, mergeChanges: true)
            }
        }
        
        // Save it in Core Data and update Payments from SubscriptionViewModel.
        do {
            try self.moc.save()
            self.getPayments()
        } catch {
            print("Error updating the payments of one subscription: \(error)")
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
    
    ///
    /// Deletes all data from Core Data.
    ///
    public func deleteAllData() {
        // Removes all Subscriptions from Core Data.
        for subscription in self.subscriptions {
            self.moc.delete(subscription)
        }
        
        // Removes all Payments from Core Data.
        for payment in self.payments {
            self.moc.delete(payment)
        }
        
        // Commits the changes in Core Data to delete everything, and update the Subscriptions and Payments arrays.
        do {
            try self.moc.save()
            self.getSubscriptions()
            self.getPayments()
        } catch {
            print("Error deleting all data from Core Data. \(error)")
        }
    }
    
    ///
    /// Adds demo data to the App (Core Data).
    ///
    public func addDemoData() {
        
        // 1
        if let customDate: Date = "2021/03/20".convertToDate() {
            self.createNewSubscription(name: "Netflix", price: 4, category: .video, cycle: "1-m", rowColor: .blueDark, nextPayment: customDate)
        }
        
        // 2
        if let customDate: Date = "2021/01/05".convertToDate() {
            self.createNewSubscription(name: "HBO", price: 4, category: .video, cycle: "3-m", rowColor: .blueDark, nextPayment: customDate)
        }
        
        // 3
        if let customDate: Date = "2019/01/10".convertToDate() {
            self.createNewSubscription(name: "AppleTV", price: 4, category: .video, cycle: "1-y", rowColor: .blueDark, nextPayment: customDate)
        }
        
        // 4
        if let customDate: Date = "2021/01/14".convertToDate() {
            self.createNewSubscription(name: "Amazon Prime", price: 4, category: .ecommerce, cycle: "1-m", rowColor: .blueDark, nextPayment: customDate)
        }
        
        // 5
        if let customDate: Date = "2021/01/21".convertToDate() {
            self.createNewSubscription(name: "AT&T", price: 4, category: .phone, cycle: "1-w", rowColor: .blueDark, nextPayment: customDate)
        }
        
        // 6
        if let customDate: Date = "2021/01/18".convertToDate() {
            self.createNewSubscription(name: "Dropbox", price: 4, category: .software, cycle: "1-y", rowColor: .blueDark, nextPayment: customDate)
        }
        
        // 7
        if let customDate: Date = "2021/01/04".convertToDate() {
            self.createNewSubscription(name: "Spotify", price: 4, category: .music, cycle: "1-m", rowColor: .blueDark, nextPayment: customDate)
        }
        
    }
    
    ///
    /// Converts a string into Color if it's one of the SubscriptionRowColors.
    /// - Parameter : A string
    /// - Returns : Optional Color
    ///
    public func convertStringToColor(stringColor: String) -> Color? {
        var color: Color?
        
        switch stringColor {
        case SubscriptionsViewModel.subscriptionRowColor.blue.rawValue:
            color = Color.customRowBlue
        case SubscriptionsViewModel.subscriptionRowColor.blueDark.rawValue:
            color = Color.customRowBlueDark
        case SubscriptionsViewModel.subscriptionRowColor.green.rawValue:
            color = Color.customRowGreen
        case SubscriptionsViewModel.subscriptionRowColor.greenDark.rawValue:
            color = Color.customRowGreenDark
        case SubscriptionsViewModel.subscriptionRowColor.pistachio.rawValue:
            color = Color.customRowPistachio
        case SubscriptionsViewModel.subscriptionRowColor.yellow.rawValue:
            color = Color.customRowYellow
        case SubscriptionsViewModel.subscriptionRowColor.mango.rawValue:
            color = Color.customRowMango
        case SubscriptionsViewModel.subscriptionRowColor.orange.rawValue:
            color = Color.customRowOrange
        case SubscriptionsViewModel.subscriptionRowColor.orangeDark.rawValue:
            color = Color.customRowOrangeDark
        case SubscriptionsViewModel.subscriptionRowColor.red.rawValue:
            color = Color.customRowRed
        default:
            print("Error convertStringToColor : '\(stringColor)' Color not defined.")
        }
        
        return color
    }
}
