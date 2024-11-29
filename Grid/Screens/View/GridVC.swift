//
//  GridVC.swift
//  Grid
//
//  Created by Saumil Doshi on 29/11/24.
//

import UIKit

class GridVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var txtInput: UITextField!
    @IBOutlet weak var colGrid: UICollectionView!
    
    // MARK: - Class properties
    
    var viewModal = GridViewModal()
    
    // MARK: - Class function
    
    func setupUI() {
        setupXIB()
        txtInput.delegate = self
        bindingModal()
        colGrid.contentInsetAdjustmentBehavior = .never
    }
    
    func bindingModal() {
        viewModal.invalidateState = { [weak self] in
            self?.showAlert(message: "Invalid Input", title: "!!!")
        }
        viewModal.onTappedReload = { [weak self] in
            self?.colGrid.reloadData()
        }
        viewModal.onTappedWon = { [weak self] in
            self?.showAlert(message: "You won the match", title: "!!!")
        }
    }
    
    func setupXIB() {
        self.colGrid.register(UINib(nibName: "GridCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GridCollectionViewCell")
        
    }
    
    // MARK: - Action function
    
    
    @IBAction func btnCreateGrid(_ sender: UIButton) {
        viewModal.setupGrid(input: txtInput.text)
        txtInput.text = ""
    }
    
    
    // MARK: - LifeCycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        colGrid.collectionViewLayout.invalidateLayout()
    }
    
}

extension GridVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModal.gridSize * viewModal.gridSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.colGrid.dequeueReusableCell(withReuseIdentifier: "GridCollectionViewCell", for: indexPath) as! GridCollectionViewCell
        
        
        switch viewModal.cellState[indexPath.item] {
        case "red":
            cell.contentView.backgroundColor = .red
            
        case "green":
            cell.contentView.backgroundColor = .green
            
        default:
            cell.contentView.backgroundColor = .gray
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalHorizontalSpacing = CGFloat(viewModal.gridSize - 1) * 2 // Assuming 2 points spacing between items
        let totalVerticalSpacing = CGFloat(viewModal.gridSize - 1) * 2  // Assuming 2 points spacing between rows
        
        // Calculate available width and height
        let availableWidth = colGrid.bounds.width - totalHorizontalSpacing
        let availableHeight = colGrid.bounds.height - totalVerticalSpacing
        
        // Calculate size of each item
        let itemWidth = floor(availableWidth / CGFloat(viewModal.gridSize))
        let itemHeight = floor(availableHeight / CGFloat(viewModal.gridSize))
        
        // Return square size
        //let itemSize = itemWidth, itemHeight
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModal.handleTappedCell(index: indexPath.item)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // Ensure no extra bottom inset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    
}

extension GridVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtInput {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }}
