//
//  SearchStateViewController.swift
//  Patient Information
//
//  Created by Ngay Vong on 10/9/20.
//

import UIKit

protocol PassDataDelegate: class {
    func updateData(with data: Any)
}

class SearchStateViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Public properties
    weak var delegate: PassDataDelegate?
    
    // MARK: - Private properties
    private let stateList = ["Alabama", "Alaska", "Arizona", "Arkansas", "California",
                             "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii",
                             "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana",
                             "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi",
                             "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey",
                             "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio",
                             "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina",
                             "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia",
                             "Washington", "West Virginia", "Wisconsin", "Wyoming"]
    private var dataSource: [String] = []
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataSource = stateList
    }
    // MARK: - Actions
    @IBAction func cancelBarButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Extensions
// MARK: UITableViewDelegate
extension SearchStateViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedState: String = dataSource[indexPath.row]
        delegate?.updateData(with: selectedState)
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: UITableViewDataSource
extension SearchStateViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StateTableViewCell", for: indexPath) as? StateTableViewCell else {
            fatalError()
        }
        cell.stateLabel.text = self.dataSource[indexPath.row]
        
        return cell
    }
}

// MARK: UISearchBarDelegate
extension SearchStateViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            self.dataSource = self.stateList.filter({ str -> Bool in
                str.uppercased().contains(searchText.uppercased())
            })
        } else {
            self.dataSource = self.stateList
        }
        
        self.tableView.reloadData()
    }
}
