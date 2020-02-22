//
//  ClientManagerModel.swift
//  Alama360
//
//  Created by Alama360 on 28/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ClientManagerModel {
    
    var id: String = ""
    var property_id: String = ""
    var m_property_id: String = ""
    var m_form_id: String = ""
    var manager_type: String = ""
    var owner_user_id: String = ""
    var manager_user_id: String = ""
    var manager_firstname: String = ""
    var manager_lastname: String = ""
    var manager_mobile: String = ""
    var manager_sms_status: String = ""
    var created_at: String = ""
    var updated_at: String = ""
    
    init() {
        
    }
    
    init(json: JSON) {

        id = json["id"].stringValue
        property_id = json["property_id"].stringValue
        m_property_id = json["m_property_id"].stringValue
        m_form_id = json["m_form_id"].stringValue
        id = json["id"].stringValue
        manager_type = json["manager_type"].stringValue
        owner_user_id = json["owner_user_id"].stringValue
        manager_user_id = json["manager_user_id"].stringValue
        manager_firstname = json["manager_firstname"].stringValue
        manager_firstname = json["manager_firstname"].stringValue
        manager_sms_status = json["manager_sms_status"].stringValue
        created_at = json["created_at"].stringValue
        updated_at = json["updated_at"].stringValue

    }
    
}

