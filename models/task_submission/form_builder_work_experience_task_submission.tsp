namespace Models {
  namespace TaskSubmission {
    model FormBuilderWorkExperienceTaskSubmission extends FormBuilderBaseTaskSubmission {
      addresses?: [];
      bank_accounts?: [];
      educations?: [];
      national_ids?: [];
      passports?: [];
      phone_numbers?: [];
      visas?: [];
      work_experiences: Models.TaskSubmission.WorkExperience[];
      "responses": {
        "694927bb4f1f89b0642be6fe": [
          "698d75a9361fc034ace53660"
        ]
      },
    }
  }
}
