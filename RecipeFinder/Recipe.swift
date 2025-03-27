//
//  Recipe.swift
//  RecipeFinder
//
//  Created by Troy Tamura on 2/14/25.
//

import Foundation

struct RecipeAPIResponse: Decodable {
  let results: [Recipe]
    
  private enum CodingKeys: String, CodingKey {
      case results
  }
}

struct Recipe: Decodable {
  let category: String
  let question: String
  let correctAnswer: String
  let incorrectAnswers: [String]
    
  enum CodingKeys: String, CodingKey {
    case question
    case correctAnswer = "correct_answer"
    case incorrectAnswers = "incorrect_answers"
    case category
  }
}
