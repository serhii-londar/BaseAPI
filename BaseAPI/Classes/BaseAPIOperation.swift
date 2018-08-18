//
//  BaseAPIOperation.swift
//  BaseAPIPackageDescription
//
//  Created by Serhii Londar on 5/19/18.
//

import Foundation

public class BaseAPIOperation: AsyncOperation {
    fileprivate var session: URLSession? = nil
    fileprivate var url: String = ""
    fileprivate var parameters: [String : String]? = nil
    fileprivate var headers: [String : String]? = nil
    fileprivate var completion: (Data?, URLResponse?, Error?) -> Swift.Void
    
    public init(session: URLSession? = nil, url: String, parameters: [String : String]? = nil, headers: [String: String]? = nil, completion: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        self.session = session
        self.url = url
        self.parameters = parameters
        self.headers = headers
        self.completion = completion
    }
    
    public override func main() {
        if let session = session {
            BaseAPI(session: session).get(url: url, parameters: parameters, headers: headers, completion: completion)
        } else {
            BaseAPI().get(url: url, parameters: parameters, headers: headers, completion: completion)
        }
    }
}
