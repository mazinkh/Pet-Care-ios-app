//
//  PetProfileViewController.swift
//  Pet Care
//

import UIKit

class PetProfileViewController: UIViewController, UIScrollViewDelegate  {
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var petAgeLabel: UILabel!
    @IBOutlet weak var petGenderLabel: UILabel!
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var petInfoTextLabel: UILabel!
    @IBOutlet weak var contactInfoLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPetProfile()
        stylePetImageView()
        loadSavedImage()
        setupScrollView()
        
        if let navigationController = self.navigationController {
               
                navigationController.interactivePopGestureRecognizer?.isEnabled = true
                print("Swipe to go back enabled: \(navigationController.interactivePopGestureRecognizer?.isEnabled ?? false)")
            }
        func loadSavedImage() {
                if let imageData = UserDefaults.standard.object(forKey: "petImage") as? Data,
                   let image = UIImage(data: imageData) {
                    petImageView.image = image
                }
            }
    }
    private func setupScrollView() {
            scrollView.delegate = self
            scrollView.minimumZoomScale = 1.0
            scrollView.maximumZoomScale = 6.0
            scrollView.zoomScale = 1.0
        }

        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return containerView
        }


    private func loadPetProfile() {
    
        let petName = UserDefaults.standard.string(forKey: "petName") ?? "N/A"
        let petAge = UserDefaults.standard.integer(forKey: "petAge")
        let petGenderIndex = UserDefaults.standard.integer(forKey: "petGender")
        let petGender = (petGenderIndex == 0) ? "Male" : "Female"
        let petInfo = UserDefaults.standard.string(forKey: "petInfo") ?? "No additional information available."
        let contactInfo = UserDefaults.standard.string(forKey: "phoneNumber") ?? "No contact info available."

        petNameLabel.text = petName
        petAgeLabel.text = "\(petAge) years old"
        petGenderLabel.text = petGender
        petInfoTextLabel.text = petInfo
        contactInfoLabel.text = "Contact: \(contactInfo)"
        
       
        petImageView.image = UIImage(named: "defaultPetImage") 
    }

    private func stylePetImageView() {
        petImageView.layer.cornerRadius = petImageView.frame.height / 2
        petImageView.clipsToBounds = true
        petImageView.layer.borderWidth = 1
        petImageView.layer.borderColor = UIColor.gray.cgColor
    }

    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        if presentingViewController != nil {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
