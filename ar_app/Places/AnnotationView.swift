//
//  AnnotationView.swift
//  Places
//
//  Created by Zheng Xu on 9/8/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import UIKit

//1
protocol AnnotationViewDelegate {
  func didTouch(annotationView: AnnotationView)
}

//2
class AnnotationView: ARAnnotationView {
  //3
  var titleLabel: UILabel?
  var distanceLabel: UILabel?
  var ratingLabel: UILabel?
  var priceLevelLabel: UILabel?
  var delegate: AnnotationViewDelegate?
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    
    loadUI()
  }
  
  //4
  func loadUI() {
    titleLabel?.removeFromSuperview()
    distanceLabel?.removeFromSuperview()
    ratingLabel?.removeFromSuperview()
    priceLevelLabel?.removeFromSuperview()
    
    let label = UILabel(frame: CGRect(x: 10, y: 0, width: self.frame.size.width, height: 30))
    label.font = UIFont.systemFont(ofSize: 16)
    label.numberOfLines = 0
    label.backgroundColor = UIColor(white: 0.3, alpha: 0.7)
    label.textColor = UIColor.white
    self.addSubview(label)
    self.titleLabel = label
    
    distanceLabel = UILabel(frame: CGRect(x: 10, y: 30, width: self.frame.size.width, height: 20))
    distanceLabel?.backgroundColor = UIColor(white: 0.3, alpha: 0.7)
    distanceLabel?.textColor = UIColor.green
    distanceLabel?.font = UIFont.systemFont(ofSize: 12)
    self.addSubview(distanceLabel!)
    
    ratingLabel = UILabel(frame: CGRect(x: 10, y: 50, width: self.frame.size.width, height: 20))
    ratingLabel?.backgroundColor = UIColor(white: 0.3, alpha: 0.7)
    ratingLabel?.textColor = UIColor.yellow
    ratingLabel?.font = UIFont.systemFont(ofSize: 12)
    self.addSubview(ratingLabel!)
    
    priceLevelLabel = UILabel(frame: CGRect(x: 10, y: 70, width: self.frame.size.width, height: 20))
    priceLevelLabel?.backgroundColor = UIColor(white: 0.3, alpha: 0.7)
    priceLevelLabel?.textColor = UIColor.yellow
    priceLevelLabel?.font = UIFont.systemFont(ofSize: 12)
    self.addSubview(priceLevelLabel!)
    
    if let annotation = annotation as? Place {
      titleLabel?.text = annotation.placeName
      distanceLabel?.text = String(format: "Distance:%.2f km", annotation.distanceFromUser / 1000)
      ratingLabel?.text = String(format: "Rating:%.1f", annotation.rating)
      priceLevelLabel?.text = annotation.price_tag
    }
  }
  
  //1
  override func layoutSubviews() {
    super.layoutSubviews()
    titleLabel?.frame = CGRect(x: 10, y: 0, width: self.frame.size.width, height: 30)
    distanceLabel?.frame = CGRect(x: 10, y: 30, width: self.frame.size.width, height: 20)
    ratingLabel?.frame = CGRect(x: 10, y: 50, width: self.frame.size.width, height: 20)
    priceLevelLabel?.frame = CGRect(x: 10, y: 70, width: self.frame.size.width, height: 20)
  }
  
  //2
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    delegate?.didTouch(annotationView: self)
  }
  
}
