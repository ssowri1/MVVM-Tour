//
//  Double+Extension.swift
//  WeatherStatus
//
//  Created by Sowrirajan S on 18/02/23.
//

import Foundation

extension Double {
    func convertTemp(from inputTempType: UnitTemperature, to outputTempType: UnitTemperature) -> String {
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 0
        formatter.unitOptions = .providedUnit
        let input = Measurement(value: self, unit: inputTempType)
        let output = input.converted(to: outputTempType)
        return formatter.string(from: output)
    }
}
