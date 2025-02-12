//
//  DetalhesFotoCell.swift
//  layoutTinder
//
//  Created by Jean Ramalho on 11/02/25.
//
import Foundation
import UIKit

class DetalhesFotoCell: UICollectionViewCell {
    
    lazy var descricaoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Fotos recentes do Instagram:"
        return label
    }()
    
    lazy var slideFotosVC: SlidesFotosVC = {
        let slide = SlidesFotosVC()
        slide.view.translatesAutoresizingMaskIntoConstraints = false
        return slide
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy(){
        self.addSubview(descricaoLabel)
        self.addSubview(slideFotosVC.view)
    
    }
    
    private func setConstraints(){

        NSLayoutConstraint.activate([
            
            descricaoLabel.topAnchor.constraint(equalTo: self.topAnchor),
            descricaoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            descricaoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            slideFotosVC.view.topAnchor.constraint(equalTo: descricaoLabel.bottomAnchor),
            slideFotosVC.view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            slideFotosVC.view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            slideFotosVC.view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
 
        ])
        
    }
}
