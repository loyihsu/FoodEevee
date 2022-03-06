//
//  fetchJson.swift
//  FoodEevee
//
//  Created by Yu-Sung Loyi Hsu on 2022/3/6.
//

import Foundation

func fetchJson(filename: String) -> Data {
    guard let path = Bundle.main.path(forResource: filename, ofType: "json") else {
        fatalError("File is not found.")
    }
    guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
        fatalError("Data cannot be loaded.")
    }
    return data
}
