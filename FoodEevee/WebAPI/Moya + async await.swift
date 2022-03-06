//
//  Moya + async await.swift
//  FoodEevee
//
//  Created by Yu-Sung Loyi Hsu on 2022/3/6.
//

import Moya

extension MoyaProvider {
    func request(_ target: Target) async throws -> Response {
        return try await withUnsafeThrowingContinuation { continuation in
            self.request(target) { response in
                switch response {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
