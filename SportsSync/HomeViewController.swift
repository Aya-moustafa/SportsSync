//
//  HomeViewController.swift
//  SportsSync
//
//  Created by Aya Mostafa on 10/05/2024.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var cricketBtn: UIButton!
    @IBOutlet weak var tennisBtn: UIButton!
    @IBOutlet weak var basketballBtn: UIButton!
    @IBOutlet weak var footballBtn: UIButton!
    @IBOutlet weak var shape4: UIButton!
    @IBOutlet weak var shape3: UIButton!
    @IBOutlet weak var shape2: UIButton!
    @IBOutlet weak var shape1: UIButton!
    var isFootball : Bool = false
    var isBasketball : Bool = false
    var isTennis : Bool = false
    var isCricket : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        shape1.layer.cornerRadius = 30
        shape2.layer.cornerRadius = 30
        shape3.layer.cornerRadius = 30
        shape4.layer.cornerRadius = 30
        footballBtn.layer.cornerRadius = 30
        basketballBtn.layer.cornerRadius = 30
        tennisBtn.layer.cornerRadius = 30
        cricketBtn.layer.cornerRadius = 30
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func footballAction(_ sender: Any) {
        let leaguesTable:LeaguesViewController = self.storyboard?.instantiateViewController(withIdentifier: "leagues") as! LeaguesViewController
        leaguesTable.isFootball = true
        self.navigationController?.pushViewController(leaguesTable, animated: true)
    }
    
    @IBAction func basketballAction(_ sender: Any) {
        let leaguesTable:LeaguesViewController = self.storyboard?.instantiateViewController(withIdentifier: "leagues") as! LeaguesViewController
        leaguesTable.isBasketball = true
        self.navigationController?.pushViewController(leaguesTable, animated: true)
    }
    
    @IBAction func tennisAction(_ sender: Any) {
        let leaguesTable:LeaguesViewController = self.storyboard?.instantiateViewController(withIdentifier: "leagues") as! LeaguesViewController
        leaguesTable.isTennis = true
        self.navigationController?.pushViewController(leaguesTable, animated: true)
    }
    
    @IBAction func cricketAction(_ sender: Any) {
        let leaguesTable:LeaguesViewController = self.storyboard?.instantiateViewController(withIdentifier: "leagues") as! LeaguesViewController
        leaguesTable.isCricket = true
        self.navigationController?.pushViewController(leaguesTable, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
