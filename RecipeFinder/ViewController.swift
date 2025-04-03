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
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var NewRecipeButton: UIButton!
    @IBOutlet weak var watchVideoButton: UIButton!
    
    
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
        recipeNameLabel.text = recipe.strMeal
        recipeCategoryLabel.text = "Category: \(recipe.strCategory ?? "N/A")"
        
        let bulletIngredients = recipe.ingredients.map { "• \($0)" }.joined(separator: "\n")

        let formattedInstructions = recipe.strInstructions?
            .replacingOccurrences(of: "\r\n", with: "\n")
            .components(separatedBy: "\n")
            .filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
            .enumerated()
            .map { "\($0 + 1). \($1)" }
            .joined(separator: "\n") ?? "No instructions available."

        var detailsString = "Ingredients:\n\(bulletIngredients)\n\n"
        detailsString += "Instructions:\n\(formattedInstructions)"

        detailsTextView.text = detailsString
        detailsTextView.setContentOffset(.zero, animated: false)

        if let imageURL = recipe.strMealThumb {
            loadImage(from: imageURL, into: mealImageView)
        }

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

