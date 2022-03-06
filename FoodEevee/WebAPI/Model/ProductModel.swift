//
//  ProductModel.swift
//  ImageJsonThing
//
//  Created by Yu-Sung Loyi Hsu on 2022/3/6.
//

struct ProductModel: Decodable {
    let items: [Item]

    struct Item: Decodable {
        let name: String
        let image: String
        let price: Int
    }
}
