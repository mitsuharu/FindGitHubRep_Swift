//
//  RouterAction.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/03/26.
//

import Foundation
import ReMVVMSwiftUI
import SwiftUI

enum RouterAction: StoreAction {
    case navigate(destination: AnyView?)
    case assignIsActive(isActive: Bool)
}
