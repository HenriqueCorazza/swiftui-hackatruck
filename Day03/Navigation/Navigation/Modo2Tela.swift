//
//  Modo2Tela.swift
//  Navigation
//
//  Created by Turma02-11 on 04/07/25.
//

import SwiftUI

struct Modo2Tela: View {
    @State var dataToPass: String
    var body: some View {
        ZStack{
            Color(.fundo).ignoresSafeArea()
            VStack{
                Text("Modo 2").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundStyle(.white)
                Spacer()
                Text("Volte, \(dataToPass)!!").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).frame(width: 150).background(Color.rosa).foregroundColor(.white).cornerRadius(9.0)
                    Spacer()
            }
        }
    }
}

