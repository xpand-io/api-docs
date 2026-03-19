namespace Models {
  namespace TaskSubmission {
    model FormBuilderBankAccountTaskSubmission extends FormBuilderBaseTaskSubmission {
      addresses?: [];
      educations?: [];
      national_ids?: [];
      passports?: [];
      work_experiences?: [];
      phone_numbers?: [];
      visas?: [];
      bank_accounts: Models.TaskSubmission.BankAccount[];
      "responses": {
        "694927bb4f1f89b0642be6fe": [
          "698d75a9361fc034ace53660"
        ]
      },
    }
  }
}
