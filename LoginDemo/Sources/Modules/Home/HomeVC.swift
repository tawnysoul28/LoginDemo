import UIKit

class HomeVC: UIViewController, IRouter {
//    private var timer: Timer?

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var currentAge: UILabel!
    
    private var authService: AuthService { return AppContainer.shared.authService }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if let user = self.authService.currentUser {
            self.usernameLabel.text = "Привет, \(user.name). Твой точный возраст:"
            self.currentAge.text = "\(getAgeFromDOF(date: user.birthDate))"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        createTime()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        stopTime()
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        self.authService.unauthorize()
        
        self.showRoot("OnboardingVC")
    }
}

extension HomeVC {
    
    func getAgeFromDOF(date: Date) -> (String) {
        
        let calender = Calendar.current
        
        let dateComponent = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from:
            date, to: Date())
        
        return "\(dateComponent.year!) лет \n \(dateComponent.month!) месяцев \n \(dateComponent.day!) дней \n \(dateComponent.hour!) часов \n \(dateComponent.minute!) минут \n \(dateComponent.second!) секунд"
    }
    
//    @objc func updateTime() {
//        let string = getAgeFromDOF(date: user.birthDate)
//        self.currentAge.text = string
//    }
//
//    func createTime() {
//        // 1
//        if self.timer == nil {
//            // 2
//            self.timer = Timer.scheduledTimer(timeInterval: 1.0,
//                                              target: self,
//                                              selector: #selector(updateTime),
//                                              userInfo: nil,
//                                              repeats: true)
//        }
//    }
    
//    func stopTime() {
//        self.timer?.invalidate()
//    }
}
