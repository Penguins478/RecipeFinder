//  CompletionViewController.swift
//  RecipeFinder
//
//  Created by Ryan Kwong on 4/9/25.
//

import UIKit

class CompletionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Completion View loaded")
        
        view.backgroundColor = .white

        let congratsLabel = UILabel()
        congratsLabel.text = "Congratulations!"
        congratsLabel.textColor = .black
        congratsLabel.textAlignment = .center
        congratsLabel.font = UIFont.boldSystemFont(ofSize: 28)
        congratsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(congratsLabel)
        
        let completionLabel = UILabel()
        let plural = SettingsViewController.recipeGoal != 1 ? "recipes!" : "recipe!"
        completionLabel.text = "You achieved your goal of completing \(SettingsViewController.recipeGoal) " + plural
        completionLabel.textColor = .black
        completionLabel.textAlignment = .center
        completionLabel.font = UIFont.systemFont(ofSize: 16)
        completionLabel.numberOfLines = 0
        completionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(completionLabel)
        
        let partyImageView = UIImageView()
        partyImageView.image = UIImage(systemName: "party.popper")
        partyImageView.tintColor = .red
        partyImageView.contentMode = .scaleAspectFit
        partyImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(partyImageView)
        
        let questionLabel = UILabel()
        questionLabel.text = "Want to try a harder goal? Go to the \"Settings\" tab to increase difficulty!"
        questionLabel.textColor = .black
        questionLabel.textAlignment = .center
        questionLabel.font = UIFont.systemFont(ofSize: 16)
        questionLabel.numberOfLines = 0
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questionLabel)
        
        // Constraints
        NSLayoutConstraint.activate([
            congratsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            congratsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),

            completionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            completionLabel.topAnchor.constraint(equalTo: congratsLabel.bottomAnchor, constant: 60),
            completionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            completionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            partyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            partyImageView.topAnchor.constraint(equalTo: completionLabel.bottomAnchor, constant: 70),
            partyImageView.widthAnchor.constraint(equalToConstant: 100),
            partyImageView.heightAnchor.constraint(equalToConstant: 100),
            
            questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionLabel.topAnchor.constraint(equalTo: partyImageView.bottomAnchor, constant: 70),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
}
