//
//  ViewController.swift
//  ListedAssignment
//
//  Created by Heramb on 04/03/23.
//

import UIKit

class ViewController: UIViewController {
    
    var dashboardViewModel = DashboardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dashboardViewModel.vc = self
        dashboardViewModel.getDashboardDetails()
    }


}

