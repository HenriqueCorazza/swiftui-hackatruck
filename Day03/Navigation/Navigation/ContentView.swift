//
//  ContentView.swift
//  Navigation
//
//  Created by Turma02-11 on 04/07/25.
//

import SwiftUI

struct ContentView: View {
    @State private var show = false
    var body: some View {
            
        NavigationStack{
                ZStack{
                    Color(.fundo).ignoresSafeArea()
                    VStack{
                        Image("logo").resizable().scaledToFit().padding()
                        Spacer()
                        NavigationLink(destination: Modo1()){
                            Text("Modo 1").frame(width: 200,height: 100).background(Color.rosa).foregroundColor(.white).cornerRadius(9.0)
                        }
                        NavigationLink(destination: Modo2()){
                            Text("Modo 2").frame(width: 200,height: 100).background(Color.rosa).foregroundColor(.white).cornerRadius(9.0)
                        }
                        Button("Modo 3"){
                            show.toggle()
                        }.frame(width: 200,height: 100).background(Color.rosa).foregroundColor(.white).cornerRadius(9.0).sheet(isPresented: $show){
                            Sheet()
                        }
                        Spacer()
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
