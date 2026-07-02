//
//  ChooseDifficultyVC.swift
//  GamesQuizer
//
//  Created by vishal sata on 17/01/20.
//  Copyright © 2019 vishal sata. All rights reserved.
//

import UIKit

class ChooseDifficultyVC: UIViewController {
    
    var MCqQuestionData : McqQuestion?
    var McqQuestions = [McqQuestionResult]()
    var type : String  = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func PushToClick(_ sender: UIButton) {
        
        switch sender.tag {
        case 1:
            type = "EASY"
        case 2:
            type = "MEDIUM"
        case 3:
            type = "HARD"
        default:
            type = "EASY"
        }
        if let path = Bundle.main.path(forResource: type, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! [String:Any]
                MCqQuestionData = McqQuestion(fromDictionary: jsonResult)
                if let resultarr = MCqQuestionData?.results
                {
                    self.McqQuestions = resultarr
                }
            } catch {
                // handle error
                print(error)
            }
        }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "QuestionsVC") as! QuestionsVC
        vc.arrQuestions = McqQuestions
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
