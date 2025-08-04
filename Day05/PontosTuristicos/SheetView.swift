//
//  SheetView.swift
//  PontosTuristicos
//
//  Created by Turma02-11 on 08/07/25.
//

import SwiftUI

struct SheetView: View {
    @Binding var escolhida: Location
    var body: some View {
        ZStack{
            Rectangle().foregroundColor(Color.fundo).ignoresSafeArea()
            VStack{
                AsyncImage(url: URL(string: "\(escolhida.foto)")) { image in
                    image
                        .resizable().frame(width: 330,height: 250).padding(.top)
                    
                } placeholder: {
                    Color.gray
                }
                Text("\(escolhida.nome)").padding(.bottom).font(.system(size: 25)).foregroundColor(.letra).fontWeight(.bold)
                ZStack{
                    VStack{
                        Text("\(escolhida.descricao)").multilineTextAlignment(.leading).padding()
                        Spacer()
                    }
                }.frame(width: 370).background(Color.letra).cornerRadius(25)
                Spacer()
            }
        }
    }
}

#Preview {
    SheetView(escolhida: .constant(Location(nome: "Presidente Prudente", foto: "https://lh3.googleusercontent.com/gps-cs-s/AC9h4nq7MKUi4-m2oD8ysZPwt1jaoG3wzMUGSfL0jI1Ya2heXeCVdtN9AwgLNf-Kfb_rq9xnojx9Qk5GauZbE1fZgTEu51KmcR-KD82D2mpdfv07mOWC_PoT6S6KRhean5oLDQBxbzVEFw=w1080-h624-n-k-no", descricao: "O Coliseu, também conhecido como Anfiteatro Flaviano, é um antigo anfiteatro localizado no centro da cidade de Roma, Itália. É um dos monumentos mais famosos e importantes do Império Romano e um dos principais pontos turísticos de Roma.", latitude: -22.95, longitude: -43.210)))
}
