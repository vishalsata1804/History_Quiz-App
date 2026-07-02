//
//  AllScoreListVC.swift
//  GamesQuizer
//
//  Created by bhikhu on 18/01/20.
//  Copyright © 2020 vishal sata. All rights reserved.
//

import UIKit

class AllScoreListVC: UIViewController , UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tblData: UITableView!
    var arrSacore = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
               self.navigationController!.navigationBar.shadowImage = UIImage()
               self.navigationController!.navigationBar.isTranslucent = true
               let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
               navigationController?.navigationBar.titleTextAttributes = textAttributes
               self.title = "Your Score List"
        tblData.rowHeight = 50
        tblData.reloadData()
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSacore.count
    }

    @IBAction func btnBackTapped(_ sender: Any) {
            self.navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellScores", for: indexPath) as! cellScores
        cell.lblScore.text = "Scored :" + String(arrSacore[indexPath.row])
        return cell
    }
}
