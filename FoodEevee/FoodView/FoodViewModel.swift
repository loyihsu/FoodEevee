//
//  ViewModel.swift
//  FoodEevee
//
//  Created by Yu-Sung Loyi Hsu on 2022/3/6.
//

import Foundation
import Moya
import RxSwift
import PromiseKit

class FoodViewModel {
    private let provider = MoyaProvider<FakeAPI>(stubClosure: MoyaProvider.immediatelyStub)
    private var isLoading = false

    var products = PublishSubject<([ProductModel.Item], Error?)>()
    var _products: [ProductModel.Item] = []

    func fetchData() {
        guard !isLoading else { return }
        isLoading = true
        _ = firstly {
            provider.request(.product)
        }.done { response in
            let decoder = JSONDecoder()
            let result = try decoder.decode(ProductModel.self, from: response.data)
            self._products = self._products + result.items

            self.products.onNext((self._products, nil))
        }.ensure {
            self.isLoading = false
        }.catch { error in
            self.products.onNext(([], error))
        }
    }
}
