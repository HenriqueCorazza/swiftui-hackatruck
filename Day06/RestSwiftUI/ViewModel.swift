import Foundation



struct pers: Decodable, Identifiable{
    let id: Int
    let name: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin: origin?
    let location: location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

struct origin: Decodable{
    let name: String?
    let url: String?
}

struct location: Decodable{
    let name: String?
    let url: String?
}

struct ep: Decodable, Identifiable{
    let id: Int
    let name: String?
    let air_date: String?
    let episode: String?
    let characters: [String]?
}
class ViewModel: ObservableObject{
    @Published var personagens: [pers] = []
    @Published var episodio: ep = ep(id: 0, name: "", air_date: "", episode: "", characters: [])
    func fetch(){
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/1,2,3,4,5,6,7,8,9,10") else{
            return
        }
        let task = URLSession.shared.dataTask(with: url){[weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let parsed = try JSONDecoder().decode([pers].self, from: data)
                DispatchQueue.main.async{
                    self?.personagens = parsed
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
    
    func fetchEpisodios(urlEp: String){
        guard let url = URL(string: urlEp) else{
            return
        }
        let task = URLSession.shared.dataTask(with: url){[weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let parsed = try JSONDecoder().decode(ep.self, from: data)
                DispatchQueue.main.async{
                    self?.episodio = parsed
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
}

