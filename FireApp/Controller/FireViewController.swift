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
    
    @IBOutlet private weak var wrapView: UIView!
    
    // 達成ラベル
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var moneyLabel: UILabel!
    @IBOutlet private weak var achievementLabel: UILabel!
    
    // 切替ボタン
    @IBOutlet private weak var fireChangeButton: UIButton!
    @IBOutlet private weak var sideFireChangeButton: UIButton!
    @IBOutlet private weak var goalChangeButton: UIButton!
    
    // spreadsheetView
    @IBOutlet private weak var spreadsheetView: SpreadsheetView!
    
    // ナビバーボタン
    @IBOutlet private weak var recordButton: UIBarButtonItem!
    @IBOutlet private weak var graphButton: UIBarButtonItem!
    
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
        wrapView.layer.cornerRadius = 10
        wrapView.layer.borderColor = UIColor.black.cgColor
        wrapView.layer.borderWidth = 0.5
        wrapView.layer.shadowOpacity = 0.3
        wrapView.layer.shadowRadius = 1
        wrapView.layer.shadowColor = UIColor.black.cgColor
        wrapView.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        // 達成ラベル
        titleLabel.text = "FIREに必要な金額"
        moneyLabel.text = "00,000,000円"
        achievementLabel.text = "○○年後の●●歳にFIREできます。"
        
        // fireChangeButtonのセットアップ
        fireChangeButton.backgroundColor = UIColor(named: "custom_Red")
        fireChangeButton.layer.cornerRadius = 10
        fireChangeButton.layer.shadowOpacity = 0.3
        fireChangeButton.layer.shadowRadius = 1
        fireChangeButton.layer.shadowColor = UIColor.black.cgColor
        fireChangeButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        // sideFireChangeButtonのセットアップ
        sideFireChangeButton.backgroundColor = UIColor.systemGray
        sideFireChangeButton.layer.cornerRadius = 10
        sideFireChangeButton.layer.shadowOpacity = 0.3
        sideFireChangeButton.layer.shadowRadius = 1
        sideFireChangeButton.layer.shadowColor = UIColor.black.cgColor
        sideFireChangeButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        // goalChangeButtonのセットアップ
        goalChangeButton.backgroundColor = UIColor.systemGray
        goalChangeButton.layer.cornerRadius = 10
        goalChangeButton.layer.shadowOpacity = 0.3
        goalChangeButton.layer.shadowRadius = 1
        goalChangeButton.layer.shadowColor = UIColor.black.cgColor
        goalChangeButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        
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
        
        fireChangeButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.titleLabel.text = "FIREに必要な金額"
                self?.moneyLabel.text = "00,000,000円"
                self?.achievementLabel.text = "○○年後の●●歳にFIREできます。"
                self?.fireChangeButton.backgroundColor = UIColor(named: "custom_Red")
                self?.sideFireChangeButton.backgroundColor = UIColor.systemGray
                self?.goalChangeButton.backgroundColor = UIColor.systemGray
            }
            .disposed(by: disposeBag)
        
        sideFireChangeButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.titleLabel.text = "サイドFIREに必要な金額"
                self?.moneyLabel.text = "00,000,000円"
                self?.achievementLabel.text = "○○年後の●●歳にサイドFIREできます。"
                self?.fireChangeButton.backgroundColor = UIColor.systemGray
                self?.sideFireChangeButton.backgroundColor = UIColor(named: "custom_Red")
                self?.goalChangeButton.backgroundColor = UIColor.systemGray
            }
            .disposed(by: disposeBag)
        
        goalChangeButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.titleLabel.text = "目標金額"
                self?.moneyLabel.text = "00,000,000円"
                self?.achievementLabel.text = "○○年後の●●歳に目標金額に到達できます。"
                self?.fireChangeButton.backgroundColor = UIColor.systemGray
                self?.sideFireChangeButton.backgroundColor = UIColor.systemGray
                self?.goalChangeButton.backgroundColor = UIColor(named: "custom_Red")
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
        return data.count
    }
    // 行数
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 50
    }
    // セルの幅
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        if column == 0 || column == 1 || column == 4 {
            return 75
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
    // 行ヘッダーの固定
    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }
    // セルの生成
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        guard let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: SpreadsheetCell.identifier, for: indexPath) as? SpreadsheetCell else {
            return Cell()
        }
        
        // セルの編集Bool値
        switch indexPath.section {
        case 2:
            if indexPath.row == 0 {
                cell.textField.isUserInteractionEnabled = false
            } else {
                cell.textField.isUserInteractionEnabled = true
            }
        default:
            cell.textField.isUserInteractionEnabled = false
        }
        
        // セルの配色
        switch indexPath.section {
        case 2:
            if indexPath.row == 0 {
                cell.backgroundColor = UIColor(named: "custom_Pink")
            } else {
                cell.backgroundColor = UIColor.systemGray5
            }
        default:
            if indexPath.row == 0 {
                cell.backgroundColor = UIColor(named: "custom_Pink")
            } else {
                cell.backgroundColor = UIColor.white
            }
        }
        
        // セルの値
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                cell.setup(with: data[indexPath.section])
            } else {
                cell.setup(with: "\(indexPath.row)")
            }
        case 1:
            if indexPath.row == 0 {
                cell.setup(with: data[indexPath.section])
            } else {
                // ViewModelから受け取る
                cell.setup(with: "\(30+Int(indexPath.row))歳")
            }
        case 2:
            if indexPath.row == 0 {
                cell.setup(with: data[indexPath.section])
            } else {
                // ViewModelから受け取る
                cell.setup(with: "¥1800000円")
            }
        case 3:
            if indexPath.row == 0 {
                cell.setup(with: data[indexPath.section])
            } else {
                // ViewModelから受け取る
                cell.setup(with: "¥1800000円")
            }
        case 4:
            if indexPath.row == 0 {
                cell.setup(with: data[indexPath.section])
            } else {
                // ViewModelから受け取る
                cell.setup(with: "5％")
            }
        case 5:
            if indexPath.row == 0 {
                cell.setup(with: data[indexPath.section])
            } else {
                // ViewModelから受け取る
                cell.setup(with: "¥1800000円")
            }
        case 6:
            if indexPath.row == 0 {
                cell.setup(with: data[indexPath.section])
            } else {
                // ViewModelから受け取る
                cell.setup(with: "¥1800000円")
            }
        case 7:
            if indexPath.row == 0 {
                cell.setup(with: data[indexPath.section])
            } else {
                // ViewModelから受け取る
                cell.setup(with: "¥1800000円")
            }
        default:
            if indexPath.row == 0 {
                cell.setup(with: data[indexPath.section])
            } else {
                // ViewModelから受け取る
                cell.setup(with: "¥1800000円")
            }
        }
        return cell
    }
    
}
