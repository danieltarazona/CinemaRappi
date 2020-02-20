//
//  AppExtensions.swift
//  Cinema
//
//  Created by Daniel Tarazona on 2/13/20.
//  Copyright © 2020 Daniel Tarazona. All rights reserved.
//

import UIKit

extension UISearchBar {
  /**
   - Description: Set the style of the search bar.
   */
  func setStyle(placeholder: String) {
    self.tintColor = .white
    self.barTintColor = .white
    let textField = self.value(forKey: "searchField") as? UITextField
    textField?.textColor = .white
    self.layer.borderWidth = 0
    self.layer.borderColor = .none
    self.returnKeyType = .done
    self.enablesReturnKeyAutomatically = false
    self.showsCancelButton = false
    self.placeholder = placeholder
    self.autocapitalizationType = .none
  }
}

extension UINavigationBar {

  /**
   - Description: Set the style of the navigation bar.
   */
  func setStyle() {
    self.shadowImage = UIImage()
    self.setBackgroundImage(UIImage(), for: .top, barMetrics: .default)
  }
}

extension UIViewController {

  /**
   - Description: Dismiss the keyboard when touch out them.
   */
  @objc func dismissKeyboardApp() {
    view.addGestureRecognizer(
      UITapGestureRecognizer(target: view, action: #selector(view.endEditing(_:)))
    )
  }
}

extension UIButton {

  func setStyle(title: String) {
    self.setTitle(title, for: .normal)
    self.titleLabel!.textAlignment = .center
    self.setTitleColor(.white, for: .normal)
    self.layer.borderColor = UIColor.white.cgColor
    self.layer.cornerRadius = 5
    self.layer.borderWidth = 1
    self.isEnabled = true
    self.isUserInteractionEnabled = true
  }
}

extension JSONEncoder {
    func encodeJSONObject<T: Encodable>(_ value: T, options opt: JSONSerialization.ReadingOptions = []) throws -> Any {
        let data = try encode(value)
        return try JSONSerialization.jsonObject(with: data, options: opt)
    }
}

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, withJSONObject object: Any, options opt: JSONSerialization.WritingOptions = []) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: object, options: opt)
        return try decode(T.self, from: data)
    }
}
