//
//  Home.swift
//  ecommerceApp
//
//  Created by Eric Rojas Pech on 03/12/22.
//

import SwiftUI

struct Home: View {
    var animation: Namespace.ID
    
    @EnvironmentObject var sharedData: SharedDataModel
    
    @StateObject var  homeData: HomeViewModel = HomeViewModel()
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 15){
                
                //Barra de busqueda
                ZStack{
                    if homeData.searchActivated{
                        SearchBar()
                    }else{
                        SearchBar()
                            .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                    }
                }
                .frame(width: getRect().width / 1.6)
                .padding(.horizontal,25)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut){
                        homeData.searchActivated = true
                    }
                }
                
                
                Text("Ordena en linea\nRecolecta en tienda")
                    .font(.custom(customFont, size: 25).bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal,25)
                
                //Productos
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 18){
                        ForEach(ProductType.allCases,id:\.self){type in
                            
                            ProductTypeView(type: type)
                            
                        }
                    }
                    .padding(.horizontal,25)
                }
                .padding(.top,25)
                
                //Pagina de productos
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 25){
                        ForEach(homeData.filteredProducts){product in
                           productCardView(product: product)
                        }
                    }
                    .padding(.horizontal,25)
                    .padding(.bottom)
                    .padding(.top,80)
                }
                .padding(.top,25)
                
                //Boton para mostrar todos los prodcutos
                Button {
                    homeData.showMoreProductsOnType.toggle()
                } label: {
                    Label{
                        Image(systemName: "arrow.right")
                    } icon:{
                        Text("Ver mas")
                    }
                    .font(.custom(customFont, size: 15).bold())
                    .foregroundColor(Color(red: 0.173, green: 0.404, blue: 0.525))
                }
                .frame(maxWidth: .infinity,alignment: .trailing)
                .padding(.trailing)
                .padding(.top,10)
            }
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        .background(LinearGradient(colors: [ Color("LoginCircle"), Color(red: 0.655, green: 0.725, blue: 0.761)], startPoint: .top, endPoint: .bottom))
    
        .onChange(of: homeData.productType) { newValue in
            homeData.filteredProductByType()
        }
        .sheet(isPresented: $homeData.showMoreProductsOnType) {
        } content:{
            MoreProductsView()
        }
        
        //Mostrando la vista de search
        .overlay(
            ZStack{
                if homeData.searchActivated{
                    SearchView(animation: animation)
                        .environmentObject(homeData)
                }
            }
        )
    }
    
    @ViewBuilder
    func SearchBar() -> some View{
        HStack(spacing: 15){
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundColor(.gray)
            
            TextField("Search", text: .constant(""))
                .disabled(true)
        }
        .padding(.vertical,12)
        .padding(.horizontal)
        .background(
            Capsule()
                .strokeBorder(Color.gray,lineWidth: 0.8)
        )
    }
    
    @ViewBuilder
    func productCardView(product: Product)->some View{
        VStack(spacing: 10){
            ZStack{
                if sharedData.showDetailProduct{
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }else{
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(product.id)IMAGEN", in: animation)
                }
            }
                .frame(width: getRect().width/2.5, height: getRect().width/2.5)
            
                .offset(y: -80)
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
        
        .onTapGesture {
            withAnimation(.easeInOut){
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }
    }
    
    @ViewBuilder
    func ProductTypeView(type: ProductType)->some View{
        Button {
            withAnimation {
                homeData.productType = type
            }
            
        } label: {
            Text(type.rawValue)
                .font(.custom(customFont, size: 15))
                .fontWeight(.semibold)
                .foregroundColor(homeData.productType == type ? Color(red: 0.173, green: 0.404, blue: 0.525) : Color.gray)
                .padding(.bottom,10)
                .overlay(
                    ZStack{
                        if homeData.productType == type{
                            Capsule()
                                .fill(Color(red: 0.173, green: 0.404, blue: 0.525))
                                .frame(height: 3)
                        }
                    }
                        .padding(.horizontal,-5)
                    ,alignment: .bottom
                    
                )
        }

    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

//Extending view to get Screen Bounds
extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
