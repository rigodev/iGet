//
//  EntertainmentViewModel.swift
//  iGet
//
//  Created by rigo on 12/06/2019.
//  Copyright © 2019 dev. All rights reserved.
//

class EntertainmentViewModel: EntertainmentViewModelType {
    
    private var entertainments = [Entertainment]()
    
    func fetchEntertainments(completion: @escaping () -> Void) {
        
        entertainments.removeAll()
        
        NetworkManager.instance.fetchEntertainmentList { [weak self] (result) in
            guard let self = self else { return }
            
            if let result = result {
                self.entertainments = result
            }
            
            completion()
        }
    }
    
    func numberOfRows() -> Int {
        
        return entertainments.count
    }
    
    func entertainmentCellViewModel(forIndex index: Int) -> EntertainmentCellViewModelType? {
        guard index < entertainments.count  else { return nil }
        
        return EntertainmentCellViewModel(entertainment: entertainments[index])
    }
    
    func detailEntertainmentViewModel(forIndex index: Int) -> DetailEntertainmentViewModelType? {
        guard index < entertainments.count  else { return nil }
        
        return DetailEntertainmentViewModel(entertainment: entertainments[index])
    }
    

}
