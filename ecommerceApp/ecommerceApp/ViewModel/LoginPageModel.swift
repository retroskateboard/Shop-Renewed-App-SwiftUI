//
//  LoginPageModel.swift
//  ecommerceApp
//
//  Created by Eric Rojas Pech on 24/11/22.
//

import SwiftUI

class LoginPageModel: ObservableObject {
    
    //Inicio de sesion
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false

    //Registro
    @Published var registerUser: Bool = false
    @Published var re_Enter_Password: String = ""
    @Published var showReEnterPassword: Bool = false
    
    //Estado del registro
    @AppStorage("log_Status") var log_Status: Bool = false
    
    //Inicio de sesion:
    func Login(){
        withAnimation {
            log_Status = true
        }
    }
    
    //Registro
    func Register(){
        withAnimation {
            log_Status = true
        }
    }
    
    //Contraseña olvidada
    func ForgotPassword(){
        
    }
}
