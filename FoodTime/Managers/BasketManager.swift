//
//  BasketManager.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 17.09.23.
//

import Foundation

class BasketManager: ObservableObject {
    
    @Published var items: [MealItemInfo] = []
    @Published var selectedMeal = MealItemInfo(imageURL: "", title: "", description: "", cost: 0.1)
    @Published var deliveryFee = 6.5
    
    private var subtotalComputed: Double {
        items.reduce(0) { $0 + $1.subtotal }
    }
    
    var subtotal: String {
        return subtotalComputed.removeZerosFromEnd()
    }
    
    var subtotalWithDeliveryFee: String {
        (subtotalComputed + deliveryFee).removeZerosFromEnd()
    }
    
    func contains() -> Bool {
        items.contains(where: { $0.id == selectedMeal.id })
    }
    
    func addSelectedItem() {
        if let index = items.firstIndex(where: { $0.id == selectedMeal.id } ) {
            items[index] = selectedMeal
            return
        }
        items.append(selectedMeal)
    }
    
    func removeItem(_ item: MealItemInfo) {
        items.removeAll(where: { $0.id == item.id })
    }
    
    func updateSelectedMealChoices(with id: UUID) {
        selectedMeal.choices = selectedMeal.choices.map {
            var tmp = $0
            tmp.isSelected = $0.id == id
            return tmp
        }
    }
}
