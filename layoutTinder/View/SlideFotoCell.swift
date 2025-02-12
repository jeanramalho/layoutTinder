//
//  DetalhesFotoCell.swift
//  layoutTinder
//
//  Created by Jean Ramalho on 11/02/25.
//
import Foundation
import UIKit

class SlideFotoCell: UICollectionViewCell {
    
    lazy var fotoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy(){
        self.addSubview(fotoImageView)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            fotoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            fotoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            fotoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            fotoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
