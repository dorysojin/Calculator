//
//  ViewController.swift
//  Calculator
//
//  Created by 박소진 on 2022/02/21.
//

import UIKit

enum Operation {
    case Add
    case Subtract
    case Divide
    case Multiply
    case unknown
}

class ViewController: UIViewController {

    @IBOutlet weak var numberResultLabel: UILabel!
    
    var displayNumber = "" // 키패드 누를 때마다 선택된 숫자들 저장
    var firstOperand = "" // 첫번째 피연산자 저장
    var secondOperand = "" // 두번째 피연산자 저장
    var result = "" // 결과 값 저장
    var currentOperation: Operation = .unknown // 현재 계산기에 어떤 연산자가 입력됐는지 알 수 있게 연산자의 값을 저장하는 프로퍼티
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func numberButtonTapped(_ sender: UIButton) {
        // 선택한 버튼의 타이틀 가져오기. 옵셔널이므로 가드 문으로 바인딩
        guard let numberValue = sender.title(for: .normal) else { return }
        
        // 숫자 9자리까지만 입력
        if self.displayNumber.count < 9 {
            self.displayNumber += numberValue
            self.numberResultLabel.text = self.displayNumber
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        self.displayNumber = ""
        self.firstOperand = ""
        self.secondOperand = ""
        self.result = ""
        self.currentOperation = .unknown
        self.numberResultLabel.text = "0"
    }
    
    @IBAction func dotButtonTapped(_ sender: UIButton) {
        // 숫자는 8자리까지, 소수점이 포함되지 않게(소숫점 중복 방지)
        if self.displayNumber.count < 8, !self.displayNumber.contains(".") {
            self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
            self.numberResultLabel.text = self.displayNumber
        }
    }
    
    @IBAction func divideButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func multiplyButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func subtractButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func equalButtonTapped(_ sender: UIButton) {
    }
}

