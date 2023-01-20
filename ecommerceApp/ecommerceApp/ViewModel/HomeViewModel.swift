//
//  HomeViewModel.swift
//  ecommerceApp
//
//  Created by Eric Rojas Pech on 03/12/22.
//

import SwiftUI

import Combine

class HomeViewModel: ObservableObject {
    
    @Published var productType: ProductType = .Wearable
    

    @Published var products: [Product] = [
        Product(type: .Wearable, title: "Apple Watch", subtitle: "Series 8 - 45MM - Midnight", description: "El Apple Watch Series 8, un novedoso sensor cardiaco eléctrico y respuesta háptica en la Digital Crown. Aunque te resultará familiar", price: "$560", productImage: "AppleWatch8"),
    Product(type: .Wearable, title: "Apple Watch", subtitle: "Ultra - Titanium case", description: "El Apple Watch Ultra, un novedoso sensor cardiaco eléctrico y respuesta háptica en la Digital Crown. Aunque te resultará familiar", price: "$1050", productImage: "AppleWatchultra"),
    Product(type: .Laptops, title: "Macbook Air", subtitle: "M2 - Spaceg Gray", description: "La nueva MacBook Air, rediseñada con la potencia del chip M2, combina una velocidad y una gran eficiencia energética en una carcasa de aluminio e increíblemente delgada.", price: "$1550", productImage: "MacbookAirM2"),
    Product(type: .Laptops, title: "Macbook Pro", subtitle: "M2 - Space Gray", description: "La nueva MacBook Pro, rediseñada con la potencia del chip M2, combina una velocidad y una gran eficiencia energética en una carcasa de aluminio e increíblemente delgada.", price: "$1680", productImage: "MacbookProM2"),
    Product(type: .Telefonos, title: "iPhone 14 Pro", subtitle: "A16 - Space Black", description: "Una forma nueva y mágica de interactuar con tu iPhone. Y una innovadora cámara de 48 MP que logra un nivel de detalle deslumbrante.", price: "$1350", productImage: "iPhone14Pro"),
    Product(type: .Telefonos, title: "iPhone 13", subtitle: "A15 - Pink", description: "Una forma nueva y mágica de interactuar con tu iPhone. Y una innovadora cámara de 48 MP que logra un nivel de detalle deslumbrante.", price: "$980", productImage: "iPhone13"),
    Product(type: .Tablets, title: "iPad Air", subtitle: "M1 - Blue", description: "Una forma nueva y mágica de interactuar con tu iPhone. Y una innovadora cámara de 48 MP que logra un nivel de detalle deslumbrante.", price: "$800", productImage: "iPadAirM1"),
    Product(type: .Tablets, title: "iPad Pro", subtitle: "M2 - Space Gray", description: "Una forma nueva y mágica de interactuar con tu iPhone. Y una innovadora cámara de 48 MP que logra un nivel de detalle deslumbrante.", price: "$1085", productImage: "iPadProM2")
    ]
    
    //Filtrando los prodcutos
    
    @Published var filteredProducts: [Product] = []
    
    @Published var showMoreProductsOnType: Bool = false
    
    //Busqueda
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false
    @Published var searchProducts: [Product]?
    
    var searchCancellable: AnyCancellable?

    init(){
        filteredProductByType()
        
        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != ""{
                    self.filteredProductBySearch()
                }else{
                    self.searchProducts = nil
                }
            })
    }
    
    func filteredProductByType(){
        
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
                .lazy
                .filter { product in
                    return product.type == self.productType
                }
            //Limitando resultado
                .prefix(4)
            DispatchQueue.main.async {
                self.filteredProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
    
    func filteredProductBySearch(){
        
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
                .lazy
                .filter { product in
                    return product.title.lowercased().contains(self.searchText.lowercased())
                }

            DispatchQueue.main.async {
                self.searchProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
}
