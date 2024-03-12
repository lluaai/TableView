//
//  TableViewHeader.swift
//  TableView
//
//  Created by Арайлым Сермагамбет on 10.03.2024.
//

import UIKit
import SnapKit

final class TableViewHeader: UIView {
    
    //MARK: - UI
    private let label: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    //NARK: -Lifeycycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Views
    
    private func setupViews() {
        backgroundColor = .systemBlue
      addSubview(label)

    }
    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
    }
    
}

