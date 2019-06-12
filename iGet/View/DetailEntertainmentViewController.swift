//
//  DetailEntertainmentViewController.swift
//  iGet
//
//  Created by rigo on 12/06/2019.
//  Copyright © 2019 dev. All rights reserved.
//

import UIKit

class DetailEntertainmentViewController: UIViewController {
    
    @IBOutlet weak var nameTextView: UITextView?
    @IBOutlet weak var descriptionTextView: UITextView?
    
    var viewModel: DetailEntertainmentViewModelType? {
        willSet(viewModel) {
            if let viewModel = viewModel {
                
                viewModel.name.bind { [weak self] (value) in
                    DispatchQueue.main.async {
                        self?.nameTextView?.text = value ?? ""
                    }
                }
                
                viewModel.description.bind { [weak self] (value) in
                    DispatchQueue.main.async {
                        self?.descriptionTextView?.text = value ?? ""
                    }
                }
                
                viewModel.fetchEntertainment()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
