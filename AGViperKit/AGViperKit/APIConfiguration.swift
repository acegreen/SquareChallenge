//
//  APIConfiguration.swift
//  AGViperKit
//
//  Created by Ace Green on 2022-10-18.
//

import UIKit
import Alamofire

public protocol APIConfiguration: URLRequestConvertible {
    var accessToken: String? { get }
    var baseURLString: String { get }
    var module: String? { get }
    var method: HTTPMethod { get }
    var path: URLPath { get }
    var queryParameters: Parameters? { get }
    var httpBody: Parameters? { get }
    var httpBodyEncoding: HTTPBodyEncoding { get }
    var headers: [String: String]? { get }

    func asURLRequest() throws -> URLRequest
}

public enum HTTPBodyEncoding {
    case json
    case formURLEncoded
}

public enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

public enum ContentType: String {
    case json = "application/json"
}

public extension APIConfiguration {

    var baseURLString: String {
        return baseURLString
    }

    var module: String? {
        return nil
    }

    var method: HTTPMethod {
        return .get
    }

    var queryParameters: Parameters? {
        return nil
    }

    var httpBody: Parameters? {
        return nil
    }

    var httpBodyEncoding: HTTPBodyEncoding {
        return .json
    }

    var headers: [String: String]? {
        return nil
    }
}

public extension APIConfiguration {
    func asURLRequest() throws -> URLRequest {
        var baseURL = try baseURLString.asURL()
        let interpolatedPath = path.interpolatedPath

        if let moduleName = module {
            baseURL.appendPathComponent(moduleName)
        }

        // URL Request
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(interpolatedPath))

        // HTTP Method
        urlRequest.httpMethod = method.rawValue

        // Global Headers
        let globalHeaders = [HTTPHeaderField.acceptType.rawValue: ContentType.json.rawValue]

        globalHeaders.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }

        // Additional Headers
        headers?.forEach { (key, value) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        // Query Parameters
        if let queryParams = queryParameters {
            let encoder = URLEncoding(destination: .queryString, arrayEncoding: .noBrackets)
            urlRequest = try encoder.encode(urlRequest, with: queryParams)
        }

        // HTTP Body
        if let httpBody = httpBody {
            switch httpBodyEncoding {
            case .json:
                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: httpBody, options: [])
                urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

            case .formURLEncoded:
                let encoder = URLEncoding(destination: .httpBody, arrayEncoding: .noBrackets)
                urlRequest = try encoder.encode(urlRequest, with: httpBody)
            }
        }

        urlRequest = try URLEncoding.queryString.encode(urlRequest, with: nil)

        // Access token
        if let accessToken = accessToken {
            urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        return urlRequest
    }
}
