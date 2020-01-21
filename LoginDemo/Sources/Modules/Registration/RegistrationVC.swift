final class RegistrationVC: UIViewController, IRouter {
    
    private let pickerBirthday = UIDatePicker()
    private var authService: AuthService { return AppContainer.shared.authService }
    
    //Mark: Outlets
    @IBOutlet weak var registLoginText: UITextField!
    @IBOutlet weak var registPasswordText: UITextField!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var registerGenderText: UITextField!

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        pickerBirthday.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pickerBirthday)
        
        pickerBirthday.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pickerBirthday.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pickerBirthday.topAnchor.constraint(equalTo: birthdayLabel.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        pickerBirthday.datePickerMode = .date
        
        let todayDate = Date()
        pickerBirthday.maximumDate = todayDate
        
        pickerBirthday.addTarget(self, action: #selector(birtdateChanged), for: .valueChanged)
        
        title = "Registration"
        
        registLoginText.delegate = self
        registPasswordText.delegate = self
        registerGenderText.delegate = self
    }
    
    //MARK: - User actions
    @IBAction func registerSignUpButton(_ sender: Any) {
        guard let name = self.registLoginText.text, !name.isEmpty,
                let password = self.registPasswordText.text, !password.isEmpty,
                let gender = Gender(rawValue: self.registerGenderText.text ?? "")
        else {
            self.showAlert(title: "Alert", message: "All fields are requaried to fill in")
            return
        }
        
        guard self.authService.register(name: name,
                                        password: password,
                                        birthDate: pickerBirthday.date,
                                        gender: gender) else { return }
        self.pushVC("HomeVC")
    }
    
    @objc
    private func birtdateChanged() {
//        self.birthdayLabel.text = "\(self.pickerBirthday.date)"
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd-MM-yyyy"
        let string = dateFormatterGet.string(from: pickerBirthday.date)
        self.birthdayLabel.text = string
    }
}

extension RegistrationVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        registLoginText.resignFirstResponder()
        registPasswordText.resignFirstResponder()
        registerGenderText.resignFirstResponder()
        return true
    }
}
