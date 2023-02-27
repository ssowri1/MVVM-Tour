//
//  WeatherDetailsViewController.swift
//  WeatherStatus
//
//  Created by Sowrirajan S on 10/02/23.
//

import Foundation
import UIKit

class WeatherDetailsViewController: ParentViewController {
    
    @IBOutlet weak var detailsTableView: UITableView!
    weak var coordinator: MainCoordinator?
    var viewModel = WeatherDetailViewModel()
    
    override func viewDidLoad() {
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        feathWeather()
    }
    
    func configureTableView() {
        detailsTableView.registerCell(name: WeatherDetailTableViewCell.onlyClassName, bundle: nil)
    }
    
    func feathWeather() {
        viewModel.fetchWeather {
            DispatchQueue.main.async { [weak self] in
                self?.title = self?.viewModel.title
                self?.detailsTableView.reloadData()
            }
        }
    }
}

extension WeatherDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WeatherDetailTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.selectionStyle = .none
        let icon = viewModel.getIcon(index: indexPath)
        let weather = viewModel.getWeather(index: indexPath)
        cell.configuredData(data: weather, weather: icon)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightOfCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getWeatherTitle(section: section)
    }
}
