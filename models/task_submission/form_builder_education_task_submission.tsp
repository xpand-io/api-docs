namespace Models {
  namespace TaskSubmission {
    model FormBuilderEducationTaskSubmission extends FormBuilderBaseTaskSubmission {
      addresses?: [];
      bank_accounts?: [];
      national_ids?: [];
      passports?: [];
      work_experiences?: [];
      phone_numbers?: [];
      visas?: [];
      educations: Models.TaskSubmission.Education[];
      "responses": {
        "694927bb4f1f89b0642be6fe": [
          "698d75a9361fc034ace53660"
        ]
      },
    }
  }
}
