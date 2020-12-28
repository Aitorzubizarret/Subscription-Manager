//
//  ColorsField.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta Perez on 24/12/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct ColorsField: View {
    
    // MARK: - Properties
    
    @Binding var selectedColor: SubscriptionsViewModel.subscriptionRowColor
    var title: String
    private var spacing: CGFloat {
        return (UIScreen.main.bounds.size.width - (12 * 4) - (40 * 7)) / 6
    }
    @State private var selectedColorPosition: Int
    
    // MARK: - Methods
    
    init(title: String, value: Binding<SubscriptionsViewModel.subscriptionRowColor>) {
        self.title = title
        self._selectedColor = value
        self._selectedColorPosition = State(wrappedValue: 0)
        
        self.setSelectedColorPosition()
    }
    
    ///
    /// Sets the selected color.
    ///
    private mutating func setSelectedColorPosition() {
        
        switch self.selectedColor {
        case .blue:
            self._selectedColorPosition = State(wrappedValue: 0)
        case .blueDark:
            self._selectedColorPosition = State(wrappedValue: 1)
        case .green:
            self._selectedColorPosition = State(wrappedValue: 2)
        case .greenDark:
            self._selectedColorPosition = State(wrappedValue: 3)
        case .mango:
            self._selectedColorPosition = State(wrappedValue: 4)
        case .orange:
            self._selectedColorPosition = State(wrappedValue: 5)
        case .orangeDark:
            self._selectedColorPosition = State(wrappedValue: 6)
        case .pistachio:
            self._selectedColorPosition = State(wrappedValue: 7)
        case .red:
            self._selectedColorPosition = State(wrappedValue: 8)
        case .yellow:
            self._selectedColorPosition = State(wrappedValue: 9)
        }
    }
    
    ///
    /// Returns a 'SubscriptionViewModel.subscriptionRowColor' based on the position.
    ///  - Parameter position : The position of the color.
    ///  - Returns : A color as 'SubscriptionsViewModel.subscriptionRowColor'.
    ///
    private func setColor(position: Int) -> SubscriptionsViewModel.subscriptionRowColor {
        switch position {
        case 0:
            return .blue
        case 1:
            return .blueDark
        case 2:
            return .green
        case 3:
            return .greenDark
        case 4:
            return .mango
        case 5:
            return .orange
        case 6:
            return .orangeDark
        case 7:
            return .pistachio
        case 8:
            return .red
        case 9:
            return .yellow
        default:
            return .blue
        }
    }
    
    ///
    /// Checks if color (based on the position) is selected and returns a boolean.
    /// - Parameter position : The position of the selected color.
    /// - Returns : True if the color is selected and false otherwise.
    ///
    private func isSelected(position: Int) -> Bool {
        if position == self.selectedColorPosition {
            return true
        } else {
            return false
        }
    }
    
    ///
    /// Updates the position of the selected color.
    /// - Parameter position : The new selected color position.
    ///
    private func updateSelectedColorPosition(position: Int) {
        self.selectedColorPosition = position
        
        switch self.selectedColorPosition {
        case 0:
            self.selectedColor = SubscriptionsViewModel.subscriptionRowColor.blue
        case 1:
            self.selectedColor = SubscriptionsViewModel.subscriptionRowColor.blueDark
        case 2:
            self.selectedColor = SubscriptionsViewModel.subscriptionRowColor.green
        case 3:
            self.selectedColor = SubscriptionsViewModel.subscriptionRowColor.greenDark
        case 4:
            self.selectedColor = SubscriptionsViewModel.subscriptionRowColor.mango
        case 5:
            self.selectedColor = SubscriptionsViewModel.subscriptionRowColor.orange
        case 6:
            self.selectedColor = SubscriptionsViewModel.subscriptionRowColor.orangeDark
        case 7:
            self.selectedColor = SubscriptionsViewModel.subscriptionRowColor.pistachio
        case 8:
            self.selectedColor = SubscriptionsViewModel.subscriptionRowColor.red
        case 9:
            self.selectedColor = SubscriptionsViewModel.subscriptionRowColor.yellow
        default:
            self.selectedColor = SubscriptionsViewModel.subscriptionRowColor.blue
        }
    }
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            FieldTitle(title: self.title)
            HStack(spacing: self.spacing) {
                ForEach(0..<7, id: \.self) { index in
                    Button(action: {
                        self.updateSelectedColorPosition(position: index)
                    }) {
                        ColorElement(color: self.setColor(position: index), selected: self.isSelected(position: index))
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 12, bottom: 12, trailing: 12))
            HStack(spacing: self.spacing) {
                ForEach(7..<10, id: \.self) { index in
                    Button(action: {
                        self.updateSelectedColorPosition(position: index)
                    }) {
                        ColorElement(color: self.setColor(position: index), selected: self.isSelected(position: index))
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 12, bottom: 12, trailing: 12))
        }
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
    }
}

struct SelectColorField_Previews: PreviewProvider {
    static var previews: some View {
        ColorsField(title: "Color", value: .constant(SubscriptionsViewModel.subscriptionRowColor.blue))
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
