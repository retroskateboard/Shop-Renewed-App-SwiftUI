//
//  OnBoardingPage.swift
//  ecommerceApp
//
//  Created by Eric Rojas Pech on 22/11/22.
//

import SwiftUI

let customFont = "Raleway-Regular"

struct OnBoardingPage: View {
    @State var showLoginPage: Bool = false
    var body: some View {
        
        VStack(alignment: .leading){
            Text("Gadget \nStore")
                .font(.custom(customFont, size: 55))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .offset(y:-110)

            //.padding(.top,-50)
                //.padding(.vertical,10)

            Image("Products")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .offset(y:-30)
                .offset(x:1)
            
            Button{
                withAnimation {
                    showLoginPage = true
                }
            }label: {
                Text("Entrar")
                    .font(.custom(customFont, size: 23))
                    .fontWeight(.semibold)
                    .padding(.vertical,18)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 5)
                    .foregroundColor(Color(red: 0.184, green: 0.431, blue: 0.553))
            }
            .padding(.horizontal,60)
            .offset(y:70)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color(red: 0.184, green: 0.431, blue: 0.553)
        )
        .overlay(
        
            Group{
                if showLoginPage{
                    LoginPage()
                        .transition(.move(edge: .trailing))
                }
            }
        )
    }
}

struct OnBoardingPage_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingPage()
        
    }
}
