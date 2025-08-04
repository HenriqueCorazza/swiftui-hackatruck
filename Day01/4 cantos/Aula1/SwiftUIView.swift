//
//  SwiftUIView.swift
//  Aula1
//
//  Created by Turma02-11 on 02/07/25.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        HStack {
            Image("urso").resizable().scaledToFit().clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/).frame(width: 120,height: 100)
                .padding()
            VStack{
                Text("Henrique Corazza").foregroundStyle(.red)
                Text("20 Anos").foregroundStyle(.blue)
                Text("Presidente Prudente").foregroundStyle(.yellow)
            }
        }
        .padding()
    }
}

#Preview {
    SwiftUIView()
}
