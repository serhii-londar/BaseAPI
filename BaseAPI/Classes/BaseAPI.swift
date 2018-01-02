//
//  BaseAPI.swift
//  Alamofire
//
//  Created by Serhii Londar on 12/8/17.
//

import Foundation

extension String: Error {
    
}

public enum RequestMethod: String {
    case OPTIONS
    case GET
    case HEAD
    case POST
    case PUT
    case DELETE
    case TRACE
    case CONNECT
}

public enum RequestHeaderFields: String {
    case acceptCharset = "Accept-Charset"
    case acceptEncoding = "Accept-Encoding"
    case acceptLanguage = "Accept-Language"
    case authorization = "Authorization"
    case expect = "Expect"
    case from = "From"
    case host = "Host"
    case ifMatch = "If-Match"
    case ifModifiedSince = "If-Modified-Since"
    case ifNoneMatch = "If-None-Match"
    case ifRange = "If-Range"
    case ifUnmodifiedSince = "If-Unmodified-Since"
    case maxForwards = "Max-Forwards"
    case proxyAuthorization = "Proxy-Authorization"
    case range = "Range"
    case referer = "Referer"
    case tE = "TE"
    case userAgent = "User-Agent"
}

public class Request {
    public var url: String
    public var method: RequestMethod
    public var parameters: [String : String]?
    public var headers: [String : String]?
    public var body: Data?
    
    public init(url: String, method: RequestMethod, parameters: [String : String]? = nil, headers: [String : String]? = nil, body: Data? = nil) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.body = body
    }
    
    public func request() -> (URLRequest?, Error?) {
        let url = URL(string: self.urlWithParameters())
        if let url = url {
            var request = URLRequest(url: url)
            if let headers = headers {
                for headerKey in headers.keys {
                    request.addValue(headerKey, forHTTPHeaderField: headers[headerKey]!)
                }
            }
            request.httpMethod = method.rawValue
            request.httpBody = body
            return (request, nil)
        } else {
            return (nil, "Unable to create URL")
        }
    }
    
    func urlWithParameters() -> String {
        var retUrl = url
        if let parameters = parameters {
            if parameters.count > 0 {
                retUrl.append("?")
                for key in parameters.keys {
                    guard let value = parameters[key] else {
                        continue
                    }
                    retUrl.append("\(key)=\(value)&")
                }
                retUrl.removeLast()
            }
        }
        return retUrl
    }
}

open class BaseAPI {
    public func get(url: String, parameters: [String : String]? = nil, headers: [String: String]? = nil, completion: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        let request = Request(url: url, method: .GET, parameters: parameters, headers: headers, body: nil)
        let buildRequest = request.request()
        if let urlRequest = buildRequest.0 {
            let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: completion)
            task.resume()
        } else {
            completion(nil, nil, buildRequest.1)
        }
    }
    
    public func head(url: String, parameters: [String : String]? = nil, headers: [String: String]? = nil, completion: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        let request = Request(url: url, method: .HEAD, parameters: parameters, headers: headers, body: nil)
        let buildRequest = request.request()
        if let urlRequest = buildRequest.0 {
            let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: completion)
            task.resume()
        } else {
            completion(nil, nil, buildRequest.1)
        }
    }
    
    public func post(url: String, parameters: [String : String]? = nil, headers: [String: String]? = nil, body: Data?, completion: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        let request = Request(url: url, method: .POST, parameters: parameters, headers: headers, body: body)
        let buildRequest = request.request()
        if let urlRequest = buildRequest.0 {
            let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: completion)
            task.resume()
        } else {
            completion(nil, nil, buildRequest.1)
        }
    }
    
    
    public func put(url: String, parameters: [String : String]? = nil, headers: [String: String]? = nil, body: Data?, completion: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        let request = Request(url: url, method: .PUT, parameters: parameters, headers: headers, body: body)
        let buildRequest = request.request()
        if let urlRequest = buildRequest.0 {
            let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: completion)
            task.resume()
        } else {
            completion(nil, nil, buildRequest.1)
        }
    }
    
    
    public func delete(url: String, parameters: [String : String]? = nil, headers: [String: String]? = nil, completion: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        let request = Request(url: url, method: .DELETE, parameters: parameters, headers: headers)
        let buildRequest = request.request()
        if let urlRequest = buildRequest.0 {
            let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: completion)
            task.resume()
        } else {
            completion(nil, nil, buildRequest.1)
        }
    }
    
    
}
