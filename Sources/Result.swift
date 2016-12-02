//
//  Result.swift
//  Request
//
//  Created by Roman Roibu on 02/12/2016.
//  Copyright © 2016 Roman Roibu. All rights reserved.
//

public enum Result<T> {
    case success(T)
    case failure(Error)

    public var success: T? {
        switch self {
        case .success(let s): return s
        case .failure(_): return nil
        }
    }

    public var failure: Error? {
        switch self {
        case .failure(let e): return e
        case .success(_): return nil
        }
    }
}
