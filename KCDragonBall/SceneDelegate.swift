//
//  SceneDelegate.swift
//  KCDragonBall
//
//  Created by Rodrigo on 24-09-24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Desempaquetamos la scene
        guard let scene = (scene as? UIWindowScene) else { return }
        // Creamos un objeto window
        let window = UIWindow(windowScene: scene)

        let loginViewController = LoginViewController()
        
        window.rootViewController = loginViewController
        window.makeKeyAndVisible()
        self.window = window
    }
    
    
    // funcion para cambiar el root view controller
    func changeRootViewController(animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        
        let tabBarController = UITabBarController()
        // Instanciamos nuestra lista de casas
        let heroListViewController = HeroListViewController()
        heroListViewController.tabBarItem = UITabBarItem(
            title: "Heroes",
            image: UIImage(systemName: "person.3"),
            selectedImage: UIImage(systemName: "person.3.fill")
        )
        
        let navigationController = UINavigationController(rootViewController: heroListViewController)
        tabBarController.viewControllers = [navigationController]
        
        window.rootViewController = tabBarController
    }


}

