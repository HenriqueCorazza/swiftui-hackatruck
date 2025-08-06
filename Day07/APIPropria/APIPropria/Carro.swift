//
//  Carro.swift
//  APIPropria
//
//  Created by Turma02-11 on 16/07/25.
//

import SwiftUI

struct Carro: View {
    @State var carSel: car
    var body: some View {
        ZStack{
            AngularGradient(colors: [Color.blue, .purple, .cyan, .teal, .green, .orange, .pink, .red], center: .bottomLeading).ignoresSafeArea()
            VStack{
                Image(systemName: "gauge.high").font(.system(size: 150)).foregroundColor(.green).shadow(color: .black, radius: 5, x: 2, y: 1).padding(.bottom, 20)
                VStack(alignment:.leading){
                    HStack{
                        Image(systemName: "gear").font(.system(size: 45))
                        Text(carSel.modelo).font(.system(size: 30)).foregroundStyle(.white).shadow(color: .black, radius: 5, x: 2, y: 1)
                    }
                    HStack{
                        Image(systemName: "globe.americas.fill").font(.system(size: 45))
                        Text(carSel.marca).font(.system(size: 30)).foregroundStyle(.white).shadow(color: .black, radius: 5, x: 2, y: 1)
                    }
                    HStack{
                        Image(systemName: "car.window.right.exclamationmark").font(.system(size: 45))
                        Text(carSel.tipo).font(.system(size: 30)).foregroundStyle(.white).shadow(color: .black, radius: 5, x: 2, y: 1)
                    }
                    HStack{
                        Image(systemName: "calendar").font(.system(size: 45)).foregroundColor(.black)
                        Text("\(carSel.ano)").font(.system(size: 30)).foregroundStyle(.white).shadow(color: .black, radius: 5, x: 2, y: 1)
                    }
                    HStack{
                        Image(systemName: "hare.fill").font(.system(size: 45)).foregroundColor(.black)
                        Text("\(carSel.hp)HP").font(.system(size: 30)).foregroundStyle(.white).shadow(color: .black, radius: 5, x: 2, y: 1)
                    }
                    HStack{
                        Image(systemName: "engine.combustion.fill").font(.system(size: 45)).foregroundColor(.black)
                        Text("\(carSel.cc)cc").font(.system(size: 30)).foregroundStyle(.white).shadow(color: .black, radius: 5, x: 2, y: 1)
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    Carro(carSel: car(modelo: "Gol", marca: "Volkswagen", tipo: "Hatch", ano: 1989, hp: 76, cc: 1600))
}
