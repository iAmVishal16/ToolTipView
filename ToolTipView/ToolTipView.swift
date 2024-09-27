//
//  ToolTipView.swift
//  ToolTipView
//
//  Created by Vishal Paliwal on 27/09/24.
//

import Foundation
import UIKit

public class ToolTipView: UIView {
    private let label = UILabel()
    private let arrowView = ArrowView()

    // The tooltip message can be set via this public initializer
    public init(message: String) {
        super.init(frame: .zero)
        
        setupLabel(message: message)
        setupBackground()
        setupArrowView()
        applyConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Method to set up the label with the provided message
    private func setupLabel(message: String) {
        label.text = message
        label.textColor = .gray // Gray text color
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0 // Allow multi-line text
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
    }

    // Method to set up the background view of the tooltip with shadow
    private func setupBackground() {
        backgroundColor = .clear
        let tooltipBackground = UIView()
        tooltipBackground.backgroundColor = .white
        tooltipBackground.layer.cornerRadius = 8
        tooltipBackground.layer.shadowColor = UIColor.black.cgColor
        tooltipBackground.layer.shadowOpacity = 0.3
        tooltipBackground.layer.shadowOffset = CGSize(width: 0, height: 2)
        tooltipBackground.layer.shadowRadius = 4
        tooltipBackground.translatesAutoresizingMaskIntoConstraints = false

        // Add the label to the background
        tooltipBackground.addSubview(label)
        addSubview(tooltipBackground)
    }

    // Method to set up the arrow view pointing to the button
    private func setupArrowView() {
        arrowView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(arrowView)
    }

    // Apply layout constraints to position elements correctly
    private func applyConstraints() {
        guard let tooltipBackground = subviews.first else { return }
        
        NSLayoutConstraint.activate([
            tooltipBackground.topAnchor.constraint(equalTo: self.topAnchor),
            tooltipBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tooltipBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            label.topAnchor.constraint(equalTo: tooltipBackground.topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: tooltipBackground.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: tooltipBackground.trailingAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: tooltipBackground.bottomAnchor, constant: -8),

            // Limit the width of the tooltip to a maximum
            tooltipBackground.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            // Arrow view constraints
            arrowView.topAnchor.constraint(equalTo: tooltipBackground.bottomAnchor, constant: 0),
            arrowView.centerXAnchor.constraint(equalTo: tooltipBackground.centerXAnchor),
            arrowView.widthAnchor.constraint(equalToConstant: 15),
            arrowView.heightAnchor.constraint(equalToConstant: 10)
        ])
    }

    // Public method to display the tooltip in a view
    public func show(in view: UIView, anchorButton: UIButton) {
        view.addSubview(self)

        // Set up the tooltip position relative to the button
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: anchorButton.centerXAnchor),
            bottomAnchor.constraint(equalTo: anchorButton.topAnchor, constant: -5)
        ])
        
        // Animate the tooltip appearance
        transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        alpha = 0
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.8,
                       options: .curveEaseOut,
                       animations: {
            self.transform = CGAffineTransform.identity
            self.alpha = 1
        })
    }

    // Public method to dismiss the tooltip
    public func dismiss() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }) { _ in
            self.removeFromSuperview()
        }
    }
}

import UIKit

// Arrow view that points to the button
class ArrowView: UIView {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))  // Tip of the arrow
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.close()

        UIColor.white.setFill() // White fill to match the tooltip background
        path.fill()
    }
}
