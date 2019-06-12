//
//  EntertainmentViewController.swift
//  iGet
//
//  Created by rigo on 12/06/2019.
//  Copyright © 2019 dev. All rights reserved.
//

import UIKit

class EntertainmentViewController: UITableViewController {
    
    @IBOutlet weak var entertainmentTableView: UITableView!
    
    private var viewModel: EntertainmentViewModelType?
    private var selectedRowIndex: Int?
    
    private enum CellId: String {
        case entertainment = "EntertainmentCell"
    }
    
    private enum SeguieID: String {
        case details = "EntertainmentDetails"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = EntertainmentViewModel()
        
        fetchData()
    }
    
    private func fetchData() {
        viewModel?.fetchEntertainments {
            DispatchQueue.main.async { [weak self] in
                self?.entertainmentTableView.reloadData()
            }
        }
    }
}

// MARK: - Table view data source
extension EntertainmentViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId.entertainment.rawValue, for: indexPath) as? EntertainmentViewCell
        
        guard let entertainmentCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        
        entertainmentCell.viewModel = viewModel.entertainmentCellViewModel(forIndex: indexPath.row)
        
        return entertainmentCell
    }
}

// MARK: - Table view delegate
extension EntertainmentViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRowIndex = indexPath.row
        
        performSegue(withIdentifier: SeguieID.details.rawValue, sender: nil)
    }
}

// MARK: - Navigation
extension EntertainmentViewController {
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identifier = segue.identifier, let viewModel = viewModel,
            let selectedRowIndex = selectedRowIndex else { return }
        
        if identifier == SeguieID.details.rawValue, let dvc = segue.destination as? DetailEntertainmentViewController {
            dvc.viewModel = viewModel.detailEntertainmentViewModel(forIndex: selectedRowIndex)
        }
    }
}

