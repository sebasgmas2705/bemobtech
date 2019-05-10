//
//  ProductsViewModel.swift
//  BeMobTech
//
//  Created by Sebastian Gelabert on 09/05/2019.
//  Copyright © 2019 Sebastian Gelabert. All rights reserved.
//

import Foundation

class ProductsViewModel{
    
    let dataSource = ProductsDataSource()
    
    func numberOfProducts() -> Int{
        return dataSource.productsList?.count ?? 0
    }
    
    func requestTransactions(delegate: NetworkDelegate){
        dataSource.requestTransactions(delegate: delegate)
    }
    
//    func nameOfProduct(inIndex index: Int) -> Transaction? {
//        guard let product = dataSource.productsList?[index] else {
//            return Transaction()
//        }
//        return product
//    }
    
    func nameOfProduct(inIndex index: Int) -> String? {
        guard let product = dataSource.productsSKUDupe?[index] else {
            return ""
        }
        return product
    }
    
}
