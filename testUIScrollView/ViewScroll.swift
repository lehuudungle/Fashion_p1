//
//  ViewScroll.swift
//  testUIScrollView
//
//  Created by Admin on 10/19/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
class ViewScroll: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var scollView: UIScrollView!
    var photo = UIImageView()
    
    @IBOutlet weak var sld_Zoom: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imgView = UIImageView(image: UIImage(named: "shop1-0.jpg"))
        
        imgView.frame = CGRectMake(0, 0, imgView.frame.size.width, imgView.frame.size.height)
        imgView.userInteractionEnabled = true  // tuong tac giao dien voi no
        imgView.multipleTouchEnabled = true   // tuong tac da diem , co the double tap cho no
        let tap  = UITapGestureRecognizer(target: self, action: Selector("tapImg:"))
        tap.numberOfTapsRequired = 1
        imgView.addGestureRecognizer(tap)
        let doubleTap = UITapGestureRecognizer(target: self, action: Selector("doubleTabImg:"))
        doubleTap.numberOfTapsRequired = 2
        tap.requireGestureRecognizerToFail(doubleTap)
        imgView.addGestureRecognizer(doubleTap)
        imgView.contentMode = .Top
        photo = imgView
        scollView.contentSize = CGSizeMake(imgView.bounds.width, imgView.bounds.height)
        scollView.minimumZoomScale = 0.5
        scollView.maximumZoomScale = 2
        self.scollView.addSubview(imgView)
        sld_Zoom.value = 0
        
    }
    
    func viewForZoomingInScrollView(scollView: UIScrollView)->UIView?{
        return photo
    }
    func tapImg(gesture: UITapGestureRecognizer ){
            let position = gesture.locationInView(photo)
        zoomRectForScale(scollView.zoomScale * 1.5,center: position)
    }
    func doubleTabImg(gesture: UITapGestureRecognizer){
        let position = gesture.locationInView(photo)
        zoomRectForScale(scollView.zoomScale * -1.5, center: position)
    }
    func zoomRectForScale(scale: CGFloat, center: CGPoint){
        var zoomRect = CGRect()
        let scrollViewSize = scollView.bounds.size
        zoomRect.size.height = scrollViewSize.height / scale
        zoomRect.size.width = scrollViewSize.width / scale
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        print(zoomRect)
        scollView.zoomToRect(zoomRect, animated: true)
    }
    
    @IBAction func actionZoom_InOut(sender: AnyObject) {
        scollView.zoomScale = CGFloat(sld_Zoom.value * 1.5 + 0.5)
    }
    
}
