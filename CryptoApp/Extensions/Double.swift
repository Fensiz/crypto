//
//  Double.swift
//  CryptoApp
//
//  Created by Симонов Иван Дмитриевич on 30.06.2023.
//

import Foundation

extension Double {
	///Convert a Double into a Currency with 2 decimal places
	///```
	///Convert 1234.56 to $1,234.56
	///```
	private var currencyFormatter2: NumberFormatter {
		let formatter = NumberFormatter()
		formatter.usesGroupingSeparator = true
		formatter.numberStyle = .currency
//		formatter.locale = .current 		//default
//		formatter.currencyCode = "usd"
//		formatter.currencySymbol = "$"
		formatter.minimumFractionDigits = 2
		formatter.maximumFractionDigits = 2
		return formatter
	}
	///Convert a Double into a Currency  as a String with 2 decimal places
	///```
	///Convert 1234.56 to $1,234.56
	///```
	func asCurrencyWith2Decimals() -> String {
		let number = NSNumber(value: self)
		return currencyFormatter6.string(from: number) ?? "$0.00"
	}
	///Convert a Double into a Currency with 2-6 decimal places
	///```
	///Convert 1234.56 to $1,234.56
	///```
	private var currencyFormatter6: NumberFormatter {
		let formatter = NumberFormatter()
		formatter.usesGroupingSeparator = true
		formatter.numberStyle = .currency
//		formatter.locale = .current 		//default
//		formatter.currencyCode = "usd"
//		formatter.currencySymbol = "$"
		formatter.minimumFractionDigits = 2
		formatter.maximumFractionDigits = 6
		return formatter
	}
	///Convert a Double into a Currency  as a String with 2-6 decimal places
	///```
	///Convert 1234.56 to $1,234.56
	///```
	func asCurrencyWith6Decimals() -> String {
		let number = NSNumber(value: self)
		return currencyFormatter6.string(from: number) ?? "$0.00"
	}
	
	///Convert a Double into a string with percent
	///```
	///Convert 1234.56 to 1234.56%
	///```
	func asPercentString() -> String {
		String(format: "%+.2f%%", self)
	}
	
	func asNumberString() -> String {
		String(format: "%.2f", self)
	}
}
