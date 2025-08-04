//
//  Paleta.swift
//  TabViewNavigation
//
//  Created by Turma02-11 on 04/07/25.
//

import SwiftUI

struct Paleta: View {
    var body: some View {
        ZStack{
            Color(.cinza)
            ZStack{
                Circle().frame(width: 300)
                Image(systemName: "paintpalette").resizable().scaledToFit().frame(width: 200).foregroundColor(.cinza)
            }
        }.ignoresSafeArea(edges: .top)
    }
}

#Preview {
    Paleta()
}
