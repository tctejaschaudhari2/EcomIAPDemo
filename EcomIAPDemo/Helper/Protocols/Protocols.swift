//
//  Protocols.swift
//  EcomIAPDemo
//
//  Created by tejas chaudhari on 26/07/25.
//

import Foundation

protocol BaseViewModel {
    var showAlert: ((String?)->())? { get set }
    var nextScreen: ((String?, Int)->())? { get set }

}

protocol actionDelegate {
    func action()
}
