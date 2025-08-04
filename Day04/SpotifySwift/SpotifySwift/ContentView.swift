//
//  ContentView.swift
//  SpotifySwift
//
//  Created by Turma02-11 on 07/07/25.
//

import SwiftUI

struct Song : Hashable{
    var name: String
    var artist: String
    var capa: String
}

struct ContentView: View {
    var musicas = [
        Song(name: "Trem das onze", artist: "Adoniran Barbosa", capa: "data:image/jpeg;base64,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"),
        Song(name: "Dissipate", artist: "Polaris", capa: "https://i.scdn.co/image/ab67616d0000b273dcc4dcf2f48f7a97da2ff39f"),
        Song(name: "Dissipate1", artist: "Polaris", capa: "https://i.scdn.co/image/ab67616d0000b273dcc4dcf2f48f7a97da2ff39f"),
        Song(name: "Dissipate", artist: "Polaris", capa: "https://i.scdn.co/image/ab67616d0000b273dcc4dcf2f48f7a97da2ff39f"),
        Song(name: "Dissipate", artist: "Polaris", capa: "https://i.scdn.co/image/ab67616d0000b273dcc4dcf2f48f7a97da2ff39f"),
        Song(name: "Dissipate", artist: "Polaris", capa: "https://i.scdn.co/image/ab67616d0000b273dcc4dcf2f48f7a97da2ff39f"),
        Song(name: "Dissipate", artist: "Polaris", capa: "https://i.scdn.co/image/ab67616d0000b273dcc4dcf2f48f7a97da2ff39f")
    ]
    var body: some View {
        NavigationStack{
            ZStack{
                Rectangle().fill(LinearGradient(stops: [
                    .init(color: .blue, location: 0.1),
                    .init(color: .black, location: 0.7),
                ],startPoint: .top, endPoint: .bottom)).ignoresSafeArea()
                VStack{
                    Image("caminhao").resizable().frame(width: 190, height: 190).padding(.top, 40)
                    Spacer()
                    Text("Hacka FM").font(.system(size: 30)).foregroundStyle(.white).frame(width: 350, alignment: .leading).padding(.top)
                    HStack{
                        Image("caminhao").resizable().scaledToFit().frame(width: 40).padding(.leading)
                        Text("HackaSong").foregroundColor(.white)
                        Spacer()
                    }.padding(.bottom)
                    ScrollView{
                        VStack{
                            ForEach(musicas, id: \.self){ musica in
                                NavigationLink(destination: TelaMais(selecionada: musica)){
                                    HStack{
                                        AsyncImage(url: URL(string: "\(musica.capa)")) { image in
                                            image
                                                .resizable()
                                            
                                        } placeholder: {
                                            Color.gray
                                        }
                                        .frame(width: 60, height: 60).padding(.all,5)
                                        VStack(alignment: .leading){
                                            Text("\(musica.name)").foregroundStyle(.white).font(.system(size: 20))
                                            Text("\(musica.artist)").foregroundStyle(.white)
                                        }
                                        Spacer()
                                        Image(systemName: "ellipsis").foregroundColor(.white).padding(.trailing)
                                        
                                        
                                    }
                                }
                            }
                        }.scrollContentBackground(.hidden)
                            .background(Color.clear)
                        Text("Sugeridos").foregroundStyle(.white).frame(width: 350, alignment: .leading).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        ScrollView(.horizontal){
                            HStack{
                                VStack{
                                    Image("lp_trem").resizable().scaledToFit().frame(width: 250)
                                    Text("1 - LP Trem").foregroundStyle(.white).padding(.top, 8)
                                }
                                VStack{
                                    Image("lp_polaris").resizable().scaledToFit().frame(width: 250)
                                    Text("Fatalism").foregroundStyle(.white).padding(.top, 8)
                                }
                                VStack{
                                    Image("lp_trem").resizable().scaledToFit().frame(width: 250)
                                    Text("LP Trem")
                                }
                            }.padding()
                            
                        }
                    }
                }
            }
            
        }.tint(.white)
    }
}

#Preview {
    ContentView()
}
