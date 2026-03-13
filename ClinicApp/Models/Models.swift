//
//  Models.swift
//  ClinicApp
//
//  Created by BSCComp-046 on 2026-03-13.
//

//
//  Models.swift
//  ClinicApp
//
//  Created by YourName on 2026-03-13.
//

import SwiftUI

// MARK: - Visit Record Model
struct VisitRecord: Identifiable {
    let id = UUID()
    let day: String
    let month: String
    let doctorName: String
    let department: String
    let diagnosis: String
    let vitals: Vitals?
    let prescriptions: [String]
    let labInvestigations: [String]
    var isExpanded: Bool = false
}

struct Vitals {
    let bp: String
    let hr: String
    let temp: String
    let spo2: String
}

// MARK: - Navigation Models
struct NavigationStep: Identifiable {
    let id = UUID()
    let systemIcon: String
    let isDestination: Bool
    let description: String
}

struct HospitalDestination: Identifiable {
    let id: Int
    let name: String
    let sub: String
    let icon: String
}

// MARK: - Sample Data
let sampleVisitRecords: [VisitRecord] = [
    VisitRecord(
        day: "14",
        month: "OCT",
        doctorName: "Dr. Sarah Jenkins",
        department: "General Medicine",
        diagnosis: "Acute Bronchitis",
        vitals: Vitals(bp: "120/80", hr: "78", temp: "99.1", spo2: "98"),
        prescriptions: ["Amoxicillin 500mg", "Cough Syrup"],
        labInvestigations: ["Chest X-Ray", "CBC Panel"],
        isExpanded: true
    ),
    VisitRecord(
        day: "02",
        month: "SEP",
        doctorName: "Dr. Michael Chen",
        department: "Cardiology",
        diagnosis: "Routine Follow-up",
        vitals: Vitals(bp: "118/76", hr: "72", temp: "98.6", spo2: "99"),
        prescriptions: ["Aspirin 75mg"],
        labInvestigations: ["ECG", "Lipid Panel"],
        isExpanded: false
    ),
    VisitRecord(
        day: "15",
        month: "JUN",
        doctorName: "Dr. Sarah Jenkins",
        department: "General Medicine",
        diagnosis: "Annual Wellness Check",
        vitals: Vitals(bp: "116/74", hr: "70", temp: "98.4", spo2: "99"),
        prescriptions: [],
        labInvestigations: ["Blood Work", "Urinalysis"],
        isExpanded: false
    )
]

let allDestinations: [HospitalDestination] = [
    HospitalDestination(id: 0, name: "Cardiology Clinic (OPD)", sub: "3rd Floor, Wing B", icon: "heart.circle.fill"),
    HospitalDestination(id: 1, name: "Emergency Department", sub: "Ground Floor, Wing A", icon: "cross.circle.fill"),
    HospitalDestination(id: 2, name: "Radiology & Imaging", sub: "2nd Floor, Wing C", icon: "camera.metering.center.weighted"),
    HospitalDestination(id: 3, name: "Pharmacy", sub: "Ground Floor, Main Lobby", icon: "pills.circle.fill"),
    HospitalDestination(id: 4, name: "Surgical Ward", sub: "4th Floor, Wing B", icon: "scissors"),
]
