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
    let consentSections: [ORKConsentSection] = consentSectionTypes.map { contentSectionType in
        let consentSection = ORKConsentSection(type: contentSectionType)
        consentSection.summary = "If you wish to complete this study..."
        consentSection.content = "In this study you will be asked five (wait, no, three!) questions. You will also have your voice recorded for ten seconds."
        return consentSection
    }
    
    consentDocument.sections = consentSections
    
    //  Request the user's signature
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
    
    
    return consentDocument
}


