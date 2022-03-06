//
//  Moya + PromiseKit.swift
//  FoodEevee
//
//  Created by Yu-Sung Loyi Hsu on 2022/3/6.
//

import Moya
import PromiseKit

extension MoyaProvider {
    func request(_ target: Target) -> Promise<Response> {
        return Promise<Response> { resolver in
            self.request(target) { response in
                switch response {
                case .success(let response):
                    resolver.fulfill(response)
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
}
