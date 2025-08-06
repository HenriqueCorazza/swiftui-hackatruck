//
//  ViewModel.swift
//  SensorUmidade
//
//  Created by Turma02-11 on 21/07/25.
//

import Foundation

struct umidade: Decodable, Hashable{
    let _id: String
    let _rev: String
    let umidade: String
}


class ViewModel: ObservableObject{
    @Published var valores: [umidade] = []
    func fetch(){
        guard let url = URL(string: "http://192.168.128.18:1880/leituraHenrique2") else{
            return
        }
        let task = URLSession.shared.dataTask(with: url){[weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let parsed = try JSONDecoder().decode([umidade].self, from: data)
                DispatchQueue.main.async{
                    self?.valores = parsed
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
}
