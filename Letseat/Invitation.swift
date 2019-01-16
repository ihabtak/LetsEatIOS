//
//  Invitation.swift
//  Letseat
//
//  Created by MAC on 10/01/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

import Foundation
struct Guest{
    var guestEmail: String
    var guestName: String
}
struct Invitation {
    var invitationId: Int
    var invitationMessage: String
    var invitationCreation: Date
    var invitationRdv: Date
    var invitationRestaurantId: Int
    var invitationUserId: Int
    var guests: [Guest]
    
}
