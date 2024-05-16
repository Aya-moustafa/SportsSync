//
//  FavoriteViewController.swift
//  SportsSync
//
//  Created by Aya Mostafa on 12/05/2024.
//

import UIKit
import Kingfisher

class FavoriteViewController: UIViewController, UITableViewDelegate ,UITableViewDataSource, FavoriteLeaguesView {

    
   
  
    @IBOutlet weak var favPlaceHolderImage: UIImageView!
    var isFootball : Bool = false
    var favLeaguesViewModel : LeaguesViewModel?
    var defaultLeague : League?
    var sport : String?
    var sports = ["football" , "basketball" , "tennis" , ""]
    @IBOutlet weak var favoriteTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.favoriteTable.reloadData()
        defaultLeague = League(leagueKey: 0, leagueName: "Unknown", countryKey: 0, countryName: "Unknown", leagueLogo: "", countryLogo: "")
        favPlaceHolderImage?.image = UIImage(named: "nofav-removebg-preview")
      //  placeholderLabel.isHidden = true
        favPlaceHolderImage.isHidden = true
       // placeHolderLabel.isHidden = true
        favLeaguesViewModel = LeaguesViewModel()
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
            
                   self.favoriteTable.reloadData()
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("the number of favorite leagues is = \(favLeaguesViewModel?.favoriteLeagues.count ?? 0)")
        let count = favLeaguesViewModel?.favoriteLeagues.count ?? 0
               if count == 0 {
                  favPlaceHolderImage.isHidden = false
                 return 0
               } else {
                   favPlaceHolderImage.isHidden = true
                 return count
               }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaguecell", for: indexPath) as! LeagueTableViewCell
        print("the leaguee name from fetching \(favLeaguesViewModel?.favoriteLeagues[0].leagueName ?? "")")
       let league = favLeaguesViewModel?.favoriteLeagues[indexPath.row]
        cell.leagueName.text = favLeaguesViewModel?.favoriteLeagues[indexPath.row].leagueName
        cell.countryName.text = favLeaguesViewModel?.favoriteLeagues[indexPath.row].countryName
        if let leagueLogo = league?.leagueLogo, let imageURL = URL(string: leagueLogo) {
            cell.leagueImg.kf.setImage(with: imageURL, placeholder: UIImage(named: "placeh"))
        } else {
            cell.leagueImg.image = UIImage(named: "placeh")
        }
        if let countryLogo = league?.countryLogo, let countryURL = URL(string: countryLogo) {
            cell.countryLogo.kf.setImage(with: countryURL, placeholder: UIImage(named: "flagPlaceholder"))
        } else {
            cell.countryLogo.image = UIImage(named: "flagPlaceholder")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        return 90
    }
    
   

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let details = self.storyboard?.instantiateViewController(withIdentifier: "eventScreen") as! EventsCollectionViewController
         details.savedLeague = favLeaguesViewModel?.favoriteLeagues[indexPath.row]
         details.isFavorite = true
         details.modalPresentationStyle = .fullScreen
         self.present(details, animated: true, completion: nil)
     }
     
     
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
             
             let alertController = UIAlertController(title: "Delete League", message: "Are you sure you want to delete this league from your favorites?", preferredStyle: .alert)
                     
                     let confirmAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
                         let index = indexPath.row
                         if let leagueToDelete = self.favLeaguesViewModel?.favoriteLeagues[index] {
                             self.favLeaguesViewModel?.favoriteLeagues.remove(at: index)
                             tableView.deleteRows(at: [indexPath], with: .fade)
                             self.favLeaguesViewModel?.deleteLeagueFromCD(league: leagueToDelete)
                             print("The league that you want to delete is \(leagueToDelete.leagueName ?? "")")
                         }
                     }

                     let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

                     alertController.addAction(confirmAction)
                     alertController.addAction(cancelAction)
     
                     present(alertController, animated: true, completion: nil)
         } else if editingStyle == .insert {
                 }
     }
     


}
