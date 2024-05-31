//
//  ViewItem.swift
//  DeactivateViewSample
//
//  Created by Davidyoon on 5/31/24.
//

import UIKit

struct SampleItem {
    
    let type: ViewPage
    
    var imageViewItem: ImageViewItem {
        switch type {
        case .enable:
            ImageViewItem(image: UIImage(systemName: "person.circle")!)
        case .disable:
            ImageViewItem(image: UIImage(systemName: "person.circle")!)
        }
    }
    
    var titleViewItem: TitleViewItem {
        switch type {
        case .enable:
            TitleViewItem(title: "김한화님,\n탈퇴하시기 전에 확인해주세요")
        case .disable:
            TitleViewItem(title: "김한화님,\n아래 사유로 탈퇴가 불가능해요")
        }
    }
    
    var descriptionsViewItem: [DescriptionViewItem] {
        switch type {
        case .enable:
            [
                DescriptionViewItem(description: "PLUS에서 관리했던 김한화님의 모든 개인정보를 다시 볼 수 없어요."),
                DescriptionViewItem(description: "다양한 혜택과 이벤트 기회 등이 모두 사라져요.")
            ]
        case .disable:
            [
                DescriptionViewItem(description: "예약 진행중인 상품 또는 아직 유효기간이 남아있는 티켓이 있어요."),
                DescriptionViewItem(description: "예약 진행 중인 상품은 탈퇴 전 취소해주셔야 해요."),
                DescriptionViewItem(description: "유효기간이 남아있는 티켓은 유효기간 만료 후 탈퇴할 수 있어요."),
                DescriptionViewItem(description: "즉시 탈퇴를 원하시면 고객센터{전화번호}로 문의해주세요.")
            ]
        }
    }
    
}

enum ViewItem: Hashable {
    case image(ImageViewItem)
    case title(TitleViewItem)
    case description([DescriptionViewItem])
}

struct ImageViewItem: Hashable {
    
    let image: UIImage
    
}

struct TitleViewItem: Hashable {
    
    let title: String
    
}

struct DescriptionViewItem: Hashable {
    
    let description: String
    
}
