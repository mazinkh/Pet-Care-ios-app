//
//  VetAppointmentViewController.swift
//  Pet Care
//
//
//

import UIKit

class VetAppointmentViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var appointmentLogLabel: UILabel!
    @IBOutlet weak var logButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        loadSavedAppointments()
        configureUI()
    }

    private func setupTextField() {
        detailTextField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss the keyboard
        return true
    }

    private func configureUI() {
        appointmentLogLabel.numberOfLines = 0
        appointmentLogLabel.lineBreakMode = .byWordWrapping
    }
    
    func showConfirmationAlert(message: String) {
        let alert = UIAlertController(title: "Confirmation", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func logAppointment(_ sender: UIButton) {
        let detail = detailTextField.text ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm a"
        let dateStr = dateFormatter.string(from: datePicker.date)

        // Create the appointment log entry
        let logEntry = "- Date: \(dateStr) Details: \(detail)\n"
        var existingLogs = UserDefaults.standard.string(forKey: "vetAppointments") ?? ""
        existingLogs += logEntry

        // Save the updated logs to UserDefaults
        UserDefaults.standard.set(existingLogs, forKey: "vetAppointments")
        
        // Update the label to show all appointments
        appointmentLogLabel.text = existingLogs
        showConfirmationAlert(message: "Your activity has been logged successfully!")
    }

    private func loadSavedAppointments() {
        if let savedAppointments = UserDefaults.standard.string(forKey: "vetAppointments"), !savedAppointments.isEmpty {
            appointmentLogLabel.text = savedAppointments
        } else {
            appointmentLogLabel.text = "No recent vet appointments found"
        }
    }

    @IBAction func resetAppointmentLog(_ sender: UIButton) {
        appointmentLogLabel.text = "No recent vet appointments found."
        UserDefaults.standard.removeObject(forKey: "vetAppointments")
        UserDefaults.standard.synchronize()
    }
}
