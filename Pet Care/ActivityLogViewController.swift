//
//  ActivityLogViewController.swift
//  Pet Care
//

import UIKit

class ActivityLogViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var activityPicker: UIPickerView!
    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var logLabel: UILabel!
    @IBOutlet weak var logButton: UIButton!
    @IBOutlet weak var resetButton: UIButton! 
    // Data for picker view
    let activities = ["Walk", "Fetch", "Pet Park", "Picnic", "Swimming"]

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView()
        setupTextField()
        loadSavedActivities()
        configureUI()
    }

    private func setupPickerView() {
        activityPicker.dataSource = self
        activityPicker.delegate = self
    }

    private func setupTextField() {
        detailTextField.delegate = self
    }

    private func configureUI() {
        logLabel.numberOfLines = 0 // Enable multi-line support
        logLabel.lineBreakMode = .byWordWrapping // Break lines nicely
    }
    
    func showConfirmationAlert(message: String) {
        let alert = UIAlertController(title: "Confirmation", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    // Picker View DataSource and Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activities.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return activities[row]
    }

    // UITextFieldDelegate to handle return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss the keyboard
        return true
    }

    // Log activity and save to UserDefaults
    @IBAction func logActivity(_ sender: UIButton) {
        let selectedActivity = activities[activityPicker.selectedRow(inComponent: 0)]
        let detail = detailTextField.text ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm a"
        let dateStr = dateFormatter.string(from: datePicker.date)

        // Create the log entry
        let logEntry = "-Date: \(dateStr) Activity: \(selectedActivity) Details: \(detail)\n"

        // Append new log to existing logs
        var existingLogs = UserDefaults.standard.string(forKey: "activityLogs") ?? ""
        existingLogs += logEntry

        // Save the updated logs to UserDefaults
        UserDefaults.standard.set(existingLogs, forKey: "activityLogs")
        
        // Update the label to show all logs
        logLabel.text = existingLogs
        showConfirmationAlert(message: "Your activity has been logged successfully!")
    }

    // Load saved activities from UserDefaults
    private func loadSavedActivities() {
        if let savedActivities = UserDefaults.standard.string(forKey: "activityLogs"), !savedActivities.isEmpty {
            logLabel.text = savedActivities
        } else {
            logLabel.text = "No recent activities found."
        }
    }

    // Reset activity logs
    @IBAction func resetLog(_ sender: UIButton) {
        logLabel.text = "" 
        logLabel.text = "No recent activities found."
        UserDefaults.standard.removeObject(forKey: "activityLogs")
        UserDefaults.standard.synchronize()
    }
}
