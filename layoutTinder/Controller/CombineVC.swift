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
    
    lazy var deslikeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "icone-deslike"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 32
        button.clipsToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 3.0
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.masksToBounds = false
        return button
    }()
    
    lazy var superLikeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "icone-superlike"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 32
        button.clipsToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 3.0
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.masksToBounds = false
        return button
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "icone-like"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 32
        button.clipsToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 3.0
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.masksToBounds = false
        return button
    }()
    
    
    
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
        if let card = gesture.view as? CombineCardView{
            let point = gesture.translation(in: view)
            //implementa movimento de drag ou seja segurar e puchar o elemento na view
            card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
            
            //pega angulo para rotação
            let rotationAngle = point.x / view.bounds.width * 0.4
            //condição para aparecer coração partido ou coração inteiro dependendo do lado para qual o card for arrastado
            if point.x > 0 {
                card.likeImageView.alpha = rotationAngle * 5
                card.deslikeImageView.alpha = 0
            } else {
                card.deslikeImageView.alpha = rotationAngle * 5 * -1
                card.likeImageView.alpha = 0
            }
            
            //implementa rotação no card para que quando for arrastado ele tenha efeito rotação
            card.transform = CGAffineTransform(rotationAngle: rotationAngle)
            
            // retorna com o elemento para a posição anterior quando o usuário solta o elemento
            if gesture.state == .ended {
                //Implementa animação para retorno do card para a posição inicial
                UIView.animate(withDuration: 0.2) {
                    card.center = self.view.center
                    card.transform = .identity
                    // faz os corações sumirem quando o toque é finalizado
                    card.deslikeImageView.alpha = 0
                    card.likeImageView.alpha = 0
                }
            }
        }
    }
}
