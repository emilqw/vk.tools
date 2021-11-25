//
//  VKImageView.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 22.11.2021.
//

import UIKit
// Кастомный Image View
@IBDesignable class VKImageView: UIImageView {
    enum Types:String{
        case user, profile, none
    }
    var _imageViewType:String?
    @IBInspectable var imageViewType: String? {
        set {
            if newValue != nil {
                _imageViewType = newValue
                switch(_imageViewType) {
                case Types.user.rawValue:
                    cornerRadius = 25
                    borderWidth = 1
                    borderColor = #colorLiteral(red: 0, green: 0.4666666667, blue: 1, alpha: 1)
                    break
                case Types.profile.rawValue:
                    cornerRadius = 50
                    borderWidth = 1
                    borderColor = #colorLiteral(red: 0, green: 0.4666666667, blue: 1, alpha: 1)
                    break
                case Types.none.rawValue:
                    cornerRadius = 0
                    borderWidth = 0
                    borderColor = nil
                    break;
                default:break;
                }
            }
        }
        get {
            guard let type = _imageViewType else {
                return nil
            }
            return type
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0{
        didSet{
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0{
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
}

extension VKImageView {
    func download(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    
    /// Скачивает изображение по URL
    /// - Parameters:
    ///   - link: URL Изображения
    ///   - mode:
    func download(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        download(from: url, contentMode: mode)
    }
}
