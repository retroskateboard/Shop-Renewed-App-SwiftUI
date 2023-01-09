//
//  Home.swift
//  ecommerceApp
//
//  Created by Eric Rojas Pech on 03/12/22.
//

import SwiftUI

struct Home: View {
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 15){
                //Barra de bsuqueda
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
                .frame(width: getRect().width / 1.6)
                .padding(.horizontal,25)
                
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
            }
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: [ Color("LoginCircle"), Color(red: 0.655, green: 0.725, blue: 0.761)], startPoint: .top, endPoint: .bottom))
    }
    
    @ViewBuilder
    func ProductTypeView(type: ProductType)->some View{
        Button {
            
        } label: {
            Text(type.rawValue)
                .font(.custom(customFont, size: 15))
                .fontWeight(.semibold)
                .foregroundColor(Color(red: 0.173, green: 0.404, blue: 0.525))
        }

    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

//Extending view to get Screen Bounds
extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
