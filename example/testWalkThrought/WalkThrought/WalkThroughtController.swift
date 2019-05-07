//
//  WalkThroughtController.swift
//  testWalkThrought
//
//  Created by MacSivsa on 06/05/2019.
//  Copyright © 2019 PSA. All rights reserved.
//


import UIKit
import Foundation


open class WalkThroughtController: UIViewController, UIScrollViewDelegate {

    
    private var viewWillDismissHandler: ViewWillDismiss?
    
    public typealias ViewWillDismiss = () -> Void
    
    private var scrollView: UIScrollView {
        let scroll: UIScrollView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        scroll.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(3), height: UIScreen.main.bounds.height)
        
        scroll.isPagingEnabled = true
        scroll.delegate = self
        return scroll
    }
    
    private var pageController: UIPageControl {
        let page = UIPageControl.init(frame: CGRect(x: (UIScreen.main.bounds.width / 2) - 50, y: UIScreen.main.bounds.height - 80, width: 100, height: 44))
        page.numberOfPages = 3
        page.currentPage = 0
        return page
    }
    
    private var btSkip: UIButton {
        let bt = UIButton.init(frame: CGRect(x: UIScreen.main.bounds.width - 90, y: 28, width: 70, height: 54))
        bt.setTitle("Skip", for: .normal)
        bt.addTarget(self, action: #selector(pressSkipButton), for: .touchUpInside)
        return bt
    }
    
    private var btLeftArrow: UIButton {
        let bt = UIButton.init(frame: CGRect(x: 16, y: UIScreen.main.bounds.height - 90 , width: 60, height: 60))
        bt.setImage(UIImage.init(named: "leftarrow"), for: .normal)
        bt.addTarget(self, action: #selector(pressLeftButton), for: .touchUpInside)
        bt.isHidden = true
        return bt
    }
    
    private var btRightArrow: UIButton {
        let bt = UIButton.init(frame: CGRect(x: UIScreen.main.bounds.width - 86, y: UIScreen.main.bounds.height - 90 , width: 60, height: 60))
        bt.setImage(UIImage.init(named: "rightarrow"), for: .normal)
        bt.addTarget(self, action: #selector(pressRightButton), for: .touchUpInside)
        return bt
    }
    
    private var closeButton: UIButton {
        let bt = UIButton.init(frame: CGRect(x: UIScreen.main.bounds.width - 70, y: UIScreen.main.bounds.height - 60 , width: 50, height: 50))
        bt.setImage(UIImage.init(named: "closeIcon"), for: .normal)
        bt.addTarget(self, action: #selector(pressCloseButton), for: .touchUpInside)
        bt.isHidden = true
        return bt
    }
    
    
    private var slides:[Slide] = [Slide]();
    
    
    //MARK: - Initialization
    
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        self.setupView()
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    
    public func initPagesWithItems(items: [WalkItem]){
        
        self.slides = [Slide]()
        
        DispatchQueue.main.async {
            for item in items {
                
                let slide: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
                
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
    
    
    //MARK: Private Methods
    
    
    private func setupView(){
        self.view.backgroundColor = UIColor.primary
        
        //self.scrollView.delegate = self
        
        self.view.addSubview(scrollView)
        self.view.addSubview(pageController)
        self.view.addSubview(btSkip)
        self.view.addSubview(closeButton)
        self.view.addSubview(btLeftArrow)
        self.view.addSubview(btRightArrow)
    }
    
    
    private func setupSlideScrollView(slides : [Slide]) {
        DispatchQueue.main.async {
            self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(self.slides.count), height: UIScreen.main.bounds.height)
        
            for i in 0 ..< slides.count {
                
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
            self.scrollView.scrollRectToVisible(frame, animated: true)
        }
    }
    
    
    //MARK: ScrollView Delegate Methods
    
    private func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
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
                    self.btLeftArrow.isHidden = true
                    self.btRightArrow.isHidden = false
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
