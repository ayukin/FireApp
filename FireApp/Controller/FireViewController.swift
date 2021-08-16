//
//  FireViewController.swift
//  FireApp
//
//  Created by Ayuki Nishioka on 2021/06/02.
//

import UIKit
import SpreadsheetView
import RxSwift
import RxCocoa

class FireViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    // 達成金額label
    @IBOutlet weak var wrapView: UIView!
    @IBOutlet weak var fireMoneyLabel: UILabel!
    @IBOutlet weak var sideFireMoneyLabel: UILabel!
    @IBOutlet weak var goalMoneyLabel: UILabel!
    
    // 達成コメントlabel
    @IBOutlet weak var fireAchievementLabel: UILabel!
    @IBOutlet weak var sideFireAchievementlabel: UILabel!
    @IBOutlet weak var goalAchievementLabel: UILabel!
    
    // spreadsheetView
    @IBOutlet weak var spreadsheetView: SpreadsheetView!
    
    // ナビバーボタン
    @IBOutlet weak var recordButton: UIBarButtonItem!
    @IBOutlet weak var graphButton: UIBarButtonItem!
    
    private let data = ["年数", "年齢", "年間投資額", "投資元本", "年利", "単年利益", "累計利益", "合計資産", "前年比"]
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupBindings()
        
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    private func setup() {
        // wrapViewのセットアップ
        wrapView.layer.masksToBounds = true
        wrapView.layer.cornerRadius = 10
        wrapView.layer.borderColor = UIColor.black.cgColor
        wrapView.layer.borderWidth = 0.5
        // spreadsheetViewのセットアップ
        spreadsheetView.register(SpreadsheetCell.self, forCellWithReuseIdentifier: SpreadsheetCell.identifier)
        spreadsheetView.gridStyle = .solid(width: 1, color: .black)
        spreadsheetView.bounces = false
        spreadsheetView.delegate = self
        spreadsheetView.dataSource = self
    }
    
    private func setupBindings() {
        
        recordButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                // 基礎情報入力画面を表示する処理
            }
            .disposed(by: disposeBag)
        
        graphButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                // グラフ画面を表示する処理
                
            }
            .disposed(by: disposeBag)
        
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }

}

extension FireViewController: SpreadsheetViewDelegate {
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension FireViewController: SpreadsheetViewDataSource {
    // 列数
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 50
    }
    // 行数
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return data.count
    }
    // セルの幅
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        if column == 0 {
            return 100
        } else {
            return 150
        }
    }
    // セルの高さ
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        return 40
    }
    // 列ヘッダーの固定
    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }    
    // セルの生成
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        guard let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: SpreadsheetCell.identifier, for: indexPath) as? SpreadsheetCell else {
            return Cell()
        }
        
        if indexPath.section == 0 {
            cell.setup(with: data[indexPath.row])
            cell.backgroundColor = UIColor(named: "custom_Pink")
            cell.textField.isUserInteractionEnabled = false
        } else {
            cell.backgroundColor = UIColor.white
            cell.textField.isUserInteractionEnabled = false
            
            switch indexPath.row {
            case 0:
                cell.setup(with: "\(indexPath.section)")
                
            case 1:
                let age = 30
                cell.setup(with: "\(age+Int(indexPath.section))歳")
                
            case 2:
                cell.setup(with: "¥1800000円")
                cell.textField.isUserInteractionEnabled = true
                cell.backgroundColor = UIColor.systemGray5
                
            case 3:
                cell.setup(with: "¥1800000円")
                
            case 4:
                cell.setup(with: "5％")
                
            case 5:
                cell.setup(with: "¥1800000円")
                
            case 6:
                cell.setup(with: "¥1800000円")
                
            case 7:
                cell.setup(with: "¥1800000円")

            default:
                cell.setup(with: "¥1800000円")
                                
            }
        }
        return cell
    }
    
}
