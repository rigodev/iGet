//
//  DetailEntertainmentViewModelType.swift
//  iGet
//
//  Created by rigo on 12/06/2019.
//  Copyright © 2019 dev. All rights reserved.
//

protocol DetailEntertainmentViewModelType {
    
    var name: Box<String?> { get }
    var description: Box<String?> { get }
    
    func fetchEntertainment()
}
