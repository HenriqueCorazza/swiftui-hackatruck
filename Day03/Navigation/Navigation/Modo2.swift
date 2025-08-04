//
//  Modo2.swift
//  Navigation
//
//  Created by Turma02-11 on 04/07/25.
//

import SwiftUI

struct Modo2: View {
    @State private var name: String = ""
    var body: some View {
        NavigationStack{
            ZStack{
                Color(.fundo).ignoresSafeArea()
                VStack{
                    Text("Modo 2").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundStyle(.white)
                    Spacer()
                    ZStack{
                        VStack{
                            Spacer()
                            TextField("", text: $name).frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/).background(Color.campo).cornerRadius(9.0).multilineTextAlignment(.center).foregroundColor(.white)
                            Text("Bem-Vindo, \(name)").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundStyle(.white).padding(.bottom, 50)
                            Button(action: {
                            }) {
                                NavigationLink(destination: Modo2Tela(dataToPass: name)){
                                    Text("Acessar Tela")
                                        .foregroundStyle(.white).frame(width: 120, height: 40).background(Color(.blue)).cornerRadius(8.0)
                                }
                            }.padding(.bottom, 20)
                        }.frame(width: 350, height: 240).background(Color(.rosa)).cornerRadius(8.0)
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    Modo2()
}
