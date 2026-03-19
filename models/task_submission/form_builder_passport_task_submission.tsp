namespace Models {
  namespace TaskSubmission {
    model FormBuilderPassportTaskSubmission extends FormBuilderBaseTaskSubmission {
      addresses?: [];
      bank_accounts?: [];
      educations?: [];
      national_ids?: [];
      work_experiences?: [];
      phone_numbers?: [];
      visas?: [];
      passports: Models.TaskSubmission.Passport[];
      "responses": {
        "694927bb4f1f89b0642be6fe": [
          "698d75a9361fc034ace53660"
        ]
      },
    }
  }
}
