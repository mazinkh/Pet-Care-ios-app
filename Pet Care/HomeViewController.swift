//
//  HomeViewController.swift
//  Pet Care
//
//
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tipsTextView: UITextView!
    @IBOutlet weak var newsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextViews()
    }
    
    func configureTextViews() {
        setupTextView(tipsTextView, withContent: [
            ("General Dog Care", "https://www.aspca.org/pet-care/dog-care/general-dog-care", "https://www.aspca.org"),
            ("Garden Plant Toxicity in Cats", "https://www.petmd.com/cat/poisoning/garden-plant-toxicity-in-cats", "https://www.petmd.com"),
            ("First aid tips for pet owners", "https://www.avma.org/resources-tools/pet-owners/emergencycare/first-aid-tips-pet-owners", "https://www.avma.org"),
            ("How to Show Your Cat You Love Them", "https://bestfriends.org/pet-care-resources/how-show-your-cat-you-love-them", "https://bestfriends.org")
        ])
        
        setupTextView(newsTextView, withContent: [
            ("Owners warned over fire risk posed by pets", "https://www.bbc.com/news/articles/cp8v4362eg8o", "https://www.bbc.com"),
            ("Beluga calf at Shedd Aquarium officially has a name", "https://www.fox32chicago.com/news/beluga-calf-shedd-aquarium-officially-has-name", "https://www.fox32chicago.com"),
            ("Playing With Dogs Relieves Stress In Humans And Canines Alike", "https://www.usnews.com/news/health-news/articles/2025-03-14/playing-with-dogs-relieves-stress-in-humans-and-canines-alike", "https://www.usnews.com"),
            ("Raw Pet Food Recalled After Bird Flu Sickens, Then Kills Two Cats", "https://www.usnews.com/news/health-news/articles/2025-02-20/raw-pet-food-recalled-after-bird-flu-sickens-then-kills-two-cats", "https://www.usnews.com")
        ])
    }
    
    func setupTextView(_ textView: UITextView, withContent content: [(title: String, url: String, displayUrl: String)]) {
        textView.isEditable = false
        textView.dataDetectorTypes = .link
        let attributedText = NSMutableAttributedString()
        
        content.forEach { item in
            let titleAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 18),
                .link: URL(string: item.url)!,
                .foregroundColor: UIColor.blue
            ]
            let urlAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor.gray
            ]
            
            let titleString = NSMutableAttributedString(string: "\(item.title)\n", attributes: titleAttributes)
            let urlString = NSAttributedString(string: "\(item.displayUrl)\n\n", attributes: urlAttributes)
            
            attributedText.append(titleString)
            attributedText.append(urlString)
        }
        
        textView.attributedText = attributedText
    }
}
