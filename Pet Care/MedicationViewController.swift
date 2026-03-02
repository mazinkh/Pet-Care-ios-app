//
//  MedicationViewController.swift
//  Pet Care
//
//

import UIKit

class MedicationViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var medicationDetailTextField: UITextField!
    @IBOutlet weak var medicationLogLabel: UILabel!
    @IBOutlet weak var logButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        loadSavedMedications()
        configureUI()
    }

    private func setupTextField() {
        medicationDetailTextField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss the keyboard
        return true
    }

    private func configureUI() {
        medicationLogLabel.numberOfLines = 0
        medicationLogLabel.lineBreakMode = .byWordWrapping
    }

    func showConfirmationAlert(message: String) {
        let alert = UIAlertController(title: "Confirmation", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func logMedication(_ sender: UIButton) {
        let detail = medicationDetailTextField.text ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm a"
        let dateStr = dateFormatter.string(from: datePicker.date)

        // Create the log entry
        let logEntry = "- Date: \(dateStr) Details: \(detail)\n"
        var existingLogs = UserDefaults.standard.string(forKey: "medicationLogs") ?? ""
        existingLogs += logEntry

        // Save the updated logs to UserDefaults
        UserDefaults.standard.set(existingLogs, forKey: "medicationLogs")
        
        // Update the label to show all logs
        medicationLogLabel.text = existingLogs
        
        showConfirmationAlert(message: "Your medication reminder has been set successfully!")
    }

    private func loadSavedMedications() {
        if let savedMedications = UserDefaults.standard.string(forKey: "medicationLogs"), !savedMedications.isEmpty {
            medicationLogLabel.text = savedMedications
        } else {
            medicationLogLabel.text = "No recent medication logs found"
        }
    }

    @IBAction func resetMedicationLog(_ sender: UIButton) {
        medicationLogLabel.text = "No recent medication logs found."
        UserDefaults.standard.removeObject(forKey: "medicationLogs")
        UserDefaults.standard.synchronize() 
    }
}
