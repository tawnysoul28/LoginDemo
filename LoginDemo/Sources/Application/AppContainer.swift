class AppContainer {
    
    static let shared = AppContainer()
    
    private(set) lazy var authService: AuthService = { [unowned self] in
        return AuthService(storage: self.storage)
    }()
    
    private let storage = UserDefaults.standard
    
    private init() {
        
    }
    
    func homeVC() -> UIViewController {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeVC")
        let navigationVC = UINavigationController(rootViewController: vc)
        return navigationVC
    }
    
    func presenter(for vc: OnboardingVC) -> OnboardingPresenter {
        return OnboardingPresenter(view: vc, authService: self.authService)
    }
    
}
