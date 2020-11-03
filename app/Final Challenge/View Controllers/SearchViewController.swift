//
//  SearchViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 22/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewSearch: UITableView!
    
    
    @IBOutlet weak var ExpandableView: UIView!
    
    @IBOutlet weak var ExpandableProximityView: UIView!
    
    @IBOutlet weak var sliderProximity: UISlider!
    @IBOutlet weak var heightOfExpandableViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var verTudoButtonOutlet: UIButton!
    @IBOutlet weak var heightOfProximityExpandableViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sliderLabel: UILabel!
    var expandableCategoryControl: Bool = false
    var expandableProximityControl: Bool = false
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    @IBOutlet weak var casaBttn: UIButton!
    
    @IBOutlet weak var docesBttn: UIButton!
    
    @IBOutlet weak var roupasBttn: UIButton!
    
    @IBOutlet weak var festaBttn: UIButton!
    
    @IBOutlet weak var comidasBttn: UIButton!
    
    @IBOutlet weak var decoracaoBttn: UIButton!
    
    @IBOutlet weak var acessoriosBttn: UIButton!
    
    @IBOutlet weak var salgadosBttn: UIButton!
    
    @IBOutlet weak var cosmeticosBttn: UIButton!
    
    @IBOutlet weak var educacaoBttn: UIButton!
    
    @IBOutlet weak var papelariaBttn: UIButton!
    
    @IBOutlet weak var saudeBttn: UIButton!
    
    var casaBttnControl:Bool = false
    var docesBttnControl:Bool = false
    var roupasBttnControl:Bool = false
    var festaBttnControl:Bool = false
    var comidasBttnControl:Bool = false
    var decorationBttnControl:Bool = false
    var acessorioBttnControl:Bool = false
    var salgadosBttnControl:Bool = false
    var cosmeticosBttnControl:Bool = false
    var educacaoBttnControl:Bool = false
    var papelariaBttnControl:Bool = false
    var saudeBttnControl:Bool = false
    
    var arrayRecentes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    func setup(){
        
        tableViewSearch.delegate = self
        tableViewSearch.dataSource = self
        
        self.scrollView.isScrollEnabled = true
        sliderProximity.value = 6
        
        self.sliderLabel.text = "\(sliderProximity.value - 1) km"
        let trackRect = sliderProximity.trackRect(forBounds: sliderProximity.frame)
        let thumbRect = sliderProximity.thumbRect(forBounds: sliderProximity.bounds, trackRect: trackRect, value: sliderProximity.value)
        
        self.sliderLabel.center = CGPoint(x: thumbRect.midX, y: self.sliderLabel.center.y)
        
        arrayRecentes = ["casa","doces","roupas","festa","comidas","decorações","acessórios","salgados","cosméticos","educação","papelaria","saúde"]
        
    }
    @IBAction func expandCategoryButtonAction(_ sender: Any) {
        if expandableCategoryControl == false {
            UIView.animate(withDuration: 0.3) {
                self.heightOfExpandableViewConstraint.constant = 250.0
                self.view.setNeedsUpdateConstraints()
                self.verTudoButtonOutlet.setTitle("Minimizar", for: .normal)
                self.view.layoutIfNeeded()
            }
            expandableCategoryControl = true
        } else {
            UIView .animate(withDuration: 0.3) {
                self.heightOfExpandableViewConstraint.constant = 0.0
                self.view.setNeedsUpdateConstraints()
                self.verTudoButtonOutlet.setTitle("Ver tudo", for: .normal)
                self.view.layoutIfNeeded()
            }
            
            scrollView.setContentOffset(.zero, animated: true)
            expandableCategoryControl = false
        }
    }
    
    
    @IBAction func proximityExpandableAction(_ sender: Any) {
        if expandableProximityControl == false {
            UIView.animate(withDuration: 0.3) {
                self.heightOfProximityExpandableViewConstraint.constant = 100.0
                self.view.setNeedsUpdateConstraints()
                self.view.layoutIfNeeded()
            }
            expandableProximityControl = true
        } else {
            UIView.animate(withDuration: 0.3) {
                self.heightOfProximityExpandableViewConstraint.constant = 0
                self.view.setNeedsUpdateConstraints()
                self.view.layoutIfNeeded()
            }
            expandableProximityControl = false
        }
    }
    
    @IBAction func sliderProximityAction(_ sender: UISlider) {
        
        sliderProximity.value = roundf(sliderProximity.value)
        self.sliderLabel.text = "\(sliderProximity.value - 1) km"
        if sliderProximity.value == 1 {
            self.sliderLabel.text = "500 m"
        }
//        let trackRect = sliderProximity.trackRect(forBounds: sliderProximity.frame)
//        let thumbRect = sliderProximity.thumbRect(forBounds: sliderProximity.bounds, trackRect: trackRect, value: sliderProximity.value)
//
//        self.sliderLabel.center = CGPoint(x: thumbRect.midX, y: self.sliderLabel.center.y)
    }
    
    @IBAction func casaActionButton(_ sender: Any) {
        if casaBttnControl == false {
            casaBttn.setBackgroundImage(#imageLiteral(resourceName: "SelectedCasa"), for: .normal)
            casaBttnControl = true
        } else {
            casaBttn.setBackgroundImage(#imageLiteral(resourceName: "Casa"), for: .normal)
            casaBttnControl = false
        }
    }
    
    @IBAction func docesActionButton(_ sender: Any) {
        if docesBttnControl == false {
            docesBttn.setBackgroundImage(#imageLiteral(resourceName: "SelectedDoces"), for: .normal)
            docesBttnControl = true
        } else {
            docesBttn.setBackgroundImage(#imageLiteral(resourceName: "Doces"), for: .normal)
            docesBttnControl = false
        }
    }
    
    @IBAction func roupasActionButton(_ sender: Any) {
        if roupasBttnControl == false {
            roupasBttn.setBackgroundImage(#imageLiteral(resourceName: "SelectedRoupas"), for: .normal)
            roupasBttnControl = true
        } else {
            roupasBttn.setBackgroundImage(#imageLiteral(resourceName: "Roupas"), for: .normal)
            roupasBttnControl = false
        }
    }
    
    @IBAction func festaActionButton(_ sender: Any) {
        if festaBttnControl == false {
            festaBttn.setBackgroundImage(#imageLiteral(resourceName: "SelectedFesta"), for: .normal)
            festaBttnControl = true
        } else {
            festaBttn.setBackgroundImage(#imageLiteral(resourceName: "Festa"), for: .normal)
            festaBttnControl = false
        }
    }
    
    @IBAction func comidasActionButton(_ sender: Any) {
        if comidasBttnControl == false {
            comidasBttn.setBackgroundImage(#imageLiteral(resourceName: "SelectedComidas"), for: .normal)
            comidasBttnControl = true
        } else {
            comidasBttn.setBackgroundImage(#imageLiteral(resourceName: "Comidas"), for: .normal)
            comidasBttnControl = false
        }
    }
    
    @IBAction func decoracaoActionButton(_ sender: Any) {
        if decorationBttnControl == false {
            decoracaoBttn.setBackgroundImage(#imageLiteral(resourceName: "SelectedDecoracao"), for: .normal)
            decorationBttnControl = true
        } else {
            decoracaoBttn.setBackgroundImage(#imageLiteral(resourceName: "Decoração"), for: .normal)
            decorationBttnControl = false
        }
    }
    @IBAction func acessoriosActionButton(_ sender: Any) {
        if acessorioBttnControl == false {
            acessoriosBttn.setBackgroundImage(#imageLiteral(resourceName: "SelectedAcessórios"), for: .normal)
            acessorioBttnControl = true
        } else {
            acessoriosBttn.setBackgroundImage(#imageLiteral(resourceName: "Acessórios"), for: .normal)
            acessorioBttnControl = false
        }
    }
    
    @IBAction func salgadosActionButton(_ sender: Any) {
        if salgadosBttnControl == false {
            salgadosBttn.setBackgroundImage(#imageLiteral(resourceName: "SelectedSalgados"), for: .normal)
            salgadosBttnControl = true
        } else {
            salgadosBttn.setBackgroundImage(#imageLiteral(resourceName: "Salgados"), for: .normal)
            salgadosBttnControl = false
        }
    }
    
    @IBAction func cosmeticosActionButton(_ sender: Any) {
        if cosmeticosBttnControl == false {
            cosmeticosBttn.setBackgroundImage(#imageLiteral(resourceName: "SelectedCosméticos"), for: .normal)
            cosmeticosBttnControl = true
        } else {
            cosmeticosBttn.setBackgroundImage(#imageLiteral(resourceName: "Cosméticos"), for: .normal)
            cosmeticosBttnControl = false
        }
    }
    
    @IBAction func educacaoActionButton(_ sender: Any) {
        if educacaoBttnControl == false {
            educacaoBttn.setBackgroundImage(#imageLiteral(resourceName: "SelectedEducação"), for: .normal)
            educacaoBttnControl = true
        } else {
            educacaoBttn.setBackgroundImage(#imageLiteral(resourceName: "Educação"), for: .normal)
            educacaoBttnControl = false
        }
    }
    
    @IBAction func papelariaActionButton(_ sender: Any) {
        if papelariaBttnControl == false {
            papelariaBttn.setBackgroundImage(#imageLiteral(resourceName: "SelectedPapelaria"), for: .normal)
            papelariaBttnControl = true
        } else {
            papelariaBttn.setBackgroundImage(#imageLiteral(resourceName: "Papelaria"), for: .normal)
            papelariaBttnControl = false
        }
    }
    
    @IBAction func saudeActionButton(_ sender: Any) {
        if saudeBttnControl == false {
            saudeBttn.setBackgroundImage(#imageLiteral(resourceName: "SelectedSaúde"), for: .normal)
            saudeBttnControl = true
        } else {
            saudeBttn.setBackgroundImage(#imageLiteral(resourceName: "Saúde"), for: .normal)
            saudeBttnControl = false
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayRecentes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HardConstants.TableView.searchCell, for: indexPath)
        cell.textLabel?.text = arrayRecentes[indexPath.row]
        return cell
    }
    
    
}
