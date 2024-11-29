//
//  GridViewModal.swift
//  Grid
//
//  Created by Saumil Doshi on 29/11/24.
//

import UIKit

class GridViewModal: UIViewController {
    
    
    // MARK: - Class properties
    
    var gridSize: Int = 0
    var cellState: [String] = []
    var invalidateState: (() -> Void)?
    var onTappedReload: (() -> Void)?
    var onTappedWon: (() -> Void)?
    
    // MARK: - Class function

    func setupGrid(input: String?) {
        
        if let inputText = input , let newGridSize = Int(inputText), newGridSize > 0 {
            let squareRoot = sqrt(Double(newGridSize))
            if squareRoot == floor(squareRoot) {
                self.gridSize = Int(squareRoot)
                cellState = Array(repeating: "default",count: gridSize * gridSize)
                
                if let randomIndex = (0..<cellState.count).randomElement() {
                    cellState[randomIndex] = "red"
                }
                
                self.onTappedReload?()
            } else {
                self.invalidateState?()
            }
        } else {
            self.invalidateState?()
        }
        
    }
    
    func handleTappedCell(index: Int) {
        
        if cellState[index] == "red" {
            cellState[index] = "green"
            
            
            let greyColoredCells = cellState.enumerated().filter{$0.element == "default"}.map{$0.offset}
            
            if let newGreeIndex = greyColoredCells.randomElement() {
                cellState[newGreeIndex] = "red"
            }
            
            if cellState.allSatisfy({ $0 == "green"}) {
                self.onTappedWon?()
            }
            
            self.onTappedReload?()
        }
        
        
    }
}
