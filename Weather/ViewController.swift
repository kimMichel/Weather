//
//  ViewController.swift
//  Weather
//
//  Created by Michel Jaejin Kim on 19/07/23.
//

import UIKit

class ViewController: UIViewController {
    
    var cityLabel: UILabel!
    var weatherImageView: UIImageView!
    var tempLabel: UILabel!
    
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBlue
        
        cityLabel = UILabel()
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.textAlignment = .center
        cityLabel.font = UIFont.systemFont(ofSize: 24)
        cityLabel.textColor = .white
        cityLabel.text = "Sao Paulo"
        view.addSubview(cityLabel)
        
        weatherImageView = UIImageView()
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.tintColor = .white
        weatherImageView.image = UIImage(systemName: "cloud.fill")
        view.addSubview(weatherImageView)
        
        tempLabel = UILabel()
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.textAlignment = .center
        tempLabel.textColor = .white
        tempLabel.text = "15°C"
        tempLabel.font = UIFont.systemFont(ofSize: 44)
        view.addSubview(tempLabel)
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherImageView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 30),
            weatherImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherImageView.heightAnchor.constraint(equalToConstant: 75.5),
            weatherImageView.widthAnchor.constraint(equalToConstant: 80),
            tempLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 20),
            tempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

