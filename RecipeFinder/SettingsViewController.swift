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
    
    static var recipeGoal = 5
    static var completedRecipes = 0
    
    var randomized = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SettingsViewController loaded")
        setupDropdownMenu()
        
        goalStepper.minimumValue = 0
        goalStepper.maximumValue = 1000
        goalStepper.stepValue = 1
        goalStepper.value = 5
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
        let option1 = UIAction(title: "Randomized", state: randomized ? .on : .off, handler: { _ in
            self.randomized = true
            self.updateMenu() // checkmark
            print("Option 1 selected, randomized = \(self.randomized)")
            //SettingsViewController.completedRecipes += 1 // just example
            self.updateCompletedLabel()
        })
        
        let option2 = UIAction(title: "Favorites", state: !randomized ? .on : .off, handler: { _ in
            self.randomized = false
            self.updateMenu() // checkmark
            print("Option 2 selected, randomized = \(self.randomized)")
            self.updateCompletedLabel()
        })
        
        let menu = UIMenu(title: "Choose an option", options: .displayInline, children: [option1, option2])
        
        randomButton.menu = menu
        randomButton.showsMenuAsPrimaryAction = true // opens menu on tap
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        goalCounter.text = "\(Int(sender.value))"
        SettingsViewController.recipeGoal = Int(sender.value)
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
