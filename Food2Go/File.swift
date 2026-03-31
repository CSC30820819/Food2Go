//
//  File.swift
//  Food2Go
//
//  Created by Kramer, Jenna L. on 3/30/26.
//

import Foundation

struct GroceryItem {
    let name: String
    let price: Double
}

let groceryData: [String: [GroceryItem]] = [
    "Dairy": [
        GroceryItem(name: "Milk", price: 3.50), GroceryItem(name: "Cheese", price: 4.99),
        GroceryItem(name: "Yogurt", price: 1.25), GroceryItem(name: "Butter", price: 3.75),
        GroceryItem(name: "Cream", price: 2.50), GroceryItem(name: "Eggs", price: 2.99),
        GroceryItem(name: "Sour Cream", price: 1.80), GroceryItem(name: "Kefir", price: 4.25),
        GroceryItem(name: "Cottage Cheese", price: 3.10)
    ],
    "Grains": [
        GroceryItem(name: "Bread", price: 3.00), GroceryItem(name: "Rice", price: 5.00),
        GroceryItem(name: "Quinoa", price: 6.00), GroceryItem(name: "Oats", price: 4.00),
        GroceryItem(name: "Pasta", price: 1.50), GroceryItem(name: "Barley", price: 2.50),
        GroceryItem(name: "Couscous", price: 3.00), GroceryItem(name: "Bagels", price: 4.00),
        GroceryItem(name: "Cereal", price: 4.50)
    ],
    "Fruits": [
        GroceryItem(name: "Apple", price: 1.00), GroceryItem(name: "Banana", price: 0.50),
        GroceryItem(name: "Strawberry", price: 4.00), GroceryItem(name: "Blueberry", price: 3.50),
        GroceryItem(name: "Mango", price: 2.00), GroceryItem(name: "Grape", price: 3.00),
        GroceryItem(name: "Orange", price: 0.80), GroceryItem(name: "Pineapple", price: 4.50),
        GroceryItem(name: "Peach", price: 1.25)
    ],
    "Vegetables": [
        GroceryItem(name: "Spinach", price: 2.50), GroceryItem(name: "Broccoli", price: 1.99),
        GroceryItem(name: "Carrots", price: 0.99), GroceryItem(name: "Bell Peppers", price: 1.50),
        GroceryItem(name: "Onions", price: 0.75), GroceryItem(name: "Potatoes", price: 3.00),
        GroceryItem(name: "Zucchini", price: 1.20), GroceryItem(name: "Garlic", price: 0.50),
        GroceryItem(name: "Asparagus", price: 4.00)
    ],
    "Meat": [
        GroceryItem(name: "Chicken", price: 8.99), GroceryItem(name: "Ground Beef", price: 7.50),
        GroceryItem(name: "Bacon", price: 5.99), GroceryItem(name: "Pork Chops", price: 6.50),
        GroceryItem(name: "Salmon", price: 12.00), GroceryItem(name: "Turkey", price: 9.25),
        GroceryItem(name: "Lamb Chops", price: 15.00), GroceryItem(name: "Sausage", price: 4.50),
        GroceryItem(name: "Sirloin", price: 14.99)
    ],
    "Drinks": [
        GroceryItem(name: "Water", price: 1.00), GroceryItem(name: "Orange Juice", price: 3.50),
        GroceryItem(name: "Coffee", price: 12.00), GroceryItem(name: "Tea", price: 4.00),
        GroceryItem(name: "Soda", price: 2.00), GroceryItem(name: "Apple Juice", price: 3.00),
        GroceryItem(name: "Seltzer", price: 1.50), GroceryItem(name: "Oat Milk", price: 4.50),
        GroceryItem(name: "Lemonade", price: 2.50)
    ]
]
