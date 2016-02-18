//
//  PageViewController.swift
//  Runny
//
//  Created by letterio d'antoni on 20/01/16.
//  Copyright © 2016 letterio d'antoni. All rights reserved.
//

import UIKit

class RNPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate {

    var pages = [UIViewController]()
    var scrollView: UIScrollView!
    var colors = [UIColor]()
    var currentPage:NSInteger = 0;
    
    enum RNPageType:Int {
        case RNFreeRun = 0
        case RNDistanceRun
        case RNTimeRun
        case RNUndefinedRun
    }

// MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        self.colors.append(UIColor(red: 140/255, green: 236/255, blue: 241/255, alpha: 1.0))
        self.colors.append(UIColor(red: 104/255, green: 176/255, blue: 178/255, alpha: 1.0))
        self.colors.append(UIColor(red: 122/255, green: 205/255, blue: 210/255, alpha: 1.0))
        self.colors.append(UIColor(red: 140/255, green: 236/255, blue: 241/255, alpha: 1.0))
        self.colors.append(UIColor(red: 104/255, green: 176/255, blue: 178/255, alpha: 1.0))


        
        let page1: UIViewController! = storyboard?.instantiateViewControllerWithIdentifier("page1")
        let page2: UIViewController! = storyboard?.instantiateViewControllerWithIdentifier("page2")
        let page3: UIViewController! = storyboard?.instantiateViewControllerWithIdentifier("page3")
        
        page1.view.backgroundColor = UIColor.clearColor()
        page2.view.backgroundColor = UIColor.clearColor()
        page3.view.backgroundColor = UIColor.clearColor()

        self.view.backgroundColor = self.colors[1];

        pages.append(page3)
        pages.append(page2)
        pages.append(page1)
        
        self.setViewControllers([page3], direction: .Forward, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let subViews:NSArray = view.subviews
        var scrollView: UIScrollView? = nil
        var pageControl: UIPageControl? = nil
        for _view in subViews {
            if _view.isKindOfClass(UIScrollView) {
                scrollView = _view as? UIScrollView
            }
            else if _view.isKindOfClass(UIPageControl) {
                pageControl = _view as? UIPageControl
            }
        }
        
        if (scrollView != nil && pageControl != nil) {
            self.scrollView = scrollView
            self.scrollView.delegate = self;
            scrollView?.frame = view.bounds
            view.bringSubviewToFront(pageControl!)
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
// MARK: UIPageViewController delegate methods
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.indexOf(viewController)!
        if (currentIndex+1 > (pages.count - 1)) {
            return nil;
        }
        return pages[currentIndex+1]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.indexOf(viewController)!
        if (currentIndex-1 < 0) {
            return nil;
        }
        return pages[currentIndex-1]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if (completed) {
            if let lastController = pageViewController.viewControllers?.last {
                self.currentPage = self.pages.indexOf(lastController)!;
                print(currentPage);
            }
        }
    }
    
// MARK: UIScrollView delegate methods
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let interPolationColors = self.interpolationColorsForContentOffset(scrollView.contentOffset);
        let fraction:CGFloat = self.normalizedFractionForOffset(scrollView.contentOffset, pageSize: self.scrollView.bounds.size.width)
        self.view.backgroundColor = interPolationColors[0].interpolateRGBColorTo(interPolationColors[1] as! UIColor, fraction:(fraction))

    }

    func interpolationColorsForContentOffset(offset:CGPoint) -> NSArray {
        let idx = self.currentPage + 1;
        let s_color:UIColor = self.colors[idx];
        let e_color:UIColor!
        let bw = self.scrollView.bounds.size.width
        if (offset.x > bw) {
            e_color = self.colors[idx + 1]
        } else {
            e_color = self.colors[idx - 1]
        }
        
        return [s_color,e_color]
    }
    
    func normalizedFractionForOffset(offset:CGPoint, pageSize:CGFloat) -> CGFloat {
        var fraction:CGFloat = 0.0
        if (offset.x == 0.0) {
            return 0.0
        } else {
            fraction = offset.x / pageSize
        }
        return fabs(1.0 - fraction)
    }
    
    func runTypeForPage() -> RNPageType {
        var pageType:RNPageType = .RNUndefinedRun
        switch currentPage {
        case 0 :
            pageType = .RNTimeRun
            break
        case 1:
            pageType = .RNDistanceRun
            break
        case 2:
            pageType = .RNFreeRun
            break
        default:
            break
        }
        return pageType
    }
}

extension UIColor {
    
    func interpolateRGBColorTo(end:UIColor, fraction:CGFloat) -> UIColor {
        var f = max(0, fraction)
        f = min(1, fraction)
        
        let c1 = CGColorGetComponents(self.CGColor)
        let c2 = CGColorGetComponents(end.CGColor)
        
        let r: CGFloat = CGFloat(c1[0] + (c2[0] - c1[0]) * f)
        let g: CGFloat = CGFloat(c1[1] + (c2[1] - c1[1]) * f)
        let b: CGFloat = CGFloat(c1[2] + (c2[2] - c1[2]) * f)
        let a: CGFloat = CGFloat(c1[3] + (c2[3] - c1[3]) * f)
        
        return UIColor.init(red:r, green:g, blue:b, alpha:a)
    }
    
}
