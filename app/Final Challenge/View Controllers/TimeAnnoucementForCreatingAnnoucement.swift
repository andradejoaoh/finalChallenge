//
//  TimeAnnoucementForCreatingAnnoucement.swift
//  Final Challenge
//
//  Created by Luiz Henrique Monteiro de Carvalho on 15/11/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import Foundation
import UIKit

class TimeAnnoucementForCreatingAnnoucement: UIViewController {
    

    
    var tempoSelected = Int()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }

    // MARK: - Table view data source
    @IBAction func duasHorasSelected(_ sender: Any) {
        tempoSelected = 7200
        performSegue(withIdentifier: "unwindSegueFromHoras", sender: self)
    }
    
    @IBAction func seisHorasSelected(_ sender: Any) {
        tempoSelected = 21600
        performSegue(withIdentifier: "unwindSegueFromHoras", sender: self)
    }
    
    @IBAction func oitoHorasSelected(_ sender: Any) {
        tempoSelected = 28800
        performSegue(withIdentifier: "unwindSegueFromHoras", sender: self)
    }
    
    
    @IBAction func dozeHorasSelected(_ sender: Any) {
        tempoSelected = 43200
        performSegue(withIdentifier: "unwindSegueFromHoras", sender: self)
    }
    
    
    @IBAction func dezesseisHorasSelected(_ sender: Any) {
        tempoSelected = 57600
        performSegue(withIdentifier: "unwindSegueFromHoras", sender: self)
    }
    
    
    @IBAction func umDiaSelected(_ sender: Any) {
        tempoSelected = 86400
        performSegue(withIdentifier: "unwindSegueFromHoras", sender: self)
    }
    
    @IBAction func doisDiasSelected(_ sender: Any) {
        tempoSelected = 172800
        performSegue(withIdentifier: "unwindSegueFromHoras", sender: self)
    }
    
    @IBAction func tresDiasSelected(_ sender: Any) {
        tempoSelected = 259200
        performSegue(withIdentifier: "unwindSegueFromHoras", sender: self)
    }
    
    @IBAction func umaSemanaSelected(_ sender: Any) {
        tempoSelected = 604800
        performSegue(withIdentifier: "unwindSegueFromHoras", sender: self)
    }
    
    
    @IBAction func duasSemanasSelected(_ sender: Any) {
            tempoSelected = 1209600
            performSegue(withIdentifier: "unwindSegueFromHoras", sender: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindSegueFromHoras" {
            let destinationController =  segue.destination as! CreateAnnoucementViewController
            destinationController.annoucementTime = tempoSelected
           
        }
    }
    
    
   

    

}
   
