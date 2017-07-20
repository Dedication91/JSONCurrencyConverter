//
//  ViewController.swift
//  JSONCurrecnyConverter
//
//  Created by Shaan Mirchandani
//  Copyright © 2017 Shaan Mirchandani. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
    
    var myCurrency:[String] = []
    var myValues:[Double] = []
    var activeCurrency:Double = 0;
    
    @IBOutlet weak var input: UITextField!
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var output: UILabel!
    @IBAction func action(_ sender: Any) {
        
        if (input.text != nil) {
            output.text = String(Double(input.text!)! * activeCurrency)
        }
        
        
    }
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myCurrency.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myCurrency[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activeCurrency = myValues[row]
    }
    

        override func viewDidLoad() {
        super.viewDidLoad()
            let url = URL(string: "http://api.fixer.io/latest")
            
            
            
            let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if error != nil {
                    print("error")
                }
                else {
                    if let content = data {
                        do {
                            let myJSON = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject

                            if let rates = myJSON["rates"] as? NSDictionary {

                                for (key, value) in rates {
                                    self.myCurrency.append(key as! String)
                                    self.myValues.append((value as? Double)!)
                                }
                                
                                print(self.myCurrency)
                                print(self.myValues)
                            
                            }
                        
                        }
                        catch {
                            
                        }
                    }
                
                }
                self.pickerView.reloadAllComponents()
            }
    task.resume()
    }
  
}
