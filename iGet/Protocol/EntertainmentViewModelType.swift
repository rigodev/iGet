//
//  EntertainmentViewModelType.swift
//  iGet
//
//  Created by rigo on 12/06/2019.
//  Copyright © 2019 dev. All rights reserved.
//

protocol EntertainmentViewModelType {
   
    func fetchEntertainments(completion: @escaping () -> Void)
    func numberOfRows() -> Int
    func entertainmentCellViewModel(forIndex index: Int) -> EntertainmentCellViewModelType?
    func detailEntertainmentViewModel(forIndex index: Int) -> DetailEntertainmentViewModelType?
}
