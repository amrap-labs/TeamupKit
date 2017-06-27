//
//  TURequestError.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 25/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public class TURequestError {
    
    // MARK: Types
    
    public enum Raw: Error {
        case unknown
    }
    
    // MARK: Properties
    
    /// The request that errored.
    public let request: TURequest?
    /// The raw error for the request.
    public let raw: Error
    /// The status code for the request.
    public let statusCode: TUResponse.StatusCode
    /// Any detail that provides reason for the request error.
    public let detail: String?
    
    /// Unknown request error
    public class var unknown: TURequestError {
        return TURequestError(for: nil, raw: Raw.unknown, statusCode: .unknown)
    }
    
    // MARK: Init
    
    internal init(for request: TURequest?,
                  raw: Error?,
         statusCode: TUResponse.StatusCode,
         response: TUResponse?) {
        self.request = request
        self.raw = raw ?? Raw.unknown
        self.statusCode = statusCode
        
        var details: ErrorDetail?
        if let data = response?.data {
            let decoder = JSONDecoder()
            do {
                details = try decoder.decode(ErrorDetail.self, from: data)
            } catch {}
        }
        self.detail = details?.detail
    }
    
    internal init(with error: Error?) {
        self.request = nil
        self.raw = error ?? Raw.unknown
        self.statusCode = .unknown
        self.detail = nil
    }
    
    internal convenience init(for request: TURequest?,
                              raw: Error?,
                     statusCode: TUResponse.StatusCode) {
        self.init(for: request,
                  raw: raw,
                  statusCode: statusCode,
                  response: nil)
    }
}

extension TURequestError: CustomStringConvertible {
    
    public var description: String {
        var description = ""
        description += "\(self.statusCode) (\(self.statusCode.rawValue)) -"
        if let detail = self.detail {
            description += " Reason: \(detail)"
        } else {
            description += " \(raw)"
        }
        return description
    }
}

extension TURequestError: Equatable {
    
    public static func ==(lhs: TURequestError, rhs: TURequestError) -> Bool {
        return lhs.statusCode == rhs.statusCode && lhs.detail == rhs.detail
    }
}
