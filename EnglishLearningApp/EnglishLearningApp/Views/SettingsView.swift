import SwiftUI

struct SettingsView: View {
    @StateObject private var localizationManager = LocalizationManager.shared
    @Environment(\.dismiss) private var dismiss

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
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }

                    HStack {
                        Text("Build")
                        Spacer()
                        Text("1")
                            .foregroundColor(.secondary)
                    }
                } header: {
                    HStack {
                        Image(systemName: "info.circle")
                        Text("App Information / Thông tin ứng dụng")
                    }
                    .font(.headline)
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
