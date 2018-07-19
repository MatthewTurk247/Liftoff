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
        agencies.append(Agency(id: 121, name: "SpaceX", abbreviation: "SpX", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "http://www.spacex.com/")!, URL(string: "https://twitter.com/SpaceX")!, URL(string: "https://www.facebook.com/SpaceX")!, URL(string: "https://www.youtube.com/channel/UCtI0Hodo5o5dUb67FeUjDeA")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/SpaceX")))
        agencies.append(Agency(id: 141, name: "Blue Origin", abbreviation: "BO", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "http://www.blueorigin.com/")!, URL(string: "https://twitter.com/blueorigin")!, URL(string: "https://www.youtube.com/channel/UCVxTHEKKLxNjGcvVaZindlg")!, URL(string: "https://www.linkedin.com/company/40018/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Blue_Origin")))
        agencies.append(Agency(id: 16, name: "Canadian Space Agency", abbreviation: "CSA", countryCode: "CAN", type: .government, infoURLs: [URL(string: "http://asc-csa.gc.ca/eng/")!, URL(string: "https://twitter.com/csa_asc")!, URL(string: "https://www.facebook.com/CanadianSpaceAgency")!, URL(string: "https://www.instagram.com/canadianspaceagency/")!, URL(string: "https://www.linkedin.com/company/9441729/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Canadian_Space_Agency")))
        agencies.append(Agency(id: 3, name: "Mexican Space Agency", abbreviation: "AEM", countryCode: "MEX", type: .government, infoURLs: [URL(string: "http://www.aem.gob.mx")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Agencia_Espacial_Mexicana")))
        agencies.append(Agency(id: 199, name: "Virgin Orbit", abbreviation: "VO", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "https://virginorbit.com/")!, URL(string: "https://twitter.com/virgin_orbit")!, URL(string: "https://www.youtube.com/channel/UCpz2PZJHMLcK7rH_1oup7Sw")!], wikiURL: URL(string: "https://en.wikipedia.org/wiki/Virgin_Orbit")))
        agencies.append(Agency(id: 82, name: "Lockheed Martin", abbreviation: "LMT", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "http://www.lockheedmartin.com/")!, URL(string: "https://twitter.com/lockheedmartin")!, URL(string: "https://www.facebook.com/lockheedmartin")!, URL(string: "https://www.youtube.com/user/LockheedMartinVideos")!, URL(string: "https://www.flickr.com/photos/lockheedmartin")!, URL(string: "https://www.instagram.com/lockheedmartin")!, URL(string: "https://www.linkedin.com/company/1319")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Lockheed_Martin")))
        agencies.append(Agency(id: 128, name: "Planetary Resources", abbreviation: "PRI", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "http://www.planetaryresources.com/")!, URL(string: "https://twitter.com/PlanetaryRsrcs")!, URL(string: "https://www.facebook.com/PlanetaryResourcesInc/")!, URL(string: "https://www.youtube.com/planetaryresources")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Planetary_Resources")))
        agencies.append(Agency(id: 140, name: "Bigelow Aerospace", abbreviation: "Bigelow", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "http://www.bigelowaerospace.com/")!, URL(string: "https://twitter.com/BigelowSpace")!, URL(string: "https://www.facebook.com/bigelowaerospace")!, URL(string: "https://www.instagram.com/BigelowSpace/")!, URL(string: "https://www.linkedin.com/company/bigelow-aerospace/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Bigelow_Aerospace")))
        agencies.append(Agency(id: 144, name: "Scaled Composites", abbreviation: "Scaled", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "http://www.scaled.com/")!, URL(string: "https://twitter.com/ScaledC")!, URL(string: "https://www.facebook.com/ScaledComposites")!, URL(string: "https://www.instagram.com/scaledcomposites")!, URL(string: "https://www.linkedin.com/company/scaled-composites")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Scaled_Composites")))
        agencies.append(Agency(id: 145, name: "XCOR  Aerospace", abbreviation: "XCOR", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "http://www.xcor.com/")!, URL(string: "https://twitter.com/XCOR")!, URL(string: "https://www.facebook.com/xcor")!, URL(string: "https://www.instagram.com/xcor")!, URL(string: "https://www.youtube.com/user/sxcspaceline")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/XCOR_Aerospace")))
        agencies.append(Agency(id: 80, name: "Boeing", abbreviation: "BA", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "https://www.boeing.com")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Boeing")))
        agencies.append(Agency(id: 73, name: "United Nations Office for Outer Space Affairs", abbreviation: "UNOOSA", countryCode: "USA", type: .multinational, infoURLs: [URL(string: "http://www.unoosa.org/")!, URL(string: "https://twitter.com/unoosa")!, URL(string: "https://www.facebook.com/UNOOSA")!, URL(string: "https://www.youtube.com/channel/UCFm-a8e8DZW97u6FL9jpCNA")!, URL(string: "https://www.flickr.com/photos/125959264@N05/")!, URL(string: "https://www.instagram.com/unoosa/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/United_Nations_Office_for_Outer_Space_Affairs")))
        agencies.append(Agency(id: 86, name: "Ball Aerospace & Technologies Corp.", abbreviation: "BLL", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "http://www.ballaerospace.com/")!, URL(string: "https://twitter.com/BallAerospace")!, URL(string: "https://www.facebook.com/ballaerospace")!, URL(string: "https://www.instagram.com/ballaerospace")!, URL(string: "https://www.linkedin.com/company/ball-aerospace")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Ball_Aerospace_%26_Technologies_Corp.")))
        agencies.append(Agency(id: 157, name: "Bristol Aerospace Company", abbreviation: "BAC", countryCode: "CAN", type: .commercial, infoURLs: [URL(string: "http://www.bristol.ca")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Bristol_Aerospace")))
        agencies.append(Agency(id: 179, name: "Orbital ATK", abbreviation: "OA", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "https://www.orbitalatk.com/")!, URL(string: "https://www.youtube.com/channel/UCLr1shBflPt0esLOrNFqAPA")!, URL(string: "https://twitter.com/OrbitalATK")!, URL(string: "https://www.facebook.com/OrbitalATK")!], wikiURL: URL(string: "https://en.wikipedia.org/wiki/Orbital_ATK")))
        agencies.append(Agency(id: 195, name: "Sandia National Laboratories", abbreviation: "SNL", countryCode: "USA", type: .government, infoURLs: [URL(string: "http://www.sandia.gov/")!, URL(string: "https://www.facebook.com/SandiaLabs")!, URL(string: "https://twitter.com/SandiaLabs")!, URL(string: "https://www.youtube.com/user/SandiaLabs")!, URL(string: "https://www.flickr.com/photos/sandialabs")!], wikiURL: URL(string: "https://en.wikipedia.org/wiki/Sandia_National_Laboratories")))
        agencies.append(Agency(id: 167, name: "Space Florida", abbreviation: "SF", countryCode: "USA", type: .government, infoURLs: [URL(string: "http://www.spaceflorida.gov/")!, URL(string: "https://twitter.com/SpaceFlorida")!, URL(string: "https://www.facebook.com/SpaceFlorida")!, URL(string: "https://www.linkedin.com/company/space-florida")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Space_Florida")))
        agencies.append(Agency(id: 118, name: "International Launch Services", abbreviation: "ILS", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "http://www.ilslaunch.com/")!, URL(string: "https://www.facebook.com/ILSLaunch/")!, URL(string: "https://www.youtube.com/user/ilslaunchservices")!, URL(string: "https://twitter.com/ILSLaunch")!, URL(string: "https://www.linkedin.com/company/international-launch-services/")!, URL(string: "https://www.instagram.com/ilslaunch/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/International_Launch_Services")))
        agencies.append(Agency(id: 126, name: "Deep Space Industries", abbreviation: "DSI", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "http://www.deepspaceindustries.com/")!, URL(string: "https://twitter.com/GoDeepSpace")!, URL(string: "https://www.facebook.com/DeepSpaceIndustries")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Deep_Space_Industries")))
        agencies.append(Agency(id: 105, name: "SpaceDev", abbreviation: "SPDV", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "http://www.spacedev.com/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/SpaceDev")))
        agencies.append(Agency(id: 136, name: "Ad Astra Rocket Company", abbreviation: "AARC", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "http://www.adastrarocket.com/")!, URL(string: "https://twitter.com/AdAstraRocket")!, URL(string: "https://www.facebook.com/AdAstraRocketCompany")!, URL(string: "https://www.youtube.com/user/adastrarocket")!, URL(string: "https://www.linkedin.com/company/ad-astra-rocket-company/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Ad_Astra_Rocket_Company")))
        agencies.append(Agency(id: 148, name: "Scorpius Space Launch Company", abbreviation: "SSLC", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "http://www.scorpius.com/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Scorpius_Space_Launch_Company")))
        agencies.append(Agency(id: 150, name: "Masten Space Systems", abbreviation: "Masten", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "http://masten.aero/")!, URL(string: "https://twitter.com/mastenspace")!, URL(string: "https://www.facebook.com/Masten-Space-Systems-Inc-63375477753")!, URL(string: "https://www.youtube.com/user/mastenspace")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Masten_Space_Systems")))
        agencies.append(Agency(id: 201, name: "Vector", abbreviation: "VEC", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "https://vector-launch.com/")!, URL(string: "https://twitter.com/vectorspacesys")!], wikiURL: URL(string: "https://en.wikipedia.org/wiki/Vector_Space_Systems")))
        agencies.append(Agency(id: 152, name: "UP Aerospace", abbreviation: "UPA", countryCode: "USA", type: .commercial, infoURLs: [URL(string: "http://www.upaerospace.com/")!, URL(string: "https://twitter.com/upaerospace")!, URL(string: "https://www.youtube.com/user/upaerospace")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/UP_Aerospace")))

        
        return Continent(named: "North America", includeAgencies: agencies)
    }
    private class func EuropeanLocations() -> Continent {
        var agencies = [Agency]()
        
        agencies.append(Agency(id: 1, name: "Belarus Space Agency", abbreviation: "BSA", countryCode: "BLR", type: .government, infoURLs: [], wikiURL: URL(string: "https://en.wikipedia.org/wiki/Belarus_Space_Agency")))
        agencies.append(Agency(id: 115, name: "Arianespace", abbreviation: "ASA", countryCode: "FRA", type: .commercial, infoURLs: [URL(string: "http://www.arianespace.com")!, URL(string: "https://www.youtube.com/channel/UCRn9F2D9j-t4A-HgudM7aLQ")!, URL(string: "https://www.facebook.com/ArianeGroup")!, URL(string: "https://twitter.com/arianespace")!, URL(string: "https://www.instagram.com/arianespace")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Arianespace")))
        agencies.append(Agency(id: 8, name: "Austrian Space Agency", abbreviation: "ALR", countryCode: "AUT", type: .government, infoURLs: [URL(string: "http://www.ffg.at/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Austrian_Space_Agency")))
        agencies.append(Agency(id: 10, name: "Belgian Institute for Space Aeronomy", abbreviation: "BIRA", countryCode: "BEL", type: .government, infoURLs: [URL(string: "http://www.aeronomie.be/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Belgian_Institute_for_Space_Aeronomy")))
        agencies.append(Agency(id: 13, name: "UK Space Agency", abbreviation: "UKSA", countryCode: "GBR", type: .government, infoURLs: [URL(string: "http://www.ukspaceagency.bis.gov.uk/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/UK_Space_Agency")))
        agencies.append(Agency(id: 15, name: "Bulgarian Space Agency", abbreviation: "SRI-BAS", countryCode: "BGR", type: .government, infoURLs: [URL(string: "http://www.space.bas.bg/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Bulgarian_Space_Agency")))
        agencies.append(Agency(id: 23, name: "Croatian Space Agency", abbreviation: "HSA", countryCode: "HRV", type: .government, infoURLs: [URL(string: "http://www.csa.hr/")!], wikiURL: URL(string: "")))
        agencies.append(Agency(id: 25, name: "Danish National Space Center", abbreviation: "DRC", countryCode: "DNK", type: .government, infoURLs: [URL(string: "http://www.spacecenter.dk/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Danish_National_Space_Center")))
        agencies.append(Agency(id: 26, name: "Technical University of Denmark - National Space Institute", abbreviation: "DTU", countryCode: "DNK", type: .educational, infoURLs: [URL(string: "http://www.space.dtu.dk/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Danish_National_Space_Center")))
        agencies.append(Agency(id: 78, name: "Thales Alenia Space", abbreviation: "THALES", countryCode: "FRA", type: .commercial, infoURLs: [URL(string: "https://www.thalesgroup.com")!, URL(string: "https://twitter.com/thalesgroup")!, URL(string: "https://www.facebook.com/thalesgroup")!, URL(string: "https://www.youtube.com/user/thethalesgroup")!, URL(string: "https://www.linkedin.com/company/thales")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Thales_Alenia_Space")))
        agencies.append(Agency(id: 76, name: "Swedish National Space Board", abbreviation: "SNSB", countryCode: "SWE", type: .government, infoURLs: [URL(string: "http://www.snsb.se/en/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Swedish_National_Space_Board")))
        agencies.append(Agency(id: 63, name: "Russian Federal Space Agency (ROSCOSMOS)", abbreviation: "RFSA", countryCode: "RUS", type: .government, infoURLs: [URL(string: "http://en.roscosmos.ru/")!, URL(string: "https://www.youtube.com/channel/UCOcpUgXosMCIlOsreUfNFiA")!, URL(string: "https://twitter.com/Roscosmos")!, URL(string: "https://www.facebook.com/Roscosmos")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Russian_Federal_Space_Agency")))
        agencies.append(Agency(id: 66, name: "Soviet Space Program", abbreviation: "CCCP", countryCode: "RUS", type: .government, infoURLs: [], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Soviet_space_program")))
        agencies.append(Agency(id: 29, name: "German Aerospace Center", abbreviation: "DLR", countryCode: "DEU", type: .government, infoURLs: [URL(string: "http://www.dlr.de/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/German_Aerospace_Center")))
        agencies.append(Agency(id: 27, name: "European Space Agency", abbreviation: "ESA", countryCode: "FRA", type: .multinational, infoURLs: [URL(string: "http://www.esa.int/")!, URL(string: "https://www.facebook.com/EuropeanSpaceAgency")!, URL(string: "https://twitter.com/esa")!, URL(string: "https://www.youtube.com/channel/UCIBaDdAbGlFDeS33shmlD0A")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Danish_National_Space_Center")))
        agencies.append(Agency(id: 30, name: "Hungarian Space Office", abbreviation: "HSO", countryCode: "HUN", type: .multinational, infoURLs: [URL(string: "http://www.hso.hu/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Hungarian_Space_Office")))
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
        agencies.append(Agency(id: 71, name: "Swiss Space Office", abbreviation: "SSO", countryCode: "CHE", type: .government, infoURLs: [URL(string: "http://www.sso.admin.ch/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Swiss_Space_Office")))
        agencies.append(Agency(id: 186, name: "Polish Space Agency", abbreviation: "POLSA", countryCode: "POL", type: .government, infoURLs: [URL(string: "https://polsa.gov.pl/")!, URL(string: "https://www.facebook.com/PolskaAgencjaKosmicznaPOLSA")!], wikiURL: URL(string: "https://pl.wikipedia.org/wiki/Polska_Agencja_Kosmiczna")))
        agencies.append(Agency(id: 151, name: "Swedish Space Corp", abbreviation: "SSC", countryCode: "SWE", type: .commercial, infoURLs: [URL(string: "http://www.sscspace.com/")!, URL(string: "https://twitter.com/Sscspace")!, URL(string: "https://www.facebook.com/SSC.SwedishSpaceCorporation")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Swedish_Space_Corporation")))
        agencies.append(Agency(id: 142, name: "Copenhagen Suborbitals", abbreviation: "CSU", countryCode: "DNK", type: .commercial, infoURLs: [URL(string: "https://twitter.com/CopSub")!, URL(string: "https://www.facebook.com/CopenhagenSuborbitals")!, URL(string: "https://www.youtube.com/user/CphSuborbitals")!, URL(string: "https://www.instagram.com/copsub")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Copenhagen_Suborbitals")))
        agencies.append(Agency(id: 130, name: "RUAG Space", abbreviation: "RUAG", countryCode: "CHE", type: .commercial, infoURLs: [URL(string: "http://www.ruag.com/space")!, URL(string: "https://twitter.com/RUAG_Group")!, URL(string: "https://www.youtube.com/channel/UCq8RXCCpamie8w0Zss7BzWQ")!, URL(string: "https://www.linkedin.com/company/3494287")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/RUAG_Space")))
        agencies.append(Agency(id: 137, name: "Reaction Engines Ltd.", abbreviation: "REL", countryCode: "GBR", type: .commercial, infoURLs: [URL(string: "http://www.reactionengines.co.uk/")!, URL(string: "https://twitter.com/reactionengines")!, URL(string: "https://www.facebook.com/ReactionEnginesLtd")!, URL(string: "https://www.linkedin.com/company/reaction-engines-limited")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Reaction_Engines_Limited")))
        agencies.append(Agency(id: 123, name: "Starsem SA", abbreviation: "SSA", countryCode: "FRA, RUS", type: .commercial, infoURLs: [URL(string: "http://www.starsem.com/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Starsem")))
        agencies.append(Agency(id: 159, name: "Avio S.p.A", abbreviation: "Avio", countryCode: "ITA", type: .commercial, infoURLs: [URL(string: "http://www.aviogroup.com/")!, URL(string: "https://www.facebook.com/AvioAero")!, URL(string: "https://twitter.com/AvioAero")!, URL(string: "https://www.instagram.com/avio_aero")!, URL(string: "https://www.youtube.com/user/AvioAero")!, URL(string: "https://www.linkedin.com/company/avio/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Avio")))
        agencies.append(Agency(id: 122, name: "Sea Launch", abbreviation: "SL", countryCode: "RUS", type: .commercial, infoURLs: [URL(string: "http://www.sea-launch.com/")!, URL(string: "https://www.facebook.com/sealaunch")!, URL(string: "https://www.instagram.com/sea_launch")!, URL(string: "https://www.linkedin.com/company/sea-launch")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Sea_Launch")))
        agencies.append(Agency(id: 116, name: "EADS Astrium Space Transportation", abbreviation: "EADS", countryCode: "FRA", type: .commercial, infoURLs: [], wikiURL: URL(string: "http://en.wikipedia.org/wiki/EADS_Astrium_Space_Transportation")))
        agencies.append(Agency(id: 119, name: "ISC Kosmotras", abbreviation: "ISCK", countryCode: "RUS", type: .commercial, infoURLs: [URL(string: "http://www.kosmotras.ru/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/ISC_Kosmotras")))
        agencies.append(Agency(id: 117, name: "Eurockot Launch Services", abbreviation: "ELS", countryCode: "FRA", type: .commercial, infoURLs: [URL(string: "http://www.eurockot.com/")!, URL(string: "http://www.youtube.com/user/Eurockot")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Eurockot_Launch_Services")))
        
        return Continent(named: "Europe", includeAgencies: agencies)
    }
    private class func AsianLocations() -> Continent {
        var agencies = [Agency]()
        
        agencies.append(Agency(id: 5, name: "Asia Pacific Multilateral Cooperation in Space Technology and Applications", abbreviation: "AP-MCSTA", countryCode: "CHN", type: .multinational, infoURLs: [URL(string: "http://www.apsco.int/AboutApscosS.asp?LinkNameW1=History_of_APSCO&LinkNameW2=Initialization_Stage_of_APSCO&LinkCodeN3=11171&LinkCodeN=17")!], wikiURL: URL(string: "")))
        agencies.append(Agency(id: 7, name: "Asia-Pacific Space Cooperation Organization", abbreviation: "APSCO", countryCode: "BGD", type: .multinational, infoURLs: [URL(string: "http://www.apmcsta.org/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Asia-Pacific_Space_Cooperation_Organization")))
        agencies.append(Agency(id: 9, name: "Azerbaijan National Aerospace Agency", abbreviation: "AMAKA", countryCode: "AZE", type: .government, infoURLs: [URL(string: "http://www.science.az/en/amaka/agentlik/index.htm")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Azerbaijan_National_Aerospace_Agency")))
        agencies.append(Agency(id: 17, name: "China National Space Administration", abbreviation: "CNSA", countryCode: "CHN", type: .government, infoURLs: [URL(string: "http://www.cnsa.gov.cn/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/China_National_Space_Administration")))
        agencies.append(Agency(id: 19, name: "Centre for Remote Imaging, Sensing and Processing", abbreviation: "CRISP", countryCode: "SGP", type: .educational, infoURLs: [URL(string: "http://www.crisp.nus.edu.sg/")!], wikiURL: URL(string: "")))
        agencies.append(Agency(id: 28, name: "Geo-Informatics and Space Technology Development Agency", abbreviation: "GISTDA", countryCode: "THA", type: .government, infoURLs: [URL(string: "http://www.gistda.or.th/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Geo-Informatics_and_Space_Technology_Development_Agency")))
        agencies.append(Agency(id: 31, name: "Indian Space Research Organization", abbreviation: "ISRO", countryCode: "IND", type: .government, infoURLs: [URL(string: "https://www.isro.gov.in/")!, URL(string: "https://twitter.com/ISRO")!, URL(string: "https://www.facebook.com/ISRO")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Indian_Space_Research_Organization")))
        agencies.append(Agency(id: 34, name: "Iranian Space Agency", abbreviation: "IRSA", countryCode: "IRN", type: .government, infoURLs: [URL(string: "http://www.isa.ir/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Iranian_Space_Agency")))
        agencies.append(Agency(id: 38, name: "National Space Agency (KazCosmos)", abbreviation: "NSA", countryCode: "KAZ", type: .government, infoURLs: [URL(string: "http://www.kazcosmos.kz/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/KazCosmos")))
        agencies.append(Agency(id: 39, name: "Kazakh Space Research Institute", abbreviation: "SRI", countryCode: "KAZ", type: .educational, infoURLs: [URL(string: "http://nffc.infospace.ru/inform/sri-kaz.htm")!], wikiURL: URL(string: "")))
        agencies.append(Agency(id: 37, name: "Japan Aerospace Exploration Agency", abbreviation: "JAXA", countryCode: "JPN", type: .government, infoURLs: [URL(string: "http://www.jaxa.jp/")!, URL(string: "https://www.youtube.com/channel/UCfMIdADo6FQayQCOkLYGhrQ")!, URL(string: "https://twitter.com/JAXA_en")!, URL(string: "https://www.facebook.com/jaxa.en")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Japan_Aerospace_Exploration_Agency")))
        agencies.append(Agency(id: 40, name: "Korean Committee of Space Technology", abbreviation: "KCST", countryCode: "PRK", type: .government, infoURLs: [], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Korean_Committee_of_Space_Technology")))
        agencies.append(Agency(id: 41, name: "Korea Aerospace Research Institute", abbreviation: "KARI", countryCode: "KOR", type: .government, infoURLs: [URL(string: "http://www.kari.kr/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Korea_Aerospace_Research_Institute")))
        agencies.append(Agency(id: 35, name: "Israeli Space Agency", abbreviation: "ISSA", countryCode: "ISR", type: .government, infoURLs: [URL(string: "https://www.gov.il/he/Departments/ministry_of_science_and_technology")!, URL(string: "https://www.facebook.com/IsraelSpaceAgency")!, URL(string: "https://twitter.com/ILSpaceAgency")!, URL(string: "https://www.youtube.com/user/IsraelMOST")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Israeli_Space_Agency")))
        agencies.append(Agency(id: 50, name: "National Institute of Aeronautics and Space", abbreviation: "LAPAN", countryCode: "IDN", type: .government, infoURLs: [URL(string: "http://www.lapan.go.id/")!, URL(string: "https://twitter.com/LAPAN_RI")!, URL(string: "https://www.facebook.com/LapanRI")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/National_Institute_of_Aeronautics_and_Space")))
        agencies.append(Agency(id: 43, name: "Malaysian National Space Agency", abbreviation: "ANGKASA", countryCode: "MYS", type: .government, infoURLs: [URL(string: "http://www.angkasa.gov.my/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Malaysian_National_Space_Agency")))
        agencies.append(Agency(id: 59, name: "Pakistan Space and Upper Atmosphere Research Commission", abbreviation: "SUPARCO", countryCode: "PAK", type: .government, infoURLs: [URL(string: "http://www.suparco.gov.pk/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Space_and_Upper_Atmosphere_Research_Commission")))
        agencies.append(Agency(id: 55, name: "National Space Organization", abbreviation: "NSPO", countryCode: "TWN", type: .government, infoURLs: [URL(string: "http://www.nspo.org.tw/")!, URL(string: "https://www.facebook.com/narlnspo")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/National_Space_Organization")))
        agencies.append(Agency(id: 64, name: "Sri Lanka Space Agency", abbreviation: "SLSA", countryCode: "LKA", type: .government, infoURLs: [], wikiURL: URL(string: "")))
        agencies.append(Agency(id: 70, name: "Space Research Institute of Saudi Arabia", abbreviation: "KACST-SRI", countryCode: "SAU", type: .government, infoURLs: [URL(string: "http://www.kacst.edu.sa/")!, URL(string: "https://twitter.com/KACST")!, URL(string: "https://www.facebook.com/KACST.AR")!, URL(string: "https://www.youtube.com/user/kacstchannel")!], wikiURL: URL(string: "")))
        agencies.append(Agency(id: 53, name: "Uzbek State Space Research Agency (UzbekCosmos)", abbreviation: "USSRA", countryCode: "UZB", type: .government, infoURLs: [], wikiURL: URL(string: "")))
        agencies.append(Agency(id: 88, name: "China Aerospace Science and Technology Corporation", abbreviation: "CASC", countryCode: "CHN", type: .government, infoURLs: [URL(string: "http://english.spacechina.com/")!, URL(string: "http://www.cast.cn/item/list.asp?id=1561")!], wikiURL: URL(string: "https://en.wikipedia.org/wiki/China_Aerospace_Science_and_Technology_Corporation")))
        agencies.append(Agency(id: 72, name: "Turkmenistan National Space Agency", abbreviation: "TNSA", countryCode: "TKM", type: .government, infoURLs: [URL(string: "http://www.turkmencosmos.gov.tm/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Turkmenistan_National_Space_Agency")))
        agencies.append(Agency(id: 95, name: "Israel Aerospace Industries", abbreviation: "IAI", countryCode: "ISR", type: .commercial, infoURLs: [URL(string: "http://www.iai.co.il/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Israel_Aerospace_Industries")))
        agencies.append(Agency(id: 247, name: "Türksat", abbreviation: "TRKST", countryCode: "TUR", type: .commercial, infoURLs: [URL(string: "https://www.turksat.com.tr/en")!], wikiURL: URL(string: "https://en.wikipedia.org/wiki/T%C3%BCrksat_(company)")))
        agencies.append(Agency(id: 182, name: "National Space Agency of the Republic of Kazakhstan", abbreviation: "KazCosmos", countryCode: "KAZ", type: .government, infoURLs: [URL(string: "http://kazcosmos.gov.kz/en")!], wikiURL: URL(string: "https://en.wikipedia.org/wiki/KazCosmos")))
        agencies.append(Agency(id: 189, name: "China Aerospace Corporation", abbreviation: "CASC", countryCode: "CHN", type: .government, infoURLs: [URL(string: "http://www.spacechina.com/")!], wikiURL: URL(string: "https://en.wikipedia.org/wiki/China_Aerospace_Science_and_Technology_Corporation")))
        agencies.append(Agency(id: 198, name: "Mohammed bin Rashid Space Centre", abbreviation: "MBRSC", countryCode: "UAE", type: .government, infoURLs: [URL(string: "https://mbrsc.ae/en")!, URL(string: "https://www.facebook.com/MBRSpaceCentre")!, URL(string: "https://twitter.com/MBRSpaceCentre")!, URL(string: "https://www.youtube.com/channel/UCPZSaUvWOLjrvwHmtrZyvgQ")!, URL(string: "https://www.instagram.com/MBRSpaceCentre")!], wikiURL: URL(string: "https://en.wikipedia.org/wiki/Mohammed_bin_Rashid_Space_Centre")))
        agencies.append(Agency(id: 109, name: "Turkish Aerospace Industries", abbreviation: "TAI", countryCode: "TUR", type: .commercial, infoURLs: [URL(string: "http://www.tai.com.tr/en/")!, URL(string: "https://twitter.com/TUSASTAI")!, URL(string: "https://www.facebook.com/turkishaerospace/")!, URL(string: "https://www.youtube.com/channel/UC4A34yFloIv5dFUC3ogXHgQ")!, URL(string: "https://www.linkedin.com/company/tai/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Turkish_Aerospace_Industries")))
        agencies.append(Agency(id: 184, name: "China Aerospace Science and Industry Corporation", abbreviation: "CASIC", countryCode: "CHN", type: .government, infoURLs: [URL(string: "http://english.casic.cn/")!, URL(string: "http://weibo.com/CASIC")!], wikiURL: URL(string: "https://en.wikipedia.org/wiki/China_Aerospace_Science_and_Industry_Corporation")))
        agencies.append(Agency(id: 194, name: "ExPace", abbreviation: "EP", countryCode: "CHN", type: .commercial, infoURLs: [], wikiURL: URL(string: "https://en.wikipedia.org/wiki/ExPace")))

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
        
        
        return Continent(named: "South America", includeAgencies: agencies)
    }
    private class func AfricanLocations() -> Continent {
        var agencies = [Agency]()
        
        agencies.append(Agency(id: 4, name: "Algerian Space Agency", abbreviation: "ASAL", countryCode: "DZA", type: .government, infoURLs: [URL(string: "http://www.asal.dz")!], wikiURL: URL(string: "https://en.wikipedia.org/wiki/Algerian_Space_Agency")))
        agencies.append(Agency(id: 69, name: "South African National Space Agency", abbreviation: "SANSA", countryCode: "ZAF", type: .government, infoURLs: [URL(string: "http://www.sansa.org.za/")!, URL(string: "https://twitter.com/SANSA7")!, URL(string: "https://www.facebook.com/SouthAfricanNationalSpaceAgency")!, URL(string: "https://www.youtube.com/user/SASpaceAgency")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/South_African_National_Space_Agency")))
        agencies.append(Agency(id: 56, name: "National Space Research and Development Agency", abbreviation: "NASRDA", countryCode: "NGA", type: .government, infoURLs: [URL(string: "http://www.nasrda.org/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/National_Space_Research_and_Development_Agency")))
        agencies.append(Agency(id: 62, name: "Royal Centre for Remote Sensing", abbreviation: "CRTS", countryCode: "MAR", type: .government, infoURLs: [URL(string: "http://www.crts.gov.ma/")!], wikiURL: URL(string: "")))
        agencies.append(Agency(id: 45, name: "National Authority for Remote Sensing and Space Sciences", abbreviation: "NARSS", countryCode: "EGY", type: .government, infoURLs: [URL(string: "http://www.narss.sci.eg/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/National_Authority_for_Remote_Sensing_and_Space_Sciences")))
        
        return Continent(named: "Africa", includeAgencies: agencies)
    }
    private class func OceanicLocations() -> Continent {
        var agencies = [Agency]()
        
        agencies.append(Agency(id: 20, name: "Commonwealth Scientific and Industrial Research Organisation", abbreviation: "CSIRO", countryCode: "AUS", type: .educational, infoURLs: [URL(string: "http://www.csiro.au/")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Commonwealth_Scientific_and_Industrial_Research_Organisation")))
        agencies.append(Agency(id: 160, name: "Royal Australian Air Force", abbreviation: "RAAF", countryCode: "AUS", type: .government, infoURLs: [URL(string: "http://www.airforce.gov.au")!, URL(string: "https://www.facebook.com/RoyalAustralianAirForce")!, URL(string: "https://twitter.com/aus_airforce")!, URL(string: "https://www.youtube.com/user/AirForceHQ")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Royal_Australian_Air_Force")))
        agencies.append(Agency(id: 147, name: "Rocket Lab Ltd", abbreviation: "RL", countryCode: "NZL", type: .commercial, infoURLs: [URL(string: "http://www.rocketlabusa.com/")!, URL(string: "https://twitter.com/rocketlab")!, URL(string: "https://www.youtube.com/user/RocketLabNZ")!, URL(string: "https://www.facebook.com/RocketLabUSA")!, URL(string: "https://www.linkedin.com/company/rocket-lab-limited")!], wikiURL: URL(string: "http://en.wikipedia.org/wiki/Rocket_Lab")))
        agencies.append(Agency(id: 188, name: "Gilmour Space Technologies", abbreviation: "GST", countryCode: "AUS", type: .`private`, infoURLs: [URL(string: "https://www.gspacetech.com/")!, URL(string: "https://www.facebook.com/gilmourspacetech")!, URL(string: "https://twitter.com/GilmourSpace")!, URL(string: "https://www.youtube.com/channel/UC0nAKlqBo0aW01UZez2LaIg")!, URL(string: "https://www.linkedin.com/company/6583851/")!], wikiURL: URL(string: "https://en.wikipedia.org/wiki/Gilmour_Space_Technologies")))
        
        return Continent(named: "Oceana", includeAgencies: agencies)
    }
}
