/*
 * Copyright (c) 2015 Razeware LLC
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

import UIKit
import MapKit

class PancakeHouseViewController : UIViewController {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var detailsLabel: UILabel!
  @IBOutlet weak var priceGuideLabel: UILabel!
  @IBOutlet weak var ratingImage: UIImageView!
  @IBOutlet weak var showDetailsButton: UIButton!
  @IBOutlet weak var showMapButton: UIButton!


  var pancakeHouse : PancakeHouse? {
    didSet {
      configureView()
    }
  }
  
  func configureView() {
    // Update the user interface for the detail item.
    if let pancakeHouse = pancakeHouse {
      nameLabel?.text = pancakeHouse.name
      imageView?.image = pancakeHouse.photo ?? UIImage(named: "placeholder")
      detailsLabel?.text = pancakeHouse.details
      priceGuideLabel?.text = "\(pancakeHouse.priceGuide)"
      ratingImage?.image = pancakeHouse.rating.ratingImage
      centreMap(mapView, atPosition: pancakeHouse.location)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }
  
  @IBAction func handleShowDetailsButtonPressed(_ sender: UIButton) {
    if detailsLabel.isHidden {
      animateView(detailsLabel, toHidden: false)
      showDetailsButton.setTitle("Hide Details", for: UIControlState())
    } else {
      animateView(detailsLabel, toHidden: true)
      showDetailsButton.setTitle("Show Details", for: UIControlState())
    }
  }
  
  @IBAction func handleShowMapButtonPressed(_ sender: UIButton) {
    if mapView.isHidden {
      animateView(mapView, toHidden: false)
      showMapButton.setTitle("Hide Map", for: UIControlState())
    } else {
      animateView(mapView, toHidden: true)
      showMapButton.setTitle("Show Map", for: UIControlState())
    }
  }

  fileprivate func animateView(_ view: UIView, toHidden hidden: Bool) {
    UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10.0, options: UIViewAnimationOptions(), animations: { () -> Void in
      view.isHidden = hidden
      }, completion: nil)
  }
  
  
  fileprivate func centreMap(_ map: MKMapView?, atPosition position: CLLocationCoordinate2D?) {
    guard let map = map,
      let position = position else {
        return
    }
    map.isZoomEnabled = false
    map.isScrollEnabled = false
    map.isPitchEnabled = false
    map.isRotateEnabled = false
    
    map.setCenter(position, animated: true)
    
    let zoomRegion = MKCoordinateRegionMakeWithDistance(position, 10000, 10000)
    map.setRegion(zoomRegion, animated: true)
    
    let annotation = MKPointAnnotation()
    annotation.coordinate = position
    map.addAnnotation(annotation)
    
  }

}

