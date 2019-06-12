//
//  EntertainmentViewCell.swift
//  iGet
//
//  Created by rigo on 12/06/2019.
//  Copyright © 2019 dev. All rights reserved.
//

import UIKit

class EntertainmentViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel?
    
    var viewModel: EntertainmentCellViewModelType? {
        willSet(viewModel) {
            if let viewModel = viewModel {
                nameLabel?.text = viewModel.name
            }
        }
    }
}
