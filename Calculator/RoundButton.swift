//
//  RoundButton.swift
//  Calculator
//
//  Created by 박소진 on 2022/02/21.
//

import UIKit

// 기존 UI버튼 + 사용자가 원하는 속성을 커스텀
class RoundButton: UIButton {
    
    // @IBInspectable - 스토리 보드에서도 isRound 프로퍼티 설정 값을 변경 할 수 있도록
    @IBInspectable var isRound: Bool = false {
        didSet {
            if isRound {
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
    }
}
