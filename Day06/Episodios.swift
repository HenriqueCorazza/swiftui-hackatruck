//
//  Episodios.swift
//  RestSwiftUI
//
//  Created by Turma02-11 on 14/07/25.
//

import SwiftUI

struct Episodios: View {
    @State var epSel: ep
    var body: some View {
        ZStack{
            Color.fundo.ignoresSafeArea()
            VStack{
                Text(epSel.name!).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text(epSel.air_date!)
                Text(epSel.episode!)
            }
        }
    }
}

