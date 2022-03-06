//
//  FakeAPI.swift
//  FoodEevee
//
//  Created by Yu-Sung Loyi Hsu on 2022/3/6.
//

import Foundation
import Moya

enum FakeAPI {
    case product
}

extension FakeAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://localhost")!
    }

    var path: String {
        switch self {
        case .product:
            return "product"
        }
    }

    var method: Moya.Method {
        switch self {
        case .product:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .product:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        return nil
    }

    var sampleData: Data {
        switch self {
        case .product:
            return fetchJson(filename: "productResponse")
        }
    }
}
