//
//  CombineVC.swift
//  layoutTinder
//
//  Created by Jean Ramalho on 15/01/25.
//
import Foundation
import UIKit

class CombineVC: UIViewController {
    
    var usuarios: [Usuario] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buscaUsuarios()
    }
    
    func buscaUsuarios(){
        self.usuarios = UsuarioService.shared.buscaUsuarios()
        self.adicionarCards()
    }

}

extension CombineVC {
   func adicionarCards(){

            for usuario in usuarios {
               let card = CombineCardView()
               card.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 32, height: view.bounds.height * 0.7)
               card.center = view.center
                card.usuario = usuario
                card.tag = usuario.id
               
               let gesture = UIPanGestureRecognizer()
               gesture.addTarget(self, action: #selector(handlerCard))
               card.addGestureRecognizer(gesture)
           
                view.insertSubview(card, at: 0)
       }
   }
}


extension CombineVC {
    @objc func handlerCard(_ gesture: UIPanGestureRecognizer){
        if let card = gesture.view {
            let point = gesture.translation(in: view)
            //implementa movimento de drag ou seja segurar e puchar o elemento na view
            card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
            
            //pega angulo para rotação
            let rotationAngle = point.x / view.bounds.width * 0.4
            
            //implementa rotação no card para que quando for arrastado ele tenha efeito rotação
            card.transform = CGAffineTransform(rotationAngle: rotationAngle)
            
            // retorna com o elemento para a posição anterior quando o usuário solta o elemento
            if gesture.state == .ended {
                //Implementa animação para retorno do card para a posição inicial
                UIView.animate(withDuration: 0.2) {
                    card.center = self.view.center
                    card.transform = .identity
                }
            }
        }
    }
}
