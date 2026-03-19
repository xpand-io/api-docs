namespace Models {
  namespace Task {
    model TextTask extends UserJourneyTaskBase {
      @example("text")
      type: string;

      @example("IP Protection and Restrictive Covenant Agreement.")
      title: string;

      @example("IP Protection and Restrictive Covenant Agreement.")
      description?: string;

      @example("<H1>Header value </H1>")
      header_value: string;

      @example("<H1>Footer value </H1>")
      footer_value: string;

      @example(false)
      requires_submission: boolean;

      @example(false)
      requires_signature: boolean;

      task_submission?: Models.TaskSubmission.BaseTaskSubmission;
    }
  }
}
