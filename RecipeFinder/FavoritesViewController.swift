//
//  FavoritesViewController.swift
//  RecipeFinder
//
//  Created by Troy Tamura on 4/9/25.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var favoriteRecipes: [Recipe] = []
    var completedRecipes: [Recipe] = []
    
    static var toRemoveFavorites: [Recipe] = []
    static var toRemoveCompleted: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.rowHeight = 600
        tableView.estimatedRowHeight = 600
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    

        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "favoriteRecipes"),
           let decoded = try? decoder.decode([Recipe].self, from: data) {
            favoriteRecipes = decoded
        } else {
            favoriteRecipes = []
        }
        if let completed = UserDefaults.standard.data(forKey: "completedRecipes"),
           let decoded = try? decoder.decode([Recipe].self, from: completed) {
            completedRecipes = decoded
        } else {
            completedRecipes = []
        }

        tableView.reloadData()
        print("Favorites Screen loaded")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRecipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as! FavoritesTableViewCell

        let recipe = favoriteRecipes[indexPath.row]
        
        let isCompleted = completedRecipes.contains { $0.strMeal == recipe.strMeal }
        cell.configure(with: recipe, isFavorite: true, isComplete: isCompleted)
        
        if let imageURL = recipe.strMealThumb {
            loadImage(from: imageURL, into: cell.mealImageView)
        }

        cell.recipeNameLabel.text = recipe.strMeal.capitalized
        cell.recipeCategoryLabel.text = recipe.strCategory
        
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

        cell.detailsTextView.text = detailsString
        
        cell.onTapFavorite = { [weak self] in
            guard let self = self else { return }
            if let index = self.favoriteRecipes.firstIndex(where: { $0.strMeal == recipe.strMeal }) {
                self.favoriteRecipes.remove(at: index)
                FavoritesViewController.toRemoveFavorites.append(recipe)
            } else {
                self.favoriteRecipes.append(recipe)
                if let removeIndex = FavoritesViewController.toRemoveFavorites.firstIndex(where: { $0.strMeal == recipe.strMeal }) {
                    FavoritesViewController.toRemoveFavorites.remove(at: removeIndex)
                }
            }

            if let encoded = try? JSONEncoder().encode(self.favoriteRecipes) {
                UserDefaults.standard.set(encoded, forKey: "favoriteRecipes")
            }

            self.tableView.reloadData()
        }

        cell.onTapWatchVideo = {
            guard let urlString = recipe.strYoutube,
                  let url = URL(string: urlString) else { return }
            UIApplication.shared.open(url)
        }
        
        cell.onTapCompleted = { [weak self] in
            guard let self = self else { return }
            if let index = self.completedRecipes.firstIndex(where: { $0.strMeal == recipe.strMeal }) {
                self.completedRecipes.remove(at: index)
                if !FavoritesViewController.toRemoveCompleted.contains(where: { $0.strMeal == recipe.strMeal }) {
                    FavoritesViewController.toRemoveCompleted.append(recipe)
                    SettingsViewController.completedRecipes -= 1
                }
            } else {
                self.completedRecipes.append(recipe)
                if let removeIndex = FavoritesViewController.toRemoveCompleted.firstIndex(where: { $0.strMeal == recipe.strMeal }) {
                    FavoritesViewController.toRemoveCompleted.remove(at: removeIndex)
                }
                SettingsViewController.completedRecipes += 1
            }
            if let encoded = try? JSONEncoder().encode(self.completedRecipes) {
                UserDefaults.standard.set(encoded, forKey: "completedRecipes")
            }

            self.tableView.reloadData()
        }
        
        return cell
    }

//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
//            let selectedRecipe = favoriteRecipes[selectedIndexPath.row]
//
//            guard let detailVC = segue.destination as? RecipeDetailViewController else { return }
//            detailVC.recipe = selectedRecipe
//        }

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
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
