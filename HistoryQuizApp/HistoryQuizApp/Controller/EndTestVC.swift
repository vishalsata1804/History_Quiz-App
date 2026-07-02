//
//  EndTestVC.swift
//  GamesQuizer
//
//  Created by vishal sata on 23/11/19.
//  Copyright © 2019 vishal sata. All rights reserved.
//

import UIKit

class EndTestVC: UIViewController {


    @IBOutlet var lblHighScore: UILabel!
    @IBOutlet var lblHighScoreSt: UILabel!
    @IBOutlet var btnYourScore: UIButton!
    @IBOutlet weak var lblScore: UILabel!
    var Score : Int = 0
    var arrSacore = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        if let arrAcore = UserDefaults.standard.value(forKey: "HighScore") as? [Int]{
            arrSacore = arrAcore
            arrSacore.append(Score)
        }else{
            arrSacore.append(Score)
            UserDefaults.standard.setValue(arrSacore, forKey: "HighScore")
        }
        DispatchQueue.main.async {
            self.btnYourScore.isHidden = self.arrSacore.count >  0 ? false : true
            self.lblHighScoreSt.isHidden = self.arrSacore.count >  0 ? false : true
            self.lblHighScore.isHidden = self.arrSacore.count >  0 ? false : true
            self.lblHighScore.text = "\(self.arrSacore.max() ?? 0)"
        }
        lblScore.text = "\(Score)"
        // Do any additional setup after loading the view.
    }
    @IBAction func btnAllQustion(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllScoreListVC") as! AllScoreListVC
        vc.arrSacore = arrSacore
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func Reset(_ sender: Any){
        self.navigationController?.popToRootViewController(animated: true)
    }
}
