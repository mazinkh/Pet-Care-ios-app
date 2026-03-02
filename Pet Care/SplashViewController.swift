//
//  SplashViewController.swift
//  Pet Care
//
//  
//
import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let splashView = CustomSplashView()
        splashView.frame = self.view.bounds
        self.view.addSubview(splashView)
        
        // Set a background color that matches your splash design
        self.view.backgroundColor = .white
        
        // Move to the main interface after a set delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // 3 seconds delay
            self.transitionToMainInterface()
        }
    }

    private func transitionToMainInterface() {
        if let windowScene = view.window?.windowScene {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController {
                tabBarController.selectedIndex = 2

                if let window = windowScene.windows.first {
                    UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                        window.rootViewController = tabBarController
                    }, completion: nil)
                }
            }
        }
    }
}
