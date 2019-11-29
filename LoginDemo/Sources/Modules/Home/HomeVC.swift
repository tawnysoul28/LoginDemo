import UIKit

class HomeVC: UIViewController, IRouter {

    @IBOutlet weak var usernameLabel: UILabel!
    
    private var authService: AuthService { return AppContainer.shared.authService }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = self.authService.currentUser {
            self.usernameLabel.text = "Hello, \(user). Твой точный возраст:"
        }
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        self.authService.unauthorize()
        
        self.showRoot("OnboardingVC")
    }
    

}
