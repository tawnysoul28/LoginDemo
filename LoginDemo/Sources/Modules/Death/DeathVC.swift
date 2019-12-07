import UIKit

let deathAgeM = 68
let deathAgeF = 78

final class DeathVC: UIViewController, IRouter {
    
    private var timer: Timer?
    
    @IBOutlet weak var deathAgeLabel: UILabel!
    
    private var authService: AuthService { return AppContainer.shared.authService }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createTime()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTime()
    }
}

extension DeathVC {
    
    func updateLabel() {
        guard let user = self.authService.currentUser else {
            self.deathAgeLabel.text = nil
            return
        }
        
        var text = ""
        switch user.gender {
        case .male:
            text = getAgeUntilFinalDate(birthDay: user.birthDate, years: deathAgeM)
        case .female:
            text = getAgeUntilFinalDate(birthDay: user.birthDate, years: deathAgeF)
        }
        self.deathAgeLabel.text = text
    }
    
    func getAgeUntilFinalDate(birthDay: Date, years: Int) -> (String) {
        
        let calender = Calendar.current
        let finalDateComp = DateComponents(year: years)
        let finalDate = calender.date(byAdding: finalDateComp, to: birthDay)
        let untilFinalDateComp = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date(), to: finalDate!)
        
        return "\(untilFinalDateComp.year!) лет \n \(untilFinalDateComp.month!) месяцев \n \(untilFinalDateComp.day!) дней \n \(untilFinalDateComp.hour!) часов \n \(untilFinalDateComp.minute!) минут \n \(untilFinalDateComp.second!) секунд"
    }
    
    @objc func updateTime() {
        self.updateLabel()
    }
    
    func createTime() {
        // 1
        if self.timer == nil {
            // 2
            self.timer = Timer.scheduledTimer(timeInterval: 1.0,
                                              target: self,
                                              selector: #selector(updateTime),
                                              userInfo: nil,
                                              repeats: true)
        }
    }
    
    func stopTime() {
        self.timer?.invalidate()
        self.timer = nil
    }
}
