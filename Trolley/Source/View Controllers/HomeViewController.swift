import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Actions
    @IBAction func signOutButtonTapped(_ sender: UIBarButtonItem) {
        let dataStore = DataStore()
        dataStore.removeAll(User.self)
        navigationController?.popToRootViewController(animated: true)
    }
}
