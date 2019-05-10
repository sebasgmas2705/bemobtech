//
//  ProductsDataSource.swift
//  BeMobTech
//
//  Created by Sebastian Gelabert on 09/05/2019.
//  Copyright © 2019 Sebastian Gelabert. All rights reserved.
//

import Foundation
import Alamofire

class ProductsDataSource {
    
    static let kTransactionsId = "ProductsDataSourceTransactions"
    static let kRatesId = "ProductsDataSourceRates"
    
    private(set) var productsList: [Transaction]?
    private(set) var productsSKUDupe: [String]?
    private(set) var productsSKUDeDupe: [String]?
    
    func requestTransactions(delegate: NetworkDelegate) {
        delegate.startLoading(ProductsDataSource.kTransactionsId)
        
        Alamofire.request("http://quiet-stone-2094.herokuapp.com/transactions.json", method: .get, parameters: [:], encoding: URLEncoding.default).validate(contentType: ["application/json"])
            .responseJSON { [weak self] response in
                switch response.result {
                case .success(let JSON):
                    guard let JSON = JSON as? [[String: Any]] else {return}
                    self?.productsList = []
                    JSON.forEach({ jsonTransaction in
                        if  let transactionData = try? JSONSerialization.data(withJSONObject: jsonTransaction),
                            let transaction = try? JSONDecoder().decode(Transaction.self, from: transactionData) {
                            self?.productsList?.append(transaction)
                        }
                    })
                    
                    delegate.stopLoadingWithSucces(ProductsDataSource.kTransactionsId)
                case .failure(let error):
                    delegate.stopLoadingWithError(ProductsDataSource.kTransactionsId, error: error)
                    //to get JSON return value
                    if let result = response.result.value {
                        let JSON = result as! NSArray
                        print(JSON)
                        JSON.forEach({ jsonTransaction in
                            if  let transactionData = try? JSONSerialization.data(withJSONObject: jsonTransaction),
                                let transaction = try? JSONDecoder().decode(Transaction.self, from: transactionData) {
                                self?.productsList?.append(transaction)
                                self?.productsSKUDupe?.append(transaction.sku ?? "NO DATA")
                            }
                        })
//                        productsSKUDeDupe = removeDuplicates(array: self?.productsSKUDupe  ?? ["NO DATA"])
                    }
                }
        }
    }
    
    func requestRatios() {
        
    }
    
    func removeDuplicates(array: [String]) -> [String] {
        var encountered = Set<String>()
        var result: [String] = []
        for value in array {
            if encountered.contains(value) {
                // Do not add a duplicate element.
            }
            else {
                // Add value to the set.
                encountered.insert(value)
                // ... Append the value.
                result.append(value)
            }
        }
        return result
    }

    
}
