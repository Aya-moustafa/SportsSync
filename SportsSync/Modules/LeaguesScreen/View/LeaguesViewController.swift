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
    var sport : String!
    var leagueViewModel : LeaguesViewModel?
    var isFootball : Bool = false
    var isBasketball : Bool = false
    var isTennis : Bool = false
    var isCricket : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leagueTable.separatorStyle = .none
        // Set corner radius for leagueImg in the bottom corners only
        let cornerRadius: CGFloat = 25.0 // Adjust the value to your desired corner radius
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: sportsImg.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath 
        leagueViewModel = LeaguesViewModel()
        leagueTable.delegate = self
        leagueTable.dataSource = self
        let nib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        leagueTable.register(nib, forCellReuseIdentifier: "leaguecell")
    //    sportsImg.layer.cornerRadius = 30
        if isFootball == true {
            sport = "football"
            sportText.text = "FOOTBALL LEAGUES"
            sportsImg.image = UIImage(named: "newfoo")
            leagueViewModel?.loadData(endPoint: ApiConstants.Endpoints.football)
        }else if isBasketball == true {
            sport = "basketball"
            sportText.text = "BASKETBALL LEAGUES"
            sportsImg.image = UIImage(named: "basketballback")
            leagueViewModel?.loadData(endPoint: ApiConstants.Endpoints.basketball)
        }else if isTennis == true {
            sport = "tennis"
            sportText.text = "TENNIS LEAGUES"
            sportsImg.image = UIImage(named: "tennisbackground")
            leagueViewModel?.loadData(endPoint: ApiConstants.Endpoints.tennis)
        }else if isCricket == true {
            sport = "cricket"
            sportText.text = "CRICKET LEAGUES"
            sportsImg.image = UIImage(named: "newfoo")
            leagueViewModel?.loadData(endPoint: ApiConstants.Endpoints.cricket)
        }
        leagueViewModel?.bindLeaguesToViewController = { [weak self] in
            print ("inside bindLeaguesToViewController")
            DispatchQueue.main.async {
                self?.leagueTable.reloadData()
            }
        }
        NetworkManager.shared.startMonitoring()
        NotificationCenter.default.addObserver(self, selector:  #selector(handleNetworkRestored), name: .networkRestored, object: nil)
        // Do any additional setup after loading the view.
    }
    
    
    @objc func handleNetworkRestored () {
        if isFootball {
                   leagueViewModel?.loadData(endPoint: ApiConstants.Endpoints.football)
               } else if isBasketball {
                   leagueViewModel?.loadData(endPoint: ApiConstants.Endpoints.basketball)
               } else if isTennis {
                   leagueViewModel?.loadData(endPoint: ApiConstants.Endpoints.tennis)
               } else if isCricket {
                   leagueViewModel?.loadData(endPoint: ApiConstants.Endpoints.cricket)
               }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .networkRestored, object: nil)
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
        
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 80))
//        paddingView.addSubview(cell.contentView)
//        cell.contentView.frame = CGRect(x: 10, y: 5, width: paddingView.frame.width - 20, height: paddingView.frame.height - 10)
//        cell.contentView.layer.cornerRadius = 30
        
       // print("the leagues fetched \(leagueViewModel?.getResultLeagues()[indexPath.row].leagueName ?? "unknown")")
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
            cell.countryLogo.kf.setImage(with: countryURl, placeholder: UIImage(named: "flagPlaceholder"), options: [.transition(.fade(0.2))], completionHandler: { result in
                switch result {
                case .success(_):
                    print("Image loaded successfully")
                case .failure(let error):
                    print("Error loading image: \(error)")
                }
            })
        } else {
            // Handle case where leagueLogo URL is nil
            cell.countryLogo.image = UIImage(named: "flagPlaceholder")
        }
        
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let details = self.storyboard?.instantiateViewController(withIdentifier: "eventScreen") as! EventsCollectionViewController
            details.leagueSport = sport
            details.savedLeague = leagueViewModel?.getResultLeagues()[indexPath.row]
        details.isFavorite = leagueViewModel?.isFav(league:  (leagueViewModel?.getResultLeagues()[indexPath.row])!)
            self.navigationController?.pushViewController(details, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Return the desired height for the cell at the specified indexPath
        return 80// Adjust this value to the desired height
    }
    
  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
     
     /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the specified item to be editable.
         return true
     }
     */

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
