//
//  ProfilePage.swift
//  ecommerceApp
//
//  Created by Eric Rojas Pech on 19/01/23.
//

import SwiftUI

struct LikedPage: View {
    @EnvironmentObject var sharedData: SharedDataModel
    
    // Delete Option...
    @State var showDeleteOption: Bool = false
    
    var body: some View {
        
        NavigationView{
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack{
                    
                    HStack{
                        
                        Text("Favoritos")
                            .font(.custom(customFont, size: 28).bold())
                        
                        Spacer()
                        
                        Button {
                            withAnimation{
                                showDeleteOption.toggle()
                            }
                        } label: {
                            Image("Delete")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                        }
                        .opacity(sharedData.likedProducts.isEmpty ? 0 : 1)

                    }
                    
                    // checking if liked products are empty...
                    if sharedData.likedProducts.isEmpty{
                        
                        Group{
                            Image(systemName: "heart.slash.fill")
                                .resizable()
                                .frame(width: 225, height: 225)
                                .aspectRatio(contentMode: .fit)
                                .padding(.top,100)
                                .padding(.bottom,50)
                                .foregroundColor(Color(red: 0, green: 0.3, blue: 0.4, opacity: 1.0))
                            
                            Text("Sin favoritos")
                                .font(.custom(customFont, size: 25))
                                .fontWeight(.semibold)
                            
                            Text("Pulsa el boton de corazón en los productos para guardarlos en tus favoritos!")
                                .font(.custom(customFont, size: 18))
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .padding(.top,10)
                                .multilineTextAlignment(.center)
                        }
                    }
                    else{
                     
                        // Displaying Products...
                        VStack(spacing: 15){
                            
                            ForEach(sharedData.likedProducts){product in
                                
                                HStack(spacing: 0){
                                    
                                    if showDeleteOption{
                                        
                                        Button {
                                            deleteProduct(product: product)
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.red)
                                        }
                                        .padding(.trailing)

                                    }
                                    
                                    CardView(product: product)
                                }
                            }
                        }
                        .padding(.top,25)
                        .padding(.horizontal)
                    }
                }
                .padding()
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(colors: [ Color(.white), Color(red: 0.655, green: 0.725, blue: 0.761)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            )
        }
    }
    
    @ViewBuilder
    func CardView(product: Product)->some View{
        
        HStack(spacing: 15){
            
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(product.title)
                    .font(.custom(customFont, size: 18).bold())
                    .lineLimit(1)
                
                Text(product.price)
                    .font(.custom(customFont, size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(Color(red: 0.114, green: 0.296, blue: 0.392))
                
                Text("\(product.subtitle)")
                    .font(.custom(customFont, size: 13))
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal,10)
        .padding(.vertical,10)
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(
        
            Color.white
                .cornerRadius(10)
        )
        .onTapGesture {
            
            withAnimation(.easeInOut){
                sharedData.fromSearchPage = true
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }
    }
    
    func deleteProduct(product: Product){
        
        if let index = sharedData.likedProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }){
            
            let _ = withAnimation{
                // removing...
                sharedData.likedProducts.remove(at: index)
            }
        }
    }
}

struct LikedPage_Previews: PreviewProvider {
    static var previews: some View {
        LikedPage()
            .environmentObject(SharedDataModel())
    }
}
