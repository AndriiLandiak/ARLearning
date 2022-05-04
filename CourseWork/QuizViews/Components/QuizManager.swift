//
//  QuizManager.swift
//  CourseWork
//
//  Created by Andrew Landiak on 04.05.2022.
//

import SwiftUI

class QuizManager: ObservableObject {
    private(set) var quiz: [QuestionModel.Result] = []
    @Published private(set) var length = 0
    @Published private(set) var index = 0
    @Published private(set) var reachedEnd = false
    @Published private(set) var answerSelected = false
    @Published private(set) var question: AttributedString = ""
    @Published private(set) var answerChoices: [Answer] = []
    @Published private(set) var progress: CGFloat = 0.0
    @Published private(set) var score = 0
    
    init() {
        Task.init {
            await fetchQuiz()
        }
    }
    
    func fetchQuiz() async {
        guard let url = URL(string: "https://gist.githubusercontent.com/AndriiLandiak/8081dcf2142cab62ab47da7068b62466/raw/d702bed6a5eb3ea6916c4b0b05d55e026eb89806/quetions.json") else { fatalError("Missing URL")}
        let urlRequest = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data")}
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(QuestionModel.self, from: data)
            
            DispatchQueue.main.async {
                self.reachedEnd = false
                self.index = 0
                self.progress = 0.0
                self.score = 0
                self.quiz = decodedData.results
                self.length = self.quiz.count
                self.setQuestion()
            }
        } catch {
            print("Error - \(error)")
        }
     }
    
    
    func goToNextQuestion() {
        if index + 1 < length {
            index += 1
            setQuestion()
        } else {
            reachedEnd = true
        }
    }
    
    func setQuestion() {
        answerSelected = false
        progress = CGFloat(Double(index + 1) / Double(length) * 350)
        
        if index < length {
            let currectQuizQuestion = quiz[index]
            question = currectQuizQuestion.formattedQuestion
            answerChoices = currectQuizQuestion.answers
        }
    }
    
    func selectAnswer(answer: Answer) {
        answerSelected = true
        if answer.isCorrect {
            score += 1
        }
    }
}
