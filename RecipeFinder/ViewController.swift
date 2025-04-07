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
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var watchVideoButton: UIButton!
    @IBOutlet weak var completedRecipeButton: UIButton!
    
    private var currentRecipe: Recipe?
    
    private var completedRecipesSet: Set<String> = []
    private var favoriteRecipes: [Recipe] = []
    private let favoritesKey = "favoriteRecipes"

    private func saveFavorites() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(favoriteRecipes) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }

    private func loadFavorites() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: favoritesKey),
           let decoded = try? decoder.decode([Recipe].self, from: data) {
            favoriteRecipes = decoded
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadFavorites()
        fetchAndDisplayRecipe()
        completedRecipeButton.addTarget(self, action: #selector(clickedRecipeCompletionButton), for: .touchUpInside)
        print("Home screen loaded")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if SettingsViewController.completedRecipes == 0 {
            completedRecipesSet.removeAll()
            completedRecipeButton.isSelected = false
            completedRecipeButton.tintColor = .black
        }
        print("Home screen opened")
    }

    private func fetchAndDisplayRecipe() {
        RecipeService.fetchRandomRecipe { [weak self] recipe in
            guard let self = self, let recipe = recipe else { return }
            self.currentRecipe = recipe
            self.updateUI(with: recipe)
        }
    }

    private func updateUI(with recipe: Recipe) {
        let recipeName = recipe.strMeal.capitalized
        recipeNameLabel.text = recipeName
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
        
        if completedRecipeButton.isSelected {
            if completedRecipesSet.contains(recipeName) {
                // leave it
            }else{
                completedRecipeButton.isSelected = false
                completedRecipeButton.tintColor = .black
            }
        }else{
            if completedRecipesSet.contains(recipeName) {
                completedRecipeButton.isSelected = true
                completedRecipeButton.tintColor = .systemBlue
            }else{
                // leave it
            }
        }
        
        if favoriteRecipes.contains(where: { $0.strMeal == recipe.strMeal }) {
            favoritesButton.tintColor = .systemRed
        } else {
            favoritesButton.tintColor = .black
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
    
    
    @IBAction func didTapFavoriteButton(_ sender: Any) {
        guard let recipe = currentRecipe else { return }

        if let index = favoriteRecipes.firstIndex(where: { $0.strMeal == recipe.strMeal }) {
            favoriteRecipes.remove(at: index)
            favoritesButton.tintColor = .black
            print("Removed from favorites: \(recipe.strMeal)")
        } else {
            favoriteRecipes.append(recipe)
            favoritesButton.tintColor = .systemRed
            print("Added to favorites: \(recipe.strMeal)")
        }
        
        saveFavorites()
        printFavoriteRecipes()
    }
    
    func printFavoriteRecipes() {
        if favoriteRecipes.isEmpty {
            print("No favorite recipes yet.")
            return
        }

        print("⭐️ Favorite Recipes:")
        for (index, recipe) in favoriteRecipes.enumerated() {
            print("\(index + 1). \(recipe.strMeal)")
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
    
    @IBAction func clickedRecipeCompletionButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected, let recipeName = currentRecipe?.strMeal {
            SettingsViewController.completedRecipes += 1
            completedRecipesSet.insert(recipeName)
        } else if let recipeName = currentRecipe?.strMeal{
            SettingsViewController.completedRecipes -= 1
            completedRecipesSet.remove(recipeName)
        }
        print("Completed Recipes: \(SettingsViewController.completedRecipes)")
        print("Completed Recipes Set: \(completedRecipesSet)")
        updateButtonAppearance()
    }
    
    func updateButtonAppearance() {
        if completedRecipeButton.isSelected {
            completedRecipeButton.tintColor = .systemBlue
            addConfettiAnimation(from: completedRecipeButton)
        } else {
            completedRecipeButton.tintColor = .black
        }
    }
    
    func addConfettiAnimation(from button: UIButton) {
        let confettiEmitter = CAEmitterLayer()
        
        let buttonCenterInMainView = button.superview?.convert(button.center, to: self.view) ?? button.center
        
        confettiEmitter.emitterPosition = buttonCenterInMainView
        
        confettiEmitter.emitterShape = .circle
        confettiEmitter.emitterSize = CGSize(width: 20, height: 20)
        
        let confettiCell = CAEmitterCell()
        
        confettiCell.contents = UIImage(named: "confetti")?.cgImage
        if confettiCell.contents == nil {
            let confettiImage = UIGraphicsImageRenderer(size: CGSize(width: 3, height: 3)).image { context in
                context.cgContext.setFillColor(UIColor.blue.cgColor)
                context.cgContext.fill(CGRect(x: 0, y: 0, width: 3, height: 3))
            }
            confettiCell.contents = confettiImage.cgImage
        }
        
        confettiCell.birthRate = 3
        confettiCell.lifetime = 2.5
        confettiCell.velocity = 25
        confettiCell.velocityRange = 15
        confettiCell.emissionLongitude = 0
        confettiCell.emissionRange = 2 * .pi
        confettiCell.spin = 4
        confettiCell.spinRange = 2
        confettiCell.scale = 0.3
        confettiCell.scaleRange = 0.1
        confettiCell.color = UIColor.blue.cgColor
        confettiCell.yAcceleration = 100
        confettiCell.alphaSpeed = -0.5
        
        confettiEmitter.emitterCells = [confettiCell]
        
        view.layer.addSublayer(confettiEmitter)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now().advanced(by: .milliseconds(500))) {
            confettiEmitter.birthRate = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now().advanced(by: .milliseconds(Int(confettiCell.lifetime * 500)))) {
            confettiEmitter.removeFromSuperlayer()
        }
    }
    
}

