//
//  SettingsViewController.swift
//  RecipeFinder
//
//  Created by Ryan Kwong on 3/28/25.
//

import UIKit

class SettingsViewController: UIViewController {

    
    var randomized = true
    
    @IBOutlet weak var randomButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SettingsViewController loaded")
        setupDropdownMenu()
        // Do any additional setup after loading the view.
    }
    
    func setupDropdownMenu() {
        updateMenu()
    }

    func updateMenu() {
        let option1 = UIAction(title: "Randomized", state: randomized ? .on : .off, handler: { _ in
            self.randomized = true
            self.updateMenu() // checkmark
            print("Option 1 selected, randomized = \(self.randomized)")
        })
        
        let option2 = UIAction(title: "Favorites", state: !randomized ? .on : .off, handler: { _ in
            self.randomized = false
            self.updateMenu() // checkmark
            print("Option 2 selected, randomized = \(self.randomized)")
        })
        
        let menu = UIMenu(title: "Choose an option", options: .displayInline, children: [option1, option2])
        
        randomButton.menu = menu
        randomButton.showsMenuAsPrimaryAction = true // opens menu on tap
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
