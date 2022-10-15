//
//  ViewController.swift
//  guidedLightProject
//
//  Created by Margels on 09/10/22.
//

import UIKit

final class ViewController: UIViewController {
    
// MARK: - Variables and constants
    
    // add background view
    private lazy var backgroundView: UIView = {
        let v = UIView()
        v.frame = CGRect(x: 0, y: 0, width: self.view.frame.width * 3, height: self.view.frame.height)
        v.alpha = 0
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    // add view that resembles a pole
    private lazy var trafficLightPoleView: UIView = {
        let v = UIView()
        v.backgroundColor = Constants.poleBackgroundColour
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOffset = .zero
        v.layer.shadowRadius = 30
        v.layer.shadowOpacity = 0.5
        v.alpha = 0
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    // add view that resembles traffic light
    private lazy var trafficLightView: UIView = {
        let v = UIView()
        v.backgroundColor = Constants.trafficLightViewBackgroundColour
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOffset = .zero
        v.layer.shadowRadius = 10
        v.layer.shadowOpacity = 0.5
        v.clipsToBounds = false
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    // add buttons to stack view
    private lazy var buttonsStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 20
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    // red light
    private lazy var redLightButton: UIButton = {
        let b = UIButton()
        b.backgroundColor = Constants.offLightsBackgroundColour
        b.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        b.layer.shadowRadius = 20
        b.layer.shadowOpacity = 1
        b.layer.shadowOffset = .zero
        b.layer.shadowColor = UIColor.clear.cgColor
        b.clipsToBounds = false
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    // yellow light
    private lazy var yellowLightButton: UIButton = {
        let b = UIButton()
        b.backgroundColor = Constants.offLightsBackgroundColour
        b.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        b.layer.shadowRadius = 20
        b.layer.shadowOpacity = 1
        b.layer.shadowOffset = .zero
        b.layer.shadowColor = UIColor.clear.cgColor
        b.clipsToBounds = false
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    // green light
    private lazy var greenLightButton: UIButton = {
        let b = UIButton()
        b.backgroundColor = Constants.offLightsBackgroundColour
        b.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        b.layer.shadowRadius = 20
        b.layer.shadowOpacity = 1
        b.layer.shadowOffset = .zero
        b.layer.shadowColor = UIColor.clear.cgColor
        b.clipsToBounds = false
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    // title label
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.alpha = 0
        l.textAlignment = .center
        l.text = Constants.defaultDescription.title
        l.font = UIFont.systemFont(ofSize: self.view.frame.height/20, weight: .heavy)
        l.minimumScaleFactor = 0.1
        l.adjustsFontSizeToFitWidth = true
        l.lineBreakMode = .byClipping
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    // description label
    private lazy var descriptionLabel: UILabel = {
        let l = UILabel()
        l.alpha = 0
        l.textAlignment = .center
        l.text = Constants.defaultDescription.description
        l.font = UIFont.systemFont(ofSize: self.view.frame.height/34, weight: .semibold)
        l.minimumScaleFactor = 0.1
        l.adjustsFontSizeToFitWidth = true
        l.lineBreakMode = .byClipping
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
        
    // constraints for animation
    private lazy var trafficLightLeadingConstraint = trafficLightPoleView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -75)
    private lazy var titleLabelLeadingConstraint = titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 150 + 30 )
    private lazy var titleLabelTrailingConstraint = titleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 150 - 30 )
    private lazy var descriptionLabelLeadingConstraint = descriptionLabel.leadingAnchor.constraint(equalTo: self.trafficLightPoleView.trailingAnchor, constant: 150 + 75)
    private lazy var descriptionLabelTrailingConstraint = descriptionLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 150 - 30)

    // collection of buttons
    private lazy var trafficLightButtons = [redLightButton, yellowLightButton, greenLightButton]

    // collection of buttons
    private lazy var animatedConstraints = [titleLabelLeadingConstraint, titleLabelTrailingConstraint, descriptionLabelLeadingConstraint, descriptionLabelTrailingConstraint]
    
    // make sure users follow the sequence
    private var sequenceCheck = [0, 1, 2]

    
    
// MARK: - View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSubviews()
        setUpConstraints()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        trafficLightsEntranceAnimation()
        
    }
    
    
// MARK: - View Methods
        
    // add subviews to view
    func setUpSubviews() {
        
        // add background
        self.view.addSubview(backgroundView)
        
        // add pole with traffic light
        self.view.addSubview(trafficLightPoleView)
        trafficLightPoleView.addSubview(trafficLightView)
        trafficLightView.addSubview(buttonsStackView)
        
        // add buttons to stack view
        buttonsStackView.insertArrangedSubview(greenLightButton, at: 0)
        buttonsStackView.insertArrangedSubview(yellowLightButton, at: 0)
        buttonsStackView.insertArrangedSubview(redLightButton, at: 0)
        
        // add labels to view
        self.view.addSubview(titleLabel)
        self.view.addSubview(descriptionLabel)
        
    }
    
    // set up constraints
    func setUpConstraints() {
        
        // width of pole & traffic light
        let trafficLightViewWidth: CGFloat = self.view.frame.width / 4
        let trafficLightPoleViewWidth = trafficLightViewWidth / 3
        
        // height of traffic light
        let stackViewPadding: CGFloat = 20*2
        let stackViewTotalSpacing: CGFloat = 20*2
        let buttons = CGFloat(trafficLightButtons.count)
        let trafficLightViewHeight = (trafficLightViewWidth-stackViewPadding) * buttons + stackViewPadding + stackViewTotalSpacing
        
        // buttons corner radius (circle)
        let buttonsCornerRadius = (trafficLightViewWidth-(20*2)) / 2
        
        // activate constraints
        NSLayoutConstraint.activate([
            
            // background image view
            backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -10),
            backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -10),
            backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 10),
            backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 10),
            
            // traffic light pole
            trafficLightLeadingConstraint,
            trafficLightPoleView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.8),
            trafficLightPoleView.widthAnchor.constraint(equalToConstant: trafficLightPoleViewWidth),
            trafficLightPoleView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 30),
            
            // traffic light view
            trafficLightView.centerXAnchor.constraint(equalTo: trafficLightPoleView.centerXAnchor),
            trafficLightView.topAnchor.constraint(equalTo: trafficLightPoleView.topAnchor, constant: 20),
            trafficLightView.widthAnchor.constraint(equalToConstant: trafficLightViewWidth),
            trafficLightView.heightAnchor.constraint(equalToConstant: trafficLightViewHeight),
            
            // traffic light buttons
            buttonsStackView.leadingAnchor.constraint(equalTo: trafficLightView.leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: trafficLightView.trailingAnchor, constant: -20),
            buttonsStackView.topAnchor.constraint(equalTo: trafficLightView.topAnchor, constant: 20),
            buttonsStackView.bottomAnchor.constraint(equalTo: trafficLightView.bottomAnchor, constant: -20),
            
            // red light button
            redLightButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor),
            redLightButton.heightAnchor.constraint(equalTo: buttonsStackView.widthAnchor),
            yellowLightButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor),
            yellowLightButton.heightAnchor.constraint(equalTo: buttonsStackView.widthAnchor),
            greenLightButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor),
            greenLightButton.heightAnchor.constraint(equalTo: buttonsStackView.widthAnchor),
            
            // title label
            titleLabelLeadingConstraint,
            titleLabelTrailingConstraint,
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.bottomAnchor.constraint(equalTo: trafficLightPoleView.topAnchor, constant: -30),
            
            // description label
            descriptionLabelLeadingConstraint,
            descriptionLabelTrailingConstraint,
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            
        ])
        
        // set up corner radius & other extras
        trafficLightPoleView.layer.cornerRadius = trafficLightPoleViewWidth / 2.5
        trafficLightView.layer.cornerRadius = trafficLightViewWidth / 2.5
        trafficLightButtons.forEach { button in
            button.layer.cornerRadius = buttonsCornerRadius
            
        }
    }
    
// MARK: - Logic Methods
    
    // handle button taps
    @objc func buttonTapped(_ sender: UIButton) {
        
        // check which button the user presses vs the expected button
        guard let buttonRawValue = trafficLightButtons.firstIndex(of: sender),
              let index = sequenceCheck.firstIndex(of: buttonRawValue)
        else { return }
        
        // set new colour
        Constants.trafficLightColour = .init(rawValue: buttonRawValue)
        
        // user presses wrong button, right button or same button
        switch index {
            
        // right button
        case 2:
            
            // update sequence & descriptor
            guard let n = sequenceCheck.last else { return }
            sequenceCheck.removeLast()
            sequenceCheck.insert(n, at: 0)
            handleTrafficLight(sender)
            Constants.currentDescriptor = Constants.descriptors[buttonRawValue]

            // start animations
            handleTrafficLight(sender)
            sender.isSelected = true

        // wrong button
        case 1:
            
            // restart sequence & remove lights
            sequenceCheck = [0, 1, 2]
            Constants.currentDescriptor = Constants.errorMessages[buttonRawValue]
            handleTrafficLight(nil)

        // same button
        default:
            
            // back to tutorial, restart sequence & remove lights
            sequenceCheck = [0, 1, 2]
            let descriptor = sender.isSelected ? Constants.defaultDescription : Constants.errorMessages[buttonRawValue]
            Constants.currentDescriptor = descriptor
            handleTrafficLight(nil)
            
        }
    }
    
    // handle lights and colours
    func handleTrafficLight(_ button: UIButton?) {
        
        // start removing labels
        removeLabels()
        
        // handle nil button scenario
        var buttons = self.trafficLightButtons
        guard let button = button else {
            turnOffAllLights(&buttons)
            return }
        
        // handle lights on & off
        turnOnSelectedLight(button)
        guard let index = buttons.firstIndex(where: { $0 == button }) else { return }
        buttons.remove(at: index)
        turnOffAllLights(&buttons)
        
    }
    
    // switch labels descriptors
    func replaceLabels() {
        
        titleLabel.text = Constants.currentDescriptor.title
        descriptionLabel.text = Constants.currentDescriptor.description
        titleLabelLeadingConstraint.isActive = true
        descriptionLabelLeadingConstraint.isActive = true
        
    }
    
    
// MARK: - Animations Methods
    
    // animation: create entrance
    func trafficLightsEntranceAnimation() {
        
        UIView.animate(withDuration: 0.75, delay: 0, options: .curveEaseOut) {
            self.trafficLightPoleView.alpha = 1
            self.trafficLightLeadingConstraint.constant = 75
            self.trafficLightLeadingConstraint.isActive = true
            self.view.layoutIfNeeded()
        } completion: { success in
            self.addLabels()
        }
    }
    
    // turn off other lights
    func turnOffAllLights(_ buttons: inout [UIButton]) {
        
        // turn off & clear shadow
        buttons.forEach { button in
            button.isSelected = false
            button.backgroundColor = Constants.offLightsBackgroundColour
            button.layer.shadowColor = UIColor.clear.cgColor
        }
        
        // neutralise background
        if buttons.count == 3 {
            self.backgroundView.backgroundColor = .clear
            self.backgroundView.alpha = 0
        }
    }
    
    // switch on light
    func turnOnSelectedLight(_ button: UIButton?) {
        
        UIView.animate(withDuration: 0.75, delay: 0, options: .curveEaseOut) {
            button?.backgroundColor = Constants.currentColour
            button?.layer.shadowColor = Constants.currentShadow?.cgColor
            self.backgroundView.backgroundColor = Constants.currentColour
            self.backgroundView.alpha = Constants.trafficLightColour != nil ? 0.65 : 0
            
        }
    }
    
    // removing labels animation
    func removeLabels() {
        
        self.titleLabel.alpha = 0.75
        self.descriptionLabel.alpha = 0.75
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            self.animatedConstraints.forEach { constraint in
                constraint.constant += 150
                constraint.isActive = true
            }
            self.titleLabel.alpha = 0
            self.descriptionLabel.alpha = 0
            self.view.layoutIfNeeded()
        } completion: { success in
            // add new labels
            self.replaceLabels()
            self.addLabels()
            
        }
    }
    
    // adding labels animation
    func addLabels() {
        
        self.titleLabel.alpha = 0.25
        self.descriptionLabel.alpha = 0.25
        UIView.animate(withDuration: 0.75, delay: 0, options: .curveEaseOut) {
            self.animatedConstraints.forEach { constraint in
                constraint.constant -= 150
                constraint.isActive = true
            }
            self.titleLabel.alpha = 1
            self.descriptionLabel.alpha = 1
            self.view.layoutIfNeeded()
            
        }
    }
    
}

