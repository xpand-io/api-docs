namespace Models {
  namespace TaskSubmission {
    model FormBuilderPhoneTaskSubmission extends FormBuilderBaseTaskSubmission {
      addresses?: [];
      bank_accounts?: [];
      educations?: [];
      national_ids?: [];
      passports?: [];
      work_experiences?: [];
      visas?: [];
      phone_numbers: Models.TaskSubmission.PhoneNumber[];
      "responses": {
        "694927bb4f1f89b0642be6fe": [
          "698d75a9361fc034ace53660"
        ]
      },
    }
  }
}
