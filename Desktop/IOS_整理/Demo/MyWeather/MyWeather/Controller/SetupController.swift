//
//  SetupController.swift
//  MyWeather
//
//  Created by Lung on 2019/10/23.
//  Copyright © 2019 Team. All rights reserved.
//

import UIKit

class SetupController: UIViewController {

    @IBOutlet weak var SelectCounty: UILabel!
    @IBOutlet weak var PickerTextField: UITextField!
    @IBOutlet weak var BackgroundImage: UIImageView!
    
    let Picker = UIPickerView()
    
    let toolbarBtnFont = UIFont.boldSystemFont(ofSize: 18.0)
    
    var ViewModel = OneWeekWeatherViewModel()
    var util = IphoneModel()
    
    var cityName: [String] = ["基隆市", "臺北市", "新北市", "桃園市", "新竹市", "新竹縣", "苗栗縣", "臺中市", "彰化縣", "南投縣", "雲林縣", "嘉義市", "嘉義縣", "臺南市", "高雄市", "屏東縣", "臺東縣", "花蓮縣", "宜蘭縣", "澎湖縣", "金門縣", "連江縣"]
    var locationName: [String] = []
    var countyName: String = ""
    var zoneIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BackgroundImageSetup()
        navigationSetup()
        labelSetup()
        pickerSetup()
        pickerBtn()
    }
}
extension SetupController: UIPickerViewDelegate, UIPickerViewDataSource {
    func labelSetup(){
        SelectCounty.text = "選擇鄉鎮"
        SelectCounty.textColor = .black
    }
    
    func pickerSetup(){
        Picker.delegate = self
        Picker.dataSource = self
        PickerTextField.inputView = Picker
        
        // 輸入文字的顏色
        PickerTextField.textColor = UIColor.black
        
        // UITextField 的背景顏色
        PickerTextField.backgroundColor = .clear
        
        // UITextField 線條粗度
        PickerTextField.layer.borderWidth = 1.5
        
        // UITextField 線條顏色
        PickerTextField.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        // UITextField 圓角弧度
        PickerTextField.layer.cornerRadius = 10
        
        // 尚未輸入時的預設顯示提示文字
        //PickerTextField.placeholder = "請選擇"
        PickerTextField.attributedPlaceholder = NSAttributedString(string: "請選擇", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])
        
        // 輸入框右邊顯示清除按鈕時機 這邊選擇當編輯時顯示
        PickerTextField.clearButtonMode = .whileEditing
        
        // 輸入框的樣式 這邊選擇圓角樣式
        PickerTextField.borderStyle = .roundedRect
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyBoard))
        view.addGestureRecognizer(tap)
    }
    
    func BackgroundImageSetup(){
        BackgroundImage.image = UIImage(named: "content_back")
        // image 透明度
        BackgroundImage.alpha = 0.5
        // 設置圖片顯示模式
        BackgroundImage.contentMode = .scaleToFill
    }
    
    func navigationSetup(){
        let width: CGFloat = self.view.frame.width
        var height: CGFloat = 0
        
        if util.modelName == "identifier" {
            height = 44
        }else{
            height = 20
        }
        
        let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        navigationBar.backgroundColor = #colorLiteral(red: 0, green: 0.231372549, blue: 0.3411764706, alpha: 1)
        
        self.view.addSubview(navigationBar)
    }
    
    func pickerBtn() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let setupbtn = UIBarButtonItem(title: "設定", style: .plain, target: self, action: #selector(self.setupKeyBoard))
        setupbtn.setTitleTextAttributes([NSAttributedString.Key.font: toolbarBtnFont], for: .normal)
        setupbtn.setTitleTextAttributes([NSAttributedString.Key.font: toolbarBtnFont], for: .selected)
        
        let closebtn = UIBarButtonItem(title: "關閉", style: .plain, target: self, action: #selector(self.closeKeyBoard))
        closebtn.setTitleTextAttributes([NSAttributedString.Key.font: toolbarBtnFont], for: .normal)
        closebtn.setTitleTextAttributes([NSAttributedString.Key.font: toolbarBtnFont], for: .selected)
        
        toolBar.setItems([closebtn, flexSpace, setupbtn], animated: true)
        toolBar.isUserInteractionEnabled = true
        PickerTextField.inputAccessoryView = toolBar
    }
    
    @objc func setupKeyBoard(){
//        let homeNav = self.tabBarController?.viewControllers?.first as! UINavigationController
//        let home = homeNav.viewControllers.first as! HomeController
        
        let home = self.tabBarController?.viewControllers![0] as! HomeController
        
        if countyName == "" || zoneIndex == 0 {
            promptAlert(prompt: "請選擇縣市與地區", error: true)
            return
        }else{
            home.countyName = countyName
            home.zoneIndex = zoneIndex
            countyName = ""
            zoneIndex = 0
            self.view.endEditing(true)
            promptAlert(prompt: "設定完成", error: false)
        }
    }
    
    @objc func closeKeyBoard(){
        self.view.endEditing(true)
    }
    
    func promptAlert(prompt: String, error: Bool){
        if error {
            let alert = UIAlertController(title: prompt, message: "", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "關閉", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: prompt, message: "", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "關閉", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return cityName.count
        case 1:
            return locationName.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return cityName[row]
        case 1:
            return locationName[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let cityText: String = cityName[Picker.selectedRow(inComponent: 0)]
        var locationText: String = ""
        
        switch component {
            case 0:
                setlocations(city: cityName[row])
                self.countyName = cityName[row]
                Picker.reloadAllComponents()
                Picker.selectRow(0, inComponent: 1, animated: true)
            case 1:
                self.zoneIndex = row
                locationText = locationName[Picker.selectedRow(inComponent: 1)]
                Picker.reloadAllComponents()
            default:
                PickerTextField.text = cityName[row]
        }
        
        PickerTextField.text = "\(cityText + locationText)"
    }
    
    func setlocations(city: String) {
        self.ViewModel.getCounty(county: city)
        self.locationName.removeAll()
        ViewModel.reloadOneWeekWeather = { [weak self] ()  in
            DispatchQueue.main.async {
             for location in (self?.ViewModel.oneweeklocations[0].location)! {
                 self?.locationName.append(location.locationName!)
             }
              
             self!.Picker.reloadAllComponents()
            }
        }
    }
}
