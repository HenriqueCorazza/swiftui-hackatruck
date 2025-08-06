//
//  Cliente.swift
//  APIPropria
//
//  Created by Turma02-11 on 16/07/25.
//

import SwiftUI

struct Cliente: View {
    @State var clienteSel: cliente
    var body: some View {
        NavigationStack{
            ZStack{
                AngularGradient(colors: [.red, .teal, .blue,.gray, .indigo, .red], center: .center).ignoresSafeArea()
                VStack{
                    VStack{
                        Image(systemName: "person.fill").font(.system(size: 150)).foregroundColor(.blue).shadow(color: .black, radius: 5, x: 2, y: 1).padding(.bottom, 50)
                    }
                    VStack(alignment: .leading){
                        HStack{
                            Image(systemName: "person.text.rectangle.fill").font(.system(size: 45))
                            Text(clienteSel.name).font(.system(size: 30)).foregroundStyle(.white).shadow(color: .black, radius: 5, x: 2, y: 1)
                        }
                        HStack{
                            Image(systemName: "tag.circle.fill").font(.system(size: 45))
                            Text(clienteSel.cpf).font(.system(size: 30)).foregroundStyle(.white).shadow(color: .black, radius: 5, x: 2, y: 1)
                        }
                        HStack{
                            Image(systemName: "figure.dress.line.vertical.figure").font(.system(size: 45))
                            Text(clienteSel.gender).font(.system(size: 30)).foregroundStyle(.white).shadow(color: .black, radius: 5, x: 2, y: 1)
                        }
                        NavigationLink(destination: Carro(carSel: clienteSel.car)){
                            HStack{
                                Image(systemName: "car.rear.road.lane").font(.system(size: 45)).foregroundColor(.black)
                                Text(clienteSel.car.modelo).font(.system(size: 30)).foregroundStyle(.white).shadow(color: .black, radius: 5, x: 2, y: 1)
                            }
                        }
                    }
                    Spacer()
                    
                }
            }
        }
    }
}

#Preview {
    Cliente(clienteSel: cliente(_id: "", name: "Teste", cpf: "505.499.548-05", gender: "Masculino", car: car(modelo: "Gol", marca: "", tipo: "", ano: 2, hp: 3, cc: 4)))
}
