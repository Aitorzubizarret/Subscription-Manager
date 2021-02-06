//
//  Payment.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta Perez on 06/02/2021.
//  Copyright © 2021 Aitor Zubizarreta. All rights reserved.
//

import CoreData

class Payment: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var subscription_id: UUID
    @NSManaged var subscription_name: String
    @NSManaged var subscription_category: String
    @NSManaged var amount: Float
    @NSManaged var date: Date
}
