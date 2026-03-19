namespace Models {
  namespace TaskSubmission {
    model FormBuilderAddressTaskSubmission extends FormBuilderBaseTaskSubmission {
      bank_accounts?: [];
      educations?: [];
      national_ids?: [];
      passports?: [];
      work_experiences?: [];
      phone_numbers?: [];
      visas?: [];
      addresses: Models.TaskSubmission.Address[];
      "responses": {
        "694927bb4f1f89b0642be6fe": [
          "698d75a9361fc034ace53660"
        ]
      },
    }
  }
}
