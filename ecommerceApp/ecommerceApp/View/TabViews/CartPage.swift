//
//  ProfilePage.swift
//  ecommerceApp
//
//  Created by Eric Rojas Pech on 19/01/23.
//

import SwiftUI

// Since both of the views are mostly identical....
struct CartPage: View {
    @EnvironmentObject var sharedData: SharedDataModel
    
    // Delete Option...
    @State var showDeleteOption: Bool = false
    
    var body: some View {
        
        NavigationView{
            
            VStack(spacing: 10){
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack{
                        
                        HStack{
                            
                            Text("Carrito")
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
                            .opacity(sharedData.cartProducts.isEmpty ? 0 : 1)

                        }
                        
                        // checking if liked products are empty...
                        if sharedData.cartProducts.isEmpty{
                            
                            Group{
                                Image(systemName: "basket")
                                    .resizable()
                                    .frame(width: 225, height: 225)
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.top,100)
                                    .padding(.bottom,50)
                                    .foregroundColor(Color(red: 0, green: 0.3, blue: 0.4, opacity: 1.0))
                                
                                Text("Sin productos")
                                    .font(.custom(customFont, size: 25))
                                    .fontWeight(.semibold)
                                
                                Text("Pulsa el boton de agregar al carrito en los productos para añadirlos a tu carrito!")
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
                                
                                // For Designing...
                                ForEach($sharedData.cartProducts){$product in
                                    
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
                                        
                                        CardView(product: $product)
                                    }
                                }
                            }
                            .padding(.top,25)
                            .padding(.horizontal,10)
                        }
                    }
                    .padding()
                }
                
                // Showing Total and check out Button...
                if !sharedData.cartProducts.isEmpty{
                    
                    Group{
                        
                        HStack{
                            
                            Text("Total")
                                .font(.custom(customFont, size: 14))
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text(sharedData.getTotalPrice())
                                .font(.custom(customFont, size: 18).bold())
                                .foregroundColor(Color(red: 0.114, green: 0.296, blue: 0.392))
                        }
                        
                        Button {
                            
                        } label: {
                            
                            Text("Pagar")
                                .font(.custom(customFont, size: 18).bold())
                                .foregroundColor(.white)
                                .padding(.vertical,18)
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 0.114, green: 0.296, blue: 0.392))
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                        }
                        .padding(.vertical)
                    }
                    .padding(.horizontal,25)
                }
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(colors: [ Color(.white), Color(red: 0.655, green: 0.725, blue: 0.761)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            )
        }
    }
    
    func deleteProduct(product: Product){
        
        if let index = sharedData.cartProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }){
            
            let _ = withAnimation{
                // removing...
                sharedData.cartProducts.remove(at: index)
            }
        }
    }
}

struct CartPage_Previews: PreviewProvider {
    static var previews: some View {
        CartPage()
    }
}

struct CardView: View{
    
    // Making Product as Binding so as to update in Real time...
    @Binding var product: Product
    
    var body: some View{
        
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
                
                // Quantity Buttons...
                HStack(spacing: 10){
                    
                    Text("Cantidad")
                        .font(.custom(customFont, size: 14))
                        .foregroundColor(.gray)
                    
                    Button {
                        product.quantity = (product.quantity > 0 ? (product.quantity - 1) : 0)
                    } label: {
                        Image(systemName: "minus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(Color(red: 0, green: 0.41, blue: 0.53, opacity: 1.0))
                            .cornerRadius(4)
                    }

                    Text("\(product.quantity)")
                        .font(.custom(customFont, size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Button {
                        product.quantity += 1
                    } label: {
                        Image(systemName: "plus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(Color(red: 0, green: 0.41, blue: 0.53, opacity: 1.0))
                            .cornerRadius(4)
                    }
                }
            }
        }
        .padding(.horizontal,10)
        .padding(.vertical,10)
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(
        
            Color.white
                .cornerRadius(10)
        )
    }
}
