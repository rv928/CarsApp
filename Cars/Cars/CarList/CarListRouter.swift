//
//  CarListRouter.swift
//  Cars
//
//  Created by Ravi Vora on 25/8/2563 BE.
//  Copyright © 2563 Ravi Vora. All rights reserved.
//

import Foundation

protocol CarListRouterInterface {}

final class CarListRouter: CarListRouterInterface {
    weak var viewController: CarListViewController!
}
