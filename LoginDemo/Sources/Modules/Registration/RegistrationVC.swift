final class RegistrationVC: UIViewController, IRouter {
    
    private let pickerBirthday = UIDatePicker()
    private var authService: AuthService { return AppContainer.shared.authService }
    
    //Mark: Outlets
    @IBOutlet weak var registLoginText: UITextField!
    @IBOutlet weak var registPasswordText: UITextField!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    //ВОПРОС 1. КАК ПРАВИЛЬНО СДЕЛАТЬ ПРЕЗЕНТЕР?
    //MARK: - Module state
//    private lazy var presenter: IRegistrationPresenter = {
//        // TODO: Should be injected on assembly layer
//        return RegistrationPresenter(view: self)
//    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ВОПРОС 2. КАК ЭТО ВСЁ ПЕРЕМЕСТИТЬ В ПЕРЗЕНТЕР?
        pickerBirthday.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pickerBirthday)
        
        pickerBirthday.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pickerBirthday.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pickerBirthday.topAnchor.constraint(equalTo: birthdayLabel.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        pickerBirthday.datePickerMode = .date
        
        let todayDate = Date()
        pickerBirthday.maximumDate = todayDate
    }
    
    //MARK: - User actions
    @IBAction func registerSignUpButton(_ sender: Any) {
        guard self.authService.register(user: self.registLoginText.text,
                                        password: self.registPasswordText.text) else {
            self.showAlert(title: "Alert", message: "All fields are requaried to fill in")
            return
        }
        
//        let birthDateInput = pickerBirthday.date //сохранение даты
        
        self.pushVC("HomeVC")
    }
}
