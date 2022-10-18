//
//  StyledNavigationController.swift
//  SquareChallenge
//
//  Created by Ace Green on 2022-10-18.
//

import Foundation
import UIKit

public class StyledNavigationController: UINavigationController {
    
    enum ButtonAppearanceType {
        case back, plain, done
    }

    @available(iOS 13.0, *)
    var styledAppearance: UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Constants.cashGreen
        appearance.titleTextAttributes = getTitleTextAttributes()
        appearance.largeTitleTextAttributes = getLargeTitleTextAttributes()
        return appearance
    }

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    open override var childForStatusBarStyle: UIViewController? {
        return nil
    }

    public var prefersLargeTitles: Bool = false {
        didSet {
            navigationBar.prefersLargeTitles = prefersLargeTitles
        }
    }

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setStyle()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setStyle()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setStyle()
    }

    private func setStyle() {
        navigationBar.tintColor = UIColor.white
        navigationBar.backgroundColor = Constants.cashGreen
        navigationBar.isTranslucent = false
        prefersLargeTitles = false

        navigationBar.standardAppearance = styledAppearance
        navigationBar.compactAppearance = styledAppearance
        navigationBar.scrollEdgeAppearance = styledAppearance
    }

    @available(iOS 13.0, *)
    private func buttonAppearance(for type: ButtonAppearanceType) -> UIBarButtonItemAppearance {
        let buttonAppearance = UIBarButtonItemAppearance()
        let normalState = buttonAppearance.normal
        let selectedState = buttonAppearance.highlighted
        switch type {
        case .back:
            normalState.titleTextAttributes = getBackButtonTitleTextAttributes(for: .normal)
            selectedState.titleTextAttributes = getBackButtonTitleTextAttributes(for: .selected)
        case .done:
            normalState.titleTextAttributes = getDoneButtonTitleTextAttributes(for: .normal)
            selectedState.titleTextAttributes = getDoneButtonTitleTextAttributes(for: .selected)
        case .plain:
            normalState.titleTextAttributes = getDefaultButtonTitleTextAttributes(for: .normal)
            selectedState.titleTextAttributes = getDefaultButtonTitleTextAttributes(for: .selected)
        }
        return buttonAppearance
    }

    private func getTitleTextAttributes() -> [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    private func getLargeTitleTextAttributes() -> [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24),
                NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    private func getBackButtonTitleTextAttributes(for state: UIControl.State) -> [NSAttributedString.Key: Any] {
        switch state {
        case .selected:
            return [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                    NSAttributedString.Key.foregroundColor: UIColor.white]
        default:
            return [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                    NSAttributedString.Key.foregroundColor: UIColor.white]
        }
    }

    private func getDefaultButtonTitleTextAttributes(for state: UIControl.State) -> [NSAttributedString.Key: Any] {
        switch state {
        case .selected:
            return [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                    NSAttributedString.Key.foregroundColor: UIColor.white]
        default:
            return [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                    NSAttributedString.Key.foregroundColor: UIColor.white]
        }
    }

    private func getDoneButtonTitleTextAttributes(for state: UIControl.State) -> [NSAttributedString.Key: Any] {
        switch state {
        case .selected:
            return [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                    NSAttributedString.Key.foregroundColor: UIColor.white]
        default:
            return [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                    NSAttributedString.Key.foregroundColor: UIColor.white]
        }
    }
}
