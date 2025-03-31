//
//  ViewController.swift
//  RecipeFinder
//
//  Created by Troy Tamura on 3/27/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")

        RecipeService.fetchRandomRecipe { recipe in
            guard let recipe = recipe else {
                print("No recipe found.")
                return
            }

            print("🍽️ Recipe: \(recipe.strMeal)")
            print("📂 Category: \(recipe.strCategory ?? "Unknown")")
            print("🌍 Area: \(recipe.strArea ?? "Unknown")")
            print("📖 Instructions: \(recipe.strInstructions ?? "None")")

            print("🖼️ Image URL: \(recipe.strMealThumb ?? "No image")")
            print("🎥 YouTube: \(recipe.strYoutube ?? "No video")")

            print("🧂 Ingredients:")
            for item in recipe.ingredients {
                print("• \(item)")
            }
        }
    }
}

