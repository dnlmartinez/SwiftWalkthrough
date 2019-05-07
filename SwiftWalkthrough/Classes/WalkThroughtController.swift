//
//  WalkThroughtController.swift
//  testWalkThrought
//
//  Created by MacSivsa on 06/05/2019.
//  Copyright © 2019 PSA. All rights reserved.
//


import UIKit
import Foundation


public class WalkThroughtController: UIViewController, UIScrollViewDelegate {
    
    var viewWillDismissHandler: ViewWillDismiss?
    
    public typealias ViewWillDismiss = () -> Void
    
    
    var scrollView: UIScrollView = UIScrollView()
    var pageController: UIPageControl = UIPageControl()
    var btSkip: UIButton = UIButton()
    var btLeftArrow: UIButton = UIButton()
    var btRightArrow: UIButton = UIButton()
    var closeButton: UIButton = UIButton()
    var slides:[Slide] = [Slide]()
    
    
    //MARK: - Initialization
    
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        self.setupView()
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    
    public func setSkipButtonText(text: String){
        DispatchQueue.main.async {
            self.btSkip.setTitle(text, for: .normal)
        }
    }
    
    
    public func initPagesWithItems(items: [WalkItem]){
        
        self.slides = [Slide]()
        
        DispatchQueue.main.async {
            for item in items {
                let slide: Slide = Bundle.init(for: WalkThroughtController.classForCoder()).loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
                slide.iconImageView.image = item.imageCenter
                slide.bottomImageView.image = item.bottomImage
                slide.labelTittle.text = item.labelTittle
                slide.labelDescription.text = item.labelDescription
                self.slides.append(slide)
            }
            self.setupSlideScrollView(slides: self.slides)
            self.pageController.numberOfPages = self.slides.count
            self.pageController.currentPage = 0
        }
        
    }
    
    
    public func presentOn(presentingViewController: UIViewController, animated: Bool = true, onDismiss dismissHandler: ViewWillDismiss?) {
        modalPresentationStyle = .overCurrentContext
        self.viewWillDismissHandler = { [weak self] in
            dismissHandler?()
        }
        presentingViewController.present(self, animated: true)
    }
    
    
    private func setupView(){
        
        //SCROLLVIEW
        self.scrollView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(3), height: UIScreen.main.bounds.height)
        
        self.scrollView.indicatorStyle = UIScrollViewIndicatorStyle.white
        self.scrollView.delegate = self
        self.scrollView.isPagingEnabled = true
        
        //PAGECONTROLLER
        self.pageController = UIPageControl.init(frame: CGRect(x: (UIScreen.main.bounds.width / 2) - 50, y: UIScreen.main.bounds.height - 60, width: 100, height: 44))
        self.pageController.currentPage = 0
        
        //SKIP BUTTON
        self.btSkip = UIButton.init(frame: CGRect(x: UIScreen.main.bounds.width - 90, y: 28, width: 70, height: 54))
        self.btSkip.setTitle("Skip", for: .normal)
        self.btSkip.addTarget(self, action: #selector(pressSkipButton), for: .touchUpInside)
        
        //LEFT BUTTON
        self.btLeftArrow = UIButton.init(frame: CGRect(x: 16, y: UIScreen.main.bounds.height - 90 , width: 60, height: 50))
        
        let imagePathL: String =  Bundle.init(for: WalkThroughtController.classForCoder()).path(forResource: "leftarrow", ofType: "png")!
        let imageL = UIImage.init(contentsOfFile: imagePathL)
        
        self.btLeftArrow.setImage(imageL, for: .normal)
        self.btLeftArrow.addTarget(self, action: #selector(pressLeftButton), for: .touchUpInside)
        self.btLeftArrow.isHidden = true
        
        //RIGHT BUTTON
        self.btRightArrow = UIButton.init(frame: CGRect(x: UIScreen.main.bounds.width - 86, y: UIScreen.main.bounds.height - 90 , width: 60, height: 50))
        
        let imagePathR: String =  Bundle.init(for: WalkThroughtController.classForCoder()).path(forResource: "rightarrow", ofType: "png")!
        let imageR = UIImage.init(contentsOfFile: imagePathR)
        
        self.btRightArrow.setImage(imageR, for: .normal)
        self.btRightArrow.addTarget(self, action: #selector(pressRightButton), for: .touchUpInside)
        
        
        //CLOSE BUTTON
        self.closeButton = UIButton.init(frame: CGRect(x: UIScreen.main.bounds.width - 86, y: UIScreen.main.bounds.height - 90 , width: 60, height: 50))
        
        let imagePathC: String =  Bundle.init(for: WalkThroughtController.classForCoder()).path(forResource: "closeIcon", ofType: "png")!
        let imageC = UIImage.init(contentsOfFile: imagePathC)
        
        self.closeButton.setImage(imageC, for: .normal)
        self.closeButton.addTarget(self, action: #selector(pressCloseButton), for: .touchUpInside)
        self.closeButton.isHidden = true
        
        
        self.view.backgroundColor = UIColor.primary
        self.view.addSubview(scrollView)
        self.view.addSubview(pageController)
        self.view.addSubview(btSkip)
        self.view.addSubview(btLeftArrow)
        self.view.addSubview(btRightArrow)
        self.view.addSubview(closeButton)
    }
    
    
    private func setupSlideScrollView(slides : [Slide]) {
        
        DispatchQueue.main.async {
            self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(self.slides.count), height: UIScreen.main.bounds.height)
        
            for i in 0 ..< slides.count{
                slides[i].frame = CGRect(x: UIScreen.main.bounds.width * CGFloat(i), y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                self.scrollView.addSubview(slides[i])
            }
            
        }
    }
    
    
    
    //MARK: Butons Actions Methods
    
    @objc private func pressSkipButton(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc private func pressCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    @objc private func pressRightButton(_ sender: Any) {
        DispatchQueue.main.async {
            var frame: CGRect = self.scrollView.frame
            let next = self.pageController.currentPage + 1
            frame.origin.x = frame.size.width * CGFloat(next)
            frame.origin.y = 0
            self.scrollView.scrollRectToVisible(frame, animated: true)
        }
    }
    
    
    @objc private func pressLeftButton(_ sender: Any) {
        DispatchQueue.main.async {
            var frame: CGRect = self.scrollView.frame
            let next = self.pageController.currentPage - 1
            frame.origin.x = frame.size.width * CGFloat(next)
            frame.origin.y = 0
            
            NSLog("SCROLL PRESS LEFT: \(self.scrollView)")
            self.scrollView.scrollRectToVisible(frame, animated: true)
        }
    }
    
    
    //MARK: ScrollView Delegate Methods
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pageIndex = round(scrollView.contentOffset.x/UIScreen.main.bounds.width)
        pageController.currentPage = Int(pageIndex)
    
        switch Int(pageIndex) {
            case 0:
                DispatchQueue.main.async {
                    self.btSkip.isHidden = false
                    self.btLeftArrow.isHidden = false
                    self.btRightArrow.isHidden = true
                    self.closeButton.isHidden = true
                }
                break
            case 1:
                DispatchQueue.main.async {
                    self.btSkip.isHidden = false
                    self.btLeftArrow.isHidden = false
                    self.btRightArrow.isHidden = false
                    self.closeButton.isHidden = true
                }
                break
            case 2:
                DispatchQueue.main.async {
                    self.btSkip.isHidden = true
                    self.btLeftArrow.isHidden = false
                    self.btRightArrow.isHidden = true
                    self.closeButton.isHidden = false
                }
                break
            default:
                break
        }
    }
    
    override open func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupSlideScrollView(slides: slides)
    }
    
}
