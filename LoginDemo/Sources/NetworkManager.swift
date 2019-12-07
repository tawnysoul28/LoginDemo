import Foundation

protocol INetworkManager: AnyObject {
    func loadDogs(completion: @escaping (Result<[String: Any], Error>) -> Void)
    func loadImage(completion: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkManager {
    private let session: URLSession //все вокруг этой сессии
    //  let sessionConfiguration = URLSessionConfiguration.default //.default - сессия по умолчанию; ввод данных кешируется на устроиство. ephemeral - приватная сессия (как инкогнито в хроме), ничего не кешируется в кеш. background - когда есть подргрузка данных в бэкграунд режиме, при заблокированном айфоне данные качаются с сервака.
    
    init(sessionConfiguration: URLSessionConfiguration) {
        self.session = URLSession(configuration: sessionConfiguration)
    }
}

extension NetworkManager: INetworkManager {
    
    func loadDogs(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let url = URL(string: "https://dog.ceo/api/breeds/list/all")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET" //получение какой-то инфы от сервера POST - выгрузка инфы
        //request.httpBody - запрос изменения имени определенной собаки
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            } // statusCode - пришлет код (ошибки 404 или 200 - все хорошо)
            
            let dictionary = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any] //из сырых данных получаем словарик. т е форматирование до нужного формата. ПРЕОБРАЗОВАНИЕ ДАННЫХ В ЧИТАЕМЫЙ ВИД
            
            completion(.success(dictionary))
        }
        
        task.resume()
    }
    //начнется выполнение, когда на устройство придет ответ от сервер, нужно проверить на ошибку, потому что данные могут не прийти. ВОТ ЧТО ДАЛЬШЕ ДЕЛАТЬ ПОСЛЕ ТТГО КАК ПОЛУЧИЛИ ДАННЫЕ
    
    //        URLSessionDataTask -- получить ответ, отправить ответ, работа с джейсоном
    //
    //        ... -- выгрузка данных (изображение)
    //
    //        ... -- загрузка данных из сети (изображение)
    
    func loadImage(completion: @escaping (Result<Data, Error>) -> Void) {
        // 1. Собрать URL.
        let url = URL(string: "https://images.dog.ceo/breeds/retriever-flatcoated/n02099267_3605.jpg")!
        
        // 2. Создать task для загрузки data-изображения.
        let task = session.downloadTask(with: url) { (url, _, error) in
            // 4. Описать clojure "что делать, когда data-изображение загрузится"
            if let error = error {
                completion(.failure(error))
                return
            }
            
            let imageData = try! Data(contentsOf: url!)
            completion(.success(imageData))
        }
        // 3. Стартануть task.
        task.resume()
    }
}
