//
//  ProductDetailView.swift
//  ecommerceApp
//
//  Created by Eric Rojas Pech on 19/01/23.
//

import SwiftUI

struct ProductDetailView: View {
    var product: Product
    
    var animation: Namespace.ID
        
    @EnvironmentObject var sharedData: SharedDataModel
    @EnvironmentObject var homeData: HomeViewModel

    var body: some View {
        
        VStack{
            
            VStack{
                
                //Titulo
                HStack{
                    
                    Button {
                        //Cerrando la vista
                        withAnimation(.easeInOut){
                            sharedData.showDetailProduct = false
                        }
                        
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    Button {
                        addToLiked()
                    } label: {
                        Image(systemName: "heart.fill")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .foregroundColor(isLiked() ? .red : Color.black.opacity(0.7))
                    }

                }
                .padding()
                
                
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "\(product.id)\(sharedData.fromSearchPage ? "BUSCAR" : "IMAGEN")", in: animation)
                    .padding(.horizontal)
                    .offset(y: -12)
                    .frame(maxHeight: .infinity)
            }
            .frame(height: getRect().height/2.7)
            .zIndex(1)
            
            ScrollView(.vertical, showsIndicators: false){
                
                VStack(alignment: .leading, spacing: 15){
                    
                    Text(product.title)
                        .font(.custom(customFont, size: 20).bold())
                    
                    Text(product.subtitle)
                        .font(.custom(customFont, size: 18))
                        .foregroundColor(.gray)
                    
                    Text("Especificaciones")
                        .font(.custom(customFont, size: 17).bold())
                        .padding(.top)
                    
                    Text(product.description)
                        .font(.custom(customFont, size: 18))
                        .foregroundColor(.gray)
                    
                    Button {
    
                    } label: {
                        
                        Label {
                            Image(systemName: "arrow.right")
                        }icon: {
                            Text("Descripción completa")
                        }
                        .font(.custom(customFont, size: 15).bold())
                        .foregroundColor(Color(red: 0.114, green: 0.296, blue: 0.392))
                    }

                    HStack{
                        
                        Text("\(product.price)")
                            .font(.custom(customFont, size: 25).bold())
                            .foregroundColor(Color(red: 0.114, green: 0.296, blue: 0.392))
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.vertical,20)
                    
                    Button {
                        addToCart()
                    } label: {
                        Text("\(isAddedToCart() ? "agregado" : "agregar") al carrito")
                            .font(.custom(customFont, size: 18).italic())
                            .foregroundColor(.white)
                            .padding(.vertical,20)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color(red: 0.173, green: 0.404, blue: 0.525)
                                    .cornerRadius(20)
                                    .shadow(color: Color.black.opacity(0.06), radius: 5, x:5, y:5)
                            )
                    }

                }

                .padding([.horizontal,.bottom],20)
                .padding(.top,25)
                .frame(maxWidth: .infinity,alignment: .leading)
                
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(
                Color.white
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 30))
                    .ignoresSafeArea()
            )
            .zIndex(0)
            
        }
        .background(LinearGradient(colors: [Color(red: 0.83, green: 0.87, blue: 0.89, opacity: 1.0), Color(red: 0.655, green: 0.725, blue: 0.761)], startPoint: .top, endPoint: .bottom).ignoresSafeArea())
    }
    
    func isLiked()->Bool{
        
        return sharedData.likedProducts.contains { product in
            return self.product.id == product.id
        }
    }
    
    func isAddedToCart()->Bool{
        
        return sharedData.cartProducts.contains { product in
            return self.product.id == product.id
        }
    }
    
    func addToLiked(){
        
        if let index = sharedData.likedProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }){
            // Remove from liked....
            sharedData.likedProducts.remove(at: index)
        }
        else{
            // add to liked
            sharedData.likedProducts.append(product)
        }
    }
    
    func addToCart(){
        
        if let index = sharedData.cartProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }){
            // Remove from liked....
            sharedData.cartProducts.remove(at: index)
        }
        else{
            // add to liked
            sharedData.cartProducts.append(product)
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
       /* ProductDetailView(product: HomeViewModel().products[0])
        .environmentObject(SharedDataModel()) */
        
        MainPage()
    }
}
