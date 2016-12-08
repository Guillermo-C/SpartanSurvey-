//
//  ConsentDocument.swift
//  Camelot
//
//  Created by Guillermo Colin on 10/9/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import Foundation
import ResearchKit

//  This var holds all the elements (i.e. overview, dataGathering, privacy, etc.) in the consent.
public var ConsentDocument: ORKConsentDocument{

    //  Document being "ethical mandate"
    let consentDocument = ORKConsentDocument()
    consentDocument.title = "SpartanSurvey"
    
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
            consentSection.summary = "Please review the following sections carefully"
            consentSection.content = "Thank you for choosing the simplest line of communication between you and your favorite places to shop, eat, and relax."
        }
        //  Text content for for dataGathering
        else if (contentSectionType == .dataGathering){
            consentSection.summary = "Your valuable opinion means a lot to businesses, this app will simplify the communication line between you and your favorite places to shop, eat, and relax."
            consentSection.content = "Your opinon will be recorded through a series of questions that business will create."
        }
        //  Text content for for privacy
        else if (contentSectionType == .privacy){
            consentSection.summary = "All personally identifying information you provide will be kept confidential unless otherwise listed. Survey creators will be able to see graphs of their demographics, but will not be able to see your personal answers."
            consentSection.content = "Any personally identifying information you provide when you make a SpartanSurvey account profile is kept secret from the survey creator. We only collect this information to minimize surveys from being tampered."
        }
        //  Text content for for dataUse
        else if(contentSectionType == .dataUse){
            consentSection.summary = "Businesses will use this information to improve products, environments, and selection. Nobody will be able to purchase your information or your opinion."
            consentSection.content = "Your opinion will be used to make products, shops, locations, food, and entertainment more enjoyable for you."
        }
        //  Text content for for timeCommitment
        else if(contentSectionType == .timeCommitment){
            consentSection.summary = "Most surveys should not take more than a few minutes of your time, unless otherwise listed."
            consentSection.content = "Most surveys will take fewer than 20 minutes, unless otherwise stated. Surveys which are expected to take longer will be clearly identified."
        }
        //  Text content for for studySurvey
        else if(contentSectionType == .studySurvey){
            consentSection.summary = "General questions will be asked, with responses listed in a picker. Survey creators can also choose to allow a more personal opinion using textboxes. "
            consentSection.content = "Possible answers will be listed in a picker. Select the one which corresponds most closely to your opinion."
        }
        //  Text content for for studyTasks
        else if(contentSectionType == .studyTasks){
            consentSection.summary = "All we ask is for an honest opinion, so that these businesses can make you experiences more enjoyable."
            consentSection.content = "Please provide us with your honest opinion."
        }
            //  Text content for for withdrawing
        else if(contentSectionType == .withdrawing){
            consentSection.summary = "You can withdraw your survey response at any time."
            consentSection.content = "You can withdraw your survey response at any time. Keep in mind though, that ones a survey creator chooses to publish their survey results, your opinion at the time of the survey is kept permanent."
        }
        
        return consentSection
    }

    //  Add all the edited consent sections to the consentDocument. 
    consentDocument.sections = consentSections
    
    
    
    //  Request the user's signature
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
    
    
    return consentDocument
}


