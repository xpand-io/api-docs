namespace Models {
  namespace Task {
    model DocumentTask extends UserJourneyTaskBase {
      @example("document")
      type: string;

      @example("Offer Letter")
      title: string;

      @example("Offer Letter")
      description?: string;

      @example(false)
      requires_submission: boolean;

      @example(false)
      requires_signature: boolean;

      document?: {
        id: string;
        url: string;
        file_name: string;
      };

      task_submission?: Models.TaskSubmission.BaseTaskSubmission;
    }
  }
}
