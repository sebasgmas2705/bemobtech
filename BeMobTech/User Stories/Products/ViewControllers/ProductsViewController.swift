//
//  ProductsViewController.swift
//  BeMobTech
//
//  Created by Sebastian Gelabert on 09/05/2019.
//  Copyright © 2019 Sebastian Gelabert. All rights reserved.
//

import UIKit

class ProductsViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "ProductsCell", bundle: nil), forCellReuseIdentifier: "ProductsCell")
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    

    var productsViewModel = ProductsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productsViewModel.requestTransactions(delegate: self)
    }
    
    override func stopLoadingWithSucces(_ idRequest: String) {
        switch idRequest {
        case ProductsDataSource.kTransactionsId:
            tableView.reloadData()
            
        default:
            return
        }
        
    }
    
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(productsViewModel.numberOfProducts())
        return productsViewModel.numberOfProducts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let nameProduct = productsViewModel.nameOfProduct(inIndex: indexPath.row), let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsCell") as? ProductsCell else {
            return UITableViewCell()
            
        }
        cell.productID.text = nameProduct
        
        return cell
    }
    
}
