final class OnboardingPresenter {
    
    private weak var view: IRouter?
    private let authService: AuthService
    
    init(view: IRouter, authService: AuthService) {
        self.view = view
        self.authService = authService
    }
 
    func onSignInTapEvent(login: String, password: String) {
        if self.authService.isAuthorized(user: login, with: password) {
            self.view?.pushVC("HomeVC")
        } else {
            self.view?.showAlert(title: "Warning!", message: "Login or password isn't matching")
        }
    }
}
