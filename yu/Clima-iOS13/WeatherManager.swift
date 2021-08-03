import Foundation

struct WeatherManager {
    let url = "https://api.openweathermap.org/data/2.5/weather?appid=REDACTED6&units=imperial"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(url)&q=\(cityName)"
        print(urlString)
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: handleRequestCompletion(data: response: error:))
            task.resume()
        }
    }
    
    func handleRequestCompletion(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
        }
    }
}
