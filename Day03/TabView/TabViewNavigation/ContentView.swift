//
//  ContentView.swift
//  TabViewNavigation
//
//  Created by Turma02-11 on 04/07/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Pincel().badge(2).tabItem {
                Label("Received", systemImage: "paintbrush")
            }
            Pincelzinho().badge(2).tabItem {
                Label("Account", systemImage: "paintbrush.pointed")
            }
            Paleta().tabItem {
                Label("Cinza", systemImage: "paintpalette")
            }
            Lista().tabItem { Label("Lista",systemImage: "list.bullet") }
        }
    }
}

#Preview {
    ContentView()
}
