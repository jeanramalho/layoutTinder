//
//  combineCardView.swift
//  layoutTinder
//
//  Created by Jean Ramalho on 22/01/25.
//
import Foundation
import UIKit

class CombineCardView: UIView {
    
    var usuario: Usuario? {
        didSet {
            if let usuario = usuario {
                fotoImageView.image = UIImage(named: usuario.foto)
                nomeLabel.text = usuario.nome
                idadeLabel.text = String(usuario.idade)
                fraseLabel.text = usuario.frase
            }
        }
    }
    
    lazy var fotoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()
    
    lazy var nomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 2.0
        label.layer.shadowOpacity = 0.8
        label.layer.shadowOffset = CGSize(width: 1, height: 1)
        label.layer.masksToBounds = false
        return label
    }()
    
    lazy var idadeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28)
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 2.0
        label.layer.shadowOpacity = 0.8
        label.layer.shadowOffset = CGSize(width: 1, height: 1)
        label.layer.masksToBounds = false
        return label
    }()
    
    lazy var fraseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 2.0
        label.layer.shadowOpacity = 0.8
        label.layer.shadowOffset = CGSize(width: 1, height: 1)
        label.layer.masksToBounds = false
        return label
    }()
    
    lazy var nomeIdadeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 12
        return stackView
    }()
    
    lazy var globalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var likeImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.image = UIImage(named: "card-like")
        return image
    }()
    
    lazy var deslikeImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.image = UIImage(named: "card-deslike")
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
        addSubview(globalStackView)
        addSubview(likeImageView)
        addSubview(deslikeImageView)
        
        globalStackView.addArrangedSubview(nomeIdadeStackView)
        globalStackView.addArrangedSubview(fraseLabel)
        
        nomeIdadeStackView.addArrangedSubview(nomeLabel)
        nomeIdadeStackView.addArrangedSubview(idadeLabel)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            fotoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            fotoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            fotoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            fotoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            globalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            globalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            globalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            
            nomeIdadeStackView.leadingAnchor.constraint(equalTo: globalStackView.leadingAnchor),
            nomeIdadeStackView.trailingAnchor.constraint(equalTo: globalStackView.trailingAnchor),
            
            nomeLabel.leadingAnchor.constraint(equalTo: nomeIdadeStackView.leadingAnchor),
            
            idadeLabel.leadingAnchor.constraint(equalTo: nomeLabel.trailingAnchor, constant: 12),
            
            fraseLabel.topAnchor.constraint(equalTo: nomeIdadeStackView.bottomAnchor),
            
            deslikeImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            deslikeImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            deslikeImageView.widthAnchor.constraint(equalToConstant: 70),
            deslikeImageView.heightAnchor.constraint(equalToConstant: 70),
            
            likeImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            likeImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            likeImageView.widthAnchor.constraint(equalToConstant: 70),
            likeImageView.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
}
