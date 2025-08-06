
import Foundation

struct cliente: Decodable, Hashable{
    let _id: String
    let name: String
    let cpf: String
    let gender: String
    let car: car
}

struct car: Decodable, Hashable{
    let modelo: String
    let marca: String
    let tipo: String
    let ano: Int
    let hp: Int
    let cc: Int
}


class ViewModel: ObservableObject{
    @Published var clientes: [cliente] = []
    func fetch(){
        guard let url = URL(string: "http://127.0.0.1:1880/leiturahenrique") else{
            return
        }
        let task = URLSession.shared.dataTask(with: url){[weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let parsed = try JSONDecoder().decode([cliente].self, from: data)
                DispatchQueue.main.async{
                    self?.clientes = parsed
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
}
    
