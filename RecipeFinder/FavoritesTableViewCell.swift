//
//  FavoritesTableViewCell.swift
//  RecipeFinder
//
//  Created by Troy Tamura on 4/9/25.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeCategoryLabel: UILabel!
    @IBOutlet weak var detailsTextView: UITextView!
    
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var watchVideoButton: UIButton!
    @IBOutlet weak var completedRecipeButton: UIButton!
    
    @IBOutlet weak var outerView: UIView!
    
    var onTapFavorite: (() -> Void)?
    var onTapWatchVideo: (() -> Void)?
    var onTapCompleted: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        outerView.layer.cornerRadius = 12
        outerView.layer.borderWidth = 1
        outerView.layer.borderColor = UIColor.lightGray.cgColor
        outerView.clipsToBounds = true
        mealImageView.layer.cornerRadius = 12
        mealImageView.layer.borderWidth = 1
        mealImageView.layer.borderColor = UIColor.lightGray.cgColor
        mealImageView.clipsToBounds = true
    }
    
    func configure(with recipe: Recipe, isFavorite: Bool, isComplete: Bool) {
        recipeNameLabel.text = recipe.strMeal
        recipeCategoryLabel.text = recipe.strCategory
        favoritesButton.tintColor = isFavorite ? .systemRed : .black
        completedRecipeButton.tintColor = isComplete ? .systemBlue : .black
    }
    

    @IBAction func didTapFavorite(_ sender: Any) {
        onTapFavorite?()
    }
    
    
    @IBAction func didTapWatchVideo(_ sender: Any) {
        onTapWatchVideo?()
    }
   
    @IBAction func didTapCompleted(_ sender: Any) {
        onTapCompleted?()
    }
}
