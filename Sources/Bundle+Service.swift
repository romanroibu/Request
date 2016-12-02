//
//  Bundle+Service.swift
//  Request
//
//  Created by Roman Roibu on 02/12/2016.
//  Copyright © 2016 Roman Roibu. All rights reserved.
//

import Foundation

extension Bundle: Service {
    public enum ServiceError: Error {
        case invalidPath
        case missingFile
    }

    public func load<T>(_ request: Request<T>, completion: @escaping (Result<T>) -> Void) {
        let urlRequest = self.configure(request.urlRequest)

        guard let filePath = urlRequest.url?.path else {
            completion(.failure(ServiceError.invalidPath))
            return
        }

        let (file, ext) = resourceComponents(atPath: filePath)

        guard let url = self.url(forResource: file, withExtension: ext) else {
            completion(.failure(ServiceError.missingFile))
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let value = try request.parse(data)
            completion(.success(value))
        } catch {
            completion(.failure(error))
        }
    }

    private func resourceComponents(atPath path: String) -> (filePath: String, extension: String) {
        var pathComponents = path.components(separatedBy: ".")
        var fileExtension = ""

        if let ext = pathComponents.last {
            fileExtension = ext
            pathComponents.removeLast()
        }

        let filePath = pathComponents.joined(separator: ".")
        return (filePath, fileExtension)
    }
}
