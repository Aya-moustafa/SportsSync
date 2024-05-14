//
//  TeamDetailsViewController.swift
//  SportsSync
//
//  Created by Elham on 13/05/2024.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    
    @IBOutlet weak var CoatcheNameLabel: UILabel!
    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var sportLabel: UILabel!
    var eventsViewModel:EventsViewModel?
    var index : Int?
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
       // teamLogo.image =  eventsViewModel?.getTeam().teamLogo
        CoatcheNameLabel.text = eventsViewModel?.getCoaches(index: index ?? 0 )[0].coachName
        teamNameLabel.text = eventsViewModel?.getTeam(index: index ?? 0).teamName
        
        // Do any additional setup after loading the view.
    }
    

}


extension TeamDetailsViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return (eventsViewModel?.getPlayers(index: index!).count)!
               
            }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let padding: CGFloat =  12
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/3, height: (self.view.frame.width * 0.45))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 50)
        }
        
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            if kind == UICollectionView.elementKindSectionHeader {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! TeamSectionHeader
                
                headerView.headerLable.text = "TEAM"
                
                return headerView
            } else {
                return UICollectionReusableView()
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let playerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerCell", for: indexPath) as! PlayerCollectionViewCell
     
        playerCell.playerName.text = eventsViewModel?.getPlayers(index: index ?? 0)[indexPath.row].playerName
        playerCell.playerTyper.text = eventsViewModel?.getPlayers(index: index ?? 0)[indexPath.row].playerType
     playerCell.playerNumber.setTitle(eventsViewModel?.getPlayers(index: index ?? 0)[indexPath.row].playerNumber, for: .normal)

                return playerCell
        
      
    }
    
    

        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         
                print("hello")
//                let teamDetails = self.storyboard?.instantiateViewController(withIdentifier: "teamDetails") as! TeamDetailsViewController
//                teamDetails.teamOfPlayers = viewModel?.getTea
//                navigationController?.pushViewController(teamDetails, animated: true)
            }
        
    

}
