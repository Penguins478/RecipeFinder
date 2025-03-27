//
//  ViewController.swift
//  RecipeFinder
//
//  Created by Troy Tamura on 2/14/25.
//

import UIKit

class RecipeViewController: UIViewController {
  
  @IBOutlet weak var currentRecipeNumberLabel: UILabel!
  @IBOutlet weak var recipeContainerView: UIView!
  @IBOutlet weak var recipeLabel: UILabel!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var answerButton0: UIButton!
  @IBOutlet weak var answerButton1: UIButton!
  @IBOutlet weak var answerButton2: UIButton!
  @IBOutlet weak var answerButton3: UIButton!
  
  private var recipes = [Recipe]()
  private var currRecipeIndex = 0
  private var numCorrectRecipes = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addGradient()
    recipeContainerView.layer.cornerRadius = 8.0
      RecipeService.fetchRecipes(
          amount: 5,
          difficulty: "easy",
          category: nil,
          type: nil
      ) { [weak self] fetchedRecipes in
          guard let self = self else { return }
          self.recipes = fetchedRecipes
          self.currRecipeIndex = 0
          self.numCorrectRecipes = 0
          self.updateRecipe(withRecipeIndex: self.currRecipeIndex)
      }

  }
  
  private func updateRecipe(withRecipeIndex recipeIndex: Int) {
    currentRecipeNumberLabel.text = "Recipe: \(recipeIndex + 1)/\(recipes.count)"
    let recipe = recipes[recipeIndex]
    recipeLabel.text = recipe.title
    categoryLabel.text = recipe.category
    let answers = ([recipe.correctAnswer] + recipe.incorrectAnswers).shuffled()
      
    if answers.count == 2{
        answerButton0.setTitle(answers[0], for: .normal)
        answerButton1.setTitle(answers[1], for: .normal)
        answerButton0.isHidden = false
        answerButton1.isHidden = false
        answerButton2.isHidden = true
        answerButton3.isHidden = true
    } else {
        if answers.count > 0 {
            answerButton0.setTitle(answers[0], for: .normal)
        }
        if answers.count > 1 {
            answerButton1.setTitle(answers[1], for: .normal)
            answerButton1.isHidden = false
        }
        if answers.count > 2 {
            answerButton2.setTitle(answers[2], for: .normal)
            answerButton2.isHidden = false
        }
        if answers.count > 3 {
            answerButton3.setTitle(answers[3], for: .normal)
            answerButton3.isHidden = false
        }
    }
  }
  
  private func updateToNextRecipe(answer: String) {
    if isCorrectAnswer(answer) {
      numCorrectRecipes += 1
    }
    currRecipeIndex += 1
    guard currRecipeIndex < recipes.count else {
      showFinalScore()
      return
    }
    updateRecipe(withRecipeIndex: currRecipeIndex)
  }
  
  private func isCorrectAnswer(_ answer: String) -> Bool {
    return answer == recipes[currRecipeIndex].correctAnswer
  }
  
  private func showFinalScore() {
    let alertController = UIAlertController(title: "Game over!",
                                            message: "Final score: \(numCorrectRecipes)/\(recipes.count)",
                                            preferredStyle: .alert)
      let resetAction = UIAlertAction(title: "Restart", style: .default) { [unowned self] _ in
          // Fetch new recipes first, without immediately updating the UI
          RecipeService.fetchRecipes( 
              amount: 5,
              difficulty: "easy",
              category: nil,
              type: nil
          ) { [weak self] fetchedRecipes in
              guard let self = self else { return }

              // Only update recipes once new ones are fetched
              if !fetchedRecipes.isEmpty {
                  self.recipes = fetchedRecipes
                  self.currRecipeIndex = 0
                  self.numCorrectRecipes = 0
                  self.updateRecipe(withRecipeIndex: self.currRecipeIndex)
              }
          }
    }
    alertController.addAction(resetAction)
    present(alertController, animated: true, completion: nil)
  }
  
  private func addGradient() {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = view.bounds
    gradientLayer.colors = [UIColor(red: 0.54, green: 0.88, blue: 0.99, alpha: 1.00).cgColor,
                            UIColor(red: 0.51, green: 0.81, blue: 0.97, alpha: 1.00).cgColor]
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
    gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
    view.layer.insertSublayer(gradientLayer, at: 0)
  }
  
  @IBAction func didTapAnswerButton0(_ sender: UIButton) {
    updateToNextRecipe(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton1(_ sender: UIButton) {
    updateToNextRecipe(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton2(_ sender: UIButton) {
    updateToNextRecipe(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton3(_ sender: UIButton) {
    updateToNextRecipe(answer: sender.titleLabel?.text ?? "")
  }
}

