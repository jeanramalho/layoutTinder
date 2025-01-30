//
//  Loading.swift
//  layoutTinder
//
//  Created by Jean Ramalho on 30/01/25.
//
import Foundation
import UIKit

class Loading: UIView {
    
    lazy var loadView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        view.backgroundColor = UIColor(red: 218/255, green: 99/255, blue: 111/255, alpha: 1)
        view.center = center
        view.layer.cornerRadius = 50
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.red.cgColor
        return view
    }()
    
    lazy var perfilImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 50
        image.layer.borderWidth = 5
        image.layer.borderColor = UIColor.white.cgColor
        image.clipsToBounds = true
        image.image = UIImage(named: "perfil")
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
        animacao()
    }
    
    private func setHierarchy(){
        self.addSubview(loadView)
        self.addSubview(perfilImageView)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            perfilImageView.widthAnchor.constraint(equalToConstant: 100),
            perfilImageView.heightAnchor.constraint(equalToConstant: 100),
            perfilImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            perfilImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    
    func animacao(){
        UIView.animate(withDuration: 1.3, animations: {
            self.loadView.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
            self.loadView.layer.cornerRadius = 125
            self.loadView.center = self.center
            self.loadView.alpha = 0.3
        }) { (_) in
            self.loadView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            self.loadView.layer.cornerRadius = 50
            self.loadView.alpha = 1
            self.loadView.center = self.center
            
            self.animacao()
        }
    }
}
