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
    
    //MARK: - Methods
    init() {
        moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    ///
    /// Creates and saves a new subscription in Core Data.
    ///
    public func createNewSubscription(name: String, price: Float) {
        let newSubscription: Subscription = Subscription(context: self.moc)
        newSubscription.name = name
        newSubscription.price = price
        
        do {
            try self.moc.save()
        } catch {
            print("Error saving new subscription: \(error)")
        }
    }
}
