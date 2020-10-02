//
//  NewSubscriptionForm.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 30/09/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct NewSubscriptionForm: View {
    
    //MARK: - Properties
    
    //MARK: - Methods
    var body: some View {
        NavigationView {
            Form {
                Text("Form")
            }.navigationBarTitle(Text("New Subscription"), displayMode: .inline)
        }
    }
}

struct NewSubscriptionForm_Previews: PreviewProvider {
    static var previews: some View {
        NewSubscriptionForm()
    }
}
