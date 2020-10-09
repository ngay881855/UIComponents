//
//  PatientInformationViewController.swift
//  Patient Information
//
//  Created by Ngay Vong on 9/23/20.
//

import UIKit

class PatientInformationViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var weightLabel: UILabel!
    @IBOutlet private weak var weightSlider: UISlider!
    @IBOutlet private weak var heightTextField: UITextField!
    @IBOutlet private weak var dateOfBirthTextField: UITextField!
    @IBOutlet private weak var streetAddressTextField: UITextField!
    @IBOutlet private weak var zipcodeTextField: UITextField!
    @IBOutlet private weak var stateButton: UIButton!
    @IBOutlet private weak var symptomTextView: UITextView!
    
    // MARK: - Private properties
    private let heightPicker = UIPickerView()
    private let datePicker = UIDatePicker()
    private let heightArray = [ ["Feet", "3", "4", "5", "6", "7"],
                      ["Inches", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"] ]
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        setupUI()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let searchStateViewController = segue.destination as? SearchStateViewController {
            searchStateViewController.delegate = self
        }
    }

    // MARK: - UISetup
    private func setupUI() {
        self.title = "Patient Information Form"
        
        // stateButton
        self.stateButton.layer.borderColor = UIColor.lightGray.cgColor
        self.stateButton.layer.borderWidth = 0.5
        self.stateButton.layer.cornerRadius = 3
        
        // heightTextField
        self.heightTextField.inputView = self.heightPicker
        self.heightPicker.dataSource = self
        self.heightPicker.delegate = self
        
        // dateOfBirthTextField
        let calendar = Calendar(identifier: .gregorian)
        
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
        
        components.year = Constants.maxYear
        components.month = Constants.maxMonth
        let maxDate = calendar.date(byAdding: components, to: currentDate)!
        
        components.year = Constants.minYear
        let minDate = calendar.date(byAdding: components, to: currentDate)!
        
        self.datePicker.minimumDate = minDate
        self.datePicker.maximumDate = maxDate
        
        self.dateOfBirthTextField.inputView = self.datePicker
        self.datePicker.datePickerMode = .date
        self.datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
    }
    
    // MARK: - IBActions
    @IBAction func stateButtonTouchUpInside(_ sender: Any) {
        performSegue(withIdentifier: "SearchStateViewController", sender: nil)
    }
    
    @IBAction private func weightSliderValueChanged(_ sender: Any) {
        let weight: Int = Int(self.weightSlider.value)
        self.weightLabel.text = "\(weight) lbs"
    }
    
    @IBAction private func tapGestureTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    @objc func datePickerValueChanged() {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .day, .year], from: self.datePicker.date)
        
        if let month = components.month,
           let day = components.day,
           let year = components.year {
            self.dateOfBirthTextField.text = "\(month)/\(day)/\(year)"
        }
    }
}

// MARK: - Extensions
extension PatientInformationViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.heightArray[component].count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        self.heightArray.count
    }
}

extension PatientInformationViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.heightArray[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let feet = self.heightArray[0][pickerView.selectedRow(inComponent: 0)]
        let inches = self.heightArray[1][pickerView.selectedRow(inComponent: 1)]
        
        if feet == "Feet" || inches == "Inches" {
            self.heightTextField.text = ""
        } else {
            self.heightTextField.text = feet + "ft " + inches + "in"
        }
    }
}

extension PatientInformationViewController: PassDataDelegate {
    func updateData(with data: Any) {
        if let state = data as? String {
            self.stateButton.setTitle(state, for: .normal)
            self.stateButton.setTitleColor(.black, for: .normal)
        }
    }
    
}
