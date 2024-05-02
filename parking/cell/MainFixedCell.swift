//
//  OneCell.swift
//  parking
//
//  Created by Андрей Коновалов on 13.04.2024.
//

import UIKit
import SnapKit

class MainFixedCell: UITableViewCell {
    
    static let identifier = "MainFixedCell"
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 255/255.0)
        view.layer.cornerRadius = 15
        self.contentView.addSubview(view)
        return view
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(view)
        return view
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$2/hours"
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.topView.addSubview(label)
        return label
    }()
    
    private lazy var placesLabel: UILabel = {
        let label = UILabel()
        label.text = "Place total: 11"
        label.textColor = UIColor(red: 180/255.0, green: 180/255.0, blue: 180/255.0, alpha: 255/255.0)
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.topView.addSubview(label)
        return label
    }()
    
    private lazy var disavledPlacesLabel: UILabel = {
        let label = UILabel()
        label.text = "3"
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.topView.addSubview(label)
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "4 Buckingham palace rd"
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.bottomView.addSubview(label)
        return label
    }()
    
    private lazy var paymentLabel: UILabel = {
        let label = UILabel()
        label.text = "Payment online"
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.bottomView.addSubview(label)
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "24 Hours"
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.bottomView.addSubview(label)
        return label
    }()
    
    private lazy var oyaView: UIImageView = {
        var oyaView = UIImageView(image: UIImage(named: "oya"))
        oyaView.translatesAutoresizingMaskIntoConstraints = false
        self.topView.addSubview(oyaView)
        return oyaView
    }()
    
    private lazy var disabledView: UIImageView = {
        var view = UIImageView(image: UIImage(systemName: "figure.roll"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .gray
        self.topView.addSubview(view)
        return view
    }()
    
    private lazy var clockView: UIImageView = {
        var view = UIImageView(image: UIImage(systemName: "clock"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .gray
        self.bottomView.addSubview(view)
        return view
    }()
    
    private lazy var creditView: UIImageView = {
        var  view = UIImageView(image: UIImage(systemName: "creditcard"))
        view.tintColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        self.bottomView.addSubview(view)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier reuseIdenrifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdenrifier)
        
        self.setupUI()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainFixedCell {
    
    private func setupUI() {
        
        topView.snp.makeConstraints{make in
            make.top.equalTo(contentView)
            make.left.equalTo(contentView).offset(30)
            make.right.equalTo(contentView).offset(-30)
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        bottomView.snp.makeConstraints{make in
            make.top.equalTo(topView.snp.bottom)
            make.bottom.equalTo(contentView)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
        }
        
        oyaView.snp.makeConstraints{make in
            make.top.equalTo(topView).offset(20)
            make.right.equalTo(topView).offset(-16)
            make.left.equalTo(placesLabel.snp.right).offset(10)
            make.bottom.equalTo(topView).offset(-20)
            make.height.equalTo(topView).multipliedBy(0.7)
        }
        
        priceLabel.snp.makeConstraints{make in
            make.top.equalTo(topView).offset(20)
            make.left.equalTo(topView).offset(16)
            make.bottom.equalTo(placesLabel.snp.top).offset(-20)
        }
        
        placesLabel.snp.makeConstraints{make in
            make.top.equalTo(priceLabel.snp.bottom).offset(20)
            make.left.equalTo(topView).offset(16)
            make.bottom.equalTo(disavledPlacesLabel.snp.top).offset(-20)
        }
        
        disavledPlacesLabel.snp.makeConstraints{make in
            make.top.equalTo(placesLabel.snp.bottom).offset(20)
            make.bottom.equalTo(topView).offset(-20)
            make.left.equalTo(disabledView.snp.right).offset(16)
        }
        
        addressLabel.snp.makeConstraints{make in
            make.top.equalTo(bottomView).offset(20)
            make.left.equalTo(bottomView).offset(75)
            make.bottom.equalTo(paymentLabel.snp.top).offset(-20)
        }
        
        paymentLabel.snp.makeConstraints{make in
            make.top.equalTo(addressLabel.snp.bottom).offset(20)
            make.left.equalTo(creditView.snp.right).offset(16)
            make.bottom.equalTo(timeLabel.snp.top).offset(-20)
        }
        
        timeLabel.snp.makeConstraints{make in
            make.top.equalTo(paymentLabel.snp.bottom).offset(20)
            make.bottom.equalTo(bottomView).offset(-25)
            make.left.equalTo(clockView.snp.right).offset(16)
        }
        
        disabledView.snp.makeConstraints{make in
            make.top.equalTo(placesLabel.snp.bottom).offset(16)
            make.bottom.equalTo(topView).offset(-16)
            make.left.equalTo(topView).offset(16)
        }
        
        creditView.snp.makeConstraints{make in
            make.top.equalTo(addressLabel.snp.bottom).offset(20)
            make.left.equalTo(bottomView).offset(38)
            make.bottom.equalTo(timeLabel.snp.top).offset(-20)
        }
        
        clockView.snp.makeConstraints{make in
            make.top.equalTo(paymentLabel.snp.bottom).offset(20)
            make.bottom.equalTo(bottomView).offset(-25)
            make.left.equalTo(bottomView).offset(40)
        }
    }
}
