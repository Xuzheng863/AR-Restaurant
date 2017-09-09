/*
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation
import CoreLocation

class Place: ARAnnotation {
  let placeName: String
  let address: String
  let rating: Double
  let price_level: Int!
  let price_tag: String
  
  
  var infoText: String {
    get {
      var info = "Address: \(address)"
      
      info += "\nRatings: \(rating)"
      
      info += "\nPrice Level: \(price_tag)"
      
      return info
    }
  }
  
  init(location: CLLocation, name: String, address: String, price_level: Int, rating: Double) {
    placeName = name
    self.address = address
    self.price_level = price_level
    self.rating = rating
    
    var price = ""
    while (self.price_level!>0)
    {
      price += "$"
      self.price_level!-=1
    }
    
    self.price_tag = price
    
    super.init()
    
    self.location = location
  }
  
  override var description: String {
    return placeName
  }
}
