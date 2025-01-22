//
//  CombineVC.swift
//  layoutTinder
//
//  Created by Jean Ramalho on 15/01/25.
//
import Foundation
import UIKit

class CombineVC: UIViewController {
    
    lazy var redView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        let gesture = UIPanGestureRecognizer()
        gesture.addTarget(self, action: #selector(handlerCard))
        redView.addGestureRecognizer(gesture)
    }
    
    
    private func setupUI(){
        view.backgroundColor = UIColor.systemGroupedBackground
        setHierarchy()
        setConstraints()
        
        
        
    }
    
    private func setHierarchy(){
        view.addSubview(redView)
        
       
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            redView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            redView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            redView.heightAnchor.constraint(equalToConstant: 300),
            redView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}

extension CombineVC {
    @objc func handlerCard(_ gesture: UIPanGestureRecognizer){
        if let card = gesture.view {
            let point = gesture.translation(in: view)
            card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        }
    }
}
