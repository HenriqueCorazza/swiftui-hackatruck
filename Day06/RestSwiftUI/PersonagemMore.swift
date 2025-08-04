//
//  PersonagemMore.swift
//  RestSwiftUI
//
//  Created by Turma02-11 on 14/07/25.
//

import SwiftUI

struct PersonagemMore: View {
    @State var pers: pers
    @StateObject var viewModel = ViewModel()
    var body: some View {
        NavigationStack{
            ZStack{
                Color.fundo.ignoresSafeArea()
                VStack{
                    AsyncImage(url: URL(string: pers.image!)).padding(.bottom)
                    Text("Nome:  \(pers.name!)")
                    Text("Origem:  \(pers.origin!.name!)")
                    Text("Espécie:  \(pers.species!)")
                    Text("Gênero:  \(pers.gender!)")
                    NavigationLink(destination: Episodios(epSel: viewModel.episodio)){
                        HStack{
                            Text("Primeira Aparição: ")
                            Image(systemName: "video.square.fill")
                        }.foregroundColor(.black)
                    }
                    Spacer()
                }
            }
        }
        .onAppear(){
            viewModel.fetchEpisodios(urlEp: pers.episode!.first!)
        }
    }
}

#Preview {
    PersonagemMore(pers: pers(id: 0, name: "", species: "", type: "", gender: "", origin: origin(name: "", url: ""), location: location(name: "", url: ""), image: "", episode: [], url: "", created: ""))
}
