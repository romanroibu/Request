//
//  Service.swift
//  Request
//
//  Created by Roman Roibu on 02/12/2016.
//  Copyright © 2016 Roman Roibu. All rights reserved.
//

import Foundation

public protocol Service {
    func configure(_ urlRequest: URLRequest) -> URLRequest
    func load<T>(_ request: Request<T>, completion: @escaping (Result<T>) -> Void)
}

extension Service {
    public func configure(_ urlRequest: URLRequest) -> URLRequest {
        return urlRequest
    }
}
