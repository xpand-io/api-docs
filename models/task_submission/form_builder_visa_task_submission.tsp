namespace Models {
  namespace TaskSubmission {
    model FormBuilderVisaTaskSubmission extends FormBuilderBaseTaskSubmission {
      addresses?: [];
      bank_accounts?: [];
      educations?: [];
      national_ids?: [];
      passports?: [];
      work_experiences?: [];
      phone_numbers?: [];
      visas: Models.TaskSubmission.Visa[];
      "responses": {
        "694927bb4f1f89b0642be6fe": [
          "698d75a9361fc034ace53660"
        ]
      },
    }
  }
}
