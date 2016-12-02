//
//  URLSession+Service.swift
//  Request
//
//  Created by Roman Roibu on 02/12/2016.
//  Copyright © 2016 Roman Roibu. All rights reserved.
//

import Foundation

extension URLSession: Service {
    public func load<T>(_ request: Request<T>, completion: @escaping (Result<T>) -> Void) {
        let urlRequest = self.configure(request.urlRequest)

        self.dataTask(with: urlRequest) { data, response, error in

            //TODO: Validate `response` instance

            guard let data = data else {
                //FIXME: Don't force-unwrap error
                completion(.failure(error!))
                return
            }

            do {
                let value = try request.parse(data)
                completion(.success(value))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
