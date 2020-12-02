import Foundation

struct PirateNameService {
    func getPirateName(for firstName: String, andThen callback: @escaping (String) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8080/pirate-name/\(firstName)") else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                callback("There was a problem with the request")
            }
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    callback(String(data: data, encoding: String.Encoding.utf8) ?? "The response was malformed")
                }
            }
        }.resume()
    }
}
