//
//  CombineVC.swift
//  layoutTinder
//
//  Created by Jean Ramalho on 15/01/25.
//
import Foundation
import UIKit

class CombineVC: UIViewController {
    
//    lazy var redView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .red
//        view.frame =
//        return view
//    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adicionarCards()
    }
    
    
//    private func setupUI(){
//        
//        adicionarCards()
//
//    }
    
    
//    private func setConstraints(){
//        NSLayoutConstraint.activate([
//            redView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            redView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            redView.heightAnchor.constraint(equalToConstant: 300),
//            redView.widthAnchor.constraint(equalToConstant: 200)
//        ])
//    }
}

extension CombineVC {
   func adicionarCards(){

           for item in 1...3 {
               let redView = UIView()
               redView.backgroundColor = item == 2 ? .blue : .red
               redView.frame = CGRect(x: 0, y: 0, width: 200, height: 300)
               redView.center = view.center
               
               
               let gesture = UIPanGestureRecognizer()
               gesture.addTarget(self, action: #selector(handlerCard))
               redView.addGestureRecognizer(gesture)
           
               view.addSubview(redView)
       }
   }
}


extension CombineVC {
    @objc func handlerCard(_ gesture: UIPanGestureRecognizer){
        if let card = gesture.view {
            let point = gesture.translation(in: view)
            //implementa movimento de drag ou seja segurar e puchar o elemento na view
            card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
            
            // retorna com o elemento para a posição anterior quando o usuário solta o elemento
            if gesture.state == .ended {
                //Implementa animação para retorno do card para a posição inicial
                UIView.animate(withDuration: 0.2) {
                    card.center = self.view.center
                }
            }
        }
    }
}
