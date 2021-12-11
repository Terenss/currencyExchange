//
//  ViewController.swift
//  CurrencyPB
//
//  Created by Dmitrii on 23.10.2021.
//

import UIKit
import DatePickerDialog

class ViewController: UIViewController {
    
    
    @IBOutlet weak var privateNameLabel: UILabel!
    @IBOutlet weak var privateDateButton: UIButton!
    @IBOutlet weak var privateDateLabel: UILabel!
    
    @IBOutlet weak var nationalNameLabel: UILabel!
    @IBOutlet weak var nationalDateButton: UIButton!
    @IBOutlet weak var nationalDateLabel: UILabel!
    
    @IBOutlet weak var privateTableView: UITableView!
    
    @IBOutlet weak var nationalTableView: UITableView!
    
    let datePicker = DatePickerDialog()
    
    var privateDataAll = [PrivateData]()
    var nationalDataAll = [NationalData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Курсы Валют"
        privateDateLabel.text = "01.12.2021"
        nationalDateLabel.text = "01.12.2021"
        labelUnderline()
        
        privateTableView.delegate = self
        privateTableView.dataSource = self
       
        nationalTableView.delegate = self
        nationalTableView.dataSource = self
        
        self.privateTableView.rowHeight = 50
        self.privateTableView.estimatedRowHeight = 50
        self.nationalTableView.rowHeight = 65
        self.nationalTableView.estimatedRowHeight = 65
        
        setData()
        
       
    }
    
    func setData() {
        privateDataAll = [PrivateData(currencyName: "EUR", currencyBuy: "28.300", currencySell: "28.300"),
                   PrivateData(currencyName: "USD", currencyBuy: "28.300", currencySell: "28.300"),
                   PrivateData(currencyName: "RUR", currencyBuy: "28.300", currencySell: "28.300"),
                   PrivateData(currencyName: "AUD", currencyBuy: "28.300", currencySell: "28.300"),
                          PrivateData(currencyName: "GBR", currencyBuy: "28.300", currencySell: "28.300"),
                          PrivateData(currencyName: "CZK", currencyBuy: "28.300", currencySell: "28.300"),
                          PrivateData(currencyName: "CAD", currencyBuy: "28.300", currencySell: "28.300")
                   
        ]
        nationalDataAll = [NationalData(name: "Доллар США", natUKR: "26.31UAH", natUS: "1USD"),
        NationalData(name: "Российский Рубль", natUKR: "26.31UAH", natUS: "100RUR"),
        NationalData(name: "Английский фунт стерлингов", natUKR: "35.70UAH", natUS: "1GBR"),
        NationalData(name: "Австралийский доллар", natUKR: "19.33UAH", natUS: "1AUD"),
        NationalData(name: "Чешская крона", natUKR: "1.18", natUS: "1CZK"),
        NationalData(name: "Канадский доллар", natUKR: "21.12", natUS: "1CAD"),
        NationalData(name: "Датская крона", natUKR: "4.04", natUS: "1DKK"),
        NationalData(name: "Японская ина", natUKR: "0.23", natUS: "1JPY"),
        NationalData(name: "Норвежская крона", natUKR: "3.03", natUS: "1NOK"),
        NationalData(name: "Евро", natUKR: "28.300", natUS: "1EUR")]
    }
    
    
    
    @IBAction func privteButtonTapped(_ sender: Any) {
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.month = -3
        dateComponents.year = -5
        let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
        
        datePicker.show("ChooseDate",
                        doneButtonTitle: "Done",
                        cancelButtonTitle: "Cancel",
                        minimumDate: threeMonthAgo,
                        maximumDate: currentDate,
                        datePickerMode: .date) { (date) in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "MM.dd.yyyy"
                self.privateDateLabel.text = formatter.string(from: dt)
            }
        }
    }
    
    @IBAction func nationalButtonTapped(_ sender: Any) {
       
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.month = -3
        dateComponents.year = -5
        let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
        
        datePicker.show("ChooseDate",
                        doneButtonTitle: "Done",
                        cancelButtonTitle: "Cancel",
                        minimumDate: threeMonthAgo,
                        maximumDate: currentDate,
                        datePickerMode: .date) { (date) in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "MM.dd.yyyy"
                self.nationalDateLabel.text = formatter.string(from: dt)
            }
        }
    }
    
    func labelUnderline() {
        privateDateLabel.attributedText = NSAttributedString(string: privateDateLabel.text!, attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        nationalDateLabel.attributedText = NSAttributedString(string: nationalDateLabel.text!, attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case privateTableView:
            return privateDataAll.count
        case nationalTableView:
            return nationalDataAll.count
        default:
            return 2
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        switch tableView {
        case privateTableView:
            let privateCell = tableView.dequeueReusableCell(withIdentifier: "privateCell", for: indexPath) as! PrivateCell
            let data = privateDataAll[indexPath.row]
            privateCell.privateCurrencyName?.text = data.currencyName
            privateCell.privateBuy?.text = data.currencyBuy
            privateCell.privateSell?.text = data.currencySell
            return privateCell
        
        case nationalTableView:
          let nationalCell = tableView.dequeueReusableCell(withIdentifier: "nationalCell", for: indexPath) as! NationalCell
            let data = nationalDataAll[indexPath.row]
            nationalCell.nationalCurrencyNameLabel?.text = data.name
            nationalCell.nationalUKRLabel?.text = data.natUKR
            nationalCell.nationalUSLabel?.text = data.natUS
            
            if (indexPath.row % 2 == 0) {
                nationalCell.backgroundColor = UIColor.systemGreen
            } else {
                nationalCell.backgroundColor = UIColor.white
            }
            return nationalCell
            
        default:
            print("Something wrong!!!")
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        func reload() {
            privateTableView.reloadData()
            nationalTableView.reloadData()
        }
        switch tableView {
            
        case privateTableView:
        if ((privateTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isSelected) == true) {
            reload()
            nationalTableView.scrollToRow(at: IndexPath(row: 9, section: 0), at: .none, animated: true)
            nationalTableView.selectRow(at: IndexPath(row: 9, section: 0), animated: true, scrollPosition: .none)
            privateTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
        } else if ((privateTableView.cellForRow(at: IndexPath(row: 1, section: 0))?.isSelected) == true) {
            reload()
            nationalTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .none, animated: true)
            nationalTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
            privateTableView.selectRow(at: IndexPath(row: 1, section: 0), animated: true, scrollPosition: .none)
        } else if ((privateTableView.cellForRow(at: IndexPath(row: 2, section: 0))?.isSelected) == true) {
            reload()
            nationalTableView.scrollToRow(at: IndexPath(row: 1, section: 0), at: .none, animated: true)
            nationalTableView.selectRow(at: IndexPath(row: 1, section: 0), animated: true, scrollPosition: .none)
            privateTableView.selectRow(at: IndexPath(row: 2, section: 0), animated: true, scrollPosition: .none)
        } else if ((privateTableView.cellForRow(at: IndexPath(row: 3, section: 0))?.isSelected) == true) {
            reload()
            nationalTableView.scrollToRow(at: IndexPath(row: 3, section: 0), at: .none, animated: true)
            nationalTableView.selectRow(at: IndexPath(row: 3, section: 0), animated: true, scrollPosition: .none)
            privateTableView.selectRow(at: IndexPath(row: 3, section: 0), animated: true, scrollPosition: .none)
            
        } else if ((privateTableView.cellForRow(at: IndexPath(row: 4, section: 0))?.isSelected) == true) {
            reload()
            nationalTableView.scrollToRow(at: IndexPath(row: 2, section: 0), at: .none, animated: true)
            nationalTableView.selectRow(at: IndexPath(row: 2, section: 0), animated: true, scrollPosition: .none)
            privateTableView.selectRow(at: IndexPath(row: 4, section: 0), animated: true, scrollPosition: .none)
        } else if ((privateTableView.cellForRow(at: IndexPath(row: 5, section: 0))?.isSelected) == true) {
            reload()
            nationalTableView.scrollToRow(at: IndexPath(row: 4, section: 0), at: .none, animated: true)
            nationalTableView.selectRow(at: IndexPath(row: 4, section: 0), animated: true, scrollPosition: .none)
            privateTableView.selectRow(at: IndexPath(row: 5, section: 0), animated: true, scrollPosition: .none)
        } else if ((privateTableView.cellForRow(at: IndexPath(row: 6, section: 0))?.isSelected) == true) {
            reload()
            nationalTableView.scrollToRow(at: IndexPath(row: 5, section: 0), at: .none, animated: true)
            nationalTableView.selectRow(at: IndexPath(row: 5, section: 0), animated: true, scrollPosition: .none)
            privateTableView.selectRow(at: IndexPath(row: 6, section: 0), animated: true, scrollPosition: .none)
        }
        
        case nationalTableView:
            
        if ((nationalTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isSelected) == true) {
            reload()
            privateTableView.scrollToRow(at: IndexPath(row: 1, section: 0), at: .none, animated: true)
            privateTableView.selectRow(at: IndexPath(row: 1, section: 0), animated: true, scrollPosition: .none)
            nationalTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
       
        } else if ((nationalTableView.cellForRow(at: IndexPath(row: 1, section: 0))?.isSelected) == true) {
            reload()
            privateTableView.scrollToRow(at: IndexPath(row: 2, section: 0), at: .none, animated: true)
            privateTableView.selectRow(at: IndexPath(row: 2, section: 0), animated: true, scrollPosition: .none)
            nationalTableView.selectRow(at: IndexPath(row: 1, section: 0), animated: true, scrollPosition: .none)
            
        } else if ((nationalTableView.cellForRow(at: IndexPath(row: 2, section: 0))?.isSelected) == true) {
            reload()
            privateTableView.scrollToRow(at: IndexPath(row: 4, section: 0), at: .none, animated: true)
            privateTableView.selectRow(at: IndexPath(row: 4, section: 0), animated: true, scrollPosition: .none)
            nationalTableView.selectRow(at: IndexPath(row: 2, section: 0), animated: true, scrollPosition: .none)
        
        } else if ((nationalTableView.cellForRow(at: IndexPath(row: 3, section: 0))?.isSelected) == true) {
            reload()
            privateTableView.scrollToRow(at: IndexPath(row: 3, section: 0), at: .none, animated: true)
            privateTableView.selectRow(at: IndexPath(row: 3, section: 0), animated: true, scrollPosition: .none)
            nationalTableView.selectRow(at: IndexPath(row: 3, section: 0), animated: true, scrollPosition: .none)
        
        } else if ((nationalTableView.cellForRow(at: IndexPath(row: 4, section: 0))?.isSelected) == true) {
            reload()
            privateTableView.scrollToRow(at: IndexPath(row: 5, section: 0), at: .none, animated: true)
            privateTableView.selectRow(at: IndexPath(row: 5, section: 0), animated: true, scrollPosition: .none)
            nationalTableView.selectRow(at: IndexPath(row: 4, section: 0), animated: true, scrollPosition: .none)
        
        } else if ((nationalTableView.cellForRow(at: IndexPath(row: 5, section: 0))?.isSelected) == true) {
            reload()
            privateTableView.scrollToRow(at: IndexPath(row: 6, section: 0), at: .none, animated: true)
            privateTableView.selectRow(at: IndexPath(row: 6, section: 0), animated: true, scrollPosition: .none)
            nationalTableView.selectRow(at: IndexPath(row: 5, section: 0), animated: true, scrollPosition: .none)
        
        } else if ((nationalTableView.cellForRow(at: IndexPath(row: 9, section: 0))?.isSelected) == true) {
            reload()
            privateTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .none, animated: true)
            privateTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
            nationalTableView.selectRow(at: IndexPath(row: 9, section: 0), animated: true, scrollPosition: .none)
        
        }
        default:
            reload()
        }
}
    
}


