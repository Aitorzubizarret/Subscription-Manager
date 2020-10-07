//
//  Subscription.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 29/09/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import CoreData

class Subscription: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var price: Float
}
