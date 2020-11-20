//
//  SearchViewController.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 22/09/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CollectionViewCellDelegate, WaterfallLayoutDelegate {
    

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var tableViewSearch: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var ExpandableView: UIView!
    
    @IBOutlet weak var ExpandableProximityView: UIView!
    
    @IBOutlet weak var sliderProximity: UISlider!
    @IBOutlet weak var heightOfExpandableViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var heigthOfTableSearchViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var heightOfViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var heightOfCategoriesView: NSLayoutConstraint!
    
    @IBOutlet weak var heightOfProximityView: NSLayoutConstraint!
    @IBOutlet weak var heightOfBairrosView: NSLayoutConstraint!
    
    
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
    
    @IBOutlet weak var bairroSelectedLabel: UILabel!
    
    var recenteSelected = String()
    var bairroSelected = String()
    
    
    
    var filteredArray = [String]()
    // Access Shared Defaults Object
    let userDefaults = UserDefaults.standard

    var strings = [String]()
    

    
    
    let searchCollectionView: UICollectionView = {
        let layout = WaterfallLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8.0
        layout.headerHeight = 20.0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    
    
    var annoucements: [Annoucement] = []{
        didSet{
            searchCollectionView.reloadData()
        }
    }
    
    var selectedAnnoucement:Int?
    var comeFromPaid: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setup()
        setupCollectionView()
        
        // Read/Get Array of Strings
        strings = userDefaults.stringArray(forKey: "myKey") ?? []

        // Append String to Array of Strings
        //strings.append("Four")

        // Write/Set Array of Strings
        userDefaults.set(strings, forKey: "myKey")
        
        
        DatabaseHandler.readAnnoucements { (result) in
            switch result {
            case let .failure(error):
                //Show error while updating feed
                print(error)
            case let .success(annoucements):
                self.annoucements = annoucements
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.comeFromPaid = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchCollectionView.reloadData()
    }
    
    
    
    func setup(){
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        tableViewSearch.delegate = self
        tableViewSearch.dataSource = self
        searchBar.delegate = self
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        
        self.scrollView.isScrollEnabled = true
        sliderProximity.value = 6
        self.sliderLabel.text = "\(sliderProximity.value - 1) km"
        let trackRect = sliderProximity.trackRect(forBounds: sliderProximity.frame)
        let thumbRect = sliderProximity.thumbRect(forBounds: sliderProximity.bounds, trackRect: trackRect, value: sliderProximity.value)
        self.sliderLabel.center = CGPoint(x: thumbRect.midX, y: self.sliderLabel.center.y)
        
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueSearchToBairroSearch"{
            let backItem = UIBarButtonItem()
                backItem.title = "Voltar"
                navigationItem.backBarButtonItem = backItem
        }
    }
    
    func setupCollectionView(){
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self        
        mainView.addSubview(searchCollectionView)
        
        searchCollectionView.register(AnnoucementSearchCell.self, forCellWithReuseIdentifier: HardConstants.CollectionView.searchAnnoucementCell)
        searchCollectionView.register(HeaderSearchCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HardConstants.CollectionView.headerSearchView)
        
        searchCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        searchCollectionView.topAnchor.constraint(equalTo: ExpandableProximityView.bottomAnchor).isActive = true
        
        searchCollectionView.leftAnchor.constraint(equalTo: mainView.leftAnchor).isActive = true
        searchCollectionView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
        searchCollectionView.rightAnchor.constraint(equalTo: mainView.rightAnchor).isActive = true
        searchCollectionView.widthAnchor.constraint(equalTo: mainView.widthAnchor).isActive = true
        
        searchCollectionView.clipsToBounds = true
        
        let layout = WaterfallLayout()
        layout.delegate = self
        layout.sectionInset = UIEdgeInsets(top: 5, left: 16, bottom: 10, right: 16)
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 8.0
        layout.headerHeight = 50.0
        searchCollectionView.collectionViewLayout = layout
    }
    
    //BUTTONS FUNCTIONS
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
    
    
    @IBAction func unwindToSearchViewController(segue:UIStoryboardSegue) {
        print(bairroSelected)
        bairroSelectedLabel.text = bairroSelected
    }
    
    
    
    
    //TABLE VIEW FUNCTIONS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        // Read/Get Array of Strings
        strings = userDefaults.stringArray(forKey: "myKey") ?? []

        // Append String to Array of Strings
        //strings.append("Four")

        // Write/Set Array of Strings
        userDefaults.set(strings, forKey: "myKey")
        
        if searchBar.text == "" {
            return strings.count
        } else {
            return filteredArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HardConstants.TableView.searchCell, for: indexPath)
        if searchBar.text == "" {
            //arrayRecentes = recentArrayUserDefaults
            cell.textLabel?.text = strings[indexPath.row]
        } else {
            cell.textLabel?.text = filteredArray[indexPath.row]
        }
        
        return cell
    }
    
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {//DESELECT
//
//        let cell = tableView.cellForRow(at: indexPath)
//        searchBar.text = cell?.textLabel?.text
//
//        heigthOfTableSearchViewConstraint.constant = 0.0
//        heightOfCategoriesView.constant = 150.0
//        heightOfExpandableViewConstraint.constant = 0.0
//        heightOfBairrosView.constant = 50.0
//        heightOfProximityView.constant = 50.0
//        heightOfProximityExpandableViewConstraint.constant = 0.0
//
//
//        self.view.setNeedsUpdateConstraints()
//        self.view.layoutIfNeeded()
//        searchBar.resignFirstResponder()
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {//SELECT
        let cell = tableView.cellForRow(at: indexPath)!
        print(cell.textLabel?.text ?? "")
        
        recenteSelected = cell.textLabel?.text ?? ""
        searchBar.text = recenteSelected
        
        heigthOfTableSearchViewConstraint.constant = 0.0
        heightOfCategoriesView.constant = 150.0
        heightOfExpandableViewConstraint.constant = 0.0
        heightOfBairrosView.constant = 50.0
        heightOfProximityView.constant = 50.0
        heightOfProximityExpandableViewConstraint.constant = 0.0
        self.view.setNeedsUpdateConstraints()
        self.view.layoutIfNeeded()
        searchBar.resignFirstResponder()
    }
    
    
    
    
    //COLLECTION VIEW FUNCTIONS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return annoucements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HardConstants.CollectionView.searchAnnoucementCell, for: indexPath) as? AnnoucementSearchCell else { return UICollectionViewCell()}
        cell.layer.cornerRadius = 10
        let annoucement = annoucements[indexPath.item]
        
        annoucement.didLoadImage = { [weak cell, weak self] imageData in
            cell?.imageAnnoucement.image = UIImage(data: annoucement.imageData ?? Data())
            cell?.activityIndicator.stopAnimating()
            self?.searchCollectionView.reloadItems(at: [indexPath])
            
        }
        //TODO: essa celula não retorna
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedAnnoucement = indexPath.item
        performSegue(withIdentifier: HardConstants.Storyboard.annoucementSegue, sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let annoucementImage = UIImage(data: annoucements[indexPath.item].imageData ?? Data()) else {
            return CGSize(width: 200, height: 200)
        }
        return CGSize(width: (annoucementImage.size.width), height: (annoucementImage.size.height))
    }
    

    func collectionViewCell(_ announcementNumber: Int) {
        self.selectedAnnoucement = announcementNumber
        self.comeFromPaid = true
        performSegue(withIdentifier: HardConstants.Storyboard.annoucementSegue, sender: self)
    }
    
    func collectionViewLayout(for section: Int) -> WaterfallLayout.Layout {
        return .waterfall(column: 2, distributionMethod: .balanced)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HardConstants.CollectionView.headerSearchView, for: indexPath) as! HeaderSearchCollectionView
            switch indexPath.section{
            case 0:
                headerView.labelHeader.text = "Anúncios"
            default:
                headerView.labelHeader.text = "Header Unknown"
            }
            return headerView
        default:
            preconditionFailure("Invalid supplementary view type for this collection view")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, headerHeightFor section: Int) -> CGFloat? {
        let headerHeight: CGFloat
        headerHeight = 40
        return headerHeight
    }
    
    
    
    //SEARCH BAR FUNCTIONS
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredArray = []
        
        if searchText == "" {
            filteredArray = strings
        } else {
            for arraySearch in strings {
                if arraySearch.lowercased().contains(searchText.lowercased()) {
                    filteredArray.append(arraySearch)
                }
            }
        }
        self.tableViewSearch.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
        heigthOfTableSearchViewConstraint.constant = heightOfViewConstraint.constant
        heightOfCategoriesView.constant = 0.0
        heightOfExpandableViewConstraint.constant = 0.0
        heightOfBairrosView.constant = 0.0
        heightOfProximityView.constant = 0.0
        heightOfProximityExpandableViewConstraint.constant = 0.0
        self.tableViewSearch.reloadData()
        self.view.setNeedsUpdateConstraints()
        self.view.layoutIfNeeded()
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || strings.contains(searchBar.text ?? ""){
        } else {
            
            // Read/Get Array of Strings
            strings = userDefaults.stringArray(forKey: "myKey") ?? []
            // Append String to Array of Strings
            strings.append(searchBar.text!)
            // Write/Set Array of Strings
            userDefaults.set(strings, forKey: "myKey")
            
        }
        heigthOfTableSearchViewConstraint.constant = 0.0
        heightOfCategoriesView.constant = 150.0
        heightOfExpandableViewConstraint.constant = 0.0
        heightOfBairrosView.constant = 50.0
        heightOfProximityView.constant = 50.0
        heightOfProximityExpandableViewConstraint.constant = 0.0
        self.view.setNeedsUpdateConstraints()
        self.view.layoutIfNeeded()
        searchBar.resignFirstResponder()//FAZER RELOAD da table view
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            heigthOfTableSearchViewConstraint.constant = 0.0
            heightOfCategoriesView.constant = 150.0
            heightOfExpandableViewConstraint.constant = 0.0
            heightOfBairrosView.constant = 50.0
            heightOfProximityView.constant = 50.0
            heightOfProximityExpandableViewConstraint.constant = 0.0
            self.view.setNeedsUpdateConstraints()
            self.view.layoutIfNeeded()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        heigthOfTableSearchViewConstraint.constant = 0.0
        heightOfCategoriesView.constant = 150.0
        heightOfExpandableViewConstraint.constant = 0.0
        heightOfBairrosView.constant = 50.0
        heightOfProximityView.constant = 50.0
        heightOfProximityExpandableViewConstraint.constant = 0.0
        self.view.setNeedsUpdateConstraints()
        self.view.layoutIfNeeded()
    }
}
