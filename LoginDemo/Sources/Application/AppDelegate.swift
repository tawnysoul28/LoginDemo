import UserNotifications
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let container = AppContainer.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.authIfNedded()
        
        let center = UNUserNotificationCenter.current()
        
        // Шаг 1: Спросить разрешения
        center.requestAuthorization(options: [.alert, .sound])
        { (granted, error) in
            //если юзер отказывается, здесь можно написать, что включить можно в настройках
        }
        
        return true
    }
    
    func authIfNedded() {
        guard self.container.authService.aurorized else { return }
    
        self.window?.rootViewController = self.container.homeVC()
        self.window?.makeKeyAndVisible()
    }
}
