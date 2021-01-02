//
//  CategoriesView.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta Perez on 02/01/2021.
//  Copyright © 2021 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct CategoriesView: View {
    
    // MARK: - Properties
    
    // MARK: - Methods
    
    // MARK: - View
    
    var body: some View {
        ScrollView {
            ForEach(1..<7, id: \.self) { index in
                CategoryElement(text: "Category \(index)")
            }
        }
        .navigationBarTitle("Categories")
    }
}

struct CategoriesView_Previews: PreviewProvider {
    
    static var previews: some View {
        CategoriesView()
    }
}
