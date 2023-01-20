//
//  MoreProductsView.swift
//  ecommerceApp
//
//  Created by Eric Rojas Pech on 17/01/23.
//

import SwiftUI

struct MoreProductsView: View {
    var body: some View {

        VStack{
            Text("More Products")
                .font(.custom(customFont, size: 24).bold())
                .foregroundColor(.black)
                .frame(maxWidth: .infinity,alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
        .background(LinearGradient(colors: [ Color("LoginCircle"), Color(red: 0.655, green: 0.725, blue: 0.761)], startPoint: .top, endPoint: .bottom))
        
    }
}

struct MoreProductsView_Previews: PreviewProvider {
    static var previews: some View {
        MoreProductsView()
    }
}
