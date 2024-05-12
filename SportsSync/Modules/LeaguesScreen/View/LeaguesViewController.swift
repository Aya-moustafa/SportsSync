//
//  LeaguesViewController.swift
//  SportsSync
//
//  Created by JETSMobileLabMini4 on 11/05/2024.
//

import UIKit
import Kingfisher
class LeaguesViewController: UIViewController, UITableViewDelegate ,UITableViewDataSource {

    @IBOutlet weak var sportText: UILabel!
    let searchController = UISearchController(searchResultsController: nil)
   

    @IBOutlet weak var sportsImg: UIImageView!
    @IBOutlet weak var leagueTable: UITableView!
    var leagueViewModel : LeaguesViewModel?
    var leaguesFootball : [League]?
    var leaguesBasketball : [League]?
    var leaguesTennis : [League]?
    var leagueCricket : [League]?
    var isFootball : Bool = false
    var isBasketball : Bool = false
    var isTennis : Bool = false
    var isCricket : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Set corner radius for leagueImg in the bottom corners only
        let cornerRadius: CGFloat = 25.0 // Adjust the value to your desired corner radius
                let maskLayer = CAShapeLayer()
                maskLayer.path = UIBezierPath(roundedRect: sportsImg.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
                sportsImg.layer.mask = maskLayer
        
        leagueViewModel = LeaguesViewModel()
        leagueTable.delegate = self
        leagueTable.dataSource = self
        let nib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        leagueTable.register(nib, forCellReuseIdentifier: "leaguecell")
    //    sportsImg.layer.cornerRadius = 30
        if isFootball == true {
            sportText.text = "FOOTBALL LEAGUES"
            sportsImg.image = UIImage(named: "newfoo")
            leagueViewModel?.loadData(endPoint: "football")
        }else if isBasketball == true {
            sportText.text = "BASKETBALL LEAGUES"
            sportsImg.image = UIImage(named: "basketballback")
            leagueViewModel?.loadData(endPoint: "basketball")
        }else if isTennis == true {
            sportText.text = "TENNIS LEAGUES"
            sportsImg.image = UIImage(named: "tennisbackground")
            leagueViewModel?.loadData(endPoint: "tennis")
        }else if isCricket == true {
            sportText.text = "CRICKET LEAGUES"
            sportsImg.image = UIImage(named: "newfoo")
            leagueViewModel?.loadData(endPoint: "cricket")
        }
        leagueViewModel?.bindLeaguesToViewController = { [weak self] in
            print ("inside bindLeaguesToViewController")
            DispatchQueue.main.async {
                self?.leagueTable.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         print("number of leagues = \(leagueViewModel?.getResultLeagues().count ?? 0)")
        return leagueViewModel?.getResultLeagues().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaguecell", for: indexPath) as! LeagueTableViewCell
        
        print("the leagues fetched \(leagueViewModel?.getResultLeagues()[indexPath.row].leagueName ?? "unknown")")
        cell.leagueName.text = leagueViewModel?.getResultLeagues()[indexPath.row].leagueName
        cell.countryName.text = leagueViewModel?.getResultLeagues()[indexPath.row].countryName
        
        if let leagueL = leagueViewModel?.getResultLeagues()[indexPath.row].leagueLogo  {
           // let baseURL = "https://image.tmdb.org/t/p/w500/"
            let imageURL = URL(string: leagueL)
            
            // Use Kingfisher to set the image from URL
            cell.leagueImg.kf.setImage(with: imageURL, placeholder: UIImage(named: "placeh"), options: [.transition(.fade(0.2))], completionHandler: { result in
                switch result {
                case .success(_):
                    print("Image loaded successfully")
                case .failure(let error):
                    print("Error loading image: \(error)")
                }
            })
        } else {
            // Handle case where leagueLogo URL is nil
                cell.leagueImg.image = UIImage(named: "placeh")
        }
        
        if let countryL = leagueViewModel?.getResultLeagues()[indexPath.row].countryLogo  {
           // let baseURL = "https://image.tmdb.org/t/p/w500/"
            let countryURl = URL(string: countryL)
            
            // Use Kingfisher to set the image from URL
            cell.countryLogo.kf.setImage(with: countryURl, placeholder: UIImage(named: "placeh"), options: [.transition(.fade(0.2))], completionHandler: { result in
                switch result {
                case .success(_):
                    print("Image loaded successfully")
                case .failure(let error):
                    print("Error loading image: \(error)")
                }
            })
        } else {
            // Handle case where leagueLogo URL is nil
            cell.leagueImg.image = UIImage(named: "placeh")
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Return the desired height for the cell at the specified indexPath
        return 100 // Adjust this value to the desired height
    }
    
  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    /* override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let details:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "details") as! ViewController
         details.movie = arr?[indexPath.row]
         self.navigationController?.pushViewController(details, animated: true)
     }*/
     
     
     /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the specified item to be editable.
         return true
     }
     */

     
     // Override to support editing the table view.
     /*override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
             tableView.deleteRows(at: [indexPath], with: .fade)
         } else if editingStyle == .insert {
         }
     }*/
     

     /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

     }
     */

     /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the item to be re-orderable.
         return true
     }
     */
}
