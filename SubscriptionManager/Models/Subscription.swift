//
//  Subscription.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 29/09/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import CoreData

class Subscription: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var name: String
    @NSManaged var price: Float
    @NSManaged var payed: Float
    @NSManaged var cycle: String
    @NSManaged var nextPayment: Date
    @NSManaged var created: Date
    @NSManaged var rowColor: String
    @NSManaged var category: String
    @NSManaged var email: String
}
