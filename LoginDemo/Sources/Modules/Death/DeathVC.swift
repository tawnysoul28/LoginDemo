import UIKit
import UserNotifications

let deathAgeM = 68
let deathAgeF = 78
let notifIdentifire = "MyUniqueIdentifier"

final class DeathVC: UIViewController, IRouter {
    
    private var timer: Timer?
    
    //MARK: - Outlets
    @IBOutlet weak var habitText: UITextField!
    @IBOutlet weak var habitLabel: UILabel!
    
    @IBOutlet weak var deathAgeLabel: UILabel!
    
    private var authService: AuthService { return AppContainer.shared.authService }
    private var storage = AppContainer.shared.storage
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateLabel()
        self.loadHabit()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createTime()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTime()
    }
    
    //MARK: - User actions
    @IBAction func sendNotifications(_ sender: Any) {
        guard let habitUserInput = self.habitText.text, !habitUserInput.isEmpty
            else {
                removeNotifications(withIdentifiers: [notifIdentifire])
                updateHabit()
                self.showAlert(title: "Alert", message: "Fill in the habit")
                return
        }
        
        scheduleNotifications(title: habitUserInput, inSeconds: 10, completion: { (success) in
            if success {
                print("We send it")
            } else {
                print("Failed")
            }
        })
        
        updateHabit()
    }
}

extension DeathVC {
    
    func updateHabit() {
        guard var user = self.authService.currentUser else {
            self.habitLabel.text = nil
            return
        }
        let habitUserInput = habitText.text ?? ""
        user.habit = habitUserInput
        self.storage.currentUser = user
        habitLabel.text = habitUserInput
        print(user.password, user.habit)
    }
    
    func loadHabit() {
        guard let user = self.authService.currentUser else {
            self.habitLabel.text = nil
            return
        }
        print("юзер хэбит: \(user.habit)")
        habitLabel.text = user.habit
    }
    
    func scheduleNotifications(title: String, inSeconds seconds: TimeInterval, completion: @escaping (Bool) -> ()) {
        
        removeNotifications(withIdentifiers: ["MyUniqueIdentifier"])
        
        let center = UNUserNotificationCenter.current()
        
        //Шаг 3: Создать тригер уведомления. (когда показывать)
        let date = Date(timeIntervalSinceNow: seconds)
        print(Date())
        print(date)
        
        // Шаг 2: Создать содержимое уведомления
        let content =  UNMutableNotificationContent()
        content.title = "Не забудь, сегодня \(title)!" //"Notification!" //user.habit
        content.body = "Ты сможешь! Сделай это!"
        content.sound = UNNotificationSound.default
        
        let dateComponents = Calendar.current.dateComponents([/*.hour, .minute,*/ .second], from: date)
        
        let triger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "MyUniqueIdentifier", content: content, trigger: triger)
        
        // Шаг 5: Зарегестрировать запрос
        center.add(request) { (error) in
            if error != nil {
                completion(false)
            } else {
                completion(true)
            }
            //            completion(false)
            // Chech the error parameter and handle any errors
        }
    }
    
    func removeNotifications(withIdentifiers identifiers: [String]) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
    }
    
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
