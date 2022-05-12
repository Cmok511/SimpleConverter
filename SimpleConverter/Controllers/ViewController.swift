//
//  ViewController.swift
//  SimpleConverter
//
//  Created by Денис Чупров on 25.04.2022.
//pull

import UIKit

class ViewController: UIViewController {
    
    var courses  = [String: Double]()
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    enum selectedCurrency {
        case RUB
        case USD
        case EUR
        case CNY
        case CHF
    }
    
    var selectedButton = selectedCurrency.RUB
        
    let rurButton = UIButton(title: "₽")
    let dollarButtont = UIButton(title: "$")
    let euroButton = UIButton(title: "€")
    let yuanButton = UIButton(title: "¥")
    let fruncButton = UIButton(title: "₣")
    
    
    let rurResultButton = UIButton(title: "₽")
    let dollarResultButtont = UIButton(title: "$")
    let euroResultButton = UIButton(title: "€")
    let yuanResultButton = UIButton(title: "¥")
    let fruncResultButton = UIButton(title: "₣")
    
    
    let mainView : UIView = {
        let mainView = UIView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()
    
    let arrowImage : UIImageView = {
        let arrowImage = UIImageView()
        arrowImage.translatesAutoresizingMaskIntoConstraints = false
        arrowImage.contentMode = .scaleAspectFill
        arrowImage.image = UIImage(named: "arrowpng")
        arrowImage.isHidden = true
        return arrowImage
    }()
    
    let textField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter amont"
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.font = UIFont(name: "Thonburi", size: 26)
        return textField
    }()
    
    let nominalLAbel = UILabel(font: "Thonburi", size: 26, text: "₽")
    
    let resultLabet = UILabel(font: "Thonburi", size: 26, text: "0 $")
    
    let startView : UIView = {
        let startView = UIView()
        startView.translatesAutoresizingMaskIntoConstraints = false
        startView.backgroundColor = .systemGray6
        startView.layer.cornerRadius = 20
        return startView
    }()
    
    let activityINdicator : UIActivityIndicatorView = {
        let activityINdicator = UIActivityIndicatorView()
        activityINdicator.translatesAutoresizingMaskIntoConstraints = false
        activityINdicator.tintColor = .blue
        activityINdicator.startAnimating()
        return activityINdicator
    }()
    
    let labelForStartView = UILabel(size: 14, text: "Get the current exchange rate")
    
    let doneView : UIImageView  = {
        let doneView = UIImageView()
        doneView.translatesAutoresizingMaskIntoConstraints = false
        doneView.image = UIImage(systemName: "checkmark.circle")
        doneView.isHidden = true
        return doneView
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Simple Converter"
        setupConstraints()
        textField.delegate = self
        moveTextfield()
        rurButton.backgroundColor = .systemBlue
        rurResultButton.isHidden = true
        dollarResultButtont.backgroundColor = .systemBlue
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureFunc))
        mainView.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(tapGesture)
        
        NetworkManager.shared.getData(url: "https://cdn.cur.su/api/latest.json") { [self] money in
            courses = money!.rates
        }
 
    // For start
        
        mainView.isUserInteractionEnabled = false
        mainView.alpha = 0.8
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if self.courses.isEmpty == false {
                self.activityINdicator.stopAnimating()
                self.doneView.isHidden = false
                self.doneView.rotationAnimation()
                self.startView.scaleAnimationView()
                self.labelForStartView.text = "Successfully"
                self.labelForStartView.font = UIFont.systemFont(ofSize: 17)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.startView.isHidden = true
                    self.mainView.isUserInteractionEnabled = true
                    self.mainView.alpha = 1
                }
            } else {
                self.activityINdicator.stopAnimating()
                self.doneView.isHidden = false
                self.doneView.image = UIImage(systemName: "xmark.circle")
                self.labelForStartView.text = "No data. Please check the connection"
            }
        }
        
    }
    
    private func setupConstraints() {
        view.addSubview(mainView)
     
        let horizontalViewForTextField = UIView()
        horizontalViewForTextField.translatesAutoresizingMaskIntoConstraints = false
        horizontalViewForTextField.addSubview(textField)
        horizontalViewForTextField.addSubview(nominalLAbel)
        view.addSubview(rurButton)
        mainView.addSubview(arrowImage)
        
        
        let upStackView = UIStackView(axis: .horizontal, spacing: 8, arrangedSubviews: [rurButton, dollarButtont, euroButton, yuanButton, fruncButton])
        mainView.addSubview(upStackView)
        
        rurButton.addTarget(self, action: #selector(currencyButtonTapped), for: .touchUpInside)
        dollarButtont.addTarget(self, action: #selector(currencyButtonTapped), for: .touchUpInside)
        euroButton.addTarget(self, action: #selector(currencyButtonTapped), for: .touchUpInside)
        yuanButton.addTarget(self, action: #selector(currencyButtonTapped), for: .touchUpInside)
        fruncButton.addTarget(self, action: #selector(currencyButtonTapped), for: .touchUpInside)
        
        
        rurButton.addTarget(self, action: #selector(detailInfoForCurrancy), for: .touchDownRepeat)
        dollarButtont.addTarget(self, action: #selector(detailInfoForCurrancy), for: .touchDownRepeat)
        euroButton.addTarget(self, action: #selector(detailInfoForCurrancy), for: .touchDownRepeat)
        yuanButton.addTarget(self, action: #selector(detailInfoForCurrancy), for: .touchDownRepeat)
        fruncButton.addTarget(self, action: #selector(detailInfoForCurrancy), for: .touchDownRepeat)
        
        let middleStackView = UIStackView(axis: .vertical, spacing: 0, arrangedSubviews: [horizontalViewForTextField, resultLabet])
        mainView.addSubview(middleStackView)
        
        let downStackView = UIStackView(axis: .horizontal, spacing: 8, arrangedSubviews: [dollarResultButtont, euroResultButton, rurResultButton,  yuanResultButton, fruncResultButton])
        mainView.addSubview(downStackView)
        
        dollarResultButtont.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
        euroResultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
        rurResultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
        yuanResultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
        fruncResultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
        
     
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: horizontalViewForTextField.leadingAnchor, constant: 35),
            textField.trailingAnchor.constraint(equalTo: horizontalViewForTextField.trailingAnchor, constant: -35),
            textField.topAnchor.constraint(equalTo: horizontalViewForTextField.topAnchor, constant: 0),
            textField.bottomAnchor.constraint(equalTo: horizontalViewForTextField.bottomAnchor, constant: 0),
            
            nominalLAbel.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            nominalLAbel.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 10)
        ])
        
        
        NSLayoutConstraint.activate([
            middleStackView.topAnchor.constraint(equalTo: upStackView.bottomAnchor, constant: 20),
            middleStackView.bottomAnchor.constraint(equalTo: downStackView.topAnchor, constant: -20),
            middleStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            middleStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1 / 2.5)
        ])
        
        NSLayoutConstraint.activate([
            upStackView.topAnchor.constraint(equalTo: mainView.topAnchor),
            upStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            upStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            upStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            downStackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            downStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            downStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            downStackView.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
        NSLayoutConstraint.activate([
            arrowImage.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            arrowImage.heightAnchor.constraint(equalToConstant: 30),
            arrowImage.bottomAnchor.constraint(equalTo: resultLabet.bottomAnchor),
            arrowImage.widthAnchor.constraint(equalToConstant: 8)
        ])
        
        view.addSubview(startView)
        
        NSLayoutConstraint.activate([
            startView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            startView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            startView.heightAnchor.constraint(equalToConstant: 140),
            startView.widthAnchor.constraint(equalToConstant: 140)
        ])
        
        startView.addSubview(activityINdicator)
        NSLayoutConstraint.activate([
            activityINdicator.centerXAnchor.constraint(equalTo: startView.centerXAnchor),
            activityINdicator.centerYAnchor.constraint(equalTo: startView.centerYAnchor, constant: -20)
        ])
        startView.addSubview(doneView)
        NSLayoutConstraint.activate([
            doneView.centerXAnchor.constraint(equalTo: startView.centerXAnchor),
            doneView.centerYAnchor.constraint(equalTo: startView.centerYAnchor, constant: -20)
        ])
        
        startView.addSubview(labelForStartView)
        NSLayoutConstraint.activate([
            labelForStartView.leadingAnchor.constraint(equalTo: startView.leadingAnchor, constant: 20),
            labelForStartView.trailingAnchor.constraint(equalTo: startView.trailingAnchor, constant: -20),
            labelForStartView.centerXAnchor.constraint(equalTo: startView.centerXAnchor),
            labelForStartView.centerYAnchor.constraint(equalTo: startView.centerYAnchor, constant: 20)
        ])
    }
    
    @objc private func resultButtonTapped(sender: UIButton) {
        let resultButtonArray = [dollarResultButtont, euroResultButton, rurResultButton, yuanResultButton, fruncResultButton]
        sender.scaleAnimation()
        resultLabet.scaleAnimation()
        arrowImage.isHidden = true
      
        for button in resultButtonArray {
                if button.isHighlighted {
                    button.backgroundColor = .systemBlue
                    resultLabet.text = "0 \(button.titleLabel?.text ?? "0")"
            } else {
                button.backgroundColor = .systemGray5
            }
        }
        result(sender: sender)
        
    }
  
    @objc private func currencyButtonTapped(sender: UIButton) {
        switch sender {
        case rurButton : selectedButton = selectedCurrency.RUB
        case dollarButtont : selectedButton = selectedCurrency.USD
        case euroButton : selectedButton = selectedCurrency.EUR
        case yuanButton : selectedButton =  selectedCurrency.CNY
        case fruncButton : selectedButton = selectedCurrency.CHF
        default : break
        }
        
        let buttonsArray = [rurButton, dollarButtont, euroButton, yuanButton, fruncButton]
        let resultButtonArray = [dollarResultButtont, euroResultButton, rurResultButton, yuanResultButton, fruncResultButton]
        sender.scaleAnimation()
        sender.scaleAnimation()
        hiddenResultButton(selectedButtonе: sender, forHiddden: resultButtonArray)
        
    for button in buttonsArray {
            if button.isHighlighted {
                button.backgroundColor = .systemBlue
                if nominalLAbel.text != button.titleLabel?.text {
                    nominalLAbel.rotationAnimation()
                    arrowImage.rotationAnimation()
                    arrowImage.scaleAnimation()
                    nominalLAbel.text = button.titleLabel?.text
                    nominalLAbel.scaleAnimation()
                } else {
                    nominalLAbel.scaleAnimation()
                }
        } else {
            button.backgroundColor = .systemGray5
        }
    }
        
        // for resultLabel text "Select currency"
            for resultButton in resultButtonArray {
                if resultButton.isHidden {
                    if resultButton.titleLabel?.text != nil && self.resultLabet.text?.last != nil {
                if (resultButton.titleLabel?.text)! == (String(self.resultLabet.text!.last!)) {
                        self.resultLabet.text = "Select currency"
                    arrowImage.isHidden = false
                    arrowImage.animateImage()
                    resultLabet.scaleAnimationTwo()
                    }
                }
                }
            }
         
        
       func hiddenResultButton(selectedButtonе : UIButton, forHiddden: [UIButton]) {
            for resultButtons in forHiddden {
                if selectedButtonе.titleLabel?.text == resultButtons.titleLabel?.text {
                    resultButtons.isHidden = true
                    resultButtons.backgroundColor = .systemGray5
                } else {
                    resultButtons.isHidden = false
                }
            }
        }
    }
    
    private func moveTextfield() {
   
    
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: ViewController.keyboardWillShowNotification, object: nil)
           
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: ViewController.keyboardWillHideNotification, object: nil)
    }
    
       @objc func keyBoardWillShow(notification: NSNotification?) {
           mainView.transform = CGAffineTransform(translationX: 0, y: -110)
       }
       
       @objc func keyBoardWillHide(notification: NSNotification?) {
           mainView.transform = CGAffineTransform(translationX: 0, y: 5)
       }

    
    @objc private func tapGestureFunc(sourceView: UIView) {
        textField.resignFirstResponder()
    }
    
    
    
    @objc private func detailInfoForCurrancy(sender: UIButton) {
   
        let infoVC = InfoPopViewController()
        infoVC.modalTransitionStyle = .crossDissolve
        infoVC.modalPresentationStyle = .popover
        let popVC = infoVC.popoverPresentationController
        popVC?.delegate = self
        popVC?.sourceView = sender

        switch sender {
        case rurButton : infoVC.titleOfView.text = "RUR - Russian Rouble"
        case dollarButtont : infoVC.titleOfView.text = "USD - United States Dollar"
        case euroButton : infoVC.titleOfView.text = "EUR - European Union"
        case yuanButton : infoVC.titleOfView.text = "CNY - Chinese Yuan"
        case fruncButton : infoVC.titleOfView.text = "CHF - Swiss Franc"
        default:
            infoVC.titleOfView.text = "RUR - Russian rubles"
        }

        popVC?.sourceRect = CGRect(x: 0 , y: 0 , width: 50, height: 50)
        infoVC.preferredContentSize = CGSize(width: self.view.bounds.width / 0.8, height: 40)

        present(infoVC, animated: true, completion: nil)
 
    }
    
    func result(sender : UIButton) {
    guard let amount = Double(textField.text!) else { return }
    // EURGBP = (USDGBP / USDEUR) = (0.73 / 0.87) = 0.84

    if selectedButton == .RUB  {
        switch sender {
        case dollarResultButtont : resultLabet.text = "\(String(format: "%.2f", (courses["USD"]! / courses["RUB"]!) * amount)) $"
        case euroResultButton : resultLabet.text =  "\( String(format: "%.2f",  (courses["EUR"]! / courses["RUB"]!) * amount)) €"
        case yuanResultButton : resultLabet.text =  "\( String(format: "%.2f", (courses["CNY"]! / courses["RUB"]!) * amount )) ¥"
        case fruncResultButton : resultLabet.text =  "\( String(format: "%.2f", (courses["CHF"]! / courses["RUB"]!) * amount)) ₣"
        default: break
        }
    }

    if selectedButton == .USD {
    switch sender {
    case rurResultButton : resultLabet.text = "\(String(format: "%.2f", amount * courses["RUB"]!)) ₽"
    case euroResultButton : resultLabet.text =  "\( String(format: "%.2f", amount *  courses["EUR"]!)) €"
    case yuanResultButton : resultLabet.text =  "\( String(format: "%.2f", amount * courses["CNY"]!)) ¥"
    case fruncResultButton : resultLabet.text =  "\( String(format: "%.2f", amount /  courses["CHF"]!)) ₣"
    default: break
        }
    }


    if selectedButton == .EUR {
    switch sender {
    case dollarResultButtont : resultLabet.text = "\(String(format: "%.2f", (courses["USD"]! / courses["EUR"]!) * amount)) $"
    case rurResultButton : resultLabet.text =  "\( String(format: "%.2f",  (courses["RUB"]! / courses["EUR"]!) * amount) ) ₽"
    case yuanResultButton : resultLabet.text =  "\( String(format: "%.2f", (courses["CNY"]! / courses["EUR"]!) * amount )) ¥"
    case fruncResultButton : resultLabet.text =  "\( String(format: "%.2f", (courses["CHF"]! / courses["EUR"]!) * amount)) ₣"
    default: break
    }
    }

    if selectedButton == .CNY {
    switch sender {
    case dollarResultButtont : resultLabet.text = "\(String(format: "%.2f", (courses["USD"]! / courses["CNY"]!) * amount)) $"
    case rurResultButton : resultLabet.text =  "\( String(format: "%.2f",  (courses["RUB"]! / courses["CNY"]!) * amount)) ₽"
    case euroResultButton : resultLabet.text =  "\( String(format: "%.2f", (courses["EUR"]! / courses["CNY"]!) * amount )) €"
    case fruncResultButton : resultLabet.text =  "\( String(format: "%.2f", (courses["CHF"]! / courses["CNY"]!) * amount)) ₣"
    default: break
    }
    }

    if selectedButton == .CHF {
    switch sender {
    case dollarResultButtont : resultLabet.text = "\(String(format: "%.2f", (courses["USD"]! / courses["CHF"]!) * amount)) $"
    case rurResultButton : resultLabet.text =  "\( String(format: "%.2f",  (courses["RUB"]! / courses["CHF"]!) * amount)) ₽"
    case euroResultButton : resultLabet.text =  "\( String(format: "%.2f", (courses["EUR"]! / courses["CHF"]!) * amount )) €"
    case yuanResultButton : resultLabet.text =  "\( String(format: "%.2f", (courses["CNY"]! / courses["CHF"]!) * amount)) ¥"
    default: break
    }
    }
    }
    
    
}

extension ViewController : UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


