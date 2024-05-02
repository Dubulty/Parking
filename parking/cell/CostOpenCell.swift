//
//  ThreeCell.swift
//  parking
//
//  Created by Андрей Коновалов on 13.04.2024.
//

import UIKit
import SnapKit

class CostOpenCell: UITableViewCell {
    
    static let identifier = "CostOpenCell"
    
    var isButtonToggled = false
    
    private lazy var arrowView: UIImageView = {
        var  arrowView = UIImageView(image: UIImage(systemName: "chevron.up"))
        arrowView.tintColor = .gray
        arrowView.translatesAutoresizingMaskIntoConstraints = false
        self.sectionButton.addSubview(arrowView)
        return arrowView
    }()
    
    lazy var sectionButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black , for: .normal)
        button.setTitle("Cost", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 260)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toggleCellButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var mainContentView: UIView = {
        let UIView = UIView()
        UIView.translatesAutoresizingMaskIntoConstraints = false
        return UIView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor(red: 242/255.0, green: 240/255.0, blue: 248/255.0, alpha: 255/255.0)
        stackView.layer.cornerRadius = 15
        stackView.axis = .vertical
        stackView.addArrangedSubview(sectionButton)
        stackView.addArrangedSubview(mainContentView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(stackView)
        return stackView
    }()
    
    private lazy var intervalLabel: UILabel = {
        let label = UILabel()
        label.text = "Mon-Sun, excluding holidays from 8:00 to 21:00"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.mainContentView.addSubview(label)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier reuseIdenrifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdenrifier)
        self.setupUI()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func toggleCellButton(_ sender: UIButton) {
        
        isButtonToggled.toggle()
        let imageName = isButtonToggled ? "chevron.down" : "chevron.up"
        arrowView.image = UIImage(systemName: imageName)
        
        UIView.animate(
            withDuration: 0.3, delay: 0, options: .curveEaseIn,
            animations: {
                self.mainContentView.isHidden.toggle()
                self.layoutIfNeeded()
            })
    }
}

extension CostOpenCell {
    
    private func setupUI() {
        
        stackView.snp.makeConstraints{make in
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView)
            make.right.equalTo(contentView).offset(-20)
            make.left.equalTo(contentView).offset(20)
        }
        
        sectionButton.snp.makeConstraints{make in
            make.top.equalTo(stackView)
            make.left.equalTo(stackView)
            make.right.equalTo(stackView)
        }
        
        arrowView.snp.makeConstraints{make in
            make.top.equalTo(sectionButton).offset(10)
            make.right.equalTo(sectionButton).offset(-30)
            make.bottom.equalTo(sectionButton).offset(-10)
        }
        
        mainContentView.snp.makeConstraints{make in
            make.bottom.equalTo(stackView)
            make.left.equalTo(stackView)
            make.right.equalTo(stackView)
        }
        
        intervalLabel.snp.makeConstraints{make in
            make.top.equalTo(mainContentView).offset(16)
            make.left.equalTo(mainContentView).offset(16)
            make.right.equalTo(mainContentView).offset(-80)
            make.bottom.equalTo(mainContentView).offset(-16)
        }
    }
}
