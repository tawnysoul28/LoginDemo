import Foundation

protocol INetworkManager: AnyObject {
    func loadQuote(_  completion: @escaping (Result<String, Error>) -> Void)
}

final class NetworkManager {

    private let session: URLSession
    
    init(sessionConfiguration: URLSessionConfiguration) {
        self.session = URLSession(configuration: sessionConfiguration)
    }}

extension NetworkManager {
    
    func loadQuote(_  completion: @escaping (Result<String, Error>) -> Void) {
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.forismatic.com/api/1.0/?method=getQuote&format=text")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                completion(.failure(error))
                print(error)
            } else if let data = data, let text = String(data: data, encoding: .utf8) {
                completion(.success(text))
            } else {
                completion(.failure(NSError(domain: "NetworkManager", code: 0, userInfo: nil)))
            }
        })
        
        dataTask.resume()
    }

    
}


