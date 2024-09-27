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
        // Instanciamos un tab bar
        let tabBarController = UITabBarController()
        // Instanciamos nuestra lista de casas
        let heroListViewController = HeroListViewController()
        heroListViewController.tabBarItem = UITabBarItem(
            title: "Hero",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        let navigationController = UINavigationController(rootViewController: heroListViewController)
        tabBarController.viewControllers = [navigationController]
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }


}

