//
//  Product.swift
//  ecommerceApp
//
//  Created by Eric Rojas Pech on 03/12/22.
//

import SwiftUI

//Modelo prodcuto:

struct Product: Identifiable,Hashable{
    var id = UUID().uuidString
    var type: ProductType
    var title: String
    var subtitle: String
    var description: String = ""
    var price: String
    var productImage: String = ""
    var quantity: Int = 1
}

//Tipo de productos

enum ProductType: String,CaseIterable{
    case Wearable = "Wearable"
    case Laptops = "Laptops"
    case Telefonos = "Telefonos"
    case Tablets = "Tablets"
}
