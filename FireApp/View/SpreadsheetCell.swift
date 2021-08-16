//
//  SpreadsheetCell.swift
//  FireApp
//
//  Created by 720.nishioka on 2021/06/20.
//

import UIKit
import SpreadsheetView

class SpreadsheetCell: Cell {
    
    static let identifier = "SpreadsheetTextCell"
    let textField = UITextField()
    
    public func setup(with text: String) {
        textField.delegate = self
        textField.text = text
        textField.textAlignment = .center
        contentView.addSubview(textField)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textField.frame = contentView.bounds
    }
}

extension SpreadsheetCell: UITextFieldDelegate {
    // 入力開始時の処理
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    // textFieldの内容をリアルタイムで反映させる
    func textFieldDidChangeSelection(_ textField: UITextField) {
    }
    // リターンキーを押したときキーボードが閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // 入力終了時の処理（フォーカスがはずれる）
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
}
