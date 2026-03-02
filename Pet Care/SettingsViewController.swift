//
//  SettingsViewController.swift
//  Pet Care
//
//

import UIKit

class SettingsViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var petNameTextField: UITextField!
    @IBOutlet weak var petAgeLabel: UILabel!
    @IBOutlet weak var petAgeStepper: UIStepper!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var petInfoTextView: UITextView!
    @IBOutlet weak var petImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        loadSettings()
        if let navigationController = self.navigationController {
                
                navigationController.interactivePopGestureRecognizer?.isEnabled = true
                print("Swipe to go back enabled: \(navigationController.interactivePopGestureRecognizer?.isEnabled ?? false)")
            }
    }

    func setupDelegates() {
            petNameTextField.delegate = self
            phoneNumberTextField.delegate = self
            petInfoTextView.delegate = self
        }
    
    // MARK: - Image Handling
       @IBAction func changeImageButtonTapped(_ sender: UIButton) {
           let imagePicker = UIImagePickerController()
           imagePicker.delegate = self
           imagePicker.allowsEditing = true
           imagePicker.sourceType = .photoLibrary

           present(imagePicker, animated: true)
       }

       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           if let editedImage = info[.editedImage] as? UIImage {
               petImageView.image = editedImage
               saveImage(image: editedImage)
           }
           picker.dismiss(animated: true)
       }

       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true)
       }

       func saveImage(image: UIImage) {
           if let imageData = image.jpegData(compressionQuality: 0.5) {
               UserDefaults.standard.set(imageData, forKey: "petImage")
           }
       }

       func loadSavedImage() {
           if let imageData = UserDefaults.standard.object(forKey: "petImage") as? Data,
              let image = UIImage(data: imageData) {
               petImageView.image = image
           }
       }

        // MARK: - UITextFieldDelegate
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder() // Dismisses the keyboard
            return true
        }

        // MARK: - UITextViewDelegate
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if text == "\n" { // Checks if the 'return' key was pressed
                textView.resignFirstResponder() // Dismiss the keyboard
                return false
            }
            return true
        }
    
    @IBAction func notificationSwitchChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "notificationsEnabled")
    }

    @IBAction func petNameChanged(_ sender: UITextField) {
        UserDefaults.standard.set(sender.text, forKey: "petName")
    }

    @IBAction func petAgeStepperChanged(_ sender: UIStepper) {
        let age = Int(sender.value)
        petAgeLabel.text = "\(age)"
        UserDefaults.standard.set(age, forKey: "petAge")
    }

    @IBAction func genderSegmentChanged(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(sender.selectedSegmentIndex, forKey: "petGender")
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        UserDefaults.standard.set(phoneNumberTextField.text, forKey: "phoneNumber")
        UserDefaults.standard.set(petInfoTextView.text, forKey: "petInfo")
        
        // Validate phone number
        guard let phoneNumber = phoneNumberTextField.text, phoneNumber.count == 10 else {
            showAlert(message: "Please enter a valid 10-digit phone number.")
            return
        }
        
        // Confirm settings saved
        showAlert(message: "Settings Saved Successfully!")
    }
    
   @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
            // This checks if the view controller was presented modally
            if presentingViewController != nil {
                dismiss(animated: true, completion: nil)
            } else {
                // If it was pushed onto a navigation stack
                navigationController?.popViewController(animated: true)
            }
        }
 
    private func loadSettings() {
        notificationSwitch.isOn = UserDefaults.standard.bool(forKey: "notificationsEnabled")
        petNameTextField.text = UserDefaults.standard.string(forKey: "petName")
        let age = UserDefaults.standard.integer(forKey: "petAge")
        petAgeLabel.text = "\(age)"
        petAgeStepper.value = Double(age)
        genderSegmentedControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "petGender")
        phoneNumberTextField.text = UserDefaults.standard.string(forKey: "phoneNumber")
        petInfoTextView.text = UserDefaults.standard.string(forKey: "petInfo")
        loadSavedImage() 
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
