import UIKit

let retirementAgeM = 65
let retirementAgeF = 60

final class RetiremnetVC: UIViewController, IRouter {
    
    @IBOutlet weak var retirementAgeLabel: UILabel!
    
    @IBOutlet weak var factLabel: UILabel!
    
    private var timer: Timer?
    private var authService: AuthService { return AppContainer.shared.authService }
    private let stringsService = RetirementPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.updateLabel()
        
        self.updateFact()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createTime()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTime()
    }
    @IBAction func nextFactButton(_ sender: Any) {
        updateFact()
    }
    
}

extension RetiremnetVC {
    
    func updateFact() {
        guard let user = self.authService.currentUser else {
            self.factLabel.text = nil
            return
        }
        
        var age: Int
        switch user.gender {
        case .male:
            age = getAgeTillRet(birthDay: user.birthDate, years: retirementAgeM)
        case .female:
            age = getAgeTillRet(birthDay: user.birthDate, years: retirementAgeF)
        }
        
        let rublesPerYearExtra = 100 * 365
        let rublesPerYearSmoke = 29869
        
        let extraMoneySave = age * rublesPerYearExtra
        let smokeMoneySave = age * rublesPerYearSmoke
        
        let stringFormat = "К этому времени у вас будет %d дополнительных рублей, если сегодня вы начнете откладывать 100 рублей каждый день. \nПлюс около %d рублей, если вы бросите курить."
        
        let tuple = self.stringsService.nextString()
        self.factLabel.text = String(format: tuple.string, extraMoneySave)
        
//        factLabel.text = String(format: stringFormat, extraMoneySave, smokeMoneySave)
        
    }
    
//    func didTapButton() {
//        let tuple = self.stringsService.nextString()
//        self.factLabel.text = String(format: tuple.string, tuple.index)
//    }
    
    func getAgeTillRet(birthDay: Date, years: Int) -> Int {
        let calender = Calendar.current
        let finalDateComp = DateComponents(year: years)
        let finalDate = calender.date(byAdding: finalDateComp, to: birthDay)
        let untilFinalDateComp = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date(), to: finalDate!)
        
        return untilFinalDateComp.year!
    }
   
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
