//
//  SettingsViewController.swift
//  RecipeFinder
//
//  Created by Ryan Kwong on 3/28/25.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var randomButton: UIButton!
    
    @IBOutlet weak var goalStepper: UIStepper!
    
    @IBOutlet weak var goalCounter: UILabel!
    
    @IBOutlet weak var completedText: UILabel!
    
    @IBOutlet weak var resetButton: UIButton!
    
    static var recipeGoal: Int = {
        let savedGoal = UserDefaults.standard.integer(forKey: "recipeGoal")
        return savedGoal != 0 ? savedGoal : 5 // default to 5 if no value is saved
    }()
    
    static var completedRecipes = 0
    
    static var randomized: Bool = {
        if UserDefaults.standard.object(forKey: "randomizedSetting") == nil {
            return true // default is randomized
        } else {
            return UserDefaults.standard.bool(forKey: "randomizedSetting")
        }
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SettingsViewController loaded")
        setupDropdownMenu()
        randomButton.layer.cornerRadius = 10
        randomButton.clipsToBounds = true
        resetButton.layer.cornerRadius = 10
        resetButton.clipsToBounds = true
        goalStepper.minimumValue = 0
        goalStepper.maximumValue = 1000
        goalStepper.stepValue = 1
        goalStepper.value = Double(SettingsViewController.recipeGoal)
        goalCounter.text = "\(Int(goalStepper.value))"
        
        updateCompletedLabel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateCompletedLabel()
        print("Settings screen opened")
    }
    
    func updateCompletedLabel() {
        completedText.text = "Completed \(SettingsViewController.completedRecipes) unique recipes"
    }
    
    func setupDropdownMenu() {
        updateMenu()
    }

    func updateMenu() {
        let option1 = UIAction(title: "Randomized", state: SettingsViewController.randomized ? .on : .off, handler: { _ in
            SettingsViewController.randomized = true
            UserDefaults.standard.set(true, forKey: "randomizedSetting")
            self.updateMenu() // checkmark
            print("Option 1 selected, randomized = \(SettingsViewController.randomized)")
            self.updateCompletedLabel()
        })
        
        let option2 = UIAction(title: "Favorites", state: !SettingsViewController.randomized ? .on : .off, handler: { _ in
            SettingsViewController.randomized = false
            UserDefaults.standard.set(false, forKey: "randomizedSetting")
            self.updateMenu() // checkmark
            print("Option 2 selected, randomized = \(SettingsViewController.randomized)")
            self.updateCompletedLabel()
        })
        
        let menu = UIMenu(title: "Choose an option", options: .displayInline, children: [option1, option2])
        
        randomButton.menu = menu
        randomButton.showsMenuAsPrimaryAction = true // opens menu on tap
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        goalCounter.text = "\(Int(sender.value))"
        SettingsViewController.recipeGoal = Int(sender.value)
        UserDefaults.standard.set(SettingsViewController.recipeGoal, forKey: "recipeGoal")
        //print(SettingsViewController.recipeGoal)
    }
    
    @IBAction func resetRecipeCounter(_ sender: UIButton) {
        showResetConfirmation()
    }
    
    func showResetConfirmation() {
        let alert = UIAlertController(title: "Reset Goal Counter",
                                      message: "Are you sure you want to reset the recipe goal counter?",
                                      preferredStyle: .alert)

        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            SettingsViewController.completedRecipes = 0
            self.updateCompletedLabel()
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)

        alert.addAction(yesAction)
        alert.addAction(noAction)

        self.present(alert, animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
