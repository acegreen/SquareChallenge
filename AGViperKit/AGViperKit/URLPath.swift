//
//  URLPath.swift
//  AGViperKit
//
//  Created by Ace Green on 2022-10-18.
//

import Foundation

public struct URLPath {
    public static let regex = try! NSRegularExpression(pattern: ":(.*?):", options: []) // swiftlint:disable:this force_try

    /// Dynamically generated list of required parameters extracted from the tokenPath
    private let requiredParameters: [String]?
    /// A dictionary mapping token names to URL parameter values
    private let parameters: [String: Any]?
    /// The path with token placeholders for parameters (i.e. "/path/to/:parameterName:/foo")
    public let tokenPath: String

    /// The path with all parameters (if any) interpolated
    public var interpolatedPath: String {
        guard
            let requiredParameters = requiredParameters,
            let parameters = parameters,
            requiredParameters.count > 0 && !parameters.isEmpty
            else { return tokenPath }

        var interpolatedPath = tokenPath
        for (key, value) in parameters {
            let key = ":\(key):"
            interpolatedPath = interpolatedPath.replacingOccurrences(of: key, with: "\(value)")
        }
        return interpolatedPath
    }

    public init(tokenPath: String, parameters: [String: Any]? = nil) {
        self.tokenPath = tokenPath
        self.parameters = parameters
        self.requiredParameters = URLPath.extractParameters(fromTokenizedPath: tokenPath)
    }

    public static func extractParameters(fromTokenizedPath path: String) -> [String]? {
        let tmp = path as NSString
        var results = [String]()

        regex.enumerateMatches(in: path, options: [], range: NSRange(location: 0, length: path.count)) { result, _, _ in
            if let range = result?.range(at: 1) {
                results.append(tmp.substring(with: range))
            }
        }
        return !results.isEmpty ? results : nil
    }
}
