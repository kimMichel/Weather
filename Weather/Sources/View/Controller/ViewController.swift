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
            descriptionLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20)
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
        ac.addAction(UIAlertAction(title: "Ok", style: .default) {_ in
            print("City was searched.")
            guard let textField = ac.textFields?.first else { return }
            let city = textField.text ?? ""
            print(city)
        })
        present(ac, animated: true)
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            viewModel.getWeather(lat: latitude, lon: longitude) { [weak self] weather in
                DispatchQueue.main.async {
                    self?.cityLabel.text = weather.cityName
                    self?.tempLabel.text = weather.temperatureString
                    self?.weatherImageView.image = UIImage(systemName: weather.conditionName)
                    self?.descriptionLabel.text = weather.description.capitalized
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

