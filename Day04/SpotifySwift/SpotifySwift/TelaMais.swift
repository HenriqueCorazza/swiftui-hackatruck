//
//  TelaMais.swift
//  SpotifySwift
//
//  Created by Turma02-11 on 07/07/25.
//

import SwiftUI

struct TelaMais: View {
    @State var selecionada : Song = Song(name: "teste", artist: "Polaris", capa: "https://i.scdn.co/image/ab67616d0000b273dcc4dcf2f48f7a97da2ff39f")
    var body: some View {
      
        ZStack{
            Rectangle().fill(LinearGradient(stops: [
                .init(color: .blue, location: 0.1),
                .init(color: .black, location: 0.7),
            ],startPoint: .top, endPoint: .bottom)).ignoresSafeArea()
            VStack{
                Spacer()
                AsyncImage(url: URL(string: "\(selecionada.capa)")) { image in
                    image
                        .resizable()
                    
                } placeholder: {
                    Color.gray
                }
                .frame(width: 330, height: 330)
                Text("\(selecionada.name)").foregroundStyle(.white).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text("\(selecionada.artist)").foregroundStyle(.white)
                Spacer()
                HStack{
                    Spacer()
                    Image(systemName: "shuffle").foregroundColor(.white).font(.system(size: 35))
                    Spacer()
                    Image(systemName: "backward.end.fill").foregroundColor(.white).font(.system(size: 35))
                    Spacer()
                    Image(systemName: "play.fill").foregroundColor(.white).font(.system(size: 50))
                    Spacer()
                    Image(systemName: "forward.end.fill").foregroundColor(.white).font(.system(size: 35))
                    Spacer()
                    Image(systemName: "repeat").foregroundColor(.white).font(.system(size: 35))
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

#Preview {
    TelaMais()
}
