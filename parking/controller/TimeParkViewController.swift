//
//  SecondViewController.swift
//  parking
//
//  Created by Андрей Коновалов on 13.04.2024.
//

import UIKit
import SnapKit

class TimeParkViewController: UIViewController {
    
    var topConstraint: Constraint?
    var heightConstraint: Constraint?
    
    lazy var ParkButton: UIButton = {
        let UIView = UIButton()
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Park", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .black
        view.addSubview(button)
        return button
    }()
    
    private lazy var numberPark: UILabel = {
        let label = UILabel()
        label.text = "Parking №0307"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28, weight: .medium)
        view.addSubview(label)
        return label
    }()
    
    private lazy var distancePark: UILabel = {
        let label = UILabel()
        label.text = "City parking 3730.8"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = UIColor(red: 180/255.0, green: 180/255.0, blue: 180/255.0, alpha: 255/255.0)
        view.addSubview(label)
        return label
    }()
    
    private lazy var timePark: UILabel = {
        let label = UILabel()
        label.text = "Min parking time - "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .medium)
        view.addSubview(label)
        return label
    }()
    
    private lazy var sesionTimePark: UILabel = {
        let label = UILabel()
        label.text = "The session will run untill 10:01"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = UIColor(red: 180/255.0, green: 180/255.0, blue: 180/255.0, alpha: 255/255.0)
        view.addSubview(label)
        return label
    }()
    
    private lazy var picker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .countDownTimer
        picker.date = Date()
        picker.addTarget(self, action: #selector(pickerValueChanged(_:)), for: .valueChanged)
        picker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picker)
        return picker
    }()
    
    private lazy var leftButtonView: UIImageView = {
        var  leftButtonView = UIImageView(image: UIImage(systemName: "chevron.left"))
        leftButtonView.tintColor = .white
        leftButtonView.translatesAutoresizingMaskIntoConstraints = false
        return leftButtonView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        
        let customBarButtonItem = UIBarButtonItem(customView: leftButtonView)
        navigationItem.leftBarButtonItem = customBarButtonItem
        leftButtonView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeView) )
        leftButtonView.addGestureRecognizer(tapGesture)
        
        updateLabelDate()
    }
}

extension TimeParkViewController{
    
    @objc func closeView() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromBottom
        
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.popViewController(animated: false)
    }
    
    override func viewWillAppear( _ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let parkingViewController = navigationController?.viewControllers.first as? ParkingViewController {
            parkingViewController.paymentButton.isHidden = true
        }
    }
    
    override func viewWillDisappear( _ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let parkingViewController = navigationController?.viewControllers.first as? ParkingViewController {
            parkingViewController.paymentButton.isHidden = false
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            heightConstraint = make.height.equalTo(500).constraint
            topConstraint = make.top.equalToSuperview().offset(UIScreen.main.bounds.size.height - 500).constraint
        }
    }
    
    private func updateLabelDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "HH 'hours' mm 'min'"
        timePark.text = "Min parking time - \(dateFormatter.string(from: picker.date))"
    }
    
    @objc private func pickerValueChanged(_ sender: UIDatePicker){
        updateLabelDate()
    }
    
    private func setupUI() {
        
        numberPark.snp.makeConstraints{make in
            make.top.equalTo(view).offset(30)
            make.centerX.equalTo(view)
        }
        
        distancePark.snp.makeConstraints{make in
            make.top.equalTo(numberPark.snp.bottom).offset(10)
            make.centerX.equalTo(view)
        }
        
        picker.snp.makeConstraints{make in
            make.top.equalTo(distancePark.snp.bottom).offset(10)
            make.centerX.equalTo(view)
        }
        
        timePark.snp.makeConstraints{make in
            make.bottom.equalTo(picker.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
        
        sesionTimePark.snp.makeConstraints{make in
            make.bottom.equalTo(timePark.snp.bottom).offset(30)
            make.centerX.equalTo(view)
        }
        
        ParkButton.snp.makeConstraints{make in
            make.bottom.equalToSuperview().offset(-30)
            make.centerX.equalToSuperview()
            make.width.equalTo(320)
            make.height.equalTo(70)
        }
        
        leftButtonView.snp.makeConstraints{make in
            make.width.equalTo(20)
            make.height.equalTo(25)
        }
    }
}
