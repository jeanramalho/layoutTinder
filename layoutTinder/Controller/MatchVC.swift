//
//  MatchVC.swift
//  layoutTinder
//
//  Created by Jean Ramalho on 31/01/25.
//
import Foundation
import UIKit

class MatchVC: UIViewController {
    
    lazy var fotoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "pessoa-1")
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI(){
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy(){
        view.addSubview(fotoImageView)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            fotoImageView.topAnchor.constraint(equalTo: view.topAnchor),
            fotoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fotoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fotoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
