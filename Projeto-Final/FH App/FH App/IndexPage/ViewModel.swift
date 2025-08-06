//
//  ViewModel.swift
//  ProjetoFinal
//
//  Created by Turma02-11 on 24/07/25.
//

import Foundation

struct usuario: Decodable, Hashable{
    var nome: String
    var sobrenome: String
    var idade: Int
    
}

struct remedio: Hashable,Encodable, Decodable{
    var _id: String?
    var _rev: String?
    var base64: String
    var nome: String
    var dosagem: String
    var funcao: [String]
    var colateral: String
    var estoque: Int?
}

class ViewModel: ObservableObject{
    @Published var med: [remedio] = [remedio(_id: "",_rev: "",base64: "", nome: "teste", dosagem: "", funcao: [], colateral: "")]
    func fetch(){
        guard let url = URL(string: "http://192.168.128.18:1880/getRemedio") else{
            return
        }
        let task = URLSession.shared.dataTask(with: url){[weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let parsed = try JSONDecoder().decode([remedio].self, from: data)
                DispatchQueue.main.async{
                    self?.med = parsed
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
    
    func postRemedio(novoRemedio: remedio) {
        guard let url = URL(string: "http://192.168.128.18:1880/postRemedio") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        
        do {
            // Codificando o objeto remedio para JSON
            let jsonData = try encoder.encode(novoRemedio)
            request.httpBody = jsonData
            
            // Envia a requisição ao servidor
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Erro no POST: \(error)")
                    return
                }
                
                // Verifica se o código de status HTTP é 200 (sucesso)
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    print("Remédio adicionado com sucesso!")
                } else {
                    print("Falha ao adicionar remédio")
                }
            }
            task.resume()
        } catch {
            print("Erro ao codificar os dados: \(error)")
        }
    }
    
    func excluirRemedio(remedioParaExcluir: remedio) {
        guard let url = URL(string: "http://192.168.128.18:1880/excRemedio") else {
            print("URL inválida.")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let encoder = JSONEncoder()
        
        do {
            let jsonData = try encoder.encode(remedioParaExcluir)
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Erro ao enviar requisição de exclusão: \(error.localizedDescription)")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        DispatchQueue.main.async {
                            self.med.removeAll { $0._id == remedioParaExcluir._id }
                                                print("Remédio excluído da lista.")
                                            }
                    } else {
                        print("Falha ao excluir remédio. Código de status: \(httpResponse.statusCode)")
                    }
                }
            }
            
            task.resume()
        } catch {
            print("Erro ao codificar o objeto remédio: \(error.localizedDescription)")
        }
    }
    
    func alterarRemedio(alterado: remedio) {
        guard let url = URL(string: "http://192.168.128.18:1880/putRemedio") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        
        do {
            // Codificando o objeto remedio para JSON
            let jsonData = try encoder.encode(alterado)
            request.httpBody = jsonData
            request.httpMethod = "PUT"
            
            // Envia a requisição ao servidor
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Erro no POST: \(error)")
                    return
                }
                
                // Verifica se o código de status HTTP é 200 (sucesso)
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    print("Remédio alterado com sucesso!")
                } else {
                    print("Falha ao adicionar remédio")
                }
            }
            task.resume()
        } catch {
            print("Erro ao codificar os dados: \(error)")
        }
    }

}
