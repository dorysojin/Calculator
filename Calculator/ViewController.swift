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
        self.operation(.Divide)
    }
    
    @IBAction func multiplyButtonTapped(_ sender: UIButton) {
        self.operation(.Multiply)
    }
    
    @IBAction func subtractButtonTapped(_ sender: UIButton) {
        self.operation(.Subtract)
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        self.operation(.Add)
    }
    
    @IBAction func equalButtonTapped(_ sender: UIButton) {
        self.operation(self.currentOperation)
    }
    
    func operation(_ operation: Operation) {
        // 첫번째 피연산자와 두번째 피연산자를 연산해주는 로직 구현
        if self.currentOperation != .unknown {
            if !self.displayNumber.isEmpty {
                self.secondOperand = self.displayNumber // 두번째 입력받은 값 대입
                self.displayNumber = "" // 초기화 - 결과 값 표시 후 다시 숫자 선택하면 새롭게 선택된 숫자가 표시되게 해야 함
                
                // 첫번째와 두번째 피연산자를 더블형으로 변환
                guard let firstOperand = Double(self.firstOperand) else { return }
                guard let secondOperand = Double(self.secondOperand) else { return }
                
                // 연산
                switch self.currentOperation {
                case .Add:
                    self.result = "\(firstOperand + secondOperand)"
                    
                case .Subtract:
                    self.result = "\(firstOperand - secondOperand)"
                    
                case .Divide:
                    self.result = "\(firstOperand / secondOperand)"
                    
                case .Multiply:
                    self.result = "\(firstOperand * secondOperand)"
                    
                default:
                    break
                }
                
                // 1로 나눈 나머지 값이 0이면 소수점 표시 없애기
                if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0 {
                    self.result = "\(Int(result))"
                }
                
                // 연산자를 여러개 사용해야 함
                self.firstOperand = self.result // 첫번째 피연산자 프로퍼티에 결과 값 저장
                self.numberResultLabel.text = self.result // 라벨에 결과 값 표시
            }
            // 함수 파라미터로 전달한 오퍼레이션 값을 커런트오퍼레이션 프로퍼티에
            self.currentOperation = operation
            
        } else { // unknown이면 계산기가 초기화된 상태에서 사용자가 첫번째 피연산자와 연산자를 선택한 상태니까
            self.firstOperand = self.displayNumber // 화면에 표시된 숫자 값이 첫번째 피연산자로 저장
            self.currentOperation = operation // 선택한 연산자를 저장
            self.displayNumber = "" // 초기화 - 연산자 선택 후 지워지고 다음 피연산자가 나와야 하기 때문에
        }
    }
}

