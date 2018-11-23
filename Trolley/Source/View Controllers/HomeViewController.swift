import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private(set) var tableView: UITableView!
    
    // MARK: - Properties
    private(set) var cart: Cart?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        cart = DataStore().fetch(Cart.self)
        tableView.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Actions
    @IBAction func signOutButtonTapped(_ sender: UIBarButtonItem) {
        let dataStore = DataStore()
        dataStore.removeAll(Cart.self)
        dataStore.removeAll(User.self)
        navigationController?.popToRootViewController(animated: true)
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: HomeTableViewCell.id,
            for: indexPath
        ) as! HomeTableViewCell
        
        guard let item = cart?.items[indexPath.row]
            else { return cell }
        
        cell.configure(with: item)
        
        return cell
    }
    
}

class HomeTableViewCell: UITableViewCell {
    
    // MARK: - ID
    static var id: String { return String(describing: self) }
    
    // MARK: - Outlets
    @IBOutlet private(set) var nameLabel: UILabel!
    @IBOutlet private(set) var qtyLabel: UILabel!
    @IBOutlet private(set) var priceLabel: UILabel!
    
    // MARK: - Configuration
    func configure(with item: CartItem) {
        nameLabel.text = item.name
        qtyLabel.text = "Qty: \(item.quantity)"
        priceLabel.text = "$\(item.price)"
    }
}
