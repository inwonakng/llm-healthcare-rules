@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix policy: <http://example.com/policy#> .
@prefix condition: <http://example.com/condition#> .
@prefix action: <http://example.com/action#> .

policy:IVIGCoverage a policy:Policy ;
    rdfs:label "IVIG Coverage Policy" ;
    policy:hasCondition condition:PrimaryImmuneDeficiency ;
    policy:hasCondition condition:MedicallyAppropriate ;
    policy:hasAction action:CoverIVIG .

condition:PrimaryImmuneDeficiency a policy:Condition ;
    rdfs:label "Primary Immune Deficiency" ;
    policy:hasRequirement [
        rdf:type policy:Diagnosis ;
        rdfs:label "Diagnosis of Primary Immune Deficiency Disease"
    ] .

condition:MedicallyAppropriate a policy:Condition ;
    rdfs:label "Medically Appropriate" ;
    policy:hasRequirement [
        rdf:type policy:DoctorDecision ;
        rdfs:label "Doctor determines it is medically appropriate"
    ] .

action:CoverIVIG a policy:Action ;
    rdfs:label "Cover IVIG" ;
    policy:hasCoverage [
        rdf:type policy:CoverageType ;
        rdfs:label "Medicare Part B covers IVIG"
    ] .