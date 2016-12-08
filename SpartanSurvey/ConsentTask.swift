//
//  ConsentTask.swift
//  Camelot
//
//  Created by Guillermo Colin on 10/9/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import Foundation
import ResearchKit

//  Consent document to be added to a task.
public var ConsentTask: ORKOrderedTask {
    
    //  Array of steps
    var steps = [ORKStep]()
    
    //  This is Visual Content step.
    let consentDocument = ConsentDocument
    let visualConsentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consentDocument)
    steps += [visualConsentStep]
    
    //  Consent Review step.
    let signature = consentDocument.signatures!.first! 
    
    let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, in: consentDocument)
    
    reviewConsentStep.text = "Review Consent!"
    reviewConsentStep.reasonForConsent = "Consent to join study"
    
    //  Update (go to next) step.
    steps += [reviewConsentStep]

    
    return ORKOrderedTask(identifier: "ConsentTask", steps: steps)
}
