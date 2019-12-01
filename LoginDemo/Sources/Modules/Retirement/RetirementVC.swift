import UIKit

//КАК РАССЧИТАТЬ СКОЛЬКО ЛЕТ ДО ПЕНСИИ У ДЕВУШКИ И МУЖЧИНЫ, ЕСЛИ ВОЗРАСТ ЭТО Int, а нам нужно вычесть Date из Int?
let retirementAgeM = 65
let retirementAgeF = 60

final class RetiremnetVC: UIViewController, IRouter {
    
    @IBOutlet weak var retirementAgeLabel: UILabel!
    
    private var authService: AuthService { return AppContainer.shared.authService }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let user = self.authService.currentUser {
            self.retirementAgeLabel.text = "\(getAgeFromDOF(date: user.birthDate))"
        }
    }
}

extension RetiremnetVC {
    
    func getAgeFromDOF(date: Date) -> (String) {
        
        let calender = Calendar.current
        
        let dateComponent = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from:
            date, to: Date())
        
        return "\(dateComponent.year!) лет \n \(dateComponent.month!) месяцев \n \(dateComponent.day!) дней \n \(dateComponent.hour!) часов \n \(dateComponent.minute!) минут \n \(dateComponent.second!) секунд"
    }
}
