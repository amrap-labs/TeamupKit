//
//  RequestError.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 25/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public class RequestError {
    
    // MARK: Properties

    /// The request that errored.
    public let request: Request?
    /// The raw error for the request.
    public let raw: Error
    /// The status code for the request.
    public let statusCode: Response.StatusCode?
    /// Any detail that provides reason for the request error.
    public let detail: String?

    /// Unknown request error
    public class var unknown: RequestError {
        return RequestError(for: nil, raw: TeamupError.Comms.unknown, statusCode: nil)
    }

    // MARK: Init

    internal init(for request: Request?,
                  raw: Error?,
                  statusCode: Response.StatusCode?,
                  response: Response?) {
        self.request = request
        self.raw = raw ?? TeamupError.Comms.unknown
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
        self.raw = error ?? TeamupError.Comms.unknown
        self.statusCode = nil
        self.detail = nil
    }

    internal convenience init(for request: Request?,
                              raw: Error?,
                              statusCode: Response.StatusCode?) {
        self.init(for: request,
                  raw: raw,
                  statusCode: statusCode,
                  response: nil)
    }
}

extension RequestError: CustomStringConvertible {

    public var description: String {
        var description = ""
        if let statusCode = self.statusCode {
            description += "Status Code: \(statusCode) -"
        }
        if let detail = self.detail {
            description += " Reason: \(detail)"
        } else {
            description += " \(raw)"
        }
        return description
    }
}

extension RequestError: Equatable {
    
    public static func ==(lhs: RequestError, rhs: RequestError) -> Bool {
        return lhs.statusCode == rhs.statusCode && lhs.detail == rhs.detail
    }
}


