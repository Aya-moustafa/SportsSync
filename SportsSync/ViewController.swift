import UIKit

class ViewController: UIViewController {
    
    let viewModel = EventsViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let leagueId = "205" // Assuming this is the league ID
        
        // Fetch latest results
//        viewModel.latestResultsHandler = { result in
//            switch result {
//            case .success(let events):
//                print("Received latest results: \(events.count)")
//                for event in events {
//                    print("Event Key: \(event.eventKey ?? 0)")
//                    print("Event Date: \(event.eventDate ?? "")")
//                    // Print other event properties as needed
//                }
//            case .failure(let error):
//                print("Error fetching latest results: \(error)")
//            }
//        }
//        viewModel.getLatestResults(leagueId: leagueId)
//        
//        // Fetch teams
//        viewModel.teamsHandler = { result in
//            switch result {
//            case .success(let teams):
//                print("Received teams: \(teams.count)")
//                for team in teams {
//                    print("Team Key: \(team.teamKey ?? 0)")
//                    print("Team Name: \(team.teamName ?? "")")
//                    // Print other team properties as needed
//                }
//            case .failure(let error):
//                print("Error fetching teams: \(error)")
//            }
//        }
//        viewModel.getTeams(leagueId: "62")
//        
//        // Fetch upcoming events
//        viewModel.upcomingEventsHandler = { result in
//            switch result {
//            case .success(let events):
//                print("Received upcoming events: \(events.count)")
//                for event in events {
//                    print("Event Key: \(event.eventKey ?? 0)")
//                    print("Event Date: \(event.eventDate ?? "")")
//                    // Print other event properties as needed
//                }
//            case .failure(let error):
//                print("Error fetching upcoming events: \(error)")
//            }
//        }
//        viewModel.getUpcomingEvents(leagueId: leagueId)
    }
}
