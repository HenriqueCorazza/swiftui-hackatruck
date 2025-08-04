//
//  ContentView.swift
//  DesafioAnimais
//
//  Created by Turma02-11 on 03/07/25.
//

import SwiftUI

struct ContentView: View {
    @State private var distancia: Float = 0
    @State private var tempo: Float = 0
    @State private var calculado: Float = 0
    @State private var backgroundColor: Color = .gray
    @State private var image: String = "padrao"
    var body: some View {
        ZStack{
            backgroundColor
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                Text("Digite a distância (km):")
                TextField("",value: $distancia, format: .number).keyboardType(.decimalPad).textContentType(.oneTimeCode).background().cornerRadius(8.0).frame(width: 200).multilineTextAlignment(.center)
                Text("Digite o tempo (h):")
                TextField("",value: $tempo, format: .number).keyboardType(.decimalPad).textContentType(.oneTimeCode).background().cornerRadius(8.0).frame(width: 200).multilineTextAlignment(.center)
                Button("Calcular"){
                    calculado = distancia/tempo
                    if (calculado > 0 && 10 > calculado){
                        image = "tartaruga"
                        backgroundColor = .verde
                    }
                    else if (calculado > 10 && 30>calculado){
                        image = "elefante"
                        backgroundColor = .azul
                    }
                    else if (calculado > 30 && 69.9 >= calculado){
                        image = "avestruz"
                        backgroundColor = .laranja
                    }
                    else if(calculado > 70 && 89.9 >= calculado){
                        image = "leao"
                        backgroundColor = .amarelo
                    }
                    else if(calculado > 90 && 130 >= calculado){
                        image = "guepardo"
                        backgroundColor = .vermelho
                    }
                    
                }.foregroundColor(.orange).padding().background(Color.black).cornerRadius(15.0)
                
                Text("\(calculado, specifier: "%.2f") Km/h")
                
                Image(image).resizable().frame(width: 300,height: 250).background(Color.yellow).clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                Spacer()
                VStack{
                    HStack{
                        Text("TARTARUGA (0 - 9.9km/h")
                        Circle().frame(width: 20).foregroundColor(Color(.verde))
                    }
                    HStack{
                        Text("ELEFANTE (10 - 29.9km/h")
                        Circle().frame(width: 20).foregroundColor(Color(.azul))
                    }
                    HStack{
                        Text("AVESTRUZ (30 - 69.9km/h")
                        Circle().frame(width: 20).foregroundColor(Color(.laranja))
                    }
                    HStack{
                        Text("LEÃO (70 - 89.9km/h")
                        Circle().frame(width: 20).foregroundColor(Color(.amarelo))
                    }
                    HStack{
                        Text("GUEPARDO (90 - 130km/h")
                        Circle().frame(width: 20).foregroundColor(Color(.vermelho))
                    }
                }.frame(width: 270,height: 200).background(Color.black).cornerRadius(10.0).foregroundColor(.white)
            }
        }
    }
}

#Preview {
    ContentView()
}
