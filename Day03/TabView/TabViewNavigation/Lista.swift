//
//  Lista.swift
//  TabViewNavigation
//
//  Created by Turma02-11 on 04/07/25.
//

import SwiftUI

struct Lista: View {
    var body: some View {
        NavigationStack{
            List {
                HStack{
                    Text("Hello World")
                    Spacer()
                    Image(systemName: "paintbrush")
                }
                HStack{
                    Text("Hello World")
                    Spacer()
                    Image(systemName: "paintbrush.pointed")
                }
                HStack{
                    Text("Hello World")
                    Spacer()
                    Image(systemName: "paintpalette")
                }
            }.navigationTitle("List")
        }
    }
}

#Preview {
    Lista()
}
