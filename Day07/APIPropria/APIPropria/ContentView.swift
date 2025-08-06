//
//  ContentView.swift
//  APIPropria
//
//  Created by Turma02-11 on 16/07/25.
//

import SwiftUI
struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        NavigationStack{
            ZStack{
                Color.blue.ignoresSafeArea()
                VStack{
                    Text("Clientes:").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).padding(.bottom)
                    ForEach(viewModel.clientes, id: \.self){ c in
                        NavigationLink(destination: Cliente(clienteSel: c)){
                            HStack{
                                Image(systemName: "person.fill").foregroundColor(.black).font(.system(size: 30))
                                Text(c.name).font(.title).foregroundStyle(.white)
                            }
                        }
                    }
                    Spacer()
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
