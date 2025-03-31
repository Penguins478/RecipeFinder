//
//  RecipeService.swift
//  RecipeApp
//
//  Created by Troy Tamura on 3/31/25.
//

import Foundation

class RecipeService {
    static func fetchRandomRecipe(completion: ((Recipe?) -> Void)? = nil) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/random.php"
        
        guard let url = URL(string: urlString) else {
            assertionFailure("Invalid API URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                assertionFailure("Error: \(error!.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  let data = data else {
                assertionFailure("Invalid response or status code")
                return
            }

            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(RecipeAPIResponse.self, from: data)
                let recipe = apiResponse.meals.first
                
                DispatchQueue.main.async {
                    completion?(recipe)
                }
            } catch {
                assertionFailure("Failed to decode JSON: \(error)")
            }
        }
        task.resume()
    }
}
