import Foundation
import UIKit
import GoogleGenerativeAI

let model = GenerativeModel(name: "gemini-2.0-flash", apiKey: "AIzaSyAiEczv1Vq6Tn9bhqXbAm179B-sXzS9Qpc") // substitua aqui

func fetchMedicineInfo(medicineName: String, image: UIImage, completion: @escaping (remedio) -> Void) {
    let base64String = image.jpegData(compressionQuality: 0.6)!.base64EncodedString()

    let prompt = """
Remédio: \(medicineName)

Responda SOMENTE com o seguinte JSON (sem explicações, sem markdown):

{
  "nome": "Nome do remédio",
  "dosagem": "Dosagem típica",
  "funcao": ["Função 1", "Função 2"],
  "colateral": "Efeitos colaterais mais comuns"
  "base64": adicione uma string vazia
}
"""

    Task {
        do {
            let response = try await model.generateContent(prompt)
            if let text = response.text {
                print("Resposta da Gemini:\n\(text)")
                let regex = try NSRegularExpression(pattern: "\\{[^\\}]+\\}", options: [])
                if let match = regex.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count)) {
                    let nsRange = match.range
                    if let swiftRange = Range(nsRange, in: text) {
                        let jsonString = String(text[swiftRange])
                        let jsonData = jsonString.data(using: .utf8)!

                        let decoded = try JSONDecoder().decode(remedio.self, from: jsonData)
                        let final = remedio(
                            base64: "",
                            nome: decoded.nome,
                            dosagem: decoded.dosagem,
                            funcao: decoded.funcao,
                            colateral: decoded.colateral,
                            estoque: 100
                        )

                        completion(final)
                        return
                    }
                }
            }

            print("❌ JSON não encontrado na resposta da Gemini.")
        } catch {
            print("❌ Erro ao chamar Gemini: \(error)")
        }
    }
}
