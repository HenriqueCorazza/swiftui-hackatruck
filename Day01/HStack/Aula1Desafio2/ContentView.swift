//
//  ContentView.swift
//  Aula1Desafio2
//
//  Created by Turma02-11 on 02/07/25.
//

import SwiftUI

struct ContentView: View {
    @State var name: String = ""
    @State private var isPresented: Bool = false
    var body: some View {
        ZStack{
            Image("floresta").resizable().opacity(0.2).ignoresSafeArea()
            VStack {
                
                Text("Bem Vindo, \(name)").font(.title).bold()
                TextField("digite", text: $name)
                    .multilineTextAlignment(.center)
                    
                Spacer()
                Image("floresta").resizable().frame(width: 200,height: 200)
                Spacer()
                
                Button("Entrar") {
                           isPresented = true
                    
                       }
                .alert("ALERTA!", isPresented: $isPresented, actions: {
                           Text("Vamos lá!")
                       },
                               message: {
                           Text("Você irá iniciar o desafio da aula agora")
                       })
            }
            
        }
    }
}

#Preview {
    ContentView()
}
