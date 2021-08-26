import Foundation

class NetworkManager: ObservableObject {
    @Published var posts = [Post]()

    func fetchData() {
        if let url = URL(string: "https://hn.algolia.com/api/v1/search?tags=front_page") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, requestError) in
                if requestError == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.async {
                                self.posts = results.hits
                            }
                        } catch(let decodeError) {
                            print(decodeError)
                        }
                    }
                } else {
                    print(requestError!)
                }
            }
            task.resume()
        }
    }
}
