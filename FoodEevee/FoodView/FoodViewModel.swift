//
//  ViewModel.swift
//  ImageJsonThing
//
//  Created by Yu-Sung Loyi Hsu on 2022/3/6.
//

import Foundation
import Moya

class FoodViewModel {
    private let provider = MoyaProvider<FakeAPI>(stubClosure: MoyaProvider.delayedStub(3))

    @Published var products: [ProductModel.Item] = []
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
                    self.products = self.products + result.items
                }
            case .failure(let error):
                print(error)
            }
            self.isLoading = false
        }
    }
}
