//
//  DetalheHeaderView.swift
//  layoutTinder
//
//  Created by Jean Ramalho on 10/02/25.
//
import Foundation
import UIKit

class DetalheHeaderView: UICollectionReusableView {
    
    var usuario: Usuario? {
        didSet{
            if let usuario = usuario {
                fotoImageView.image = UIImage(named: usuario.foto)
            }
        }
    }
    
    lazy var fotoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
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
