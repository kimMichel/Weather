//
//  ViewController.swift
//  Weather
//
//  Created by Michel Jaejin Kim on 19/07/23.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var searchButton: UIButton!
    var cityLabel: UILabel!
    var weatherImageView: UIImageView!
    var tempLabel: UILabel!
    var descriptionLabel: UILabel!
    var minTempLabel: UILabel!
    var minTempValueLabel: UILabel!
    var maxTempLabel: UILabel!
    var maxTempValueLabel: UILabel!
    var tempFeelsLike: UILabel!
    var tempFeelsLikeValue: UILabel!
    
    var viewModel = WeatherViewModel()
    var locationManager = CLLocationManager()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBlue
        
        searchButton = UIButton(type: .system)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .white
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        view.addSubview(searchButton)
        
        
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
        
        descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = "-----"
        descriptionLabel.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(descriptionLabel)
        
        minTempLabel = UILabel()
        minTempLabel.translatesAutoresizingMaskIntoConstraints = false
        minTempLabel.font = UIFont.systemFont(ofSize: 24)
        minTempLabel.textAlignment = .left
        minTempLabel.textColor = .white
        minTempLabel.text = "Temperatura min:"
        view.addSubview(minTempLabel)
        
        minTempValueLabel = UILabel()
        minTempValueLabel.translatesAutoresizingMaskIntoConstraints = false
        minTempValueLabel.font = UIFont.systemFont(ofSize: 24)
        minTempValueLabel.textAlignment = .right
        minTempValueLabel.textColor = .white
        minTempValueLabel.text = "---"
        view.addSubview(minTempValueLabel)
        
        maxTempLabel = UILabel()
        maxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTempLabel.font = UIFont.systemFont(ofSize: 24)
        maxTempLabel.textAlignment = .left
        maxTempLabel.textColor = .white
        maxTempLabel.text = "Temperatura max:"
        view.addSubview(maxTempLabel)
        
        maxTempValueLabel = UILabel()
        maxTempValueLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTempValueLabel.font = UIFont.systemFont(ofSize: 24)
        maxTempValueLabel.textAlignment = .right
        maxTempValueLabel.textColor = .white
        maxTempValueLabel.text = "---"
        view.addSubview(maxTempValueLabel)
        
        tempFeelsLike = UILabel()
        tempFeelsLike.translatesAutoresizingMaskIntoConstraints = false
        tempFeelsLike.font = UIFont.systemFont(ofSize: 24)
        tempFeelsLike.textAlignment = .left
        tempFeelsLike.textColor = .white
        tempFeelsLike.text = "Sensação térmica:"
        view.addSubview(tempFeelsLike)
        
        tempFeelsLikeValue = UILabel()
        tempFeelsLikeValue.translatesAutoresizingMaskIntoConstraints = false
        tempFeelsLikeValue.font = UIFont.systemFont(ofSize: 24)
        tempFeelsLikeValue.textAlignment = .right
        tempFeelsLikeValue.textColor = .white
        tempFeelsLikeValue.text = "---"
        view.addSubview(tempFeelsLikeValue)
        
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            searchButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            cityLabel.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 20),
            cityLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            weatherImageView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 30),
            weatherImageView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            weatherImageView.heightAnchor.constraint(equalToConstant: 75.5),
            weatherImageView.widthAnchor.constraint(equalToConstant: 80),
            tempLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 20),
            tempLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 20),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
            minTempLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 25),
            minTempLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
            minTempLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.7),
            minTempValueLabel.centerYAnchor.constraint(equalTo: minTempLabel.centerYAnchor),
            minTempValueLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
            minTempValueLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.3),
            maxTempLabel.topAnchor.constraint(equalTo: minTempLabel.bottomAnchor, constant: 20),
            maxTempLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
            maxTempLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.7),
            maxTempValueLabel.centerYAnchor.constraint(equalTo: maxTempLabel.centerYAnchor),
            maxTempValueLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
            maxTempValueLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.3),
            tempFeelsLike.topAnchor.constraint(equalTo: maxTempLabel.bottomAnchor, constant: 20),
            tempFeelsLike.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
            tempFeelsLike.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.7),
            tempFeelsLikeValue.centerYAnchor.constraint(equalTo: tempFeelsLike.centerYAnchor),
            tempFeelsLikeValue.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
            tempFeelsLikeValue.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.3)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    @objc private func searchButtonTapped() {
        let ac = UIAlertController(title: "Pesquisar", message: "Digite o nome da cidade", preferredStyle: .alert)
        ac.addTextField { textField in
            textField.placeholder = "Digite o nome da cidade"
            textField.textAlignment = .center
            textField.autocapitalizationType = .words
            textField.keyboardType = .default
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Ok", style: .default) {[weak self] _ in
            print("City was searched.")
            guard let textField = ac.textFields?.first else { return }
            let city = textField.text ?? ""
            self?.viewModel.getWeather(cityName: city) { [weak self] weather in
                self?.loadView(weather)
            }
        })
        present(ac, animated: true)
    }
    
    func loadView(_ weather: WeatherModel) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.tempLabel.text = weather.temperatureString
            self.weatherImageView.image = UIImage(systemName: weather.conditionName)
            self.descriptionLabel.text = weather.description.capitalized
            self.minTempValueLabel.text = weather.minTempString
            self.maxTempValueLabel.text = weather.maxTempString
            self.tempFeelsLikeValue.text = weather.tempFeelsLikeString
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            viewModel.getWeather(lat: latitude, lon: longitude) { [weak self] weather in
                self?.loadView(weather)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

