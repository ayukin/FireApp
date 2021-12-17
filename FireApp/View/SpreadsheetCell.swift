//
//  SpreadsheetCell.swift
//  FireApp
//
//  Created by 720.nishioka on 2021/06/20.
//

import UIKit
import SpreadsheetView
import RxSwift
import RxCocoa

class SpreadsheetCell: Cell {
    
    private let disposeBag = DisposeBag()
    
    static let identifier = "SpreadsheetTextCell"
    let textField = UITextField()
    
    public func setup(with text: String) {
        textField.text = text
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        contentView.addSubview(textField)
        
        // textFieldの値が変更されるたびに処理が走る
        textField.rx.controlEvent(.editingChanged).asDriver()
            .drive(onNext: { _ in
                print("editingChanged")
            })
            .disposed(by: disposeBag)
        
        // キーボードが閉じた時に処理が走る
        textField.rx.controlEvent(.editingDidEnd).asDriver()
            .drive(onNext: { _ in
                print("editingDidEnd")
            })
            .disposed(by: disposeBag)
        
        // よくわからない
        textField.rx.controlEvent(.editingDidEndOnExit).asDriver()
            .drive(onNext: { _ in
                
                print("editingDidEndOnExit")
            })
            .disposed(by: disposeBag)
        
        // よくわからない
        textField.rx.controlEvent(.valueChanged).asDriver()
            .drive(onNext: { _ in
                print("valueChanged")
            })
            .disposed(by: disposeBag)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textField.frame = contentView.bounds
    }
}
