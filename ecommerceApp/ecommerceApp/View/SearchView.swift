//
//  SearchView.swift
//  ecommerceApp
//
//  Created by Eric Rojas Pech on 18/01/23.
//

import SwiftUI

struct SearchView: View {
    
    var animation: Namespace.ID
    
    @EnvironmentObject var sharedData: SharedDataModel

    @EnvironmentObject var homeData: HomeViewModel
    
    //Poner el textfield
    @FocusState var startTF: Bool
    
    var body: some View {
        
        VStack(spacing: 0) {
            //Barra de busqueda
            HStack(spacing: 20){
                
                //Boton de cierre
                Button {
                    withAnimation{
                        homeData.searchActivated = false
                    }
                    homeData.searchText = ""
                    sharedData.fromSearchPage = false
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.7))
                }
                
                //Search bar
                HStack(spacing: 15){
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    TextField("Buscar", text: $homeData.searchText)
                        .focused($startTF)
                        .textCase(.lowercase)
                        .disableAutocorrection(true)
                }
                .padding(.vertical,12)
                .padding(.horizontal)
                .background(
                    Capsule()
                        .strokeBorder(Color(red: 0.173, green: 0.404, blue: 0.525),lineWidth: 1.5)
                )
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing,20)
            }
            .padding([.horizontal])
            .padding(.top)
            .padding(.bottom,10)
            
            if let products = homeData.searchProducts{
                if products.isEmpty{
                    VStack(spacing: 10){
                        
                        Image(systemName: "minus.magnifyingglass")
                            .resizable()
                            .frame(width: 225, height: 225)
                            .aspectRatio(contentMode: .fit)
                            .padding(.top,100)
                        
                        Text("Producto no encontrado")
                            .font(.custom(customFont, size: 25).bold())
                            .padding(.top,50)
                        
                        Text("Intenta buscando un termino mas génerico o busca una alternativa al producto")
                            .font(.custom(customFont, size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal,30)

                    }
                    .padding()
                    
                }else{
                    //Filtrando resultados
                    ScrollView(.vertical, showsIndicators: false){
                        
                        VStack(spacing: 0){
                            StaggeredGrid(columns: 2, spacing: 25, list: products) {product in
                                productCardView(product: product)
                            }
                        }
                        .padding()
                    }
                }
            }else{
                ProgressView()
                    .padding(.top,30)
                    .opacity(homeData.searchText == "" ? 0 : 1)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(LinearGradient(colors: [ Color(.white), Color(red: 0.655, green: 0.725, blue: 0.761)], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
        )
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
             startTF = true
            }
        }
    }
    
    @ViewBuilder
    func productCardView(product: Product)->some View{
        VStack(spacing: 10){
            
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)

            
                .offset(y: -50)
                .padding(.bottom, -80)
            
            Text(product.title)
                .font(.custom(customFont, size: 16))
                .fontWeight(.semibold)
                .padding(.top)
            
            Text(product.subtitle)
                .font(.custom(customFont, size: 14))
                .foregroundColor(.gray)
                .padding(.top,5)
            
            Text(product.price)
                .font(.custom(customFont, size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.173, green: 0.404, blue: 0.525))
                .padding(.top,5)
        }
        .padding(.horizontal,20)
        .padding(.bottom,22)
        .background(
            Color.white
            .cornerRadius(25)
        )
        .padding(.top,50)
        .onTapGesture {
            
            withAnimation(.easeInOut){
                sharedData.fromSearchPage = true
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }

    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
