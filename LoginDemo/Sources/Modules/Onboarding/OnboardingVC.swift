// ВОПРОС 2. КАК ОТ СКРОЛЛ ВС СДЕЛАТЬ КАЛЕНДАРЬ ВС.

final class OnboardingVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var loginText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    
    //MARK: - Module state
    private lazy var presenter: OnboardingPresenter = { return AppContainer.shared.presenter(for: self) }()
    
    private var timer: Timer?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
    @IBAction func signInButton(_ sender: Any) {
        let loginUserInput = loginText.text ?? ""
        let passwordUserInput = passwordText.text ?? ""
        presenter.onSignInTapEvent(login: loginUserInput, password: passwordUserInput)
     
    }
    
    @IBAction func signUpButton(_ sender: Any) {
    }
}

extension OnboardingVC: IRouter {
    
    @objc func updateTime() {
        let string = DateFormatter.medium.string(from: Date())
        self.timeLabel.text = string
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
    }
    ////////////////////////////////////////
}
