//
//  LoginPage.swift
//  ecommerceApp
//
//  Created by Eric Rojas Pech on 24/11/22.
//

import SwiftUI


struct LoginPage: View {
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    var body: some View {
        VStack{
            
            Text(loginData.registerUser ? "Hola,\nextraño!" : "Bienvenido\nde nuevo!")
                .font(.custom(customFont, size: 55))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: CGRectGetHeight(.init(x: 1, y: 1, width: 1, height: 200)))
                .padding()
                .background(
                    
                    ZStack{
                        LinearGradient(colors: [ Color("LoginCircle"),
                                                 Color("LoginCircle"),
                                                 Color(red: 0.616, green: 0.737, blue: 0.365)
                                               ], startPoint: .top, endPoint: .bottom)
                        .frame(width: 110, height: 110)
                        .rotationEffect(.degrees(180))
                        .clipShape(Circle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(.trailing)
                        .ignoresSafeArea()
                        
                        Circle()
                            .strokeBorder(Color.white.opacity(0.3),lineWidth: 3)
                            .frame(width: 30, height: 30)
                            .blur(radius: 2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                            .padding(45)
                        
                        Circle()
                            .strokeBorder(Color.white.opacity(0.3),lineWidth: 3)
                            .frame(width: 30, height: 30)
                            .blur(radius: 2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .padding(.leading,35)
                    }
                )
            
            ScrollView(.vertical, showsIndicators: false){
                
                //Formulario de inicio de sesion:
                VStack(spacing: 12){
                    
                    Text(loginData.registerUser ? "Registro" : "Iniciar sesión")
                        .font(.custom(customFont, size: 30).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 5)
                        .foregroundColor(.black)
                    
                    //Text field...
                    CustomTextField(icon: "envelope", title: "Correo", hint: "justine@gmail.com", value: $loginData.email, showPassword: .constant(false))
                        .padding(.top,10)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)

                    
                    CustomTextField(icon: "lock", title: "Contraseña", hint: "123456", value: $loginData.password, showPassword: $loginData.showPassword)
                        .padding(.top,7)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                    
                    //Registro (reingresa tu contraseña)
                    if loginData.registerUser{
                        CustomTextField(icon: "lock", title: "Reingresa Contraseña", hint: "123456", value: $loginData.re_Enter_Password, showPassword: $loginData.showReEnterPassword)
                            .padding(.top,10)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                    }
                    
                    //Boton de contraseña olvidada
                    
                    Button {
                        loginData.ForgotPassword()
                    } label: {
                        
                        Text(loginData.registerUser ? "" : "Olvidaste tu contraseña?")
                            .font(.custom(customFont, size: 15))
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 0.184, green: 0.431, blue: 0.553))
                    }
                    .padding(.top,8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    //Boton de inicio de sesion
                    
                    Button {
                        if loginData.registerUser{
                            loginData.Register()
                        }else{
                            loginData.Login()
                        }
                    } label: {
                        
                        Text(loginData.registerUser ? "Registrate ahora!" : "Iniciar sesión")
                            .font(.custom(customFont, size: 17).bold())
                            .padding(.vertical,20)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background((Color(red: 0.184, green: 0.431, blue: 0.553)))
                            .cornerRadius(30)
                            .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 5)
                    }
                    .padding(.top,20)
                    .padding(.horizontal,50)
                    
                    //Boton de registar usuario
                    Button {
                        withAnimation{
                            loginData.registerUser.toggle()
                        }
                    } label: {
                        
                        Text(loginData.registerUser ? "Regresar a inicio de sesión" : "Crear cuenta")
                            .font(.custom(customFont, size: 15))
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 0.184, green: 0.431, blue: 0.553))
                    }
                    .padding(.top,8)
                }
                .padding(23)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                //Esquinas personalizadas:
                    .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 30))
                    .ignoresSafeArea()
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.184, green: 0.431, blue: 0.553))
        
        //Limpiando datos al cambiar entre inicio y registro
        .onChange(of: loginData.registerUser){
            newValue in
            
            loginData.email = ""
            loginData.password = ""
            loginData.re_Enter_Password = ""
            loginData.showPassword = false
            loginData.showReEnterPassword = false
        }
    }
    
    @ViewBuilder
    func CustomTextField(icon: String,title: String,hint: String,value: Binding<String>,showPassword: Binding<Bool>)->some View{
        
        VStack(alignment: .leading, spacing: 12){
            Label {
                Text(title)
                    .font(.custom(customFont, size: 16))
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color.black)
            
            if title.contains("Contraseña") && !showPassword.wrappedValue{
                SecureField(hint, text: value)
                    .padding(.top,2)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
            }else{
                TextField(hint, text: value)
                    .padding(.top,2)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
            }
            
            Divider()
                .background(Color.black)
        }
        
        //Boton "Mostrar contraseña"
        .overlay(
          
            Group{
                
                if title.contains("Contraseña"){
                    Button(action: {
                        showPassword.wrappedValue.toggle()
                    }, label: {
                        Text(showPassword.wrappedValue ? "Ocultar" : "Mostrar")
                            .font(.custom(customFont, size: 16).bold())
                            .foregroundColor(Color(red: 0.184, green: 0.431, blue: 0.553))
                    })
                            .offset(y: 9)
                }
            }
            
            ,alignment: .trailing
        )
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
