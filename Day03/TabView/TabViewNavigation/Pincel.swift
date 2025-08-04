//
//  Pincel.swift
//  TabViewNavigation
//
//  Created by Turma02-11 on 04/07/25.
//

import SwiftUI

struct Pincel: View {
    var body: some View {
        ZStack{
            Color(.rosa)
            ZStack{
                Circle().frame(width: 300)
                Image(systemName: "paintbrush").resizable().scaledToFit().frame(width: 200).foregroundColor(.rosa)
            }
        }.ignoresSafeArea(edges: .top)
    }
}

#Preview {
    Pincel()
}
