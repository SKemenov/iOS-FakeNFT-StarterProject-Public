import UIKit

final class TabBarController: UITabBarController {
    
    let servicesAssembly = ServicesAssembly(
        networkClient: DefaultNetworkClient(),
        nftStorage: NftStorageImpl()
    )
    
    private let catalogTabBarItem = UITabBarItem(
        title: NSLocalizedString("Tab.catalog", comment: ""),
        image: UIImage(named: "сatalog"),
        tag: 0
    )
    
    private let cartTabBarItem = UITabBarItem(
        title: NSLocalizedString("Tab.cart", comment: ""),
        image: UIImage(named: "сart"),
        tag: 1
    )
    
    private let orderTabBarItem = UITabBarItem(
        title: NSLocalizedString("Tab.cart", comment: ""),
        image: UIImage.cartDelete,
        tag: 2
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let catalogController = TestCatalogViewController(
            servicesAssembly: servicesAssembly
        )
        
        let orderViewController = OrderViewController(
            servicesAssembly: servicesAssembly,
            service: servicesAssembly.orderService
        )
        
        orderViewController.tabBarItem = orderTabBarItem
        
        catalogController.tabBarItem = catalogTabBarItem
        
        let navigationController = UINavigationController(rootViewController: CartViewController())
        navigationController.tabBarItem = cartTabBarItem
        
        viewControllers = [catalogController, navigationController, orderViewController]
        
        view.backgroundColor = UIColor.ypWhiteDay
        tabBar.backgroundColor = UIColor.ypWhiteDay
        tabBar.tintColor = UIColor.ypBlueUniversal
        tabBar.unselectedItemTintColor = UIColor.ypBlackDay
    }
}
