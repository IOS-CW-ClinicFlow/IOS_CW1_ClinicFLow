//
//  ProfileScreen.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-10.
//
import SwiftUI

// ── Which sheet is open ────────────────────────────────────────────────────────
private enum ProfileSheet: Identifiable {
    case profile, payment, favourite, settings, helpCenter, privacy
    var id: Int { hashValue }
}

struct ProfileScreen: View {

    var onBack:   () -> Void = {}
    var onLogout: () -> Void = {}

    @State private var activeSheet: ProfileSheet?
    @State private var showLogoutConfirmation = false

    var body: some View {
        VStack(spacing: 0) {

            TopBar(title: "Profile", showBack: true, onBack: onBack)

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {

                    ProfileAvatarView(
                        name:       ProfileData.userName,
                        avatarName: ProfileData.avatarName,
                        onEditTap:  { activeSheet = .profile }
                    )

                    VStack(spacing: 0) {
                        ForEach(Array(ProfileData.menuItems.enumerated()), id: \.element.id) { index, item in
                            ProfileMenuRow(
                                item:  item,
                                onTap: {
                                    switch item.label {
                                    case "Your profile":    activeSheet = .profile
                                    case "Payment Methods": activeSheet = .payment
                                    case "Favourite":       activeSheet = .favourite
                                    case "Settings":        activeSheet = .settings
                                    case "Help Center":     activeSheet = .helpCenter
                                    case "Privacy Policy":  activeSheet = .privacy
                                    case "Log out":         showLogoutConfirmation = true
                                    default: break
                                    }
                                }
                            )
                            if index < ProfileData.menuItems.count - 1 {
                                Rectangle()
                                    .fill(Color(hex: "#F0F0F5"))
                                    .frame(height: 1)
                                    .padding(.horizontal, 22)
                            }
                        }
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .black.opacity(0.06), radius: 12, x: 0, y: 2)
                    .padding(.horizontal, 18)
                    .padding(.bottom, 24)
                }
            }
            .background(Color(hex: "#F4F6FB"))
        }
        .background(Color(hex: "#F4F6FB"))
        .confirmDialog(
            title:        "Log out",
            message:      "Are you sure you want to log out?",
            confirmLabel: "Log out",
            isPresented:  $showLogoutConfirmation,
            onConfirm:    onLogout
        )
        .sheet(item: $activeSheet) { sheet in
            switch sheet {
            case .profile:    EditProfileSheet()
            case .payment:    PaymentMethodsSheet()
            case .favourite:  FavouritesSheet()
            case .settings:   SettingsSheet()
            case .helpCenter: HelpCenterSheet()
            case .privacy:    PrivacyPolicySheet()
            }
        }
    }
}

// ─────────────────────────────────────────────────────────────────────────────
// MARK: – Edit Profile Sheet
// ─────────────────────────────────────────────────────────────────────────────

private struct EditProfileSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name     = ProfileData.userName
    @State private var email    = "sandun@example.com"
    @State private var phone    = "+94 77 123 4567"
    @State private var dob      = "01 Jan 1990"
    @State private var gender   = "Male"

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {

                    // Avatar
                    ZStack(alignment: .bottomTrailing) {
                        Image(ProfileData.avatarName)
                            .resizable().scaledToFill()
                            .frame(width: 90, height: 90).clipShape(Circle())
                            .overlay(Circle().stroke(Color(hex: "#E0ECF8"), lineWidth: 3))
                        ZStack {
                            Circle().fill(Color(hex: "#1A8FD1")).frame(width: 26, height: 26)
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            Image(systemName: "pencil").font(.system(size: 11, weight: .bold)).foregroundColor(.white)
                        }
                        .offset(x: 2, y: 2)
                    }
                    .padding(.top, 8)

                    VStack(spacing: 14) {
                        profileField(label: "Full Name",    value: $name)
                        profileField(label: "Email",        value: $email,  keyboard: .emailAddress)
                        profileField(label: "Phone",        value: $phone,  keyboard: .phonePad)
                        profileField(label: "Date of Birth",value: $dob)
                        profileField(label: "Gender",       value: $gender)
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 32)
            }
            .background(Color(hex: "#F4F6FB"))
            .navigationTitle("Your Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { dismiss() }
                        .fontWeight(.bold)
                }
            }
        }
    }

    private func profileField(label: String, value: Binding<String>,
                               keyboard: UIKeyboardType = .default) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(Color(hex: "#888888"))
            TextField(label, text: value)
                .keyboardType(keyboard)
                .font(.system(size: 15))
                .padding(.horizontal, 14).padding(.vertical, 13)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(hex: "#E0E0EE"), lineWidth: 1.5))
        }
    }
}

// ─────────────────────────────────────────────────────────────────────────────
// MARK: – Payment Methods Sheet
// ─────────────────────────────────────────────────────────────────────────────

private struct PaymentMethodsSheet: View {
    @Environment(\.dismiss) private var dismiss

    private let cards = [
        ("Visa",       "•••• •••• •••• 4242", "visa",        "12/27"),
        ("Mastercard", "•••• •••• •••• 8888", "creditcard",  "09/26"),
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 14) {
                    ForEach(cards, id: \.1) { card in
                        HStack(spacing: 16) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(hex: "#EAF4FE"))
                                    .frame(width: 48, height: 48)
                                Image(systemName: card.2)
                                    .font(.system(size: 20))
                                    .foregroundColor(Color(hex: "#1A8FD1"))
                            }
                            VStack(alignment: .leading, spacing: 4) {
                                Text(card.0).font(.system(size: 15, weight: .semibold)).foregroundColor(Color(hex: "#1a1a1a"))
                                Text(card.1).font(.system(size: 13)).foregroundColor(Color(hex: "#888888"))
                            }
                            Spacer()
                            Text("Exp \(card.3)").font(.system(size: 12)).foregroundColor(Color(hex: "#AAAAAA"))
                        }
                        .padding(16)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
                    }

                    // Add new card
                    Button {} label: {
                        HStack(spacing: 12) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(hex: "#EAF4FE"))
                                    .frame(width: 48, height: 48)
                                Image(systemName: "plus").font(.system(size: 18, weight: .semibold)).foregroundColor(Color(hex: "#2196F3"))
                            }
                            Text("Add New Card").font(.system(size: 15, weight: .medium)).foregroundColor(Color(hex: "#1A8FD1"))
                            Spacer()
                        }
                        .padding(16)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color(hex: "#1A8FD1").opacity(0.3), lineWidth: 1.5))
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 18)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
            .background(Color(hex: "#F4F6FB"))
            .navigationTitle("Payment Methods")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

// ─────────────────────────────────────────────────────────────────────────────
// MARK: – Favourites Sheet
// ─────────────────────────────────────────────────────────────────────────────

private struct FavouritesSheet: View {
    @Environment(\.dismiss) private var dismiss

    private let favourites: [(String, String, String)] = [
        ("Dr. Jayaani Dennis",  "Physiologist",  "doc_jayaani"),
        ("Dr. Ryan De Silva",   "Cardiologist",  "doc_ryan"),
        ("Dr. Sarath Fernando", "Dentist",        "doc_sarath"),
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 14) {
                    ForEach(favourites, id: \.0) { fav in
                        HStack(spacing: 14) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12).fill(Color(hex: "#D6E8F5")).frame(width: 56, height: 56)
                                Image(fav.2).resizable().scaledToFill().frame(width: 56, height: 56).clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                            VStack(alignment: .leading, spacing: 4) {
                                Text(fav.0).font(.system(size: 15, weight: .semibold)).foregroundColor(Color(hex: "#1a1a1a"))
                                Text(fav.1).font(.system(size: 13)).foregroundColor(Color(hex: "#888888"))
                            }
                            Spacer()
                            Image(systemName: "heart.fill").foregroundColor(Color(hex: "#F44336")).font(.system(size: 18))
                        }
                        .padding(14)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
                    }
                }
                .padding(.horizontal, 18).padding(.top, 16).padding(.bottom, 32)
            }
            .background(Color(hex: "#F4F6FB"))
            .navigationTitle("Favourites")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) { Button("Done") { dismiss() } }
            }
        }
    }
}

// ─────────────────────────────────────────────────────────────────────────────
// MARK: – Settings Sheet
// ─────────────────────────────────────────────────────────────────────────────

private struct SettingsSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var notifications  = true
    @State private var reminders      = true
    @State private var darkMode       = false
    @State private var biometrics     = false
    @State private var language       = "English"

    var body: some View {
        NavigationStack {
            List {
                Section("Notifications") {
                    Toggle("Push Notifications", isOn: $notifications)
                    Toggle("Appointment Reminders", isOn: $reminders)
                }
                Section("Appearance") {
                    Toggle("Dark Mode", isOn: $darkMode)
                    Picker("Language", selection: $language) {
                        Text("English").tag("English")
                        Text("සිංහල").tag("සිංහල")
                        Text("தமிழ்").tag("தமிழ்")
                    }
                }
                Section("Security") {
                    Toggle("Face ID / Touch ID", isOn: $biometrics)
                }
                Section("Account") {
                    Button("Change Password", role: .none) {}
                        .foregroundColor(Color(hex: "#1A8FD1"))
                    Button("Delete Account", role: .destructive) {}
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) { Button("Done") { dismiss() } }
            }
        }
    }
}

// ─────────────────────────────────────────────────────────────────────────────
// MARK: – Help Center Sheet
// ─────────────────────────────────────────────────────────────────────────────

private struct HelpCenterSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var expandedFAQ: String? = nil

    private let faqs: [(String, String)] = [
        ("How do I book an appointment?",
         "Go to Services → Doctors, tap a doctor and press Make Appointment. Select a package, fill in patient details and complete payment."),
        ("How do I reschedule or cancel?",
         "Open My Appointments, tap the appointment, then use the Reschedule or Cancel button at the bottom."),
        ("How do I get my prescription?",
         "After your consultation is complete, go to Consultation Summary and tap the download button on the prescription card."),
        ("Can I pay with cash?",
         "Yes. On the payment screen select Cash — your booking will be confirmed and you can pay at reception."),
        ("How does queue tracking work?",
         "On your appointment detail screen tap Track Appointment. A countdown shows your estimated wait. When it's your turn the Scan QR button appears."),
    ]

    private let contacts: [(String, String, String)] = [
        ("Call Support",  "phone.fill",          "+94 11 234 5678"),
        ("Live Chat",     "message.fill",         "Available 8am – 8pm"),
        ("Email Us",      "envelope.fill",        "support@clinicflow.lk"),
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    // Contact options
                    VStack(spacing: 12) {
                        ForEach(contacts, id: \.0) { item in
                            HStack(spacing: 16) {
                                ZStack {
                                    Circle().fill(Color(hex: "#EAF4FE")).frame(width: 44, height: 44)
                                    Image(systemName: item.1).font(.system(size: 18)).foregroundColor(Color(hex: "#1A8FD1"))
                                }
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(item.0).font(.system(size: 14, weight: .semibold)).foregroundColor(Color(hex: "#1a1a1a"))
                                    Text(item.2).font(.system(size: 13)).foregroundColor(Color(hex: "#888888"))
                                }
                                Spacer()
                                Image(systemName: "chevron.right").font(.system(size: 13)).foregroundColor(Color(hex: "#C8C8D0"))
                            }
                            .padding(14)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
                        }
                    }

                    // FAQs
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Frequently Asked Questions")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(Color(hex: "#1a1a1a"))
                            .padding(.bottom, 8)

                        ForEach(faqs, id: \.0) { faq in
                            VStack(spacing: 0) {
                                Button {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        expandedFAQ = expandedFAQ == faq.0 ? nil : faq.0
                                    }
                                } label: {
                                    HStack(spacing: 12) {
                                        Text(faq.0)
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(Color(hex: "#1a1a1a"))
                                            .multilineTextAlignment(.leading)
                                        Spacer()
                                        Image(systemName: expandedFAQ == faq.0 ? "chevron.up" : "chevron.down")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundColor(Color(hex: "#AAAAAA"))
                                    }
                                    .padding(14)
                                }
                                .buttonStyle(.plain)

                                if expandedFAQ == faq.0 {
                                    Text(faq.1)
                                        .font(.system(size: 13))
                                        .foregroundColor(Color(hex: "#666666"))
                                        .padding(.horizontal, 14)
                                        .padding(.bottom, 14)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .transition(.opacity.combined(with: .move(edge: .top)))
                                }
                            }
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
                        }
                    }
                }
                .padding(.horizontal, 18)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
            .background(Color(hex: "#F4F6FB"))
            .navigationTitle("Help Center")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) { Button("Done") { dismiss() } }
            }
        }
    }
}

// ─────────────────────────────────────────────────────────────────────────────
// MARK: – Privacy Policy Sheet
// ─────────────────────────────────────────────────────────────────────────────

private struct PrivacyPolicySheet: View {
    @Environment(\.dismiss) private var dismiss

    private let sections: [(String, String)] = [
        ("Information We Collect",
         "We collect personal information you provide when creating an account, booking appointments, or contacting support. This includes your name, contact details, and health-related information necessary to provide our services."),
        ("How We Use Your Information",
         "Your information is used to manage appointments, send reminders, process payments, and improve the ClinicFlow experience. We do not sell your data to third parties."),
        ("Data Security",
         "We use industry-standard encryption to protect your personal and medical information. Access is restricted to authorised personnel only."),
        ("Sharing with Healthcare Providers",
         "Relevant health information is shared only with the doctors and labs you book through ClinicFlow, solely to provide the requested services."),
        ("Your Rights",
         "You may access, update, or request deletion of your personal data at any time by contacting our support team or through the Settings screen."),
        ("Cookies & Analytics",
         "We use anonymised analytics to improve app performance. No personally identifiable information is used in analytics reporting."),
        ("Contact Us",
         "For any privacy-related concerns please email privacy@clinicflow.lk or call +94 11 234 5678."),
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Last updated: March 2026")
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex: "#AAAAAA"))

                    ForEach(sections, id: \.0) { section in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(section.0)
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(Color(hex: "#1a1a1a"))
                            Text(section.1)
                                .font(.system(size: 14))
                                .foregroundColor(Color(hex: "#555555"))
                                .lineSpacing(4)
                        }
                        .padding(16)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .shadow(color: .black.opacity(0.04), radius: 8, x: 0, y: 2)
                    }
                }
                .padding(.horizontal, 18)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
            .background(Color(hex: "#F4F6FB"))
            .navigationTitle("Privacy Policy")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) { Button("Done") { dismiss() } }
            }
        }
    }
}

#Preview { ProfileScreen() }
