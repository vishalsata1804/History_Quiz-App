//
//  McqQuestionResult.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on November 17, 2019

import Foundation


class McqQuestionResult : NSObject{

    var category : String!
    var correctAnswer : String!
    var difficulty : String!
    var incorrectAnswers : [String]!
    var question : String!
    var type : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        category = dictionary["category"] as? String
        correctAnswer = dictionary["correct_answer"] as? String
        difficulty = dictionary["difficulty"] as? String
        question = dictionary["question"] as? String
        type = dictionary["type"] as? String
        incorrectAnswers = dictionary["incorrect_answers"] as? [String]
    }
}
