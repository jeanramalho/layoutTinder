//
//  combineCardView.swift
//  layoutTinder
//
//  Created by Jean Ramalho on 22/01/25.
//
import Foundation
import UIKit

class CombineCardView: UIView {
    
    lazy var fotoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "pessoa-1")
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        layer.borderWidth = 0.3
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 8
        clipsToBounds = true
        
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy(){
        addSubview(fotoImageView)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            fotoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            fotoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            fotoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            fotoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
