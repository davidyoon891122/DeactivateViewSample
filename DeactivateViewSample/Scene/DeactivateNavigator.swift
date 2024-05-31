//
//  DeactivateNavigator.swift
//  DeactivateViewSample
//
//  Created by Davidyoon on 5/31/24.
//

import UIKit

protocol DeactivateNavigatorProtocol {
    
    func toDeactivate()
    func dismiss()
    
}

struct DeactivateNavigator {
    
    private let window: UIWindow?
    private weak var navigationController: UINavigationController?
    
    init(
        window: UIWindow?,
        navigationController: UINavigationController? = nil
    ) {
        self.window = window
        self.navigationController = navigationController
    }
    
}

extension DeactivateNavigator: DeactivateNavigatorProtocol {
    
    func toDeactivate() {
        let window = self.window
        
        let viewModel = DeactivateViewModel()
        let vc = DeactivateViewController(viewModel: viewModel)
        
        let nv = UINavigationController(rootViewController: vc)
        
        window?.rootViewController = nv        
    }
    
    func dismiss() {
        let window = self.window
        
        let nv = window?.rootViewController as? UINavigationController
        
        nv?.popViewController(animated: true)
    }
    
}
