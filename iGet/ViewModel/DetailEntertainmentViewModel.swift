//
//  DetailEntertainmentViewModel.swift
//  iGet
//
//  Created by rigo on 12/06/2019.
//  Copyright © 2019 dev. All rights reserved.
//

class DetailEntertainmentViewModel: DetailEntertainmentViewModelType {
    
    private var entertainment: Entertainment
    
    var name: Box<String?> = Box(nil)
    var description: Box<String?> = Box(nil)
    
    init(entertainment: Entertainment) {
        self.entertainment = entertainment
    }
    
    func fetchEntertainment() {
        
        NetworkManager.instance.fetchEntertainmentDetails(forEntertainmentId: entertainment.id) { [weak self] (detailedEntertainment) in
            
            guard let self = self else { return }
            
            if let detailedEntertainment = detailedEntertainment {
                self.name.value = detailedEntertainment.name
                self.description.value = detailedEntertainment.description
            } else {
                self.name.value = nil
                self.description.value = nil
            }
        }
    }
}
