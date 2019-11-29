protocol IRouter: AnyObject {
    var storyboard: UIStoryboard? { get }
    
    func pushVC(_ identifier: String)
    func showAlert(title: String, message: String)
    func showRoot(_ identifier: String)
}

extension IRouter where Self: UIViewController {
    
    func pushVC(_ identifier: String) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: identifier) else {
            assertionFailure("VC must not be nil")
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "Ok", style: .default) {
                (action: UIAlertAction!) in
                print("Ok button tapped")
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showRoot(_ identifier: String) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: identifier)
        let navigationVC = UINavigationController(rootViewController: vc!)
        let sharedDelegate = UIApplication.shared.delegate as? AppDelegate
        sharedDelegate?.window?.rootViewController = navigationVC
        sharedDelegate?.window?.makeKeyAndVisible()
    }
    
}
