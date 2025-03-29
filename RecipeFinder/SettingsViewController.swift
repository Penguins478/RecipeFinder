//
//  SettingsViewController.swift
//  RecipeFinder
//
//  Created by Ryan Kwong on 3/28/25.
//

import UIKit

class SettingsViewController: UIViewController {

    
    var randomized = true
    var favorited = false
    
    @IBOutlet weak var randomButton: UIButton!
    
    @IBOutlet weak var favoritedButton: UIButton!
    
    @IBAction func randomizedButtonClicked(_ sender: UIButton) {
        // idempotent
        randomized = true
        favorited = false
        print("bruh1")
    }
    
    @IBAction func favoritedButtonClicked(_ sender: UIButton) {
        randomized = false
        favorited = true
        print("bruh2")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SettingsViewController loaded")
        // Do any additional setup after loading the view.
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
