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
        view.backgroundColor = UIColor(red: 218/255, green: 99/255, blue: 111/255, alpha: 1)
        view.layer.cornerRadius = 50
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.red.cgColor
        return view
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
        self.addSubview(loadView)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            loadView.widthAnchor.constraint(equalToConstant: 100),
            loadView.heightAnchor.constraint(equalToConstant: 100),
            loadView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
