//
//  Seeds.swift
//  CarsTests
//
//  Created by Ravi Vora on 26/8/2563 BE.
//  Copyright © 2563 Ravi Vora. All rights reserved.
//

import Foundation
@testable import Cars

struct Seeds {
    
    struct Cars {
        static let car1 = CarListModel.Response.Car(119302, "Q7 - Greatness starts, when you don't stop.", "The Audi Q7 is masculine, yet exudes lightness. Inside, it offers comfort at the highest level. With even more space for your imagination. The 3.0 TDI engine accelerates this powerhouse as a five-seater starting at an impressive 6.3 seconds from 0 to 100 kmh.", "29.11.2017 15:12", "https://www.apphusetreach.no//sites//default//files//audi_q7.jpg")
        
         static let car2 = CarListModel.Response.Car(119298, "Q2 - En route to myself", "From its sharp lights with distinctive light signature via its upstanding front end with a single wide frame and its coup 00e9-like silhouette to its sculptural rear end, the Audi A7 Sportback is an ambassador of a revolutionary language of design, carrying classic quattro genes at the same time. Proof that one can remain true to oneself through reinvention.", "29.11.2017 15:09", "https://www.apphusetreach.no//sites//default//files//audi_q2.jpg")

        static let car3 = CarListModel.Response.Car(119289, "A6 - Fascination comes through in many facets.", "From its sharp lights with distinctive light signature via its upstanding front end with a single wide frame and its coup e9-like silhouette to its sculptural rear end, the Audi A7 Sportback is an ambassador of a revolutionary language of design, carrying classic quattro genes at the same time. Proof that one can remain true to oneself through reinvention.", "29.11.2017 15:08", "https://www.apphusetreach.no//sites//default//files//audi_a7.jpg")
        
        static let car4 = CarListModel.Response.Car(119287, "A5 - Sets standards.", "Technically, the sport coupe is state of the art: In addition to the new body, the Audi A5 impresses with a completely new chassis, high-performance drive technology, innovative infotainment equipment and driver assistance systems. The Audi A5 sets standards. The formative design has been modernised and is more chiselled. The redesigned front with the optional Audi Matrix LED headlights which perform the dynamic functions. ", "08.02.2018 15:08", "https://www.apphusetreach.no//sites//default//files//audi_a6_0.jpg")

        static let car5 = CarListModel.Response.Car(119285, "A7 - Four rings. A clear line.", "And a thrilling wide range of equipment. The Audi A6 Saloon and the Audi A6 Avant combine these values within an extraordinary symbiosis of sportiness and elegance, and open a wide range of possibilities for pioneering mobility. Discover yours. Innovative technologies. Progressive design. ", "29.11.2017 15:08", "https://www.apphusetreach.no//sites//default//files//audi_a5.jpg")

        static let car6 = CarListModel.Response.Car(119282, "A4 - Feel progress.", "The Audi A4 allroad quattro 2013 expressiveness that strikes a chord. Wherever the journey takes you. Thanks to quattro all-wheel drive. Plus optional innovative infotainment and assistance systems that ensure a high level of comfort, convenience and safety. Fascinating technology. Design that sets standards. Extravagant. ", "01.01.2018 15:07", "https://www.apphusetreach.no//sites//default//files//audi_a4.jpg")

        static let car7 = CarListModel.Response.Car(119279, "A1 - A great idea. In compact form.", "Also equipped with efficient technologies and modern communication solutions. The Audi A1 and the Audi A1 Sportback 2013 two urban performers that whet your appetite. Because greatness has many facets", "29.11.2017 15:06", "https://www.apphusetreach.no//sites//default//files//audi_a1_0.jpg")
        
        static let car8 = CarListModel.Response.Car(119276, "A3 - There's only one direction. Ahead.", "An interior that impressively combines aesthetics with intuitive functionality. Our lead can be discovered in many facets. Progressive design that speaks a unique language. Innovative technologies that emphasize dynamism and efficiency.", "29.11.2017 15:05", "https://www.apphusetreach.no//sites//default//files//audi_a3.jpg")

        static let all = [car1,car2,car3,car4,car5,car6,car7,car8]
    }
}
