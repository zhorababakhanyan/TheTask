//
//  SignUpView.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 28/04/2025.
//

import SwiftUI

struct SignUpView: View {
    @Binding var selectedTab: Tab

    @StateObject private var viewModel = SignUpViewModel()
    @FocusState private var focusedField: FieldFocus?
    
    @State var nameField = ""
    @State var emailField = ""
    @State var phoneNumber = ""
    
    @State private var nameError: String? = nil
    @State private var emailError: String? = nil
    @State private var phoneError: String? = nil
    
    @State var selectedPositionId = 1

    @State private var image: UIImage?
    @State private var isImagePickerPresented = false
    @State private var uploadingImageErrorMessage: String?
    @State private var showErrorUploadImageAlert = false
    @State private var showValidation = false
    
    @State private var isRegistrationSuccessFullScreenPresented = false
    @State private var isRegistrationFaildFullScreenPresented = false
    @State private var isAnyRegistrationFindedErrorAlert = false
    
    var body: some View {
        ScrollView {
            ZStack (alignment: .topLeading){
                Color.primaryBackgroundColor
                    .ignoresSafeArea(.all)
                VStack(alignment: .leading, spacing: 16) {
                    self.userInputView()
                    Text("Select your position")
                        .customFont(.regular_400, size: 18, color: .primaryTextColor)
                        .padding(.top, 8)
                    self.userPoitionSelectionListView()
                    self.userUploadPictureView()
                    self.userSignUpButtonView()
                }
                .onChange(of: viewModel.registrationResponse) { _ , response in
                    if let res = response {
                        print("🎉 Registration Success: \(res)")
                        self.isRegistrationSuccessFullScreenPresented = true
                    }
                }
                
                .onChange(of: viewModel.registerUserErrorMessage) { _ , message in
                    if let msg = message {
                        print("⚠️ Registration failed: \(msg)")
                        if viewModel.emailAlreadyRedigtered {
                            self.isRegistrationFaildFullScreenPresented = true
                        } else {
                            self.isAnyRegistrationFindedErrorAlert = true
                        }
                    }
                }
                .fullScreenCover(isPresented: $isRegistrationSuccessFullScreenPresented) {
                    SignUpSuccessView(selectedTab: $selectedTab)
                }
                .fullScreenCover(isPresented: $isRegistrationFaildFullScreenPresented) {
                    SignUpFailedView()
                }
                .alert(isPresented: $isAnyRegistrationFindedErrorAlert) {
                    Alert(
                        title: Text("😕Oops! Something went wrong"),
                        message: Text("Something went wrong. Please try signing up again.")
                    )
                }
                .alert(isPresented: $showErrorUploadImageAlert) {
                    Alert(
                        title: Text("⚠️ Failed To Upload Image"),
                        message: Text("\(String(describing: self.uploadingImageErrorMessage))")
                    )
                }
                .onChange(of: nameField) { _, _ in clearError(for: .name) }
                .onChange(of: emailField) { _, _ in clearError(for: .email) }
                .onChange(of: phoneNumber) { _, _ in clearError(for: .phone) }
                .padding(.top, 32)
                .padding(.horizontal, 16)
            }
            .task {
                await viewModel.fetchPositions()
            }
        }
    }
}

// MARK: - ClearErros()
extension SignUpView {
    /// Clears the validation error message for a specific input field based on its focus.
        ///
        /// This function is typically called when the user begins editing a field, allowing
        /// the UI to remove any previously displayed error for that field.
        ///
        /// - Parameter field: The field currently in focus (`.name`, `.email`, or `.phone`).
        ///                   If `nil` or an unsupported case, no action is taken.
    func clearError(for field: FieldFocus?) {
        switch field {
        case .name: self.nameError = nil
        case .email: self.emailError = nil
        case .phone: self.phoneError = nil
        default: break
        }
    }
}

// MARK: - ValidateError()
extension SignUpView {
    /// Validates the user's input fields and triggers sign-up if all fields are valid.
    ///
    /// This function sets `showValidation` to true to enable validation UI feedback,
    /// then uses `FunctionManager` to validate the name, email, and phone number fields.
    /// If all validations pass and an image is uploaded, it proceeds by calling `performSignup()`.
    ///
    /// - Note: If any field is invalid or the image is missing, the function exits early and does not proceed with sign-up.
    func validateForm() {
        self.showValidation = true

        self.nameError = FunctionManager.shared.validateName(self.nameField)
        self.emailError = FunctionManager.shared.validateEmail(self.emailField)
        self.phoneError = FunctionManager.shared.validatePhone(self.phoneNumber)
        
        guard nameError == nil,
              emailError == nil,
              phoneError == nil,
              image != nil else {
            return
        }
        self.performSignup()
    }
}

// MARK: - PerformSignUp()
extension SignUpView {
    /// Initiates the user registration process by calling `registerUser` on the view model.
    ///
    /// This asynchronous function gathers user input including name, lowercased email, phone number,
    /// selected position ID, and the uploaded image (assumed to be non-nil), then passes them to the
    /// view model's `registerUser` method inside a `Task` to ensure it runs asynchronously.
    ///
    /// - Note: Force-unwrapping the image assumes it is non-nil. Consider validating the image before calling this function.
    func performSignup() {
        Task {
            await viewModel.registerUser(
                name: self.nameField,
                email: self.emailField.lowercased(),
                phone: self.phoneNumber,
                positionId: self.selectedPositionId,
                image: self.image!)
        }
    }
}

// MARK: - UserInputFieldsView
extension SignUpView {
    /// Returns a vertical stack of input fields for the user's name, email, and phone number.
     ///
     /// Each field is represented using `PrimaryInputTextField` and includes validation for empty fields,
     /// optional field info (e.g., phone format), and focus management using `focusedField` and `focusID`.
     ///
     /// - Returns: A view containing vertically stacked input fields with spacing between them.
    func userInputView() -> some View {
        VStack (spacing: 15){
            PrimaryInputTextField(title: "Name", fieldInfo: "", emptyFieldError: nameError, focusID: .name, text: $nameField, focused: $focusedField)
            PrimaryInputTextField(title: "Email", fieldInfo: "", emptyFieldError: emailError, focusID: .email, text: $emailField, focused: $focusedField)
            PrimaryInputTextField(title: "Phone Number", fieldInfo: "+38 (XXX) XXX - XX - XX", emptyFieldError: phoneError, focusID: .phone, text: $phoneNumber, focused: $focusedField)
        }
    }
}

// MARK: - UserPositionSelectionListView
extension SignUpView {
    /// Returns a list view allowing the user to select a position during sign-up.
    ///
    /// The list displays available positions from `viewModel.positions`, and tapping a row
    /// sets the `selectedPositionId` to the corresponding position's ID.
    /// Each row uses `PositionSelectionView` to indicate selection state.
    ///
    /// - Returns: A styled list view for position selection, with a fixed height and no separators.
    func userPoitionSelectionListView() -> some View {
        List(viewModel.positions, id: \.id) { position in
            Button(action: {
                self.selectedPositionId = position.id
            }) {
                PositionSelectionView(position: position,
                                      isSelected: selectedPositionId == position.id)
            }
            .listRowBackground(Color.clear)
            .buttonStyle(PlainButtonStyle())
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
        }
        .scrollContentBackground(.hidden)
        .background(Color.clear)
        .frame(height: CGFloat(viewModel.positions.count) * 50)
        .padding(.horizontal)
        .listStyle(.plain)
    }
}

// MARK: - UserUploadImageView
extension SignUpView {
    /// Returns a view that allows the user to upload a profile picture during sign-up.
    ///
    /// Displays a custom `UploadPictureView` which indicates whether an image has been uploaded
    /// and shows validation feedback if required. When tapped, it toggles the presentation
    /// of an image picker sheet. Handles both image selection and potential image upload errors.
    ///
    /// - Returns: A view containing the image upload interface and image picker sheet.
    func userUploadPictureView() -> some View {
        UploadPictureView(
            imageUploaded: self.image != nil,
            showValidation: self.showValidation,
            action: { self.isImagePickerPresented.toggle()
        })
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(image: $image, onImagePicked: { pickedImage in }, onImageError: { error in
                self.uploadingImageErrorMessage = error
                self.showErrorUploadImageAlert = true
            })
        }
    }
}

// MARK: - UserSignUpButtonView
extension SignUpView {
    /// When tapped, it triggers the `validateForm()` function to process the sign-up logic.
    /// The button uses a `PrimaryFilledButton` style and triggers `validateForm()` when tapped.
     /// - Returns: A view containing the sign-up button centered within an `HStack`.
    func userSignUpButtonView() -> some View {
        HStack {
            Spacer()
            PrimaryFilledButton(title: "Sign Up", state: .normal) {
                self.validateForm()
            }
            Spacer()
        }
    }
}

