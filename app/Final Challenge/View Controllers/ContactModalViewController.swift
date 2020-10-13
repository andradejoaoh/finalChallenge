//
//  ContactModalViewController.swift
//  Final Challenge
//
//  Created by Luiz Henrique Monteiro de Carvalho on 07/10/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class ContactModalViewController: UIViewController {
    
    
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewContactModalDidLoad")
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        // Nao deixa o usuario puxar a view mais para cima
        guard translation.y >= 0 else { return }
        
        // o X tem que ser 0 para a view não ir para os lados
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended{
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                    
                }
            }
        }
    }
    


}
