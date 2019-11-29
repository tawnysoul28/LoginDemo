@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let container = AppContainer.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.authIfNedded()
        
        return true
    }
    
    func authIfNedded() {
        guard self.container.authService.aurorized else { return }
    
        self.window?.rootViewController = self.container.homeVC()
        self.window?.makeKeyAndVisible()
    }
}
