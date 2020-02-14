//
//  ViewController.swift
//  MyNotebook_w7
//
//  Created by admin on 14/02/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
  
    
    
    var savedText = ""
    var textArray = [String]()
    var currentIndex = -1
  //  var edit = false
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var resultSet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad() //Will only get called first time app launched
        // Do any additional setup after loading the view.
        resultSet.dataSource = self
        resultSet.delegate = self

    }
    
    
    @IBAction func readFromFile(_ sender: Any) {
        let filename = getDocumentsDirectory().appendingPathComponent("output.txt")
        
        do {
            let content = try String(contentsOf: filename)
            textField.text = content
        } catch {
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
        }
    
    }
    
    
    @IBAction func saveToFile(_ sender: Any) {
        let str = textField.text
        let filename = getDocumentsDirectory().appendingPathComponent("output.txt")
        do {
            try str!.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
        }
        
    }
    
    //Func to documents directory
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(paths)
        return paths[0]
    
    }


    @IBAction func buttonPressed(_ sender: Any) {
        savedText = textField.text!
        if currentIndex > -1 {
            textArray[currentIndex] = savedText
            currentIndex = -1
            //edit = false
        }
        else{
            savedText = textField.text!
            textArray.append(savedText)
        }
        
        resultSet.backgroundColor = UIColor.gray
        resultSet.backgroundColor = UIColor.gray
        resultSet.reloadData()
        textField.text = ""
        
        
    }
    
    //How many rows does the array have
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
      }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
        cell?.textLabel?.text = textArray[indexPath.row]
        return cell!
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        textField.text = textArray[indexPath.row]
        currentIndex = indexPath.row
       // edit = true
    
    }
    
}

