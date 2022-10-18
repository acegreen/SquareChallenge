//
//  JSON+Extensions.swift
//  AGViperKit
//
//  Created by Ace Green on 2022-10-18.
//

import Foundation

public extension JSONDecoder {

    /// The default JSONDecoder for making a JSON String into a native object.
     static let `default` = { () -> JSONDecoder in
        let decoder = JSONDecoder()
        return decoder
    }()
}
