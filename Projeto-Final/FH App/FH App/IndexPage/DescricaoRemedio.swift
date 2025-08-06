//
//  DescricaoRemedio.swift
//  ProjetoFinal
//
//  Created by Turma02-11 on 24/07/25.
//

import SwiftUI

struct DescricaoRemedio: View {
    @Binding var med: remedio
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.blueHacka, Color.blueFarma]), startPoint: .topTrailing, endPoint: .bottomTrailing).ignoresSafeArea()
            VStack(alignment: .center){
                AsyncImage(url: URL(string: "\(med.base64)")){ image in
                    image.image?.resizable().scaledToFit().frame(width: 200).clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/).padding(.bottom,3).shadow(color: .black, radius: 10)
                }
                HStack{
                    Text("\(med.nome)").foregroundColor(.white).font(.system(size: 50)).shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 3, x: 2, y: 2)
                    
                }
                HStack{
                    Text("\(med.dosagem)").foregroundColor(.white).font(.system(size: 30)).shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 4, x: 2, y: 2)
                }.padding(.bottom,25)
                VStack(alignment: .leading){
                    Text("Função:").font(.system(size: 27)).padding(.bottom, 1).bold()
                    ForEach(med.funcao, id: \.self){ alivio in
                        HStack{
                            Image(systemName: "arrowshape.forward.circle.fill").foregroundColor(.green)
                            Text("\(alivio)")
                        }.font(.system(size: 25))
                    }
                    Text("Efeito Colateral:").padding(.top).bold().font(.system(size: 27)).padding(.bottom, 1)
                    HStack{
                        Image(systemName: "arrowshape.forward.circle.fill").foregroundColor(.red)
                        Text("\(med.colateral)")
                    }.font(.system(size: 25))
                    HStack(alignment: .bottom){
                        Image(systemName: "basket.fill").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).shadow(radius: 1)
                        Text("\(String(describing: med.estoque ?? 0))").font(.system(size: 20)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text("restantes")
                    }.padding(.top)
                }.padding().background().cornerRadius(30)
                Spacer()
            }
            
        }
    }
}

#Preview {
    DescricaoRemedio(med: .constant(remedio(_id: "", _rev: "", base64: "https://cdn.awsli.com.br/2500x2500/1935/1935132/produto/135542942/3f8c86ee08.jpg", nome: "Dipirona", dosagem: "500mg/ml", funcao: ["Dor de cabeça", "Febre"], colateral: "Enjoo", estoque: 23)))
}
