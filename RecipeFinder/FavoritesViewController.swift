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

            tableView.reloadData()
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return favoriteRecipes.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as! FavoritesTableViewCell

            let recipe = favoriteRecipes[indexPath.row]
            
            if let imageURL = recipe.strMealThumb {
                loadImage(from: imageURL, into: cell.mealImageView)
            }

            cell.recipeNameLabel.text = recipe.strMeal
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
