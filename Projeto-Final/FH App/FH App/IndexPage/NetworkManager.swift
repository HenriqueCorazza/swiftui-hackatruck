import Foundation
func sendToNodeRED(remedio: remedio, completion: @escaping (Bool) -> Void) {
    guard let url = URL(string: "http://192.168.128.18:1880/postRemedio") else {
        print("URL inválida para Node-RED")
        completion(false)
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    do {
        let jsonData = try JSONEncoder().encode(remedio)
        request.httpBody = jsonData
    } catch {
        print("Erro ao codificar JSON: \(error)")
        completion(false)
        return
    }

    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Erro no envio: \(error)")
            completion(false)
        } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            completion(true)
        } else {
            completion(false)
        }
    }.resume()
}
