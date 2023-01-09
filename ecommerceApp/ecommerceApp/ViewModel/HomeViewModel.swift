//
//  HomeViewModel.swift
//  ecommerceApp
//
//  Created by Eric Rojas Pech on 03/12/22.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var productType: ProductType = .Wearable
    

    @Published var products: [Product] = [
    Product(type: .Wearable, title: "Apple Watch", subtitle: "Series 8 - 45MM - Midnight", price: "$560", productImage: "AppleWatch8"),
    Product(type: .Wearable, title: "Apple Watch", subtitle: "Ultra - Titanium case", price: "$1050", productImage: "AppleWatchultra"),
    Product(type: .Laptops, title: "Macbook Air", subtitle: "M2 - Spaceg Gray", price: "$1550", productImage: "MacbookAirM2"),
    Product(type: .Laptops, title: "Macbook Pro", subtitle: "M2 - Space Gray", price: "$1680", productImage: "MacbookProM2"),
    Product(type: .Telefonos, title: "iPhone 14 Pro", subtitle: "A16 - Space Black", price: "$1350", productImage: "iPhone14Pro"),
    Product(type: .Telefonos, title: "iPhone 13", subtitle: "A15 - Pink", price: "$980", productImage: "iPhone13"),
    Product(type: .Tablets, title: "iPad Air", subtitle: "M1 - Blue", price: "$800", productImage: "iPadAirM1"),
    Product(type: .Tablets, title: "iPad Pro", subtitle: "M2 - Space Gray", price: "$1085", productImage: "iPadProM2")
    ]
}
