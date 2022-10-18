//
//  ModuleInteractor+Extensions.swift
//  AGViperKit
//
//  Created by Ace Green on 6/12/21.
//

import Foundation
import Alamofire
import PromiseKit

public class DefaultInteractor: ModuleInteractor {
    public init() {}
}

public extension ModuleInteractor {

    // empty implementation by default
    func configure(presenter: ModulePresenter) { }

    /// Builds the data request, adding any necessary status code validation
    private func buildRequest(forRoute route: APIConfiguration) -> DataRequest {
        return AlamofireSessionManager.shared.session.request(route)
    }

    func request<T: Codable>(_ route: APIConfiguration,
                             decoder: JSONDecoder = .default) -> Promise<T> {

        func request() -> Promise<T> {
            return Promise { seal in
                self.buildRequest(forRoute: route).responseDecodable(decoder: decoder) { [weak self] (response: DataResponse<T, AFError>) in
                    
//                    debugPrint(response)

                    switch response.result {
                    case .success(let decodable):
                        seal.fulfill(decodable)
                    case .failure(let error):
                        print(error)
                        seal.reject(error)
                    }
                }
            }
        }

        return request()
    }
    
    func getLocalObject<T>(type: T.Type,
                           fromFileName fileName: String,
                           fileExtension: String = "json",
                           latency: Int = 0,
                           jsonDecoder: JSONDecoder = JSONDecoder(),
                           completionHandler: @escaping (T?) -> Void) where T: Decodable {

        DispatchQueue.global().async {
            if let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) {
                do {
                    let data = try Data(contentsOf: url)
                    let result = try jsonDecoder.decode(type.self, from: data)
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(latency)) {
                        completionHandler(result)
                    }

                } catch let error {
                    print(error)
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(latency)) {
                        completionHandler(nil)
                    }
                }
            } else {
                print("no url")
                completionHandler(nil)
            }
        }
    }
}
