//
//  ViewModel.swift
//  ImageJsonThing
//
//  Created by Yu-Sung Loyi Hsu on 2022/3/6.
//

import Foundation
import Moya
import RxSwift

class FoodViewModel {
    private let provider = MoyaProvider<FakeAPI>(stubClosure: MoyaProvider.delayedStub(3))

    var products = PublishSubject<[ProductModel.Item]>()
    var _products: [ProductModel.Item] = []
    var isLoading = false

    func fetchData() {
        guard !isLoading else { return }
        isLoading = true

        provider.request(.product) { response in
            switch response {
            case .success(let response):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let result = try? decoder.decode(ProductModel.self, from: response.data) {
                    self._products = self._products + result.items
                    self.products.onNext(self._products)
                }
            case .failure(let error):
                print(error)
            }
            self.isLoading = false
        }
    }
}
