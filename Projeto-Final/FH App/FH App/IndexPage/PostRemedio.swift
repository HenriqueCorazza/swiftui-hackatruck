import SwiftUI

struct AddRemedioView: View {
    @StateObject var viewModel = ViewModel()
    
    @State private var nome: String = ""
    @State private var dosagem: String = ""
    @State private var funcao: String = ""
    @State private var colateral: String = ""
    @State private var estoque: String = ""
    
    var body: some View {
        
        NavigationStack {
                Form {
                    
                    Section(header: Text("Informações do Remédio")) {
                        TextField("Nome", text: $nome)
                        TextField("Dosagem", text: $dosagem)
                        TextField("Função", text: $funcao)
                        TextField("Colateral", text: $colateral)
                        TextField("Estoque", text: $estoque)
                            .keyboardType(.numberPad)
                    }
                    
                    Button(action: {
                        guard let estoqueInt = Int(estoque) else {
                            print("Estoque inválido")
                            return
                        }
                        
                        let novoRemedio = remedio(
                            base64: "https://e.drogasul.med.br/6442-home_default/gcefalexina-500-mg-8-cpr.webp", // Aqui você pode colocar a imagem em base64, se necessário
                            nome: nome,
                            dosagem: dosagem,
                            funcao: [funcao], // Você pode modificar isso se houver várias funções
                            colateral: colateral,
                            estoque: estoqueInt
                        )
                        print(novoRemedio)
                        
                        viewModel.postRemedio(novoRemedio: novoRemedio)
                        clearFields() // Limpar os campos após o POST
                    }) {
                        Text("Adicionar Remédio")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                .navigationTitle("Adicionar Remédio")
            }
        }
        
    }
    
    // Função para limpar os campos após adicionar o remédio
    func clearFields() {
        nome = ""
        dosagem = ""
        funcao = ""
        colateral = ""
        estoque = ""
    }
}

struct AddRemedioView_Previews: PreviewProvider {
    static var previews: some View {
        AddRemedioView()
    }
}
