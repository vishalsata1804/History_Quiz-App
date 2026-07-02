//
//  QuestionsVC.swift
//  GamesQuizer
//
//  Created by vishal sata on 17/01/20.
//  Copyright © 2019 vishal sata. All rights reserved.
//

import UIKit

class QuestionsVC: UIViewController {
    //MARK: - Timer Varible
    @IBOutlet weak var questionCounter: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    //Outlet for Buttons
    @IBOutlet weak var optionA: UIButton!
    @IBOutlet weak var optionB: UIButton!
    @IBOutlet weak var optionC: UIButton!
    @IBOutlet weak var optionD: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    var questionNumber: Int = 0
    var score: Int = 0
    var selectedAnswer: String = ""
    
    @IBOutlet var TicTicView: SRCountdownTimer!
    var arrQuestions = [McqQuestionResult]()
    var arrincorrectAnswers = [String]()
    var Finishstr : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    func setupUI(){
        TicTicView.labelFont = UIFont(name: "HelveticaNeue-Light", size: 30.0)
        TicTicView.labelTextColor = UIColor.red
        TicTicView.timerFinishingText = "0"
        TicTicView.lineWidth = 4
        Finishstr = ""
        TicTicView.delegate = self
        //TicTicView.start(beginingValue: 30, interval: 1)
        updateQuestion()
        updateUI()
        print(arrQuestions)
    }
    
    
    @IBAction func answerPressed(_ sender: UIButton) {
        
        if sender.titleLabel?.text == selectedAnswer {
            score += 1
            sender.backgroundColor = UIColor.green
        }else{
            sender.backgroundColor = UIColor.init(hex: "B22222")
        }
        switch selectedAnswer {
                   case optionA.titleLabel?.text :
                       optionA.backgroundColor = UIColor.init(hex: "2E8B57")
                   case optionB.titleLabel?.text :
                       optionB.backgroundColor = UIColor.init(hex: "2E8B57")
                   case optionC.titleLabel?.text :
                       optionC.backgroundColor = UIColor.init(hex: "2E8B57")
                   case optionD.titleLabel?.text :
                       optionD.backgroundColor = UIColor.init(hex: "2E8B57")
                   default:
                       return
                   }
        optionA.isEnabled = false
        optionB.isEnabled = false
        optionC.isEnabled = false
        optionD.isEnabled = false
    }
    
    func updateQuestion(){
        if questionNumber <= arrQuestions.count - 1{
            questionLabel.text = arrQuestions[questionNumber].question
            //optionA.setTitle(arrQuestions[questionNumber].correctAnswer, for: .normal)
            arrincorrectAnswers = arrQuestions[questionNumber].incorrectAnswers
            print(arrincorrectAnswers)
            if arrincorrectAnswers.count > 0{
                print(arrincorrectAnswers)
                optionA.setTitle(arrincorrectAnswers[0], for: .normal)
                optionB.setTitle(arrincorrectAnswers[1], for: .normal)
                optionD.setTitle(arrincorrectAnswers[2], for: .normal)
                optionC.setTitle(arrincorrectAnswers[3], for: .normal)
            }
            
            
            selectedAnswer = arrQuestions[questionNumber].correctAnswer
            updateUI()
            
        }else {
            
        }
    }
    func updateUI(){
        TicTicView.start(beginingValue: 30, interval: 1)
   //     scoreLabel.text = "Score: \(score)"
        questionCounter.text = "\(questionNumber + 1)/\(arrQuestions.count)"
    }
    @IBAction func BtnNext(_ sender: Any){
        if Finishstr == "Finish" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "EndTestVC") as! EndTestVC
            vc.Score = score
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
        optionC.backgroundColor = UIColor.clear
        optionB.backgroundColor = UIColor.clear
        optionA.backgroundColor = UIColor.clear
        optionD.backgroundColor = UIColor.clear
        
        optionA.isEnabled = true
        optionB.isEnabled = true
        optionC.isEnabled = true
        optionD.isEnabled = true
        
        if questionNumber < arrQuestions.count - 1{
            questionNumber += 1
            TicTicView.reset()
            TicTicView.start(beginingValue: 30)
            updateQuestion()
            updateUI()
        } else {
            btnNext.setTitle("Finish", for: .normal)
           // btnNext.setBackgroundImage(UIImage.init(named: "button_finish"), for: .normal)
            Finishstr = "Finish"
            }
            
    }
 }
    @IBAction func GoBack(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "HistoryQuizer", message: " are you sure you want to exit?",         preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
                //Cancel Action
            }))
            alert.addAction(UIAlertAction(title: "Yes",
                                          style: UIAlertAction.Style.default,
                                          handler: {(_: UIAlertAction!) in
            self.navigationController?.popToRootViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }

extension QuestionsVC: SRCountdownTimerDelegate{
    func timerDidUpdateCounterValue(sender: SRCountdownTimer, newValue: Int) {
        
    }
    func timerDidStart(sender: SRCountdownTimer) {
        
    }
    func timerDidPause(sender: SRCountdownTimer) {
        
    }
    func timerDidResume(sender: SRCountdownTimer) {
        
    }
    func timerDidEnd(sender: SRCountdownTimer, elapsedTime: TimeInterval) {
        print(elapsedTime)
     
        
        switch selectedAnswer {
              case optionA.titleLabel?.text :
                  optionA.backgroundColor = UIColor.init(hex: "2E8B57")
              case optionB.titleLabel?.text :
                  optionB.backgroundColor = UIColor.init(hex: "2E8B57")
              case optionC.titleLabel?.text :
                  optionC.backgroundColor = UIColor.init(hex: "2E8B57")
              case optionD.titleLabel?.text :
                  optionD.backgroundColor = UIColor.init(hex: "2E8B57")
              default:
                  return
              }
              optionA.isEnabled = false
              optionB.isEnabled = false
              optionC.isEnabled = false
              optionD.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//            sender.reset()
//            sender.start(beginingValue: 30)
            self.BtnNext(self)
        }
        
    }
}
