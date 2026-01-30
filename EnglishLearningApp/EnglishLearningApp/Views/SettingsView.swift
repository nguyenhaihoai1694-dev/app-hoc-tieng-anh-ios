import SwiftUI

struct SettingsView: View {
    @StateObject private var localizationManager = LocalizationManager.shared
    @Environment(\.dismiss) private var dismiss
    @State private var showResetConfirmation = false

    var body: some View {
        NavigationView {
            List {
                // Language Section
                Section {
                    ForEach(AppLanguage.allCases, id: \.self) { language in
                        LanguageRow(
                            language: language,
                            isSelected: localizationManager.currentLanguage == language
                        ) {
                            withAnimation {
                                localizationManager.currentLanguage = language
                            }
                            SoundEffectService.shared.playTapSound()
                        }
                    }
                } header: {
                    HStack {
                        Image(systemName: "globe")
                        Text("Language / Ngôn ngữ")
                    }
                    .font(.headline)
                }

                // App Info
                Section {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0")
                            .foregroundColor(.secondary)
                    }

                    HStack {
                        Text("Build")
                        Spacer()
                        Text(Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1")
                            .foregroundColor(.secondary)
                    }

                    HStack {
                        Text("Bundle ID")
                        Spacer()
                        Text(Bundle.main.bundleIdentifier ?? "N/A")
                            .foregroundColor(.secondary)
                            .font(.system(size: 12))
                    }
                } header: {
                    HStack {
                        Image(systemName: "info.circle")
                        Text("App Information / Thông tin ứng dụng")
                    }
                    .font(.headline)
                }

                // Advanced / Debug Tools
                Section {
                    Button(action: {
                        showResetConfirmation = true
                    }) {
                        HStack {
                            Image(systemName: "arrow.counterclockwise.circle")
                                .foregroundColor(.orange)
                            Text("Reset Achievements / Đặt lại thành tích")
                                .foregroundColor(.primary)
                        }
                    }
                } header: {
                    HStack {
                        Image(systemName: "wrench.and.screwdriver")
                        Text("Advanced / Nâng cao")
                    }
                    .font(.headline)
                } footer: {
                    Text("Reset all achievement progress. This cannot be undone. / Đặt lại tất cả tiến độ thành tích. Không thể hoàn tác.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                // About
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("English Learning App for Kids")
                            .font(.headline)

                        Text("Ứng dụng Học Tiếng Anh cho Trẻ em")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        Text("Ages 6-12 • Độ tuổi 6-12")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.top, 5)
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle(localizationManager.localized(.settings))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Done / Xong")
                            .fontWeight(.semibold)
                    }
                }
            }
            .alert("Reset Achievements?", isPresented: $showResetConfirmation) {
                Button("Cancel / Hủy", role: .cancel) {}
                Button("Reset / Đặt lại", role: .destructive) {
                    AchievementManager.shared.resetAchievements()
                }
            } message: {
                Text("This will reset all your achievement progress. This action cannot be undone.\n\nĐiều này sẽ đặt lại tất cả tiến độ thành tích của bạn. Hành động này không thể hoàn tác.")
            }
        }
    }
}

struct LanguageRow: View {
    let language: AppLanguage
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 15) {
                Text(language.flag)
                    .font(.system(size: 32))

                VStack(alignment: .leading, spacing: 4) {
                    Text(language.displayName)
                        .font(.body)
                        .fontWeight(isSelected ? .semibold : .regular)
                        .foregroundColor(.primary)

                    if language == .english {
                        Text("English")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    } else {
                        Text("Vietnamese")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.blue)
                        .font(.title3)
                }
            }
            .padding(.vertical, 8)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
