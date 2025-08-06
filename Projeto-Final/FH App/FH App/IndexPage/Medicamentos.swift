//
//  Medicamentos.swift
//  IndexPage
//
//  Created by Turma02-1 on 25/07/25.
//

import SwiftUI

struct IdentifiableRemedio: Identifiable, Equatable {
    let id = UUID()
    let remedio: remedio
}

struct Medicamentos: View {
    @StateObject private var viewModel = ViewModel()
    @State private var remedioSelecionado: IdentifiableRemedio?
    @State private var remedioASerExcluido = remedio(base64: "", nome: "", dosagem: "", funcao: [], colateral: "")
    @State private var mostrarConfirmacaoExclusao = false

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blueHacka, Color.blueFarma]),
                startPoint: .topTrailing,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea(.container, edges: .top)

            ScrollView {
                VStack(spacing: 24) {
                    ForEach(viewModel.med, id: \._id) { remedio in
                        let item = IdentifiableRemedio(remedio: remedio)
                        RemedioCard(remedio: remedio) {
                            remedioASerExcluido = remedio
                            mostrarConfirmacaoExclusao = true
                        }
                        .onTapGesture {
                            remedioSelecionado = item
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
        }
        .onAppear {
            viewModel.fetch()
        }
        .sheet(item: $remedioSelecionado) { item in
            DescricaoRemedio(med: .constant(item.remedio))
        }
        .alert("Excluir Medicamento", isPresented: $mostrarConfirmacaoExclusao, presenting: remedioASerExcluido) { item in
            Button("Cancelar", role: .cancel) {}
            Button("Excluir", role: .destructive) {
                viewModel.excluirRemedio(remedioParaExcluir: remedioASerExcluido)
            }
        } message: { item in
            Text("Tem certeza que deseja excluir o medicamento \"\(remedioASerExcluido.nome)\"?")
        }
    }
}

struct RemedioCard: View {
    let remedio: remedio
    let onDelete: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 12) {
                AsyncImage(url: URL(string: remedio.base64)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 250, height: 150)
                            .cornerRadius(12)
                    } else if phase.error != nil {
                        ZStack {
                            Color.white.opacity(0) // mantém o espaço reservado
                                .frame(width: 250, height: 150)
                                .cornerRadius(12)

                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.init(white: 0.875))
                        }
                    } else {
                        ProgressView()
                            .frame(width: 250, height: 150)
                    }
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(remedio.nome)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.black)
                        .lineLimit(1)

                    HStack {
                        Text("Dose:")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        Text(remedio.dosagem)
                            .foregroundColor(.black).lineLimit(1)
                    }
                    .font(.title3)

                    HStack {
                        Text("Estoque:")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        Text("\(remedio.estoque ?? 0) unidades")
                            .foregroundColor(.black)
                    }
                    .font(.title3)
                }.lineLimit(1)
            }
            .padding()
            .background(Color.white.opacity(0.9))
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.15), radius: 6, x: 0, y: 4)
            
            Button {
                onDelete()
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.red)
                    .padding(8)
                    .background(Circle().fill(Color.white))
                    .shadow(radius: 3)
            }
            .offset(x: -12, y: 12)
        }
    }
}

#Preview {
    Medicamentos()
}
