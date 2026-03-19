namespace Models {
  namespace TaskSubmission {
    model FormBuilderNationalIdTaskSubmission extends FormBuilderBaseTaskSubmission {
      addresses?: [];
      bank_accounts?: [];
      educations?: [];
      passports?: [];
      work_experiences?: [];
      phone_numbers?: [];
      visas?: [];
      national_ids: Models.TaskSubmission.NationalId[];
      "responses": {
        "694927bb4f1f89b0642be6fe": [
          "698d75a9361fc034ace53660"
        ]
      },
    }
  }
}
