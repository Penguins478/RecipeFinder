//
//  ViewController.swift
//  RecipeFinder
//
//  Created by Troy Tamura on 3/27/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeCategoryLabel: UILabel!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var watchVideoButton: UIButton!
    @IBOutlet weak var NewRecipeButton: UIButton!
    
    private var currentRecipe: Recipe?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAndDisplayRecipe()
    }

    private func fetchAndDisplayRecipe() {
        RecipeService.fetchRandomRecipe { [weak self] recipe in
            guard let self = self, let recipe = recipe else { return }
            self.currentRecipe = recipe
            self.updateUI(with: recipe)
        }
    }

    private func updateUI(with recipe: Recipe) {
        print("🍽️ Recipe ingredients: \(recipe.ingredients.joined(separator: "\n"))")
        recipeNameLabel.text = recipe.strMeal
        recipeCategoryLabel.text = "Category: \(recipe.strCategory ?? "N/A")"
//        instructionsTextView.text = recipe.strInstructions ?? "No instructions"
        ingredientsLabel.text = "\(recipe.ingredients.joined(separator: "\n"))"
        
        if let imageURL = recipe.strMealThumb {
            loadImage(from: imageURL, into: mealImageView)
        }

//        watchVideoButton.isHidden = recipe.strYoutube == nil || recipe.strYoutube!.isEmpty
    }

    private func loadImage(from urlString: String, into imageView: UIImageView) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
    }

    @IBAction func didTapNewRecipeButton(_ sender: UIButton) {
        fetchAndDisplayRecipe()
    }

    @IBAction func didTapWatchVideoButton(_ sender: UIButton) {
        guard let urlString = currentRecipe?.strYoutube,
              let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
}

