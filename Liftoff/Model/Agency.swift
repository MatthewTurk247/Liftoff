//
//  Agency.swift
//  Liftoff
//
//  Created by Matthew Turk on 7/10/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import Foundation

enum AgencyType: Int, Codable {
    case unknown
    case government
    case multinational
    case commercial
    case educational
    case `private`
    
    init(_ rawValue: Int) {
        self = AgencyType(rawValue: rawValue) ?? .unknown
    }
}

struct Agency: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case abbreviation = "abbrev"
        case countryCode
        case type
        case infoURLs
        case wikiURL
    }
    
    let id: Int
    let name: String
    let abbreviation: String
    let countryCode: String
    let type: AgencyType
    let infoURLs: [URL]
    let wikiURL: URL?
}

// MARK: - Store static data of the world's 232 space agencies.

class Continent {
    // Variables
    var name: String
    var agencies: [Agency]
    
    init(named: String, includeAgencies: [Agency]) {
        name = named
        agencies = includeAgencies
    }
    
    class func continents() -> [Continent] {
        return [self.NorthAmericanLocations(), self.EuropeanLocations(), self.AsianLocations(), self.SouthAmericanLocations(), self.AfricanLocations(), self.OceanicLocations()]
    }
    
    // Private methods
    
    private class func NorthAmericanLocations() -> Continent {
        var agencies = [Agency]()
        
        agencies.append(Agency(id: 44, name: "National Aeronautics and Space Administration", abbreviation: "NASA", countryCode: "USA", type: .government, infoURLs: [URL(string: "http://www.nasa.gov")!, URL(string: "https://www.youtube.com/channel/UCLA_DiR1FfKNvjuUpBHmylQ")!, URL(string: "https://twitter.com/nasa")!, URL(string: "https://www.facebook.com/nasa")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/National_Aeronautics_and_Space_Administration")))
        agencies.append(Agency(id: 16, name: "Canadian Space Agency", abbreviation: "CSA", countryCode: "CAN", type: .government, infoURLs: [URL(string: "http://asc-csa.gc.ca/eng/")!, URL(string: "https://twitter.com/csa_asc")!, URL(string: "https://www.facebook.com/CanadianSpaceAgency")!, URL(string: "https://www.instagram.com/canadianspaceagency/")!, URL(string: "https://www.linkedin.com/company/9441729/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Canadian_Space_Agency")))
        agencies.append(Agency(id: 3, name: "Mexican Space Agency", abbreviation: "AEM", countryCode: "MEX", type: .government, infoURLs: [URL(string: "http://www.aem.gob.mx")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Agencia_Espacial_Mexicana")))
        agencies.append(Agency(id: 21, name: "Consultative Committee for Space Data Systems", abbreviation: "CCSDS", countryCode: "USA", type: .multinational, infoURLs: [URL(string: "http://public.ccsds.org/default.aspx")!], wikiURL: URL(string: "https://en.wikipedia.org/wiki/Consultative_Committee_for_Space_Data_Systems")))
        agencies.append(Agency(id: 75, name: "United Nations Committee on the Peaceful Uses of Outer Space", abbreviation: "UNCOPUOS", countryCode: "USA", type: .multinational, infoURLs: [URL(string: "http://www.unoosa.org/oosa/COPUOS/copuos.html")!, URL(string: "https://twitter.com/unoosa")!, URL(string: "https://www.facebook.com/UNOOSA")!, URL(string: "https://www.youtube.com/channel/UCFm-a8e8DZW97u6FL9jpCNA")!, URL(string: "https://www.flickr.com/photos/125959264@N05")!, URL(string: "https://www.instagram.com/unoosa")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/United_Nations_Committee_on_the_Peaceful_Uses_of_Outer_Space")))
        agencies.append(Agency(id: 225, name: "1worldspace", abbreviation: "1WSP", countryCode: "USA", type: .commercial, infoURLs: [], wikiURL: URL(string: "https://en.wikipedia.org/wiki/1worldspace")))
        agencies.append(Agency(id: 73, name: "United Nations Office for Outer Space Affairs", abbreviation: "UNOOSA", countryCode: "USA", type: .multinational, infoURLs: [URL(string: "http://www.unoosa.org/")!, URL(string: "https://twitter.com/unoosa")!, URL(string: "https://www.facebook.com/UNOOSA")!, URL(string: "https://www.youtube.com/channel/UCFm-a8e8DZW97u6FL9jpCNA")!, URL(string: "https://www.flickr.com/photos/125959264@N05/")!, URL(string: "https://www.instagram.com/unoosa/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/United_Nations_Office_for_Outer_Space_Affairs")))
        agencies.append(Agency(id: 82, name: "Lockheed Martin", abbreviation: "LMT", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "http://www.lockheedmartin.com/")!, URL(string: "https://twitter.com/lockheedmartin")!, URL(string: "https://www.facebook.com/lockheedmartin")!, URL(string: "https://www.youtube.com/user/LockheedMartinVideos")!, URL(string: "https://www.flickr.com/photos/lockheedmartin")!, URL(string: "https://www.instagram.com/lockheedmartin")!, URL(string: "https://www.linkedin.com/company/1319")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Lockheed_Martin")))
        agencies.append(Agency(id: 83, name: "Space Systems/Loral", abbreviation: "SSL", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "http://www.ssloral.com/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Space_Systems/Loral")))
        agencies.append(Agency(id: 141, name: "Blue Origin", abbreviation: "BO", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "http://www.blueorigin.com/")!, URL(string: "https://twitter.com/blueorigin")!, URL(string: "https://www.youtube.com/channel/UCVxTHEKKLxNjGcvVaZindlg")!, URL(string: "https://www.linkedin.com/company/40018/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Blue_Origin")))
        agencies.append(Agency(id: 139, name: "Armadillo Aerospace", abbreviation: "Armadillo", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "http://armadilloaerospace.com/n.x/Armadillo/Home")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Armadillo_Aerospace")))
        agencies.append(Agency(id: 140, name: "Bigelow Aerospace", abbreviation: "Bigelow", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "http://www.bigelowaerospace.com/")!, URL(string: "https://twitter.com/BigelowSpace")!, URL(string: "https://www.facebook.com/bigelowaerospace")!, URL(string: "https://www.instagram.com/BigelowSpace/")!, URL(string: "https://www.linkedin.com/company/bigelow-aerospace/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Bigelow_Aerospace")))
        agencies.append(Agency(id: 143, name: "PlanetSpace", abbreviation: "PlanetSpace", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "http://www.planetspace.org/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/PlanetSpace")))
        agencies.append(Agency(id: 144, name: "Scaled Composites", abbreviation: "Scaled", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "http://www.scaled.com/")!, URL(string: "https://twitter.com/ScaledC")!, URL(string: "https://www.facebook.com/ScaledComposites")!, URL(string: "https://www.instagram.com/scaledcomposites")!, URL(string: "https://www.linkedin.com/company/scaled-composites")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Scaled_Composites")))
        agencies.append(Agency(id: 145, name: "XCOR  Aerospace", abbreviation: "XCOR", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "http://www.xcor.com/")!, URL(string: "https://twitter.com/XCOR")!, URL(string: "https://www.facebook.com/xcor")!, URL(string: "https://www.instagram.com/xcor")!, URL(string: "https://www.youtube.com/user/sxcspaceline")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/XCOR_Aerospace")))
        agencies.append(Agency(id: 146, name: "Canadian Arrow", abbreviation: "Canadian Arrow", countryCode: "CAN", type: .commercial, infoURLs: [URL(string: "http://www.canadianarrow.com/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Canadian_Arrow")))
        agencies.append(Agency(id: 80, name: "Boeing", abbreviation: "BA", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "https://www.boeing.com")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Boeing")))
        agencies.append(Agency(id: 86, name: "Ball Aerospace & Technologies Corp.", abbreviation: "BLL", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "http://www.ballaerospace.com/")!, URL(string: "https://twitter.com/BallAerospace")!, URL(string: "https://www.facebook.com/ballaerospace")!, URL(string: "https://www.instagram.com/ballaerospace")!, URL(string: "https://www.linkedin.com/company/ball-aerospace")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Ball_Aerospace_%26_Technologies_Corp.")))
        agencies.append(Agency(id: 89, name: "Fairchild Space and Electronics Division", abbreviation: "FSED", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "http://www.fairchild.com/")!, URL(string: "https://twitter.com/onsemi")!, URL(string: "https://www.facebook.com/onsemiconductor")!, URL(string: "https://www.youtube.com/user/ONSemiconductor")!, URL(string: "https://www.linkedin.com/company/165308")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Fairchild_Industries")))
        agencies.append(Agency(id: 93, name: "Hughes Aircraft", abbreviation: "HAC", countryCode: "USA", type: .commercial, infoURLs: [], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Hughes_Aircraft")))
        agencies.append(Agency(id: 243, name: "Hughes", abbreviation: "HUGH", countryCode: "USA", type: .commercial, infoURLs: [], wikiURL: URL(string: "https://en.wikipedia.org/wiki/Hughes_Communications")))
        agencies.append(Agency(id: 241, name: "WildBlue", abbreviation: "WBLU", countryCode: "USA", type: .commercial, infoURLs: [], wikiURL: URL(string: "https://en.wikipedia.org/wiki/Viasat,_Inc.")))
        agencies.append(Agency(id: 161, name: "United States Air Force", abbreviation: "USAF", countryCode: "USA", type: .government, infoURLs: [URL(string: "http://www.af.mil")!, URL(string: "https://www.facebook.com/USairforce")!, URL(string: "https://twitter.com/USairforce")!, URL(string: "https://www.youtube.com/afbluetube")!, URL(string: "https://www.instagram.com/usairforce")!, URL(string: "https://www.flickr.com/photos/usairforce")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/United_States_Air_Force")))
        agencies.append(Agency(id: 256, name: "Mexican Satellite System", abbreviation: "MEXSAT", countryCode: "MEX", type: .government, infoURLs: [], wikiURL: URL(string: "https://en.wikipedia.org/wiki/Mexican_Satellite_System")))
        agencies.append(Agency(id: 257, name: "Northrop Grumman Innovation Systems", abbreviation: "NGIS", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "http://www.northropgrumman.com/AboutUs/BusinessSectors/InnovationSystems/Pages/default.aspx")!, URL(string: "https://twitter.com/northropgrumman")!, URL(string: "https://www.facebook.com/NorthropGrumman")!], wikiURL: URL(string: "https://en.wikipedia.org/wiki/Northrop_Grumman#Innovation_Systems")))

        
        return Continent(named: "North America", includeAgencies: agencies)
    }
    private class func EuropeanLocations() -> Continent {
        var agencies = [Agency]()
        
        agencies.append(Agency(id: 1, name: "Belarus Space Agency", abbreviation: "BSA", countryCode: "BLR", type: .government, infoURLs: [], wikiURL: URL(string: "https://en.wikipedia.org/wiki/Belarus_Space_Agency")))
        agencies.append(Agency(id: 8, name: "Austrian Space Agency", abbreviation: "ALR", countryCode: "AUT", type: .government, infoURLs: [URL(string: "http://www.ffg.at/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Austrian_Space_Agency")))
        agencies.append(Agency(id: 10, name: "Belgian Institute for Space Aeronomy", abbreviation: "BIRA", countryCode: "BEL", type: .government, infoURLs: [URL(string: "http://www.aeronomie.be/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Belgian_Institute_for_Space_Aeronomy")))
        agencies.append(Agency(id: 13, name: "UK Space Agency", abbreviation: "UKSA", countryCode: "GBR", type: .government, infoURLs: [URL(string: "http://www.ukspaceagency.bis.gov.uk/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/UK_Space_Agency")))
        agencies.append(Agency(id: 15, name: "Bulgarian Space Agency", abbreviation: "SRI-BAS", countryCode: "BGR", type: .government, infoURLs: [URL(string: "http://www.space.bas.bg/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Bulgarian_Space_Agency")))
        agencies.append(Agency(id: 22, name: "Committee on Space Research", abbreviation: "COSPAR", countryCode: "FRA", type: .multinational, infoURLs: [URL(string: "http://cosparhq.cnes.fr/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/COSPAR")))
        agencies.append(Agency(id: 23, name: "Croatian Space Agency", abbreviation: "HSA", countryCode: "HRV", type: .government, infoURLs: [URL(string: "http://www.csa.hr/")!], wikiURL: URL(string: "")))
        agencies.append(Agency(id: 24, name: "Ministry of Transport of the Czech Republic - Space Technologies and Satellite Systems Department", abbreviation: "CSO", countryCode: "CZE", type: .government, infoURLs: [URL(string: "http://www.czechspaceportal.cz/EN/")!], wikiURL: URL(string: "https://en.wikipedia.org/wiki/Ministry_of_Transport_(Czech_Republic)")))
        agencies.append(Agency(id: 25, name: "Danish National Space Center", abbreviation: "DRC", countryCode: "DNK", type: .government, infoURLs: [URL(string: "http://www.spacecenter.dk/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Danish_National_Space_Center")))
        agencies.append(Agency(id: 26, name: "Technical University of Denmark - National Space Institute", abbreviation: "DTU", countryCode: "DNK", type: .educational, infoURLs: [URL(string: "http://www.space.dtu.dk/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Danish_National_Space_Center")))
        agencies.append(Agency(id: 78, name: "Thales Alenia Space", abbreviation: "THALES", countryCode: "FRA", type: .commercial, infoURLs: [URL(string: "https://www.thalesgroup.com")!, URL(string: "https://twitter.com/thalesgroup")!, URL(string: "https://www.facebook.com/thalesgroup")!, URL(string: "https://www.youtube.com/user/thethalesgroup")!, URL(string: "https://www.linkedin.com/company/thales")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Thales_Alenia_Space")))
        agencies.append(Agency(id: 76, name: "Swedish National Space Board", abbreviation: "SNSB", countryCode: "SWE", type: .government, infoURLs: [URL(string: "http://www.snsb.se/en/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Swedish_National_Space_Board")))
        agencies.append(Agency(id: 63, name: "Russian Federal Space Agency (ROSCOSMOS)", abbreviation: "RFSA", countryCode: "RUS", type: .government, infoURLs: [URL(string: "http://en.roscosmos.ru/")!, URL(string: "https://www.youtube.com/channel/UCOcpUgXosMCIlOsreUfNFiA")!, URL(string: "https://twitter.com/Roscosmos")!, URL(string: "https://www.facebook.com/Roscosmos")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Russian_Federal_Space_Agency")))
        agencies.append(Agency(id: 66, name: "Soviet Space Program", abbreviation: "CCCP", countryCode: "RUS", type: .government, infoURLs: [], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Soviet_space_program")))
        agencies.append(Agency(id: 29, name: "German Aerospace Center", abbreviation: "DLR", countryCode: "DEU", type: .government, infoURLs: [URL(string: "http://www.dlr.de/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/German_Aerospace_Center")))
        agencies.append(Agency(id: 27, name: "European Space Agency", abbreviation: "ESA", countryCode: "FRA", type: .multinational, infoURLs: [URL(string: "http://www.esa.int/")!, URL(string: "https://www.facebook.com/EuropeanSpaceAgency")!, URL(string: "https://twitter.com/esa")!, URL(string: "https://www.youtube.com/channel/UCIBaDdAbGlFDeS33shmlD0A")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Danish_National_Space_Center")))
        agencies.append(Agency(id: 30, name: "Hungarian Space Office", abbreviation: "HSO", countryCode: "HUN", type: .multinational, infoURLs: [URL(string: "http://www.hso.hu/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Hungarian_Space_Office")))
        agencies.append(Agency(id: 32, name: "Institute for Space Applications and Remote Sensing", abbreviation: "ISARS", countryCode: "GRC", type: .government, infoURLs: [URL(string: "http://www.space.noa.gr/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Institute_for_Space_Applications_and_Remote_Sensing")))
        agencies.append(Agency(id: 33, name: "Instituto Nacional de Técnica Aeroespacial", abbreviation: "INTA", countryCode: "ESP", type: .government, infoURLs: [URL(string: "http://www.inta.es")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Instituto_Nacional_de_T%C3%A9cnica_Aeroespacial")))
        agencies.append(Agency(id: 60, name: "FCT Space Office", abbreviation: "FTC SO", countryCode: "PRT", type: .government, infoURLs: [URL(string: "https://www.fct.pt/apoios/cooptrans/espaco/index.phtml.en")!], wikiURL: URL(string: "")))
        agencies.append(Agency(id: 36, name: "Italian Space Agency", abbreviation: "ASI", countryCode: "ITA", type: .government, infoURLs: [URL(string: "http://www.asi.it/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Italian_Space_Agency")))
        agencies.append(Agency(id: 42, name: "Lithuanian Space Association", abbreviation: "LSA", countryCode: "LTU", type: .government, infoURLs: [URL(string: "http://www.space-lt.eu/aprasymas.htm?lid=4")!], wikiURL: URL(string: "https://en.wikipedia.org/wiki/Lithuanian_Space_Association")))
        agencies.append(Agency(id: 57, name: "Netherlands Institute for Space Research", abbreviation: "SRON", countryCode: "NLD", type: .government, infoURLs: [URL(string: "http://www.sron.nl/")!, URL(string: "https://twitter.com/SRON_Space")!, URL(string: "https://www.facebook.com/sron.nl")!, URL(string: "https://www.youtube.com/user/SRONruimteonderzoek")!, URL(string: "https://www.linkedin.com/company/sron")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Netherlands_Institute_for_Space_Research")))
        agencies.append(Agency(id: 61, name: "Romanian Space Agency", abbreviation: "ASR", countryCode: "ROU", type: .government, infoURLs: [URL(string: "http://www.rosa.ro/")!, URL(string: "https://www.facebook.com/RomanianSpaceAgency")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Romanian_Space_Agency")))
        agencies.append(Agency(id: 58, name: "Norwegian Space Centre", abbreviation: "NRS", countryCode: "NOR", type: .government, infoURLs: [URL(string: "http://www.spacecentre.no/")!, URL(string: "https://www.facebook.com/Norsk-Romsenter-65960206022/")!, URL(string: "https://twitter.com/Romsenteret")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Romanian_Space_Agency")))
        agencies.append(Agency(id: 46, name: "National Center of Space Research", abbreviation: "CNES", countryCode: "FRA", type: .government, infoURLs: [URL(string: "http://www.cnes.fr/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/CNES")))
        agencies.append(Agency(id: 54, name: "National Space Agency of Ukraine", abbreviation: "HKAY", countryCode: "UKR", type: .government, infoURLs: [URL(string: "http://www.nkau.gov.ua/")!, URL(string: "https://www.facebook.com/DKAUkraine")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/National_Space_Agency_of_Ukraine")))
        agencies.append(Agency(id: 68, name: "Space Research Centre", abbreviation: "CBK-PAN", countryCode: "POL", type: .government, infoURLs: [URL(string: "http://www.cbk.waw.pl/en/")!, URL(string: "https://www.facebook.com/CentrumBadanKosmicznychPAN/")!, URL(string: "https://www.youtube.com/user/SpaceResearchCentre")!, URL(string: "https://www.flickr.com/photos/SpaceResearchCentre")!], wikiURL: URL(string: "https://en.wikipedia.org/wiki/Space_Research_Centre_of_Polish_Academy_of_Sciences")))
        agencies.append(Agency(id: 79, name: "JSC Information Satellite Systems", abbreviation: "JSC-ISS", countryCode: "RUS", type: .commercial, infoURLs: [URL(string: "http://www.iss-reshetnev.com/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/JSC_Information_Satellite_Systems")))
        agencies.append(Agency(id: 84, name: "Amsat", abbreviation: "AMSAT", countryCode: "GBR", type: .commercial, infoURLs: [URL(string: "http://ww2.amsat.org/")!], wikiURL: URL(string: "en.wikipedia.org/wiki/Amsat")))
        agencies.append(Agency(id: 87, name: "British Aerospace", abbreviation: "BAE", countryCode: "GBR", type: .commercial, infoURLs: [], wikiURL: URL(string: "http://en.wikipedia.org/wiki/British_Aerospace")))
        agencies.append(Agency(id: 71, name: "Swiss Space Office", abbreviation: "SSO", countryCode: "CHE", type: .government, infoURLs: [URL(string: "http://www.sso.admin.ch/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Swiss_Space_Office")))
        agencies.append(Agency(id: 242, name: "Paradigm Secure Communications", abbreviation: "PSCOM", countryCode: "GBR", type: .commercial, infoURLs: [], wikiURL: URL(string: "http://www.defence-and-security.com/contractors/communications-systems-and-equipment/paradigm-secure-communications/")))
        agencies.append(Agency(id: 250, name: "HispaSat", abbreviation: "HISPA", countryCode: "ESP", type: .commercial, infoURLs: [], wikiURL: URL(string: "https://en.wikipedia.org/wiki/Hispasat")))
        agencies.append(Agency(id: 253, name: "French Armed Forces", abbreviation: "FAF", countryCode: "FRA", type: .government, infoURLs: [], wikiURL: URL(string: "https://en.wikipedia.org/wiki/French_Armed_Forces")))
        
        
        return Continent(named: "Europe", includeAgencies: agencies)
    }
    private class func AsianLocations() -> Continent {
        var agencies = [Agency]()
        
        agencies.append(Agency(id: 5, name: "Asia Pacific Multilateral Cooperation in Space Technology and Applications", abbreviation: "AP-MCSTA", countryCode: "CHN", type: .multinational, infoURLs: [URL(string: "http://www.apsco.int/AboutApscosS.asp?LinkNameW1=History_of_APSCO&LinkNameW2=Initialization_Stage_of_APSCO&LinkCodeN3=11171&LinkCodeN=17")!], wikiURL: URL(string: "")))
        agencies.append(Agency(id: 6, name: "Asia-Pacific Regional Space Agency Forum", abbreviation: "APRSA", countryCode: "CHN", type: .multinational, infoURLs: [URL(string: "http://www.aprsaf.org/")!], wikiURL: URL(string: "")))
        agencies.append(Agency(id: 7, name: "Asia-Pacific Space Cooperation Organization", abbreviation: "APSCO", countryCode: "BGD", type: .multinational, infoURLs: [URL(string: "http://www.apmcsta.org/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Asia-Pacific_Space_Cooperation_Organization")))
        agencies.append(Agency(id: 9, name: "Azerbaijan National Aerospace Agency", abbreviation: "AMAKA", countryCode: "AZE", type: .government, infoURLs: [URL(string: "http://www.science.az/en/amaka/agentlik/index.htm")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Azerbaijan_National_Aerospace_Agency")))
        agencies.append(Agency(id: 17, name: "China National Space Administration", abbreviation: "CNSA", countryCode: "CHN", type: .government, infoURLs: [URL(string: "http://www.cnsa.gov.cn/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/China_National_Space_Administration")))
        agencies.append(Agency(id: 19, name: "Centre for Remote Imaging, Sensing and Processing", abbreviation: "CRISP", countryCode: "SGP", type: .educational, infoURLs: [URL(string: "http://www.crisp.nus.edu.sg/")!], wikiURL: URL(string: "")))
        agencies.append(Agency(id: 28, name: "Geo-Informatics and Space Technology Development Agency", abbreviation: "GISTDA", countryCode: "THA", type: .government, infoURLs: [URL(string: "http://www.gistda.or.th/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Geo-Informatics_and_Space_Technology_Development_Agency")))
        agencies.append(Agency(id: 31, name: "Indian Space Research Organization", abbreviation: "ISRO", countryCode: "IND", type: .government, infoURLs: [URL(string: "https://www.isro.gov.in/")!, URL(string: "https://twitter.com/ISRO")!, URL(string: "https://www.facebook.com/ISRO")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Indian_Space_Research_Organization")))
        agencies.append(Agency(id: 34, name: "Iranian Space Agency", abbreviation: "ISA", countryCode: "IRN", type: .government, infoURLs: [URL(string: "http://www.isa.ir/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Iranian_Space_Agency")))
        agencies.append(Agency(id: 38, name: "National Space Agency (KazCosmos)", abbreviation: "NSA", countryCode: "KAZ", type: .government, infoURLs: [URL(string: "http://www.kazcosmos.kz/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/KazCosmos")))
        agencies.append(Agency(id: 39, name: "Kazakh Space Research Institute", abbreviation: "SRI", countryCode: "KAZ", type: .educational, infoURLs: [URL(string: "http://nffc.infospace.ru/inform/sri-kaz.htm")!], wikiURL: URL(string: "")))
        agencies.append(Agency(id: 37, name: "Japan Aerospace Exploration Agency", abbreviation: "JAXA", countryCode: "JPN", type: .government, infoURLs: [URL(string: "http://www.jaxa.jp/")!, URL(string: "https://www.youtube.com/channel/UCfMIdADo6FQayQCOkLYGhrQ")!, URL(string: "https://twitter.com/JAXA_en")!, URL(string: "https://www.facebook.com/jaxa.en")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Japan_Aerospace_Exploration_Agency")))
        agencies.append(Agency(id: 40, name: "Korean Committee of Space Technology", abbreviation: "KCST", countryCode: "PRK", type: .government, infoURLs: [], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Korean_Committee_of_Space_Technology")))
        agencies.append(Agency(id: 41, name: "Korea Aerospace Research Institute", abbreviation: "KARI", countryCode: "KOR", type: .government, infoURLs: [URL(string: "http://www.kari.kr/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Korea_Aerospace_Research_Institute")))
        agencies.append(Agency(id: 35, name: "Israeli Space Agency", abbreviation: "ISA", countryCode: "ISR", type: .government, infoURLs: [URL(string: "https://www.gov.il/he/Departments/ministry_of_science_and_technology")!, URL(string: "https://www.facebook.com/IsraelSpaceAgency")!, URL(string: "https://twitter.com/ILSpaceAgency")!, URL(string: "https://www.youtube.com/user/IsraelMOST")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Israeli_Space_Agency")))
        agencies.append(Agency(id: 92, name: "Hawker Siddeley Dynamics", abbreviation: "HSD", countryCode: "GBR", type: .commercial, infoURLs: [URL(string: "http://www.hssaustralia.com/about_us.htm")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Hawker_Siddeley")))
        agencies.append(Agency(id: 50, name: "National Institute of Aeronautics and Space", abbreviation: "LAPAN", countryCode: "IDN", type: .government, infoURLs: [URL(string: "http://www.lapan.go.id/")!, URL(string: "https://twitter.com/LAPAN_RI")!, URL(string: "https://www.facebook.com/LapanRI")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/National_Institute_of_Aeronautics_and_Space")))
        agencies.append(Agency(id: 51, name: "National Remote Sensing Center of Mongolia", abbreviation: "NRSC", countryCode: "MNG", type: .government, infoURLs: [], wikiURL: URL(string: "")))
        agencies.append(Agency(id: 43, name: "Malaysian National Space Agency", abbreviation: "ANGKASA", countryCode: "MYS", type: .government, infoURLs: [URL(string: "http://www.angkasa.gov.my/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Malaysian_National_Space_Agency")))
        agencies.append(Agency(id: 59, name: "Pakistan Space and Upper Atmosphere Research Commission", abbreviation: "SUPARCO", countryCode: "PAK", type: .government, infoURLs: [URL(string: "http://www.suparco.gov.pk/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Space_and_Upper_Atmosphere_Research_Commission")))
        agencies.append(Agency(id: 55, name: "National Space Organization", abbreviation: "NSPO", countryCode: "TWN", type: .government, infoURLs: [URL(string: "http://www.nspo.org.tw/")!, URL(string: "https://www.facebook.com/narlnspo")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/National_Space_Organization")))
        agencies.append(Agency(id: 64, name: "Sri Lanka Space Agency", abbreviation: "SLSA", countryCode: "LKA", type: .government, infoURLs: [], wikiURL: URL(string: "")))
        agencies.append(Agency(id: 67, name: "Space Research and Remote Sensing Organization", abbreviation: "SPARRSP", countryCode: "BGD", type: .government, infoURLs: [URL(string: "http://sparrso.gov.bd/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Space_Research_and_Remote_Sensing_Organization")))
        agencies.append(Agency(id: 70, name: "Space Research Institute of Saudi Arabia", abbreviation: "KACST-SRI", countryCode: "SAU", type: .government, infoURLs: [URL(string: "http://www.kacst.edu.sa/")!, URL(string: "https://twitter.com/KACST")!, URL(string: "https://www.facebook.com/KACST.AR")!, URL(string: "https://www.youtube.com/user/kacstchannel")!], wikiURL: URL(string: "")))
        agencies.append(Agency(id: 53, name: "Uzbek State Space Research Agency (UzbekCosmos)", abbreviation: "USSRA", countryCode: "UZB", type: .government, infoURLs: [], wikiURL: URL(string: "")))
        agencies.append(Agency(id: 65, name: "TUBITAK Space Technologies Research Institute", abbreviation: "TUBITAK UZAY", countryCode: "TUR", type: .government, infoURLs: [URL(string: "http://uzay.tubitak.gov.tr/en")!, URL(string: "https://www.facebook.com/tubitak")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/TUBITAK_Space_Technologies_Research_Institute")))
        agencies.append(Agency(id: 88, name: "China Aerospace Science and Technology Corporation", abbreviation: "CASC", countryCode: "CHN", type: .government, infoURLs: [URL(string: "http://english.spacechina.com/")!, URL(string: "http://www.cast.cn/item/list.asp?id=1561")!], wikiURL: URL(string: "https://en.wikipedia.org/wiki/China_Aerospace_Science_and_Technology_Corporation")))
        agencies.append(Agency(id: 72, name: "Turkmenistan National Space Agency", abbreviation: "TNSA", countryCode: "TKM", type: .government, infoURLs: [URL(string: "http://www.turkmencosmos.gov.tm/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Turkmenistan_National_Space_Agency")))
        agencies.append(Agency(id: 95, name: "Israel Aerospace Industries", abbreviation: "IAI", countryCode: "ISR", type: .commercial, infoURLs: [URL(string: "http://www.iai.co.il/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Israel_Aerospace_Industries")))
        agencies.append(Agency(id: 246, name: "Vietnam Posts and Telecommunications Group", abbreviation: "VNPT", countryCode: "VNM", type: .commercial, infoURLs: [], wikiURL: URL(string: "https://en.wikipedia.org/wiki/Vietnam_Posts_and_Telecommunications_Group")))
        agencies.append(Agency(id: 251, name: "AlYahSat", abbreviation: "ALYAH", countryCode: "ARE", type: .commercial, infoURLs: [URL(string: "http://www.yahsat.com/")!], wikiURL: URL(string: "https://en.wikipedia.org/wiki/Al_Yah_Satellite_Communications")))
        agencies.append(Agency(id: 247, name: "Türksat", abbreviation: "TRKST", countryCode: "TUR", type: .commercial, infoURLs: [URL(string: "https://www.turksat.com.tr/en")!], wikiURL: URL(string: "https://en.wikipedia.org/wiki/T%C3%BCrksat_(company)")))

        
        return Continent(named: "Asia", includeAgencies: agencies)
    }
    private class func SouthAmericanLocations() -> Continent {
        var agencies = [Agency]()
        
        agencies.append(Agency(id: 2, name: "Bolivarian Agency for Space Activities", abbreviation: "ABAE", countryCode: "VEN", type: .government, infoURLs: [], wikiURL: URL(string: "https://en.wikipedia.org/wiki/Centro_de_Investigaci%C3%B3n_y_Difusi%C3%B3n_Aeron%C3%A1utico-Espacial")))
        agencies.append(Agency(id: 11, name: "Aeronautics and Space Research and Diffusion Center", abbreviation: "CIDA-E", countryCode: "URY", type: .government, infoURLs: [URL(string: "http://www.abae.gob.ve/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Agencia_Bolivariana_para_Actividades_Espaciales")))
        agencies.append(Agency(id: 12, name: "Brazilian Space Agency", abbreviation: "AEB", countryCode: "BRA", type: .government, infoURLs: [URL(string: "http://www.aeb.gov.br/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Brazilian_Space_Agency")))
        agencies.append(Agency(id: 14, name: "Bolivian Space Agency", abbreviation: "ABAE", countryCode: "BOL", type: .government, infoURLs: [URL(string: "https://www.abe.bo/")!], wikiURL: URL(string: "https://es.wikipedia.org/wiki/Agencia_Boliviana_Espacial")))
        agencies.append(Agency(id: 18, name: "Colombian Space Commission", abbreviation: "CCE", countryCode: "COL", type: .government, infoURLs: [URL(string: "http://www.cce.gov.co/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Colombian_Space_Commission")))
        agencies.append(Agency(id: 49, name: "National Space Activities Commission", abbreviation: "CONAE", countryCode: "ARG", type: .government, infoURLs: [URL(string: "http://www.conae.gov.ar")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Comisi%C3%B3n_Nacional_de_Actividades_Espaciales")))
        agencies.append(Agency(id: 47, name: "National Commission for Aerospace Research and Development", abbreviation: "CONIDA", countryCode: "PER", type: .government, infoURLs: [URL(string: "http://www.conida.gob.pe/")!], wikiURL: URL(string: "")))
        agencies.append(Agency(id: 48, name: "National Commission for Space Research", abbreviation: "CNIE", countryCode: "ARG", type: .government, infoURLs: [URL(string: "http://www.conae.gov.ar/index.php/es/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Comisi%C3%B3n_Nacional_de_Investigaciones_Espaciales")))
        agencies.append(Agency(id: 244, name: "Star One", abbreviation: "STA1", countryCode: "BRA", type: .commercial, infoURLs: [], wikiURL: URL(string: "https://en.wikipedia.org/wiki/Star_One_(satellite_operator)")))
        
        
        return Continent(named: "South America", includeAgencies: agencies)
    }
    private class func AfricanLocations() -> Continent {
        var agencies = [Agency]()
        
        agencies.append(Agency(id: 45, name: "National Authority for Remote Sensing and Space Sciences", abbreviation: "NARSS", countryCode: "EGY", type: .government, infoURLs: [URL(string: "http://www.narss.sci.eg/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/National_Authority_for_Remote_Sensing_and_Space_Sciences")))
        agencies.append(Agency(id: 4, name: "Algerian Space Agency", abbreviation: "ASAL", countryCode: "DZA", type: .government, infoURLs: [URL(string: "http://www.asal.dz")!], wikiURL: URL(string: "https://en.wikipedia.org/wiki/Algerian_Space_Agency")))
        agencies.append(Agency(id: 52, name: "National Remote Sensing Center of Tunisia", abbreviation: "CNT", countryCode: "TUN", type: .government, infoURLs: [URL(string: "http://www.cnt.nat.tn/")!], wikiURL: URL(string: "")))
        agencies.append(Agency(id: 56, name: "National Space Research and Development Agency", abbreviation: "NASRDA", countryCode: "NGA", type: .government, infoURLs: [URL(string: "http://www.nasrda.org/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/National_Space_Research_and_Development_Agency")))
        agencies.append(Agency(id: 62, name: "Royal Centre for Remote Sensing", abbreviation: "CRTS", countryCode: "MAR", type: .government, infoURLs: [URL(string: "http://www.crts.gov.ma/")!], wikiURL: URL(string: "")))
        agencies.append(Agency(id: 69, name: "South African National Space Agency", abbreviation: "SANSA", countryCode: "ZAF", type: .government, infoURLs: [URL(string: "http://www.sansa.org.za/")!, URL(string: "https://twitter.com/SANSA7")!, URL(string: "https://www.facebook.com/SouthAfricanNationalSpaceAgency")!, URL(string: "https://www.youtube.com/user/SASpaceAgency")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/South_African_National_Space_Agency")))
        
        return Continent(named: "Africa", includeAgencies: agencies)
    }
    private class func OceanicLocations() -> Continent {
        var agencies = [Agency]()
        
        agencies.append(Agency(id: 20, name: "Commonwealth Scientific and Industrial Research Organisation", abbreviation: "CSIRO", countryCode: "AUS", type: .educational, infoURLs: [URL(string: "http://www.csiro.au/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Commonwealth_Scientific_and_Industrial_Research_Organisation")))
        agencies.append(Agency(id: 160, name: "Royal Australian Air Force", abbreviation: "RAAF", countryCode: "AUS", type: .government, infoURLs: [URL(string: "http://www.airforce.gov.au")!, URL(string: "https://www.facebook.com/RoyalAustralianAirForce")!, URL(string: "https://twitter.com/aus_airforce")!, URL(string: "https://www.youtube.com/user/AirForceHQ")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Royal_Australian_Air_Force")))
        
        return Continent(named: "Oceana", includeAgencies: agencies)
    }
}
