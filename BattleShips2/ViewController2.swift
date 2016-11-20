//
//  ViewController2.swift
//  BattleShips2
//
//  Created by Wilson Ng on 11/19/16.
//  Copyright © 2016 Wilson Ng. All rights reserved.
//

import UIKit
class ViewController2: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var model : BattleshipModel? = nil
    var didMiss = false;
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    var items = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09","10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96", "97", "98", "99"]
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if model != nil{
            loadShip()
            didMiss = false;
        }
    }
    
    func loadShip(){
        items = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09","10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96", "97", "98", "99"]
        var x = 0
        var y = 0
        for item in (model?.grid)!{
            for i in item{
                if i == 2 {
                    items[items.index(of: "\(x)\(y)")!] = "H"
                }
                if i == 3 {
                    items[items.index(of: "\(x)\(y)")!] = "M"
                }
                if i == 4 {
                    items[items.index(of: "\(x)\(y)")!] = "S"
                }
                y += 1
            }
            x += 1
            y = 0
        }
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.myLabel.text = self.items[indexPath.item]
        cell.backgroundColor = UIColor.cyan
        if self.items[indexPath.item] == "H" || self.items[indexPath.item] == "S" || self.items[indexPath.item] == "M" {
            cell.backgroundColor = UIColor.red
            cell.myLabel.textColor = UIColor.white
        }
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        
        return cell
    }
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        var x : Int = 0
        var y : Int = 0
        let length = indexPath.item.description.distance(from: indexPath.item.description.startIndex, to: indexPath.item.description.endIndex)
        let index = indexPath.item.description.index(indexPath.item.description.startIndex, offsetBy: 1)

        if length == 1 {
            y = Int(indexPath.item.description.substring(to: index))!
        }
        else {
            x = Int(indexPath.item.description.substring(to: index))!
            y = Int(indexPath.item.description.substring(from: index))!
        }
        if didMiss == false{
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.backgroundColor = UIColor.red
            let msg = model?.launchMissile(x: x, y: y)
            if  msg == "missed" {
                label.text = "You missed. Next Player"
                didMiss = true
            }
            else if msg == "hit" {
                label.text = "Hit. Keep going"
                if (model?.checkIfWin())!{
                    winAlert()
                }
            }
            else if msg == "sunked" {
                label.text = "Hit. SUNKED. Keep going"
                if (model?.checkIfWin())!{
                    winAlert()
                }
            }
        }
    }
    
    func winAlert(){
        let alert = UIAlertController(title: NSLocalizedString("GAME WON!", comment: ""), message: NSLocalizedString("You have  destroyed all the ships! Thanks for Playing!", comment: ""), preferredStyle: .actionSheet)
        alert.modalPresentationStyle = .popover
        present(alert, animated: true, completion: nil)
    }
}

