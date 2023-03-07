//
//  ViewController.swift
//  ListedAssignment
//
//  Created by Heramb on 04/03/23.
//

import UIKit
import Charts
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var greetingLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var topDividerView: UIView!
    @IBOutlet weak var overviewLbl: UILabel!
    @IBOutlet weak var chartBgView: UIView!
    @IBOutlet weak var chartDateRangeLbl: UILabel!
    @IBOutlet weak var expectedPerformanceViewLineChart:LineChartView!
    @IBOutlet weak var segmentControl: HBSegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var dashboardViewModel = DashboardViewModel()
    var greetingMessage: String {
      let hour = Calendar.current.component(.hour, from: Date())
      if hour < 12 { return "Good morning" }
      if hour < 18 { return "Good afternoon" }
      return "Good evening"
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dashboardViewModel.vc = self
        dashboardViewModel.getDashboardDetails()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.setupUi()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            
            let statusbarView = UIView()
            statusbarView.backgroundColor = UIColor(red: 0.05, green: 0.44, blue: 1.00, alpha: 1.00)
            view.addSubview(statusbarView)
          
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
       
    }
    func setupUi(){
        headerLbl.addInterlineSpacing(spacingValue: 0.83)
        topDividerView.clipsToBounds = true
        topDividerView.layer.cornerRadius = 16
        topDividerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively
        chartBgView.layer.cornerRadius = 8
        nameLbl.addInterlineSpacing(spacingValue: 1.25)
        greetingLbl.addInterlineSpacing(spacingValue: 1.11)
        nameLbl.text = "Heramb Joshi"
        greetingLbl.text = self.greetingMessage
        overviewLbl.addInterlineSpacing(spacingValue: 1.19)
        let initialDate = self.dashboardViewModel.dashboardDetails?.data?.overallURLChart?.first?.key ?? ""
        let firstDate = dashboardViewModel.convertDateFormat(inputDate: initialDate)
        let todayDate = dashboardViewModel.convertDateFormat(inputDate: Date.getCurrentDate())
        chartDateRangeLbl.addInterlineSpacing(spacingValue: 0.83)
        chartDateRangeLbl.text = "\(firstDate) - \(todayDate)"
        expectedPerformance()
        segmentControl.items = ["Top Links","Recent Links"]
        segmentControl.font = UIFont.Figtree_SemiBold(size: 16)
        segmentControl.borderColor = UIColor.clear
        segmentControl.selectedIndex = 0
        segmentControl.padding = 3
        segmentControl.thumbColor = UIColor(hexString: "#0E6FFF")
        segmentControl.selectedLabelColor = UIColor.white
        segmentControl.unselectedLabelColor = UIColor.lightGray
        segmentControl.addTarget(self, action: #selector(ViewController.segmentValueChanged(_:)), for: .valueChanged)
        let nibtable = UINib(nibName: "LinkTableViewCell", bundle: nil)
        self.tableView?.register(nibtable, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    private func expectedPerformance(){
        var dataEntries : [ChartDataEntry] = []
        let chartDataDict = self.dashboardViewModel.dashboardDetails?.data?.overallURLChart
        for i in chartDataDict ?? [:] {
            let currentDate = i.key
            let dateArray = currentDate.components(separatedBy: "-")
            let lastElement = Double(dateArray.last ?? "") ?? 0.0
            if i.value > 0 {
                dataEntries.append(ChartDataEntry(x: lastElement , y: Double(i.value)))
            }
        }
        
        expectedPerformanceViewLineChart.rightAxis.labelTextColor = UIColor.clear
        expectedPerformanceViewLineChart.xAxis.labelPosition = .bottom
        expectedPerformanceViewLineChart.xAxis.labelFont = UIFont.Figtree_Regular(size: 9)!
        expectedPerformanceViewLineChart.xAxis.drawGridLinesEnabled = true
        expectedPerformanceViewLineChart.xAxis.labelTextColor = UIColor(red: 0.6, green: 0.612, blue: 0.627, alpha: 1)
        expectedPerformanceViewLineChart.xAxis.setLabelCount(.bitWidth, force: true)
        
        let set = LineChartDataSet(entries: dataEntries)
        set.mode = .cubicBezier
        set.drawCirclesEnabled = false
        set.lineWidth = 2
        set.setColor(UIColor(hexString: "#0E6FFF"))
        let colorTop =  UIColor(red: 0.055, green: 0.435, blue: 1, alpha: 1)
        set.drawHorizontalHighlightIndicatorEnabled = false
        set.highlightColor = UIColor.clear
        set.fillAlpha = 0.24
        let colorBottom = UIColor(red: 0.055, green: 0.435, blue: 1, alpha: 0)
        let gradientColors = [colorBottom.cgColor, colorTop.cgColor] as CFArray
        let colorLocations:[CGFloat] = [0.0, 1.0]
        
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Objectsel
        set.fill = LinearGradientFill(gradient: gradient!, angle: 90.0)
        set.drawFilledEnabled = true
        let data = LineChartData(dataSet: set)
        data.setDrawValues(false)
        expectedPerformanceViewLineChart.data = data
        expectedPerformanceViewLineChart.gridBackgroundColor = UIColor(hexString: "#EBEBEB")
    }
    
    @objc func segmentValueChanged(_ sender: AnyObject?){
        
        if segmentControl.selectedIndex == 0 {
            debugPrint("segmentControl.selectedIndex = 0")
            self.tableView.reloadData()
        }else if segmentControl.selectedIndex == 1{
            debugPrint("segmentControl.selectedIndex = 1")
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var linksCount: Int = 0
        if segmentControl.selectedIndex == 0 {
            linksCount = dashboardViewModel.dashboardDetails?.data?.topLinks?.count ?? 0
        }else if segmentControl.selectedIndex == 1{
            linksCount = dashboardViewModel.dashboardDetails?.data?.recentLinks?.count ?? 0
        }
        return linksCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! LinkTableViewCell
        if segmentControl.selectedIndex == 0 {
            let currentCellData = dashboardViewModel.dashboardDetails?.data?.topLinks?[indexPath.row]
            cell.originalImgView.sd_setImage(with: URL(string: currentCellData?.originalImage ?? ""), placeholderImage: UIImage(named: "logo"))
            cell.titleLbl.text = currentCellData?.title?.maxLength(length: 21) ?? "Sample link name..."
            cell.createdAtLbl.text = currentCellData?.timesAgo ?? ""
            cell.totalClicksLbl.text = String(currentCellData?.totalClicks ?? 0)
            cell.webLinkLbl.text = currentCellData?.webLink?.maxLength(length: 41) ?? ""
        } else {
            let currentCellData = dashboardViewModel.dashboardDetails?.data?.recentLinks?[indexPath.row]
            cell.originalImgView.sd_setImage(with: URL(string: currentCellData?.originalImage ?? ""), placeholderImage: UIImage(named: "logo"))
            cell.titleLbl.text = currentCellData?.title?.maxLength(length: 21) ?? "Sample link name..."
            cell.createdAtLbl.text = currentCellData?.timesAgo ?? ""
            cell.totalClicksLbl.text = String(currentCellData?.totalClicks ?? 0)
            cell.webLinkLbl.text = currentCellData?.webLink?.maxLength(length: 41) ?? ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
}

