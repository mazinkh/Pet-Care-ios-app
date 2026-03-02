//
//  NutritionViewController.swift
//  Pet Care
//
//

import UIKit

class NutritionViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    // MARK: Outlets
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var mealTypePicker: UIPickerView!
    @IBOutlet weak var mealDescriptionTextField: UITextField!
    @IBOutlet weak var mealInfoLabel: UILabel!
    @IBOutlet weak var saveMealButton: UIButton!

    // MARK: Data
    let mealTypes = ["Treat", "Breakfast", "Lunch", "Dinner"]

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView()
        setupTextField()
        loadSavedMealPlans()
        
        mealInfoLabel.numberOfLines = 0  // Allows the label to expand vertically as needed
        mealInfoLabel.lineBreakMode = .byWordWrapping  // Ensures that words are not split at the end of a line
    }

    // MARK: Setup
    private func setupPickerView() {
        mealTypePicker.dataSource = self
        mealTypePicker.delegate = self
    }

    private func setupTextField() {
        mealDescriptionTextField.delegate = self
    }

    // MARK: UIPickerView DataSource and Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mealTypes.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mealTypes[row]
    }
    
    func showConfirmationAlert(message: String) {
        let alert = UIAlertController(title: "Confirmation", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss the keyboard
        return true
    }

    // MARK: Actions
    @IBAction func saveMealPlan(_ sender: UIButton) {
        // Formatting the date and time
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd : hh:mm a"
        let dateString = dateFormatter.string(from: datePicker.date)

        // Retrieving the selected meal type
        let selectedMealType = mealTypes[mealTypePicker.selectedRow(inComponent: 0)]

        // Retrieving the meal description
        let mealDescription = mealDescriptionTextField.text ?? "No description provided"

        // Concatenating all details into the desired format
        let newReminderDetails = "-Date: \(dateString) Meal Type: \(selectedMealType) Details: \(mealDescription)\n" // New line for readability

        // Retrieve existing reminders and append the new one
        var existingReminders = UserDefaults.standard.string(forKey: "mealPlans") ?? ""
        print("Existing Reminders Before Append: \(existingReminders)") // Debugging
        existingReminders += newReminderDetails
        print("New Reminder Details: \(newReminderDetails)") // Debugging
        print("All Reminders After Append: \(existingReminders)") // Debugging

        // Save the updated reminders to UserDefaults
        UserDefaults.standard.set(existingReminders, forKey: "mealPlans")
        UserDefaults.standard.synchronize()

        // Update the label to show all reminders
        mealInfoLabel.text = existingReminders
        loadSavedMealPlans() // Reload data to check
        showConfirmationAlert(message: "Your meal plan has been logged successfully!")
    }
    // Load all saved meal plans from UserDefaults
    private func loadSavedMealPlans() {
        if let savedMealPlans = UserDefaults.standard.string(forKey: "mealPlans") , !savedMealPlans.isEmpty {
            mealInfoLabel.text = savedMealPlans
        } else {
            mealInfoLabel.text = "No meal plans found."
        }
        
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
 
        mealDescriptionTextField.text = ""

        mealInfoLabel.text = "No meal plans found."

      
        UserDefaults.standard.removeObject(forKey: "mealPlans")
        UserDefaults.standard.synchronize() 
    }
    
  
}
