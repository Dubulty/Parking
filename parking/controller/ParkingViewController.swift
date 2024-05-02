//
//  ParkingViewController.swift
//  parking
//
//  Created by Андрей Коновалов on 13.04.2024.
//

import UIKit
import SnapKit

class ParkingViewController: UITableViewController {
    
    var fullScreen = false
    var topConstraint: Constraint?
    var heightConstraint: Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        let customBarButtonItem = UIBarButtonItem(customView: leftButtonView)
        navigationItem.leftBarButtonItem = customBarButtonItem
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        
        view.backgroundColor = UIColor(red: 242/255.0, green: 240/255.0, blue: 248/255.0, alpha: 255/255.0)
        
        tableView.register(MainFixedCell.self, forCellReuseIdentifier: MainFixedCell.identifier)
        tableView.register(CongestionOpenCell.self, forCellReuseIdentifier: CongestionOpenCell.identifier)
        tableView.register(CostOpenCell.self, forCellReuseIdentifier: CostOpenCell.identifier)
        
        tableView.contentInset = UIEdgeInsets(top: 80, left: 0, bottom: 0, right: 0)
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        view.addGestureRecognizer(swipeGesture)
    }
    
    lazy var paymentButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Pay for parking", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(timeParking), for: .touchUpInside)
        button.backgroundColor = .black
        UIApplication.shared.windows.first?.addSubview(button)
        return button
    }()
    
    private lazy var customTitleView: UIView = {
        let customTitleView = UIView()
        customTitleView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customTitleView)
        return customTitleView
    }()
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Parking 0307"
        label.font = .boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        customTitleView.addSubview(label)
        return label
    }()
    
    private lazy var distanceParkingLabel: UILabel = {
        let label = UILabel()
        label.text = "Citry parking 3730.8 km"
        label.textColor = UIColor(red: 180/255.0, green: 180/255.0, blue: 180/255.0, alpha: 255/255.0)
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        customTitleView.addSubview(label)
        return label
    }()
    
    private lazy var leftButtonView: UIImageView = {
        var  leftButtonView = UIImageView(image: UIImage(systemName: "chevron.left"))
        leftButtonView.tintColor = .white
        leftButtonView.translatesAutoresizingMaskIntoConstraints = false
        return leftButtonView
    }()
    
    @objc func refreshButtonTapped(_ sender: UIButton) {
        tableView.reloadData()
    }
}

extension ParkingViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            heightConstraint = make.height.equalTo(750).constraint
            topConstraint = make.top.equalToSuperview().offset(UIScreen.main.bounds.size.height - 750).constraint
        }
    }
    
    @objc func handleSwipe(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let screenHeight = UIScreen.main.bounds.size.height
        
        if gesture.state == .changed {
            let newHeight = max(screenHeight - translation.y, screenHeight / 2)
            let newTop = max(translation.y + (fullScreen ? 0 : screenHeight / 2), 0)
            
            heightConstraint?.update(offset: newHeight)
            topConstraint?.update(offset: newTop)
            
            view.superview?.layoutIfNeeded()
        } else if gesture.state == .ended {
            let velocity = gesture.velocity(in: view)
            if velocity.y > 0 {
                minimizeView()
            } else {
                maximizeView()
            }
        }
    }
    
    func maximizeView() {
        UIView.animate(withDuration: 0.3) {
            let screenSize = UIScreen.main.bounds.size
            self.heightConstraint?.update(offset: 750)
            self.topConstraint?.update(offset: screenSize.height - 750)
            self.view.superview?.layoutIfNeeded() 
        }
        fullScreen = true
    }
    
    func minimizeView() {
        UIView.animate(withDuration: 0.3) {
            let screenSize = UIScreen.main.bounds.size
            self.topConstraint?.update(offset: screenSize.height - 500)
            self.view.superview?.layoutIfNeeded()
        }
        fullScreen = false
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell =  tableView.dequeueReusableCell(withIdentifier: MainFixedCell.identifier, for: indexPath) as! MainFixedCell
            return cell
        case 1:
            let cell =  tableView.dequeueReusableCell(withIdentifier: CongestionOpenCell.identifier, for: indexPath) as! CongestionOpenCell
            cell.sectionButton.addTarget(self,action: #selector(refreshButtonTapped(_:)), for: .touchUpInside)
            return cell
        case 2:
            let cell =  tableView.dequeueReusableCell(withIdentifier: CostOpenCell.identifier, for: indexPath) as! CostOpenCell
            cell.sectionButton.addTarget(self,action: #selector(refreshButtonTapped(_:)), for: .touchUpInside)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    @objc func timeParking() {
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.pushViewController(TimeParkViewController(), animated: false)
    }
    
    private func setupUI() {
        
        paymentButton.snp.makeConstraints{make in
            make.bottom.equalToSuperview().offset(-30)
            make.centerX.equalToSuperview()
            make.width.equalTo(320)
            make.height.equalTo(70)
        }
        
        leftButtonView.snp.makeConstraints{make in
            make.width.equalTo(20)
            make.height.equalTo(25)
        }
        
        mainLabel.snp.makeConstraints{make in
            make.top.equalTo(customTitleView)
            make.centerX.equalTo(customTitleView)
        }
        
        distanceParkingLabel.snp.makeConstraints{make in
            make.top.equalTo(mainLabel.snp.bottom).offset(5)
            make.centerX.equalTo(customTitleView)
        }
        
        customTitleView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.height.equalTo(5)
        }
    }
}
