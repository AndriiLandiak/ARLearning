//
//  QuizManager.swift
//  CourseWork
//
//  Created by Andrew Landiak on 04.05.2022.
//

import SwiftUI
import Foundation

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
        let link = await fetchTempLink()
        guard let url = URL(string: "https://gist.githubusercontent.com/AndriiLandiak/8081dcf2142cab62ab47da7068b62466" + link) else { fatalError("Missing URL")}
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
    
    func fetchTempLink() async -> String {
        var link:[String] = []
        guard let tempURL = URL(string: "https://gist.github.com/AndriiLandiak/8081dcf2142cab62ab47da7068b62466") else { fatalError("Missing URL")}
        let tempUrlRequest = URLRequest(url: tempURL)
            do {
                let (data, response) = try await URLSession.shared.data(for: tempUrlRequest)
                guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data")}
                let result = (String(data: data, encoding: .utf8)!)
                link = self.matches(for: "/raw/[a-z0-9]*/[a-z]*.json", in: result)
                DispatchQueue.main.async {}
            } catch {
                print("Error - \(error)")
            }
        return link[0]
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
    
    func matches(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = text as NSString
            let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
