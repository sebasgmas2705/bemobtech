//
//  NetworkDelegate.swift
//  BeMobTech
//
//  Created by Sebastian Gelabert on 09/05/2019.
//  Copyright © 2019 Sebastian Gelabert. All rights reserved.
//

import Foundation

protocol NetworkDelegate{
    func startLoading(_ idRequest: String)
    func stopLoadingWithSucces(_ idRequest: String)
    func stopLoadingWithError(_ idRequest: String, error: Error)
}
