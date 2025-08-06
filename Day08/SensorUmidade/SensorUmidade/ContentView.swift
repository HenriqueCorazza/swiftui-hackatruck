//
//  ContentView.swift
//  SensorUmidade
//
//  Created by Turma02-11 on 21/07/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack {
            AngularGradient(colors: [Color.blue, .purple, .cyan, .teal, .green, .orange, .pink, .red], center: .bottomLeading).ignoresSafeArea()
            VStack{
                Image(systemName: "drop.halffull").font(.system(size: 150)).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).background(Circle().frame(width: 200,height: 170).foregroundColor(.mint)).padding(.bottom, 90)
                Text("Valor: \(viewModel.valores.last?.umidade ?? "0.00")").font(.system(size: 30)).padding(.bottom)
                Button("Atualizar Informações!"){
                    viewModel.fetch()
                }.foregroundColor(.black).frame(width: 190, height: 50).background(Color.green).cornerRadius(90).shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 7, x: 2, y: 2)
                Spacer()
                
            }.onReceive(timer){_ in 
                viewModel.fetch()
            }
        }.onAppear(){
            viewModel.fetch()
        }
    }
}

#Preview {
    ContentView()
}
