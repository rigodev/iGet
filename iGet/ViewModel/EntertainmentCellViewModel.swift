//
//  EntertainmentCellViewModel.swift
//  iGet
//
//  Created by rigo on 12/06/2019.
//  Copyright © 2019 dev. All rights reserved.
//

class EntertainmentCellViewModel: EntertainmentCellViewModelType {
    
    private var entertainment: Entertainment
    
    var name: String {
        return entertainment.name
    }
    
    init(entertainment: Entertainment) {
        self.entertainment = entertainment
    }
}
