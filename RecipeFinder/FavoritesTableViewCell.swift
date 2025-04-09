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
    

//        override func setSelected(_ selected: Bool, animated: Bool) {
//            super.setSelected(selected, animated: animated)
//        }

}
