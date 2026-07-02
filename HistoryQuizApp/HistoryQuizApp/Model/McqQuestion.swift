//
//  McqQuestion.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on November 17, 2019

import Foundation


class McqQuestion : NSObject{

    var responseCode : Int!
    var results : [McqQuestionResult]!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        responseCode = dictionary["response_code"] as? Int
        results = [McqQuestionResult]()
        if let resultsArray = dictionary["results"] as? [[String:Any]]{
            for dic in resultsArray{
                let value = McqQuestionResult(fromDictionary: dic)
                results.append(value)
            }
        }
    }
}