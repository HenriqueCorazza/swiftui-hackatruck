//
//  Sheet.swift
//  Navigation
//
//  Created by Turma02-11 on 04/07/25.
//

import SwiftUI

struct Sheet: View {
    var body: some View {
        ZStack{
            Color(.fundo).ignoresSafeArea()
            VStack{
                Text("Sheet View").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundStyle(.white)
                Spacer()
                ZStack{
                    VStack{
                        Text("Nome: Tiago").foregroundStyle(.white)
                        Text("Sobrenome: Pereira").foregroundStyle(.white)
                    }.frame(width: 200, height: 140).background(Color(.rosa)).cornerRadius(8.0)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    Sheet()
}
