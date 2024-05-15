//
//  EventsCollectionViewController.swift
//  SportsSync
//
//  Created by Elham on 12/05/2024.
//

import UIKit

class EventsCollectionViewController: UIViewController {

    
    
    var viewModel : EventsViewModel?
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leagueId = "205"
        viewModel = EventsViewModel()
       
        // Do any additional setup after loading the view.
        viewModel?.bindLeaguesToViewController = { [weak self] in
            print ("inside CollectionViewController")
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        viewModel?.fetchTeams(teamId: "62" )
        viewModel?.fetchLatestResults(leagueId: leagueId)
        viewModel?.fetchUpcomingEvents(leagueId: leagueId)
                
        collectionView.delegate = self
        collectionView.dataSource = self
        
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
            
           
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(180))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            section.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
            
          
            let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
            
            return section
        }
        
      
    
        func createLatestEventsSectionLayout() -> NSCollectionLayoutSection {
            
                    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                          heightDimension: .absolute(180))
            
                    let item = NSCollectionLayoutItem(layoutSize: itemSize)
                    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 4)
            
                    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                           heightDimension: .absolute(180))
            
                    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
                   
                    let section = NSCollectionLayoutSection(group: group)
                    section.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 8, bottom: 8, trailing: 4)
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
                case 2:
                    return viewModel?.getTeams().count ?? 0
                    
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
            upCell.name1.text = viewModel?.getUpcomingEvents()[indexPath.row].eventHomeTeam
            upCell.name2.text = viewModel?.getUpcomingEvents()[indexPath.row].eventAwayTeam
            
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
           
            return upCell
        } else if(indexPath.section == 1){
            latestCell.team1.text = viewModel?.getLatestEvents()[indexPath.row].eventHomeTeam
            latestCell.team2.text = viewModel?.getLatestEvents()[indexPath.row].eventAwayTeam
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
           
            return latestCell
        }
        else {
                if let teamName = viewModel?.getTeams()[indexPath.row].teamName {
                    teamCell.teamName.text = teamName
                    let logo1 = viewModel?.getTeams()[indexPath.row].teamLogo ?? " "
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
                    print("Team Name\(teamName)")
                } else {
                    teamCell.teamName.text = "Team Name Not Available"
                }
                return teamCell
            }
       // return upCell
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
    
    

        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if indexPath.section == 2 {
                print("hello")
                let teamDetails = self.storyboard?.instantiateViewController(withIdentifier: "teamDetails") as! TeamDetailsViewController
                teamDetails.eventsViewModel = viewModel
                teamDetails.index = indexPath.row
                navigationController?.pushViewController(teamDetails, animated: true)
            }
        }
    

}
