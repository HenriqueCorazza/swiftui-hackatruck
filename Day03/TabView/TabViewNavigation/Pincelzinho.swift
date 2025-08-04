//
//  Pincelzinho.swift
//  TabViewNavigation
//
//  Created by Turma02-11 on 04/07/25.
//

import SwiftUI

struct Pincelzinho: View {
    var body: some View {
        ZStack{
            Color(.azul)
            ZStack{
                Circle().frame(width: 300)
                Image(systemName: "paintbrush.pointed").resizable().scaledToFit().frame(width: 200).foregroundColor(.azul)
            }
        }.ignoresSafeArea(edges: .top)
    }
}

#Preview {
    Pincelzinho()
}
