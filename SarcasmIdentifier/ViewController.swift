//
//  ViewController.swift
//  SarcasmIdentifier
//
//  Created by Zarioiu Bogdan on 3/28/19.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var inputTextField: UITextField!
    var identifyButton: UIButton!
    var predictionLabel: UILabel!
    let SarcasmClassifier = sarcasmClassifier()

    override func viewDidLoad() {
        super.viewDidLoad()
        createOutlets()
        applyingConstraints()
        dismissKeyboard()
    }

    
    func createOutlets() {
        inputTextField = UITextField()
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        let attributedPlaceholder = NSAttributedString(string: "Enter your search querry here!", attributes: [NSAttributedString.Key.paragraphStyle: centeredParagraphStyle])
        inputTextField.attributedPlaceholder = attributedPlaceholder
        view.addSubview(inputTextField)
        
        identifyButton = UIButton()
        identifyButton.setTitle("Identify", for: .normal)
        identifyButton.backgroundColor = .red
        identifyButton.layer.cornerRadius = 25
        identifyButton.addTarget(self, action: #selector(identifyPressed), for: .touchUpInside)
        view.addSubview(identifyButton)
        
        predictionLabel = UILabel()
        predictionLabel.text = "The magic happens here!"
        predictionLabel.textColor = .black
        predictionLabel.textAlignment = .center
        view.addSubview(predictionLabel)
    }

    func dismissKeyboard() {
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        toolbar.setItems([flexSpace, doneButton], animated: false)
        toolbar.sizeToFit()
        self.inputTextField.inputAccessoryView = toolbar
    }
    
    
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
    
    
    
    func applyingConstraints() {
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 250).isActive = true
        inputTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        inputTextField.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        identifyButton.translatesAutoresizingMaskIntoConstraints = false
        identifyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        identifyButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        identifyButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        identifyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        predictionLabel.translatesAutoresizingMaskIntoConstraints = false
        predictionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        predictionLabel.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        predictionLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        predictionLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    func animatePredictionLabel() {
        UIView.animate(withDuration: 2) {
            self.predictionLabel.transform = CGAffineTransform(scaleX: 2, y: 2)
            //self.predictionLabel.transform = CGAffineTransform(rotationAngle: 90)
            self.predictionLabel.textColor = .red

            
            
        }
    }
    
    @objc func identifyPressed() {
        if let searchText = inputTextField.text {
            do {
                
                let prediction = try SarcasmClassifier.prediction(text: searchText)
                
                if prediction.label ==  "Sarcasm" {
                    self.predictionLabel.text = "Sarcasm!"
                   // animatePredictionLabel()
                } else {
                    self.predictionLabel.text = "Not a Sarcasm!"
                }
                
            } catch {
                print("There was an error with making a prediction, \(error)")
            }
            
        }
    }
}

