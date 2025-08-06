import SwiftUI

struct Viewscanner: View {
    @State private var showCamera = false
    @State private var remedioData: remedio?
    @State private var imagemRemedio: UIImage?
    @State private var envioConcluido = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if let imagem = imagemRemedio {
                    Image(uiImage: imagem)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(10)
                        .shadow(radius: 4)
                }

                if let r = remedioData {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("📦 Nome: \(r.nome)")
                        Text("💊 Dosagem: \(r.dosagem)")
                        Text("🧠 Função: \(r.funcao.joined(separator: ", "))")
                        Text("⚠️ Colateral: \(r.colateral)")
                        if let estoque = r.estoque {
                            Text("📦 Estoque: \(estoque)")
                        }
                    }
                    .padding()
                }

                if envioConcluido {
                    Text("Remédio adicionado com sucesso")
                        .foregroundColor(.green)
                        .bold()
                }

                Button("📷 Tirar Foto do Remédio") {
                    envioConcluido = false
                    showCamera = true
                }
                .padding()
                .sheet(isPresented: $showCamera) {
                    CameraView { recognizedText, image in
                        imagemRemedio = image
                        fetchMedicineInfo(medicineName: recognizedText, image: image) { remedioResult in
                            DispatchQueue.main.async {
                                self.remedioData = remedioResult
                                sendToNodeRED(remedio: remedioResult) { sucesso in
                                    if sucesso {
                                        DispatchQueue.main.async {
                                            self.envioConcluido = true
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Analisador de Remédio")
        }
    }
}
