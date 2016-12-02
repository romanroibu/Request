//
//  Request.swift
//  Request
//
//  Created by Roman Roibu on 02/12/2016.
//  Copyright © 2016 Roman Roibu. All rights reserved.
//

import Foundation

public struct Request<T> {
    public let parse: (Data) throws -> T
    internal let urlRequest: URLRequest

    public init(request: URLRequest, parse: @escaping (Data) throws -> T) {
        self.urlRequest = request
        self.parse = parse
    }

    public init(request: URLRequest, options: JSONSerialization.ReadingOptions = [], parseJSON: @escaping (Any) throws -> T) {
        self.urlRequest = request
        self.parse = { data in
            let json = try JSONSerialization.jsonObject(with: data, options: options)
            return try parseJSON(json)
        }
    }
}

extension Request {

    public init(url: URL, parse: @escaping (Data) throws -> T) {
        self.init(request: URLRequest(url: url), parse: parse)
    }

    public init(url: URL, options: JSONSerialization.ReadingOptions = [], parseJSON: @escaping (Any) throws -> T) {
        self.init(request: URLRequest(url: url), options: options, parseJSON: parseJSON)
    }
}
