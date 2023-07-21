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
    
    var viewModel = WeatherViewModel()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBlue
        
        cityLabel = UILabel()
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.textAlignment = .center
        cityLabel.font = UIFont.systemFont(ofSize: 24)
        cityLabel.textColor = .white
        cityLabel.text = "---"
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
        tempLabel.text = "---"
        tempLabel.font = UIFont.boldSystemFont(ofSize: 44)
        view.addSubview(tempLabel)
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            cityLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            weatherImageView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 30),
            weatherImageView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            weatherImageView.heightAnchor.constraint(equalToConstant: 75.5),
            weatherImageView.widthAnchor.constraint(equalToConstant: 80),
            tempLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 20),
            tempLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }

    private func loadData() {
        viewModel.getWeather { [weak self] weather in
            DispatchQueue.main.async {
                self?.cityLabel.text = weather.cityName
                self?.tempLabel.text = weather.temperatureString
                self?.weatherImageView.image = UIImage(systemName: weather.conditionName)
            }
        }
    }

}

