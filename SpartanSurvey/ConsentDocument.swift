//
//  ConsentDocument.swift
//  Camelot
//
//  Created by Guillermo Colin on 10/9/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import Foundation
import ResearchKit


public var ConsentDocument: ORKConsentDocument{

    //  Document being "ethical mandate"
    let consentDocument = ORKConsentDocument()
    consentDocument.title = "Example Consent"
    
    //  Consent types
    let consentSectionTypes: [ORKConsentSectionType] = [
        .overview,
        .dataGathering,
        .privacy,
        .dataUse,
        .timeCommitment,
        .studySurvey,
        .studyTasks,
        .withdrawing
    ]
    
    
    
    
    //  Mapped consent types
    //  Each section in the consentSectionTypes needs to have its own summary and content. Edit those down below.
    let consentSections: [ORKConsentSection] = consentSectionTypes.map { contentSectionType in
        let consentSection = ORKConsentSection(type: contentSectionType)
        
        //  Text content for for overview
        if contentSectionType == .overview {
            consentSection.summary = ""
            consentSection.content = ""
        }
        //  Text content for for dataGathering
        else if (contentSectionType == .dataGathering){
            consentSection.summary = ""
            consentSection.content = ""
        }
        //  Text content for for privacy
        else if (contentSectionType == .privacy){
            consentSection.summary = ""
            consentSection.content = ""
        }
        //  Text content for for dataUse
        else if(contentSectionType == .dataUse){
            consentSection.summary = ""
            consentSection.content = ""
        }
        //  Text content for for timeCommitment
        else if(contentSectionType == .timeCommitment){
            consentSection.summary = ""
            consentSection.content = ""
        }
        //  Text content for for studySurvey
        else if(contentSectionType == .studySurvey){
            consentSection.summary = ""
            consentSection.content = ""
        }
        //  Text content for for studyTasks
        else if(contentSectionType == .studyTasks){
            consentSection.summary = ""
            consentSection.content = ""
        }
            //  Text content for for withdrawing
        else if(contentSectionType == .withdrawing){
            consentSection.summary = ""
            consentSection.content = ""
        }
        
        return consentSection
    }
    

    
    
    
    consentDocument.sections = consentSections
    
    
    
    //  Request the user's signature
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
    
    
    return consentDocument
}


