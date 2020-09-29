//
//  PatientInformationViewController.swift
//  UI Component
//
//  Created by Ngay Vong on 9/23/20.
//

import UIKit

class PatientInformationViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var weightLabel: UILabel!
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        setupUI()
    }

    // MARK: - UISetup
    private func setupUI() {
        self.title = "Patient Information Form"
    }
}

