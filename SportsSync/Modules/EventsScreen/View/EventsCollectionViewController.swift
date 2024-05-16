//
//  EventsCollectionViewController.swift
//  SportsSync
//
//  Created by Elham on 12/05/2024.
//

import UIKit

class EventsCollectionViewController: UIViewController {
    var selectedTeamId: Int = 0

   // @IBOutlet weak var favBtn: UIButton!
   // @IBOutlet weak var leagueName: UILabel!
    var viewModel : EventsViewModel?
    var savedLeague : League?
    var leagueViewModel : LeaguesViewModel?
    var isFavorite : Bool!
    var leagueSport : String?
    var teamId = 0
    @IBAction func favBtnHandler(_ sender: Any) {
        let alertController = UIAlertController(title: "Confirmation", message: isFavorite ? "Are you sure you want to remove this league from favorites?" : "Are you sure you want to add this league to favorites?", preferredStyle: .alert)
                   
                   let confirmAction = UIAlertAction(title: "Yes", style: .default) { _ in
                       if self.isFavorite {
                           DispatchQueue.main.async {
                               self.favBtn.setImage(UIImage(systemName: "star"), for: .normal)
                           }
                           self.leagueViewModel?.deleteLeagueFromCD(league: self.savedLeague ?? League(leagueKey: 0, leagueName: "unknown", countryKey: 0, countryName: "", leagueLogo: "", countryLogo: ""))
                       } else {
                           DispatchQueue.main.async {
                               self.favBtn.setImage(UIImage(systemName: "star.fill"), for: .normal)
                           }
                           print("leagueSport = : \(self.leagueSport ?? "unknown sport")")
                           self.leagueViewModel?.saveLeagueToCoreData(league: self.savedLeague ?? League(leagueKey: 0, leagueName: "unknown", countryKey: 0, countryName: "", leagueLogo: "", countryLogo: ""), sport: self.leagueSport!)
                           print("the saved league is \(self.savedLeague?.leagueName ?? "unknown")")
                       }
                       self.isFavorite.toggle() // Update the favorite status after the action
                   }
                   
                   let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
                   
                   alertController.addAction(confirmAction)
                   alertController.addAction(cancelAction)
                   
                   present(alertController, animated: true, completion: nil)
        }
    
//    var savedLeague : League?
//    var leagueViewModel : LeaguesViewModel?
//    var isFavorite : Bool!
    @IBOutlet weak var favBtn: UIButton!
  //  var viewModel : EventsViewModel?
    var leagueId = 205
  //  var leagueSport : String?
    var sport = "football"
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
       // leagueName.text = savedLeague?.leagueName
        //let leagueId = 205
       
        if isFavorite == true {
            DispatchQueue.main.async {
                self.favBtn.setImage(UIImage(systemName: "star.fill"), for: .normal)
            }
        }else{
            DispatchQueue.main.async {
                self.favBtn.setImage(UIImage(systemName: "star"), for: .normal)
            }
        }
        
        viewModel = EventsViewModel()
        leagueViewModel = LeaguesViewModel()
        // Do any additional setup after loading the view.
        viewModel?.bindLeaguesToViewController = { [weak self] in
            print ("inside CollectionViewController")
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
       
        viewModel?.fetchLatestResults(leagueId: leagueId,endPoint :sport)
        viewModel?.fetchUpcomingEvents(leagueId: leagueId,endPoint :sport)
        //viewModel?.fetchTeams(leagueId: leagueId,endPoint : sport)
        collectionView.delegate = self
        collectionView.dataSource = self
        print("Team Id in events = \(teamId)")
        setupCollectionViewLayout()
    }
    //MARK: - CompositionalLayout
    func setupCollectionViewLayout() {
            let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
                switch sectionIndex {
                case 0:
                    return self.createUpcomingEventsSectionLayout()
                case 1:
                    return self.createLatestEventsSectionLayout()
                case 2:
                    return self.createTeamsSectionLayout()
                default:
                    return nil
                }
            }
            collectionView.collectionViewLayout = layout
        }
    
    
 
    func createTeamsSectionLayout() -> NSCollectionLayoutSection {
          
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(180))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75)
                , heightDimension: .absolute(180))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize
                , subitems: [item])
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 0)
        
                    section.orthogonalScrollingBehavior = .continuous
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        
                // Animation
                section.visibleItemsInvalidationHandler = { (items, offset, environment) in
                     items.forEach { item in
                     let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                     let minScale: CGFloat = 0.8
                     let maxScale: CGFloat = 1.0
                     let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                     item.transform = CGAffineTransform(scaleX: scale, y: scale)
                     }
                }
                return section
            
        }
        
      
    
        func createLatestEventsSectionLayout() -> NSCollectionLayoutSection {
            
                    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                          heightDimension: .absolute(180))
            
                    let item = NSCollectionLayoutItem(layoutSize: itemSize)
                    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 0)
            
                    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                           heightDimension: .absolute(180))
            
                    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
                   
                    let section = NSCollectionLayoutSection(group: group)
                    section.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 0, bottom: 8, trailing: 0)
                    section.contentInsetsReference = .layoutMargins
                    section.interGroupSpacing = 10
            
            let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
            
                    return section
        }
        
       
        func createUpcomingEventsSectionLayout() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(180))
                    let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0)
                    , heightDimension: .absolute(180))
                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize
                    , subitems: [item])
            
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)
            
                        section.orthogonalScrollingBehavior = .continuous
            let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
            
                    // Animation
                    section.visibleItemsInvalidationHandler = { (items, offset, environment) in
                         items.forEach { item in
                         let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                         let minScale: CGFloat = 0.8
                         let maxScale: CGFloat = 1.0
                         let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                         item.transform = CGAffineTransform(scaleX: scale, y: scale)
                         }
                    }
                    return section
                }

    }

    


// MARK: - CollectionViewController
extension EventsCollectionViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel?.getUpcomingEvents().count ?? 0
        case 1:
            return viewModel?.getLatestEvents().count ?? 0
            //  return 1
        case 2:
            return viewModel?.getTeams2().count ?? 0
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let upCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpCell", for: indexPath) as! UpComingCollectionViewCell
        
        let latestCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestCell", for: indexPath) as!
        LatestCollectionViewCell
        let teamCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as!
        TeamsCollectionViewCell
        if(indexPath.section == 0){
            
            //   upCell.date.text = viewModel?.getLatestEvents()[indexPath.row].eventDate
            upCell.name1.text = viewModel?.getUpcomingEvents()[indexPath.row].eventHomeTeam
            upCell.name2.text = viewModel?.getUpcomingEvents()[indexPath.row].eventAwayTeam
            upCell.date.text = viewModel?.getUpcomingEvents()[indexPath.row].eventDate
            let logo1 = viewModel?.getUpcomingEvents()[indexPath.row].homeTeamLogo ?? " "
            let imageURL = URL(string: logo1)
            
            // Use Kingfisher to set the image from URL
            upCell.img1.kf.setImage(with: imageURL, placeholder: UIImage(named: "placeh"), options: [.transition(.fade(0.2))], completionHandler: { result in
                switch result {
                case .success(_):
                    print("Image loaded successfully")
                case .failure(let error):
                    print("Error loading image: \(error)")
                }
            })
            
            let logo2 = viewModel?.getUpcomingEvents()[indexPath.row].awayTeamLogo ?? " "
            let imageURL2 = URL(string: logo2)
            
            // Use Kingfisher to set the image from URL
            upCell.img2.kf.setImage(with: imageURL2, placeholder: UIImage(named: "placeh"), options: [.transition(.fade(0.2))], completionHandler: { result in
                switch result {
                case .success(_):
                    print("Image loaded successfully")
                case .failure(let error):
                    print("Error loading image: \(error)")
                }
            })
            // }
            return upCell
        } else if(indexPath.section == 1){
            
            // latestCell.result.text = viewModel?.getLatestEvents()[indexPath.row].eventFinalResult
            latestCell.team1.text = viewModel?.getLatestEvents()[indexPath.row].eventHomeTeam
            latestCell.team2.text = viewModel?.getLatestEvents()[indexPath.row].eventAwayTeam
            
            latestCell.date.text = viewModel?.getUpcomingEvents()[indexPath.row].eventDate ?? "3-3-2022"
            latestCell.result.text = viewModel?.getUpcomingEvents()[indexPath.row].eventFinalResult
            let logo1 = viewModel?.getLatestEvents()[indexPath.row].homeTeamLogo ?? " "
            let imageURL = URL(string: logo1)
            
            // Use Kingfisher to set the image from URL
            latestCell.img1.kf.setImage(with: imageURL, placeholder: UIImage(named: "placeh"), options: [.transition(.fade(0.2))], completionHandler: { result in
                switch result {
                case .success(_):
                    print("Image loaded successfully")
                case .failure(let error):
                    print("Error loading image: \(error)")
                }
            })
            
            let logo2 = viewModel?.getLatestEvents()[indexPath.row].awayTeamLogo ?? " "
            let imageURL2 = URL(string: logo2)
            
            // Use Kingfisher to set the image from URL
            latestCell.img2.kf.setImage(with: imageURL2, placeholder: UIImage(named: "placeh"), options: [.transition(.fade(0.2))], completionHandler: { result in
                switch result {
                case .success(_):
                    print("Image loaded successfully")
                case .failure(let error):
                    print("Error loading image: \(error)")
                }
            })
            //}
            return latestCell
        }
        else {
            if let teamName = viewModel?.getTeams2()[indexPath.row].teamName {
                teamCell.teamName.text = teamName
                let logo1 = viewModel?.getTeams2()[indexPath.row].teamLogo ?? " "
                let imageURL = URL(string: logo1)
                
                // Use Kingfisher to set the image from URL
                teamCell.logo.kf.setImage(with: imageURL, placeholder: UIImage(named: "placeh"), options: [.transition(.fade(0.2))], completionHandler: { result in
                    switch result {
                    case .success(_):
                        print("Image loaded successfully")
                    case .failure(let error):
                        print("Error loading image: \(error)")
                    }
                })
                
            } else {
                teamCell.teamName.text = "Team Name Not Available"
            }
            return teamCell
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeaderView", for: indexPath) as! SectionHeaderView
            
            
            switch indexPath.section {
            case 0:
                headerView.titleLabel.text = "Upcoming Events"
            case 1:
                headerView.titleLabel.text = "Latest Events"
            case 2:
                headerView.titleLabel.text = "Teams"
            default:
                headerView.titleLabel.text = ""
            }
            
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
    
    
    
    //            func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //
    //                if indexPath.section == 2 {
    //                    print("viewModel?.getTeams2()[indexPath.row].teamKey ?? 0  = \(viewModel?.getTeams2()[indexPath.row].teamKey ?? 0)")
    //                    teamId = viewModel?.getTeams2()[indexPath.row].teamKey ?? 0
    //                }
    //            }
    //
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        let teamDetails = self.storyboard?.instantiateViewController(withIdentifier: "teamDetails") as! TeamDetailsViewController
    //        print("ttttttttteamIiiiiiiiiD =\(teamId )")
    //        teamDetails.sport = sport
    //        teamDetails.teamId = teamId
    //        navigationController?.pushViewController(teamDetails, animated: true)
    //    }
    //
    //
    //}
    //
    
    
   
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let teamDetails = TeamDetailsViewController ()
            teamDetails.sport = sport
            print("ttttttttteamIiiiiiiiiD =\(selectedTeamId )")
            teamDetails.teamId = viewModel?.getTeams2()[indexPath.row].teamKey ?? 0
            print("viewModel?.getTeams2()[indexPath.row].teamKey ?? 0  = \(viewModel?.getTeams2()[indexPath.row].teamKey ?? 0)   annnnd  teamDetails.teamId  =\(teamDetails.teamId)")
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
            
       
    }
    
}



//let upCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpCell", for: indexPath) as! UpComingCollectionViewCell
//
//let latestCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestCell", for: indexPath) as!
//LatestCollectionViewCell
//let teamCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as!
//TeamsCollectionViewCell
//if(indexPath.section == 0){
////            if(sport == "tennis")
////            {
////                upCell.date.text = viewModel?.getLatestEvents()[indexPath.row].eventDate
////                upCell.name1.text = viewModel?.getUpcomingEvents()[indexPath.row].eventFirstPlayer
////                upCell.name2.text = viewModel?.getUpcomingEvents()[indexPath.row].eventSecondPlayer
////
////                let logo1 = viewModel?.getUpcomingEvents()[indexPath.row].eventFirstPlayerLogo ?? " "
////                let imageURL = URL(string: logo1)
////
////                // Use Kingfisher to set the image from URL
////                upCell.img1.kf.setImage(with: imageURL, placeholder: UIImage(named: "placeh"), options: [.transition(.fade(0.2))], completionHandler: { result in
////                    switch result {
////                    case .success(_):
////                        print("Image loaded successfully")
////                    case .failure(let error):
////                        print("Error loading image: \(error)")
////                    }
////                })
////
////                let logo2 = viewModel?.getUpcomingEvents()[indexPath.row].eventSecondPlayerLogo ?? " "
////                let imageURL2 = URL(string: logo2)
////
////                // Use Kingfisher to set the image from URL
////                upCell.img2.kf.setImage(with: imageURL2, placeholder: UIImage(named: "placeh"), options: [.transition(.fade(0.2))], completionHandler: { result in
////                    switch result {
////                    case .success(_):
////                        print("Image loaded successfully")
////                    case .failure(let error):
////                        print("Error loading image: \(error)")
////                    }
////                })
////            }else if(sport == "cricket"){
////             //   upCell.date.text = viewModel?.getLatestEvents()[indexPath.row].eventDate
////                upCell.name1.text = viewModel?.getUpcomingEvents()[indexPath.row].eventHomeTeam
////                upCell.name2.text = viewModel?.getUpcomingEvents()[indexPath.row].eventAwayTeam
////
////                let logo1 = viewModel?.getUpcomingEvents()[indexPath.row].eventHomeTeamLogo ?? " "
////                let imageURL = URL(string: logo1)
////
////                // Use Kingfisher to set the image from URL
////                upCell.img1.kf.setImage(with: imageURL, placeholder: UIImage(named: "placeh"), options: [.transition(.fade(0.2))], completionHandler: { result in
////                    switch result {
////                    case .success(_):
////                        print("Image loaded successfully")
////                    case .failure(let error):
////                        print("Error loading image: \(error)")
////                    }
////                })
////
////                let logo2 = viewModel?.getUpcomingEvents()[indexPath.row].eventAwayTeamLogo ?? " "
////                let imageURL2 = URL(string: logo2)
////
////                // Use Kingfisher to set the image from URL
////                upCell.img2.kf.setImage(with: imageURL2, placeholder: UIImage(named: "placeh"), options: [.transition(.fade(0.2))], completionHandler: { result in
////                    switch result {
////                    case .success(_):
////                        print("Image loaded successfully")
////                    case .failure(let error):
////                        print("Error loading image: \(error)")
////                    }
////                })}
////            else{
//     //   upCell.date.text = viewModel?.getLatestEvents()[indexPath.row].eventDate
//    upCell.name1.text = viewModel?.getUpcomingEvents()[indexPath.row].eventHomeTeam
//    upCell.name2.text = viewModel?.getUpcomingEvents()[indexPath.row].eventAwayTeam
//    
//    let logo1 = viewModel?.getUpcomingEvents()[indexPath.row].eventHomeTeamLogo ?? " "
//    let imageURL = URL(string: logo1)
//    
//    // Use Kingfisher to set the image from URL
//    upCell.img1.kf.setImage(with: imageURL, placeholder: UIImage(named: "placeh"), options: [.transition(.fade(0.2))], completionHandler: { result in
//        switch result {
//        case .success(_):
//            print("Image loaded successfully")
//        case .failure(let error):
//            print("Error loading image: \(error)")
//        }
//    })
//    
//    let logo2 = viewModel?.getUpcomingEvents()[indexPath.row].eventAwayTeamLogo ?? " "
//    let imageURL2 = URL(string: logo2)
//    
//    // Use Kingfisher to set the image from URL
//    upCell.img2.kf.setImage(with: imageURL2, placeholder: UIImage(named: "placeh"), options: [.transition(.fade(0.2))], completionHandler: { result in
//        switch result {
//        case .success(_):
//            print("Image loaded successfully")
//        case .failure(let error):
//            print("Error loading image: \(error)")
//        }
//    })
//// }
//    return upCell
//} else if(indexPath.section == 1){
////            if(sport == "tennis")
////            { latestCell.date.text = viewModel?.getLatestEvents()[indexPath.row].eventDate
////                latestCell.team1.text = viewModel?.getLatestEvents()[indexPath.row].eventFirstPlayer
////                latestCell.team2.text = viewModel?.getLatestEvents()[indexPath.row].eventSecondPlayer
////                latestCell.result.text = viewModel?.getLatestEvents()[indexPath.row].eventFinalResult
////                let logo1 = viewModel?.getLatestEvents()[indexPath.row].eventFirstPlayerLogo ?? " "
////                let imageURL = URL(string: logo1)
////
////                // Use Kingfisher to set the image from URL
////                latestCell.img1.kf.setImage(with: imageURL, placeholder: UIImage(named: "placeh"), options: [.transition(.fade(0.2))], completionHandler: { result in
////                    switch result {
////                    case .success(_):
////                        print("Image loaded successfully")
////                    case .failure(let error):
////                        print("Error loading image: \(error)")
////                    }
////                })
////
////                let logo2 = viewModel?.getLatestEvents()[indexPath.row].eventSecondPlayerLogo ?? " "
////                let imageURL2 = URL(string: logo2)
////
////                // Use Kingfisher to set the image from URL
////                latestCell.img2.kf.setImage(with: imageURL2, placeholder: UIImage(named: "placeh"), options: [.transition(.fade(0.2))], completionHandler: { result in
////                    switch result {
////                    case .success(_):
////                        print("Image loaded successfully")
////                    case .failure(let error):
////                        print("Error loading image: \(error)")
////                    }
////                })
////            }else if(sport == "cricket"){
//       // latestCell.date.text = viewModel?.getLatestEvents()[indexPath.row].eventDate
////                latestCell.team1.text = viewModel?.getLatestEvents()[indexPath.row].eventHomeTeam
////                latestCell.team2.text = viewModel?.getLatestEvents()[indexPath.row].eventAwayTeam
////                latestCell.result.text = viewModel?.getLatestEvents()[indexPath.row].eventFinalResult
////                let logo1 = viewModel?.getLatestEvents()[indexPath.row].eventHomeTeamLogo ?? " "
////                let imageURL = URL(string: logo1)
////
////                // Use Kingfisher to set the image from URL
////                latestCell.img1.kf.setImage(with: imageURL, placeholder: UIImage(named: "placeh"), options: [.transition(.fade(0.2))], completionHandler: { result in
////                    switch result {
////                    case .success(_):
////                        print("Image loaded successfully")
////                    case .failure(let error):
////                        print("Error loading image: \(error)")
////                    }
////                })
////
////                let logo2 = viewModel?.getLatestEvents()[indexPath.row].eventAwayTeamLogo ?? " "
////                let imageURL2 = URL(string: logo2)
////
////                // Use Kingfisher to set the image from URL
////                latestCell.img2.kf.setImage(with: imageURL2, placeholder: UIImage(named: "placeh"), options: [.transition(.fade(0.2))], completionHandler: { result in
////                    switch result {
////                    case .success(_):
////                        print("Image loaded successfully")
////                    case .failure(let error):
////                        print("Error loading image: \(error)")
////                    }
////                })
////            }
//   // else {
//       // latestCell.result.text = viewModel?.getLatestEvents()[indexPath.row].eventFinalResult
//        latestCell.team1.text = viewModel?.getLatestEvents()[indexPath.row].eventHomeTeam
//        latestCell.team2.text = viewModel?.getLatestEvents()[indexPath.row].eventAwayTeam
//        let logo1 = viewModel?.getLatestEvents()[indexPath.row].homeTeamLogo ?? " "
//        let imageURL = URL(string: logo1)
//        
//        // Use Kingfisher to set the image from URL
//        latestCell.img1.kf.setImage(with: imageURL, placeholder: UIImage(named: "placeh"), options: [.transition(.fade(0.2))], completionHandler: { result in
//            switch result {
//            case .success(_):
//                print("Image loaded successfully")
//            case .failure(let error):
//                print("Error loading image: \(error)")
//            }
//        })
//        
//        let logo2 = viewModel?.getLatestEvents()[indexPath.row].awayTeamLogo ?? " "
//        let imageURL2 = URL(string: logo2)
//        
//        // Use Kingfisher to set the image from URL
//        latestCell.img2.kf.setImage(with: imageURL2, placeholder: UIImage(named: "placeh"), options: [.transition(.fade(0.2))], completionHandler: { result in
//            switch result {
//            case .success(_):
//                print("Image loaded successfully")
//            case .failure(let error):
//                print("Error loading image: \(error)")
//            }
//        })
//    //}
//    return latestCell
//}
//else {
//        if let teamName = viewModel?.getTeams2()[indexPath.row].teamName {
//            teamCell.teamName.text = teamName
//            let logo1 = viewModel?.getTeams2()[indexPath.row].teamLogo ?? " "
//            let imageURL = URL(string: logo1)
//            
//            // Use Kingfisher to set the image from URL
//            teamCell.logo.kf.setImage(with: imageURL, placeholder: UIImage(named: "placeh"), options: [.transition(.fade(0.2))], completionHandler: { result in
//                switch result {
//                case .success(_):
//                    print("Image loaded successfully")
//                case .failure(let error):
//                    print("Error loading image: \(error)")
//                }
//            })
//          
//        } else {
//            teamCell.teamName.text = "Team Name Not Available"
//        }
//        return teamCell
//    }
//
//}
