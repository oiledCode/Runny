//
//  RNActivityListViewController.swift
//  Runny
//
//  Created by letterio d'antoni on 10/02/16.
//  Copyright © 2016 letterio d'antoni. All rights reserved.
//

import UIKit

class RNActivityListViewController: UITableViewController, UIGestureRecognizerDelegate {

    var pageViewController:RNPageViewController!
    var fakeData:NSMutableArray!
    var selectedIndexPath:NSIndexPath?;
    var selectedCell:RNActivityListCell?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewControllerWithIdentifier("PVS")
        self.pageViewController = vc as? RNPageViewController
        self.fakeData = NSMutableArray()
        
        self.fakeData.addObjectsFromArray([
            ["distance":"7.5 km", "time":"00:53:22 hrs", "pace":"5.45 km/h", "calories":"700", "steps":NSNumber(int: 81)],
            ["distance":"5.3 km", "time":"00:42:34 hrs", "pace":"6.00 km/h", "calories":"470", "steps":NSNumber(int: 68)],
            ["distance":"9.2 km", "time":"01:10:34 hrs", "pace":"5.37 km/h", "calories":"932", "steps":NSNumber(int: 96)],
            ["distance":"5.6 km", "time":"00:44:34 hrs", "pace":"6.00 km/h", "calories":"490", "steps":NSNumber(int: 69)],
            ["distance":"6.7 km", "time":"00:51:28 hrs", "pace":"5.34 km/h", "calories":"600", "steps":NSNumber(int: 71)],
            ["distance":"7.2 km", "time":"00:51:22 hrs", "pace":"5.45 km/h", "calories":"630", "steps":NSNumber(int: 78)],
            ["distance":"8.4 km", "time":"00:58:44 hrs", "pace":"5.98 km/h", "calories":"700", "steps":NSNumber(int: 84)],
            ["distance":"7.5 km", "time":"00:53:22 hrs", "pace":"5.45 km/h", "calories":"700", "steps":NSNumber(int: 81)],
            ["distance":"9.2 km", "time":"01:10:34 hrs", "pace":"5.37 km/h", "calories":"932", "steps":NSNumber(int: 96)],
            ["distance":"5.6 km", "time":"00:44:34 hrs", "pace":"6.00 km/h", "calories":"490", "steps":NSNumber(int: 69)],

        ])
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageViewController.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 200)
        let headerView = RNHeaderView.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 200), subview: self.pageViewController.view)
        
        self.addChildViewController(self.pageViewController);
        self.tableView.tableHeaderView = headerView;
        self.pageViewController.didMoveToParentViewController(self);
        
        let button = RNRoundButton.init(frame: CGRect(x: self.view.bounds.size.width - 65, y: 165, width: 50, height: 50))
        button.setImage(UIImage(named: "runIcon"), forState: .Normal)
        button.fillColor = UIColor.whiteColor()
        button.addTarget(self, action: NSSelectorFromString("startTapped:"), forControlEvents: .TouchUpInside)
        self.tableView.addSubview(button);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func startTapped(sender:RNRoundButton) {
        print(__FUNCTION__)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewControllerWithIdentifier("act")
        self.presentViewController(vc, animated: true, completion: nil)
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print(__FUNCTION__)
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        
        (cell as? RNActivityListCell)?.configureForActivity(self.fakeData[indexPath.row] as! NSDictionary)


        return cell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0;
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var rowHeight:CGFloat = 144.0
        if(self.selectedIndexPath?.compare(indexPath) == .OrderedSame) {
            if(self.selectedCell!.expanded) {
                rowHeight = 144.0
            }
            else {
                rowHeight = 450.0
            }
            self.selectedCell!.expanded = !self.selectedCell!.expanded
        }
        return rowHeight
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        return view
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedCell = tableView.cellForRowAtIndexPath(indexPath) as? RNActivityListCell
        tableView.beginUpdates()
        self.selectedIndexPath = indexPath;
        tableView.endUpdates()
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        (self.tableView.tableHeaderView as? RNHeaderView)?.relayoutWithOffSet(scrollView.contentOffset)
    }
}
