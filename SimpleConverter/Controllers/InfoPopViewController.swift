//
//  InfoPopViewController.swift
//  SimpleConverter
//
//  Created by Денис Чупров on 28.04.2022.
//

import UIKit

class InfoPopViewController: UIViewController {
   
    let titleOfView : UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .black
        title.text = "Unicode symbols"
        return title
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addConstraints()
    }
    
    private func addConstraints() {
        view.addSubview(titleOfView)
        NSLayoutConstraint.activate([
            titleOfView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleOfView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        
        ])
    
    }
  
}
