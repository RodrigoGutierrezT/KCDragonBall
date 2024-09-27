//
//  HeroListViewController.swift
//  KCDragonBall
//
//  Created by Rodrigo on 26-09-24.
//

import UIKit

final class HeroListViewController: UITableViewController {
    
    // MARK: - Table View DataSource
    typealias DataSource = UITableViewDiffableDataSource<Int, Hero>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Hero>
    
    // MARK: - Model
    private let heros: [Hero] = []
    private let networkModel: NetworkModel
    private var dataSource: DataSource?
    
    // MARK: - Components
    private var activityIndicator: UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        return spinner
    }
    
    // MARK: - Initializers
    init(networkModel: NetworkModel = .shared) {
        self.networkModel = networkModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = activityIndicator
        
        // 1. Registrar la celda custom
        // Registramos la celda que hemos creado de forma personalizada
        tableView.register(
            // Instanciamos el archivo .xib a traves de su numbre
            UINib(nibName: HeroTableViewCell.identifier, bundle: nil),
            // Cada vez que TableView se encuentre este identificador
            // tiene que instanciar el .xib que le especificamos
            forCellReuseIdentifier: HeroTableViewCell.identifier
        )
        
        // 2. Configurar el data source
        dataSource = DataSource(tableView: tableView) { tableView, indexPath, hero in
            // Obtenemos una celda reusable y la casteamos a
            // el tipo de celda que queremos representar
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: HeroTableViewCell.identifier,
                for: indexPath
            ) as? HeroTableViewCell else {
                // Si no podemos desempaquetarla
                // retornamos una celda en blanco
                return UITableViewCell()
            }
            cell.configure(with: hero)
            return cell
        }
        
        // 3. Añadir el data source al table view
        tableView.dataSource = dataSource
        tableView.delegate = self
        
        // 4. Crear un snapshot con los objetos a representar
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(heros)
        
        // 5. Aplicar el snapshot al data source para añadir los objetos
        networkModel.getHeros { [weak self] result in
            switch result {
                case let .success(heros):
                    snapshot.appendItems(heros)
                    self?.dataSource?.apply(snapshot)
                case .failure:
                    break
            }
        }
    }
    
}

extension HeroListViewController {
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        120
    }
}
