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
    
    @Binding var selectedCategory: SubscriptionsViewModel.subscriptionCategory
    @State private var selectedCategoryIndex: Int
    private var categoryList: [String]
    private var navBarTitle: String = ""
    
    // MARK: - Methods
    
    init(value: Binding<SubscriptionsViewModel.subscriptionCategory>) {
        self._selectedCategory = value
        self._selectedCategoryIndex = State(wrappedValue: -1)
        self.categoryList = []
        for category in SubscriptionsViewModel.subscriptionCategory.allCases {
            self.categoryList.append(category.rawValue)
        }
        
        self.localizeText()
    }
    
    ///
    /// Localize UI text elements.
    ///
    private mutating func localizeText() {
        // Get strings from localizable.
        self.navBarTitle = NSLocalizedString("categories", comment: "")
        
    }
    
    ///
    /// Checks if category is selected and returns a boolean.
    /// - Parameter index : The index 
    /// - Returns : True if the category is selected and false otherwise.
    ///
    private func isSelected(index: Int) -> Bool {
        if self.selectedCategory.rawValue == self.categoryList[index] {
            return true
        } else {
            return false
        }
    }
    
    ///
    /// Updates the index of the selected category.
    /// - Parameter newIndex : The new index of the selected category.
    ///
    private func updateCategory(newIndex: Int) {
        self.selectedCategoryIndex = newIndex
        
        switch self.selectedCategoryIndex {
        case 1:
            self.selectedCategory = SubscriptionsViewModel.subscriptionCategory.video
        case 2:
            self.selectedCategory = SubscriptionsViewModel.subscriptionCategory.music
        case 3:
            self.selectedCategory = SubscriptionsViewModel.subscriptionCategory.software
        case 4:
            self.selectedCategory = SubscriptionsViewModel.subscriptionCategory.gaming
        case 5:
            self.selectedCategory = SubscriptionsViewModel.subscriptionCategory.news
        case 6:
            self.selectedCategory = SubscriptionsViewModel.subscriptionCategory.ecommerce
        case 7:
            self.selectedCategory = SubscriptionsViewModel.subscriptionCategory.phone
        case 8:
            self.selectedCategory = SubscriptionsViewModel.subscriptionCategory.internet
        case 9:
            self.selectedCategory = SubscriptionsViewModel.subscriptionCategory.rent
        case 10:
            self.selectedCategory = SubscriptionsViewModel.subscriptionCategory.gym
        case 11:
            self.selectedCategory = SubscriptionsViewModel.subscriptionCategory.education
        default:
            self.selectedCategory = SubscriptionsViewModel.subscriptionCategory.video
        }
    }
    
    // MARK: - View
    
    var body: some View {
        ScrollView {
            ForEach(1..<self.categoryList.count, id: \.self) { index in
                Button(action: {
                    self.selectedCategoryIndex = index
                    self.updateCategory(newIndex: index)
                }) {
                    CategoryElement(text: self.categoryList[index], selected: self.isSelected(index: index))
                }
            }
        }
        .navigationBarTitle(self.navBarTitle)
    }
}

struct CategoriesView_Previews: PreviewProvider {
    
    static var previews: some View {
        CategoriesView(value: .constant(SubscriptionsViewModel.subscriptionCategory(rawValue: "video")!))
    }
}
