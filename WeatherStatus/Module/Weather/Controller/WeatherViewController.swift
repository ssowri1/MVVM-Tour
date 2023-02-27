//
//  ViewController.swift
//  WeatherStatus
//
//  Created by Sowrirajan S on 10/02/23.
//

import UIKit
import CoreLocation
import CoreData

class WeatherViewController: ParentViewController, LocationHandlerProtocol {
    
    /// Porperties
    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var locateMeButton: UIButton! {
        didSet {
            locateMeButton.cornerCurve()
        }
    }
    var viewModel = WeatherViewModel()
    var geoCoder = CLGeocoder()
    weak var coordinator: MainCoordinator?
    var resultSearchController = UISearchController()
    var location: CLLocation?
    
    //:MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = AppGeneral.weatherTitle
        configureTableView()
        LocationHandler.shared.configureLocationManager(delegate: self)
        configureLocation()
    }
    
    func configureTableView() {
        weatherTableView.registerCell(name: WeatherTableViewCell.onlyClassName, bundle: nil)
        weatherTableView.registerHeaderFooterView(name: WeatherTableViewCell.onlyClassName, bundle: nil)
    }
    /****
     To fetch weather details from server
     - Paremeters
        - payload: Dictionary
        - isSucess: Bool
     */
    func fetchWeather(_ payload: Parameters? = nil) {
        viewModel.fetchWeatherData(payload: payload, viewController: self) { [weak self] in
            DispatchQueue.main.async {
                self?.weatherTableView.reloadData()
            }
        }
    }
    /****
     To update the user current location
     */
    @IBAction func configureLocation() {
        var payLoad: Parameters? = nil
        if let coordinate = location?.coordinate {
            payLoad = [AppGeneral.latitude: String(describing: coordinate.latitude),
                       AppGeneral.longitude: String(describing: coordinate.longitude)]
        }
        viewModel.fetchLocation(self, payLoad) {
            DispatchQueue.main.async { [weak self] in
                self?.weatherTableView.reloadData()
            }
        }
    }
}

//:MARK: Table view delegate and datasource
extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return AppGeneral.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resultSearchController.isActive {
            return viewModel.numberOfRows
        } else {
            return viewModel.numberOfRows
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WeatherTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.selectionStyle = .none
        cell.data = viewModel.getWeather(indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return AppGeneral.heightOfHeader
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AppGeneral.heightOfCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.showWeatherDeatils(payload: viewModel.getWeather(indexPath))
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: AppGeneral.heightOfHeader))
        let headerCell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.onlyClassName) as? WeatherTableViewCell
        headerCell?.headerData = WeatherPayload(id: AppGeneral.id, name: AppGeneral.name, type: AppGeneral.type)
        headerCell?.frame = headerView.frame
        headerCell?.containerView.backgroundColor = .systemGray5
        headerView.addSubview(headerCell ?? WeatherTableViewCell())
        return headerView
    }
}

//MARK: Search bar delegates & location update delegate
extension WeatherViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.searchLocation(self, location: searchBar.text) { [weak self] in
            DispatchQueue.main.async {
                self?.weatherTableView.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    /****
     To fetch the current location from device
     - Paremeters
        - location: CLLocationCoordinate2D
     */
    func updateLocation(location: CLLocation) {
        self.location = location
    }
}
