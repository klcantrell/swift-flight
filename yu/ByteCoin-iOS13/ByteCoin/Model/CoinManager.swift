import Foundation

protocol CoinManagerDelegate {
    func didReceiveData(_ coinManager: CoinManager, coinData: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "REDACTED"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.setValue(apiKey, forHTTPHeaderField: "X-CoinAPI-Key")
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data, let coinData = parseJSON(safeData) {
                    self.delegate?.didReceiveData(self, coinData: coinData)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            return CoinModel(rate: decodedData.rate)
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
