//
//  FavoriteViewController.swift
//  SportsSync
//
//  Created by Aya Mostafa on 12/05/2024.
//

import UIKit
import Kingfisher

class FavoriteViewController: UIViewController, UITableViewDelegate ,UITableViewDataSource, FavoriteLeaguesView {

    
    var isFootball : Bool = false
    var favLeaguesViewModel : FavoriteViewModel?
    var defaultLeague : League?
    @IBOutlet weak var favoriteTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultLeague = League(leagueKey: 0, leagueName: "Unknown", countryKey: 0, countryName: "Unknown", leagueLogo: "", countryLogo: "")
        favLeaguesViewModel = FavoriteViewModel()
        favoriteTable.delegate = self
        favoriteTable.dataSource = self
        let nib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        favoriteTable.register(nib, forCellReuseIdentifier: "leaguecell")
        favLeaguesViewModel?.setUpView(tableViewToBeRefreshed: self)
        favLeaguesViewModel?.fetchFavoriteLeagusFromCoreData()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favLeaguesViewModel?.fetchFavoriteLeagusFromCoreData()
       // self.favoriteTable.reloadData()
    }
    
    func updateData(leagues: [League]) {
        DispatchQueue.main.async {
                //   self.favLeaguesViewModel?.favoriteLeagues = leagues
                   self.favoriteTable.reloadData()
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("the number of favorite leagues is = \(favLeaguesViewModel?.favoriteLeagues.count ?? 0)")
        return favLeaguesViewModel?.favoriteLeagues.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaguecell", for: indexPath) as! LeagueTableViewCell
        print("the leaguee name from fetching \(favLeaguesViewModel?.favoriteLeagues[0].leagueName ?? "")")
        let league = favLeaguesViewModel?.favoriteLeagues[indexPath.row]
        cell.favBtn.isHidden = true
        cell.leagueName.text = favLeaguesViewModel?.favoriteLeagues[indexPath.row].leagueName
        cell.countryName.text = favLeaguesViewModel?.favoriteLeagues[indexPath.row].countryName
        if let leagueLogo = league?.leagueLogo, let imageURL = URL(string: leagueLogo) {
            cell.leagueImg.kf.setImage(with: imageURL, placeholder: UIImage(named: "placeh"))
        } else {
            cell.leagueImg.image = UIImage(named: "placeh")
        }
        if let countryLogo = league?.countryLogo, let countryURL = URL(string: countryLogo) {
            cell.countryLogo.kf.setImage(with: countryURL, placeholder: UIImage(named: "placeh"))
        } else {
            cell.countryLogo.image = UIImage(named: "placeh")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Return the desired height for the cell at the specified indexPath
        return 90// Adjust this value to the desired height
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
      func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
             let index = indexPath.row
             let leagueToDelete = favLeaguesViewModel?.favoriteLeagues[index]
             favLeaguesViewModel?.favoriteLeagues.remove(at: index)
             favoriteTable.deleteRows(at: [indexPath], with: .fade)
             if let league = leagueToDelete {
                             favLeaguesViewModel?.deleteLeagueFromCD(league: league)
             }
            // self.favoriteTable.reloadData()
             print("the league that you want to delete is \(leagueToDelete?.leagueName ?? "")")
         } else if editingStyle == .insert {
         }
     }
     

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
