//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Troy Tamura on 2/14/25.
//
import Foundation

class TriviaService {
    static func fetchTriviaQuestions(
        amount: Int,
        difficulty: String?,
        category: Int?,
        type: String?,
        completion: (([TriviaQuestion]) -> Void)? = nil
    ) {
        // Construct the API URL with parameters
        var urlString = "https://opentdb.com/api.php?amount=\(amount)"

        if let category = category {
            urlString += "&category=\(category)"
        }
        if let difficulty = difficulty {
            urlString += "&difficulty=\(difficulty)"
        }
        if let type = type {
            urlString += "&type=\(type)"
        }
        
        guard let url = URL(string: urlString) else {
            assertionFailure("Invalid API URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
              // this closure is fired when the response is received
              guard error == nil else {
                assertionFailure("Error: \(error!.localizedDescription)")
                return
              }
              guard let httpResponse = response as? HTTPURLResponse else {
                assertionFailure("Invalid response")
                return
              }
              guard let data = data, httpResponse.statusCode == 200 else {
                assertionFailure("Invalid response status code: \(httpResponse.statusCode)")
                return
              }

            let decoder = JSONDecoder()
            let response = try! decoder.decode(TriviaAPIResponse.self, from: data)
            
            DispatchQueue.main.async {
                completion?(response.results)
            }
            
        }
        task.resume()
    }
}
