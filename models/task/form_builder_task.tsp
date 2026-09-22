namespace Models {
  namespace Task {
    model FormBuilderTask extends UserJourneyTaskBase {
      @example("form_builder")
      "type": string;

      @example("Phone number / Visa / Address / Work Experience / etc.")
      title: string;

      @example("Form Builder Task")
      description?: string;

      form?: {
        id: string;
        name: string;
      };

      task_submission?:
        Models.TaskSubmission.FormBuilderPhoneTaskSubmission |
        Models.TaskSubmission.FormBuilderVisaTaskSubmission |
        Models.TaskSubmission.FormBuilderAddressTaskSubmission |
        Models.TaskSubmission.FormBuilderWorkExperienceTaskSubmission |
        Models.TaskSubmission.FormBuilderEducationTaskSubmission |
        Models.TaskSubmission.FormBuilderPassportTaskSubmission |
        Models.TaskSubmission.FormBuilderBankAccountTaskSubmission |
        Models.TaskSubmission.FormBuilderNationalIdTaskSubmission;
    }
  }
}
