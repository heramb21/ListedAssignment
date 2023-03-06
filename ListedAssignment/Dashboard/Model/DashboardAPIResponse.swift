//
//  DashboardAPIResponse.swift
//  ListedAssignment
//
//  Created by Heramb on 06/03/23.
//

import Foundation

// MARK: - DashboardAPIResponse
struct DashboardAPIResponse: Codable {
    let status: Bool?
    let statusCode: Int?
    let message, supportWhatsappNumber: String?
    let extraIncome: Double?
    let totalLinks, totalClicks, todayClicks: Int?
    let topSource, topLocation, startTime: String?
    let linksCreatedToday: Int?
    let data: DataClass?
    
    enum CodingKeys: String, CodingKey {
        case status, statusCode, message
        case supportWhatsappNumber = "support_whatsapp_number"
        case extraIncome = "extra_income"
        case totalLinks = "total_links"
        case totalClicks = "total_clicks"
        case todayClicks = "today_clicks"
        case topSource = "top_source"
        case topLocation = "top_location"
        case startTime
        case linksCreatedToday = "links_created_today"
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        supportWhatsappNumber = try values.decodeIfPresent(String.self, forKey: .supportWhatsappNumber)
        extraIncome = try values.decodeIfPresent(Double.self, forKey: .extraIncome)
        totalLinks = try values.decodeIfPresent(Int.self, forKey: .totalLinks)
        totalClicks = try values.decodeIfPresent(Int.self, forKey: .totalClicks)
        todayClicks = try values.decodeIfPresent(Int.self, forKey: .todayClicks)
        topSource = try values.decodeIfPresent(String.self, forKey: .topSource)
        topLocation = try values.decodeIfPresent(String.self, forKey: .topLocation)
        startTime = try values.decodeIfPresent(String.self, forKey: .startTime)
        linksCreatedToday = try values.decodeIfPresent(Int.self, forKey: .linksCreatedToday)
        data = try values.decodeIfPresent(DataClass.self, forKey: .data)
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let recentLinks: [Link]?
    let topLinks: [Link]?
    let overallURLChart: [String: Int]?
    
    enum CodingKeys: String, CodingKey {
        case recentLinks = "recent_links"
        case topLinks = "top_links"
        case overallURLChart = "overall_url_chart"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        recentLinks = try values.decodeIfPresent([Link].self, forKey: .recentLinks)
        topLinks = try values.decodeIfPresent([Link].self, forKey: .topLinks)
        overallURLChart = try values.decodeIfPresent([String: Int].self, forKey: .overallURLChart)
    }
}

// MARK: - Link
struct Link: Codable {
    let urlID: Int?
    let webLink: String?
    let smartLink, title: String?
    let totalClicks: Int?
    let originalImage: String?
    let thumbnail: String?
    let timesAgo, createdAt: String?
    let domainID: DomainID?
    let urlPrefix: String?
    let urlSuffix, app: String?

    enum CodingKeys: String, CodingKey {
        case urlID = "url_id"
        case webLink = "web_link"
        case smartLink = "smart_link"
        case title
        case totalClicks = "total_clicks"
        case originalImage = "original_image"
        case thumbnail
        case timesAgo = "times_ago"
        case createdAt = "created_at"
        case domainID = "domain_id"
        case urlPrefix = "url_prefix"
        case urlSuffix = "url_suffix"
        case app
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        urlID = try values.decodeIfPresent(Int.self, forKey: .urlID)
        webLink = try values.decodeIfPresent(String.self, forKey: .webLink)
        smartLink = try values.decodeIfPresent(String.self, forKey: .smartLink)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        totalClicks = try values.decodeIfPresent(Int.self, forKey: .totalClicks)
        originalImage = try values.decodeIfPresent(String.self, forKey: .originalImage)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
        timesAgo = try values.decodeIfPresent(String.self, forKey: .timesAgo)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        domainID = try values.decodeIfPresent(DomainID.self, forKey: .domainID)
        urlPrefix = try values.decodeIfPresent(String.self, forKey: .urlPrefix)
        urlSuffix = try values.decodeIfPresent(String.self, forKey: .urlSuffix)
        app = try values.decodeIfPresent(String.self, forKey: .app)
    }
}

enum DomainID: String, Codable {
    case inopenappCOM = "inopenapp.com/"
}
