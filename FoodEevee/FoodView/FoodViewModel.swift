//
//  ViewModel.swift
//  FoodEevee
//
//  Created by Yu-Sung Loyi Hsu on 2022/3/6.
//

import Foundation
import class Moya.MoyaProvider
import RxSwift

@MainActor
class FoodViewModel {
    private let provider = MoyaProvider<FakeAPI>(stubClosure: MoyaProvider.delayedStub(3))
    private var isLoading = false

    var products = PublishSubject<[ProductModel.Item]>()
    var _products: [ProductModel.Item] = []

    func fetchData() {
        guard !isLoading else { return }
        Task {
            do {
                try await loadingIndicated {
                    let response = try await provider.request(.product)

                    let decoder = JSONDecoder()
                    let result = try decoder.decode(ProductModel.self, from: response.data)
                    _products = _products + result.items

                    products.onNext(_products)
                }
            } catch {
                print(error)
            }
        }
    }

    func loadingIndicated(closure: () async throws -> Void) async throws {
        isLoading = true
        try await closure()
        isLoading = false
    }
}
