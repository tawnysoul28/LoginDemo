import UIKit

//как вычесть todayDate (Date) из deathAge (Int)?
let deathAge = 74

final class DeathVC: UIViewController, IRouter {
    
    @IBOutlet weak var deathAgeLabel: UILabel!
    
    
    private var authService: AuthService { return AppContainer.shared.authService }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = self.authService.currentUser {
            self.deathAgeLabel.text = "\(getAgeFromDOF(date: user.birthDate))"
        }
    }
}

extension DeathVC {
    
    func getAgeFromDOF(date: Date) -> (String) {
        
        let calender = Calendar.current
        
        let dateComponent = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from:
            date, to: Date())
        
        return "\(dateComponent.year!) лет \n \(dateComponent.month!) месяцев \n \(dateComponent.day!) дней \n \(dateComponent.hour!) часов \n \(dateComponent.minute!) минут \n \(dateComponent.second!) секунд"
    }
}
