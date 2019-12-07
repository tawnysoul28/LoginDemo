import UIKit

let retirementAgeM = 65
let retirementAgeF = 60

final class RetiremnetVC: UIViewController, IRouter {
    
    private var timer: Timer?
    
    @IBOutlet weak var retirementAgeLabel: UILabel!
    
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

extension RetiremnetVC {
   
    func updateLabel() {
        guard let user = self.authService.currentUser else {
            self.retirementAgeLabel.text = nil
            return
        }
        
        var text = ""
        switch user.gender {
        case .male:
            text = getAgeUntilFinalDate(birthDay: user.birthDate, years: retirementAgeM)
        case .female:
            text = getAgeUntilFinalDate(birthDay: user.birthDate, years: retirementAgeF)
        }
        self.retirementAgeLabel.text = text
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
