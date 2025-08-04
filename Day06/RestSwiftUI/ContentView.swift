//
//  ContentView.swift
//  RestSwiftUI
//
//  Created by Turma02-11 on 14/07/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        NavigationStack{
            ZStack{
                Color(.blue).ignoresSafeArea()
                ScrollView{
                    VStack{
                        Image("104").resizable().clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/).scaledToFit().frame(width: 100)
                        Text("Personagens de Rick & Morty").foregroundStyle(.white).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).padding(.bottom)
                        ForEach(viewModel.personagens){ personagem in
                            NavigationLink(destination: PersonagemMore(pers: personagem)){
                                Text(personagem.name!).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundStyle(.black)
                            }
                        }
                    }
                }
            }
        }
        .onAppear(){
            viewModel.fetch()
        }
    }
}

#Preview {
    ContentView()
}
