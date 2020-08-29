//
//  CarListViewController.swift
//  Cars
//
//  Created by Ravi Vora on 25/8/2563 BE.
//  Copyright © 2563 Ravi Vora. All rights reserved.
//

import UIKit

protocol CarListView {
    func displayCarList(axCarList: [CarListModel.ViewModel])
    func showLoading()
    func hideLoading()
    func showAlertError(error: String?)
}

class CarListViewController: UIViewController {
    
    @IBOutlet weak var carListTableView: UITableView!
    var interactor: CarListBusinessLogic!
    var router: CarListRouterInterface!
    private var request = CarListModel.Request()
    private var cars: [CarListModel.ViewModel]! = []
    
    
    // MARK: - Initializers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil:
        Bundle?) {
        super.init(nibName: nibNameOrNil, bundle:nibBundleOrNil)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    init(interatcor: CarListBusinessLogic? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.interactor = interatcor
    }
    
    
    // MARK: - Setup
    private func setup() {
        let router = CarListRouter()
        router.viewController = self
        
        let presenter = CarListPresenter(viewController: self)
        presenter.carListView = self
        
        let interactor = CarListInteractor(presenter: presenter)
        interactor.presenter = presenter
        
        self.interactor = interactor
        self.router = router
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
        setUpCarListTableView()
        fetchCars()
    }
    
    override func viewDidLayoutSubviews() {
        self.carListTableView.frame = view.bounds
    }
    
    /*
     * This method will setup NavigationBar
     */
    func setupNavigationBar() {
        self.navigationItem.title = "Cars"
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white,
                                                    .font: UIFont.SFUI(.medium, size: 17.0)]
            navBarAppearance.backgroundColor = UIColor().black25A
            navBarAppearance.shadowColor = nil
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.compactAppearance = navBarAppearance
        } else {
            self.navigationController?.navigationBar.barTintColor = UIColor().black25
            self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.SFUI(.medium, size: 17.0)]
        }
    }
    
    func setupUI() {
        self.carListTableView.rowHeight = UITableView.automaticDimension
        self.carListTableView.estimatedRowHeight = 100
        self.carListTableView.isHidden = true
    }
    
    func setUpCarListTableView() {
        self.carListTableView.separatorInset = .zero
        self.carListTableView.layoutMargins = .zero
        self.carListTableView.contentInsetAdjustmentBehavior = .never
        self.carListTableView.tableFooterView = UIView(frame: .zero)
        
        self.carListTableView.register(UINib(nibName: "CarCell", bundle: nil), forCellReuseIdentifier: "CarCell")
        self.carListTableView.accessibilityIdentifier = "tableView--carListTableView"
    }
    
    private func fetchCars() {
        DispatchQueue.main.async {
            self.interactor.showLoading()
        }
        self.interactor.fetchCarList(request: self.request)
    }
}


extension CarListViewController: CarListView {
    
    func displayCarList(axCarList: [CarListModel.ViewModel]) {
        
        for(index, _) in axCarList.enumerated() {
            let currentCar: CarListModel.ViewModel = axCarList[index]
            self.cars.append(currentCar)
        }
        
        DispatchQueue.main.async {
            self.carListTableView.isHidden = false
            self.carListTableView.delegate = self
            self.carListTableView.dataSource = self
            self.carListTableView.reloadData()
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            Tools.shared.showProgressHUD()
        }
    }
    
    func hideLoading() {
        Tools.shared.hideProgressHUD()
    }
    
    func showAlertError(error: String?) {
        if error == nil {
            presentAlert(withTitle: APP_NAME, message: SERVER_ERROR)
        } else {
            presentAlert(withTitle: APP_NAME, message: error!)
        }
    }
}

extension CarListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = self.cars {
            return data.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell", for: indexPath) as? CarCell {
            cell.accessibilityIdentifier = "CarCell\(indexPath.row)"
            let data = self.cars[indexPath.row]
            cell.prepareCell(with: data)
            return cell
        }
        return UITableViewCell()
    }
}

extension CarListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}
