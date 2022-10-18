//
//  AlamofireSessionManager.swift
//  AGViperKit
//
//  Created by Ace Green on 2022-10-18.
//

import Alamofire

public class AlamofireSessionManager: SessionDelegate {
    public static let shared = AlamofireSessionManager()
    public var logEntries = [NetworkLogItem]()
    public var session: Session!

    public init() {
        super.init()

        self.session = Session(configuration: URLSessionConfiguration.default,
                                    delegate: self,
                                    rootQueue: DispatchQueue.main,
                                    eventMonitors: [ ])
    }

    // MARK: SessionDelegate
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.performDefaultHandling, nil)
    }
}

public class NetworkLogItem {
    public var debugDescription = ""

    public init(debugDescription: String) {
        self.debugDescription = debugDescription
    }
}
