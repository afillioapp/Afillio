//
//   StripeManager.swift
//  Afillio
//
//  Created by Alireza Motahari on 2025-05-10.
//

import Foundation
import Stripe

final class StripeManager {
    static let shared = StripeManager()
    private init() {}

    func configure() {
        STPAPIClient.shared.publishableKey = "<STRIPE_PUBLISHABLE_KEY>"
    }

    /// Charge a brand and add funds to campaign escrow
    func deposit(brandID: String, amount: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        // Hit your Cloud Function / backend to create a PaymentIntent
        completion(.success(()))
    }

    /// Pay out an influencer via Connect
    func payout(influencerID: String, amount: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        // Hit your backend to create a Transfer / Payout
        completion(.success(()))
    }
}
