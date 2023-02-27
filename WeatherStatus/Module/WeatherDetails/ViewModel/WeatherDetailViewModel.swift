//
//  WeatherDetailViewModel.swift
//  WeatherStatus
//
//  Created by Sowrirajan S on 10/02/23.
//

import Foundation

class WeatherDetailViewModel {
    
    var weatherData: [String: Any] = [:]
    var sectionArray: [String] = []
    var weatherViewModel = WeatherViewModel()
    var payLoad: Parameters = [:]
    var weatherDetails: WeatherResponseModel?

    lazy var today: String = {
        let formatter = DateFormatter()
        formatter.dateFormat = AppGeneral.dateFormatOutput
        let nowString = formatter.string(from: Date())
        return nowString
    }()
    
    var title: String {
        return self.weatherDetails?.city.name ?? AppGeneral.detailsTitle
    }
    
    var numberOfSections: Int {
        return sectionArray.count
    }
    
    var numberOfRows: Int {
        return AppGeneral.numberOfRows
    }
    
    var heightOfCell: CGFloat {
        return AppGeneral.heightOfDetailCell
    }
    
    convenience init(data: WeatherData) {
        self.init()
        payLoad = [AppGeneral.latitude: String(describing: data.lat), AppGeneral.longitude: String(describing: data.lon)]
    }
    /****
     To get weather from response and recofiguring to adopt our UI
     - Paremeters
        - completion: @escaping()
     */
    func fetchWeather(closureHandler: @escaping() -> Void) {
        weatherViewModel.fetchWeatherData(payload: payLoad, viewController: WeatherDetailsViewController()) {
            self.weatherDetails = self.weatherViewModel.weatherDetails!
            self.weatherData = self.weatherDetails!.list.reduce(into: [String: [Any]]()) {
                $0[$1.dtTxt.toDate()] = $1.main
            }
            self.sectionArray = self.weatherData.keys.sorted { $0 < $1 }
            self.sectionArray.removeAll(where: { $0 == self.today })
            closureHandler()
        }
    }
    /****
     To get the weather from  resource
     - Paremeters
        - index: IndexPath
        - return: MainClass
     */
    func getWeather(index: IndexPath) -> MainClass? {
        let weather = weatherData[sectionArray[index.section]] as? MainClass
        return weather
    }
    /****
     To get the icon from  resource
     - Paremeters
        - index: IndexPath
        - return: Weather
     */
    func getIcon(index: IndexPath) -> Weather? {
        let weather = self.weatherDetails?.list[index.section].weather[index.row] as? Weather
        return weather
    }
    
    /****
     To get the weather title
     - Paremeters
        - section: Int
        - return: String
     */
    func getWeatherTitle(section: Int) -> String {
        return sectionArray[section]
    }
}
