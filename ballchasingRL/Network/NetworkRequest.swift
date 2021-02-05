import UIKit

let apiKey = "U9bIUx8mQcyyzI78dstxIZ5BlCbrxbffQImrrunU"

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func load(withCompletion completion: @escaping(ModelType?) -> Void)
    func decode(_ data: Data) -> ModelType?
}

extension NetworkRequest {
    func load(_ url: URL, withCompletion completion: @escaping (ModelType?) -> Void) {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Authorization": apiKey]
        let session = URLSession(configuration: config, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: url, completionHandler: {
            [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            guard let data = data else {
                completion(nil)
                return
            }
            completion(self?.decode(data))
        })
        task.resume()
    }

}

class MatchDetailsRequest<Resource: APIResource> {
    let resource: Resource

    init(resource: Resource) {
        self.resource = resource
    }
}

extension MatchDetailsRequest: NetworkRequest {
    func load(withCompletion completion: @escaping (Resource.ModelType?) -> Void) {
        load(resource.url, withCompletion: completion)
    }

    func decode(_ data: Data) -> Resource.ModelType? {
        do {
            let wrapper = try? JSONDecoder().decode(Resource.ModelType.self, from: data)
            return wrapper
        } catch {
            print(error)
        }
        return nil
    }
}

class APIRequest<Resource: APIResource> {
    let resource: Resource

    init(resource: Resource) {
        self.resource = resource
    }
}

extension APIRequest: NetworkRequest {

    func load(withCompletion completion: @escaping (ResultWrapper<Resource.ModelType>?) -> Void) {
        load(resource.url, withCompletion: completion)
    }

    func decode(_ data: Data) -> ResultWrapper<Resource.ModelType>? {
        do {
            let wrapper = try? JSONDecoder().decode(ResultWrapper<Resource.ModelType>.self, from: data)
            return wrapper
        } catch {
            print(error)
        }
        return nil
    }
}

protocol APIResource {
    associatedtype ModelType: Decodable
    var scheme: String { get }
    var host: String { get }
    var methodPath: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension APIResource {
    var url: URL {
        get {
            var components = URLComponents()
            components.scheme = scheme
            components.host = host
            components.path = methodPath
            components.queryItems = queryItems

            guard let requestUrl = components.url else {
                print("Could not generate request url -- APIResource \(String(describing: ModelType.self))" )
                fatalError()
            }
            return requestUrl
        }
    }
}
