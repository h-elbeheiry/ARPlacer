//
//  ViewController.swift
//  ARPlacer
//
//  Created by Hussein AlBehary on 3/19/18.
//  Copyright © 2018 HUSSEIN ELBEHEIRY. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import MaterialComponents

class ViewController: UIViewController {
    
    // 3D object variable
    var objectName: String = "chair"
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setp gesture
        addTapGestureToSceneView()
        
        // Setup scene light
        configureLighting()
        
        // Show toast message to tell the user to wait
        showToast(message: "Initializing ...")
        
        // Init UIButton
        candleFloatButton()
        chairFloatButton()
        closetFloatButton()
        vaseFloatButton()
        couchFloatButton()
        
        // Init Reset Button
        resetButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpSceneView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    // MARK: Scene Setup
    func setUpSceneView() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration)
        
        sceneView.delegate = self
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
    }
    
    // MARK: Light Setup
    func configureLighting() {
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
    }
    
    // MARK: Object Setup
    @objc func addObjectToSceneView(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
        
        guard let hitTestResult = hitTestResults.first else { return }
        let translation = hitTestResult.worldTransform.translation
        let x = translation.x
        let y = translation.y
        let z = translation.z
        
        // 3D object variable
        objectName = "\(objectName)"
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/\(objectName)/\(objectName).scn")!
        
        let node = scene.rootNode.childNode(withName: "\(objectName)", recursively: true)!
        node.position = SCNVector3(x,y,z)
        
        scene.rootNode.addChildNode(node)
        
        // To add multiple object to the scene
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    // MARK: Touch gestures recoginzer
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.addObjectToSceneView(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    // MARK: UI Buttons - Create RESET Button
    /*
    func createCandleButton() {
        // UIButton to select Candle Object
        let selectButton = UIButton(type: .custom)
        selectButton.setImage(#imageLiteral(resourceName: "CandleSelectButton"), for: .normal)
        //selectButton.setImage(#imageLiteral(resourceName: "SelectButton"), for: .normal)
        selectButton.frame = CGRect(x: 90.0, y: 700.0, width: 80.0, height: 80.0)
        selectButton.center.x = self.view.center.x
        selectButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        
        view.addSubview(selectButton)
    }
    */
    
    // MARK: Material Design Float Button
    // Candle Float Button
    func candleFloatButton() {
        let floatingButton = MDCFloatingButton()
        //floatingButton.setTitle("+", for: .normal)
        floatingButton.setImage(#imageLiteral(resourceName: "CandleSelectButton"), for: .normal)
        floatingButton.sizeToFit()
        floatingButton.frame = CGRect(x: 320.0, y: 750.0, width: 45.0, height: 45.0)
        //floatingButton.center.x = self.view.center.x
        floatingButton.addTarget(self, action: #selector(candleFloatAction), for: .touchUpInside)
        self.view.addSubview(floatingButton)
    }
    
    // Vase Float Button
    func vaseFloatButton() {
        let floatingButton = MDCFloatingButton()
        //floatingButton.setTitle("+", for: .normal)
        floatingButton.setImage(#imageLiteral(resourceName: "VaseSelectButton"), for: .normal)
        floatingButton.sizeToFit()
        floatingButton.frame = CGRect(x: 320.0, y: 600.0, width: 45.0, height: 45.0)
        //floatingButton.center.x = self.view.center.x
        floatingButton.addTarget(self, action: #selector(vaseFloatAction), for: .touchUpInside)
        self.view.addSubview(floatingButton)
    }
    
    // Chair Float Button
    func chairFloatButton() {
        let floatingButton = MDCFloatingButton()
        floatingButton.setImage(#imageLiteral(resourceName: "ChairSelectButton"), for: .normal)
        floatingButton.sizeToFit()
        floatingButton.frame = CGRect(x: 320.0, y: 700.0, width: 45.0, height: 45.0)
        //floatingButton.center.x = self.view.center.x
        floatingButton.addTarget(self, action: #selector(chairFloatAction), for: .touchUpInside)
        self.view.addSubview(floatingButton)
    }
    
    // Closet Float Button
    func closetFloatButton() {
        let floatingButton = MDCFloatingButton()
        floatingButton.setImage(#imageLiteral(resourceName: "ClosetSelectButton"), for: .normal)
        floatingButton.sizeToFit()
        floatingButton.frame = CGRect(x: 320.0, y: 650.0, width: 45.0, height: 45.0)
        //floatingButton.center.x = self.view.center.x
        floatingButton.addTarget(self, action: #selector(closetFloatAction), for: .touchUpInside)
        self.view.addSubview(floatingButton)
    }
    
    // Couch Float Button
    func couchFloatButton() {
        let floatingButton = MDCFloatingButton()
        floatingButton.setImage(#imageLiteral(resourceName: "SofaSelectButton"), for: .normal)
        floatingButton.sizeToFit()
        floatingButton.frame = CGRect(x: 320.0, y: 550.0, width: 45.0, height: 45.0)
        //floatingButton.center.x = self.view.center.x
        floatingButton.addTarget(self, action: #selector(couchFloatAction), for: .touchUpInside)
        self.view.addSubview(floatingButton)
    }
    
    // Selecting Couch Button Action
    @objc func couchFloatAction(sender: UIButton) {
        print("Button pushed")
        objectName = "couch"
        print(objectName)
    }
    
    // Selecting Closet Button Action
    @objc func closetFloatAction(sender: UIButton) {
        print("Button pushed")
        objectName = "wardrobe_low"
        print(objectName)
    }
    
    // Selecting Candle Button Action
    @objc func candleFloatAction(sender: UIButton) {
        print("Button pushed")
        objectName = "candle"
        print(objectName)
    }
    
    // Selecting Chair Button Action
    @objc func chairFloatAction(sender: UIButton) {
        print("Button pushed")
        objectName = "chair"
        print(objectName)
    }
    
    // Selecting Vase Button Action
    @objc func vaseFloatAction(sender: UIButton) {
        print("Button pushed")
        objectName = "vase"
        print(objectName)
    }
    
    // Delete all objects from the scene
    func resetButton() {
        let resetButton = MDCFloatingButton()
        resetButton.setImage(#imageLiteral(resourceName: "ResetButton"), for: .normal)
        resetButton.sizeToFit()
        resetButton.frame = CGRect(x: 30.0, y: 50.0, width: 35.0, height: 35.0)
        resetButton.addTarget(self, action: #selector(resetButtonAction), for: .touchUpInside)
        self.view.addSubview(resetButton)
    }
    
    @objc func resetButtonAction(sender: UIButton) {
        print("Deleted the scene ...")
        
        self.sceneView.scene.rootNode.enumerateChildNodes { (existingNode, _) in
            existingNode.removeFromParentNode()
        }
        
    }
    
}

// MARK: Plane square
extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}

extension UIColor {
    open class var transparentLightBlue: UIColor {
        return UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 0.30)
    }
}

extension ViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // Setup Anchor
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        // Object Size/Dimensions
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        let plane = SCNPlane(width: width, height: height)
        
        // Setup blue light square for plane detection
        plane.materials.first?.diffuse.contents = UIColor.transparentLightBlue
        
        // Initializing child Node containing object
        let planeNode = SCNNode(geometry: plane)
        
        // Coordinates in scene
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x,y,z)
        planeNode.eulerAngles.x = -.pi / 2
        
        // Adding the child Node to Parent Node
        node.addChildNode(planeNode)
        
        // init Toast to place the object
        showToast(message: "Tap to place your object")
    }
    
    // MARK: Renderer
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        // Init anchor
        guard let planeAnchor = anchor as?  ARPlaneAnchor,
            let planeNode = node.childNodes.first,
            let plane = planeNode.geometry as? SCNPlane
            else { return }
        
        // Set the width and hight
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        plane.width = width
        plane.height = height
        
        // Set the dimension points
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x, y, z)
    }
}


// MARK: Toast Extension
extension UIViewController {
    // Toast setup
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        // Apply duration
        UIView.animate(withDuration: 10.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    } }
