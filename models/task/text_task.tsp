namespace Models {
  namespace Task {
    model TextTask extends UserJourneyTaskBase {
      @example("text")
      "type": string;

      @example("IP Protection and Restrictive Covenant Agreement.")
      title: string;

      @example("IP Protection and Restrictive Covenant Agreement.")
      description?: string;

      @example(false)
      requires_submission: boolean;

      @example(false)
      requires_signature: boolean;

      @example("http://s3.amazonaws.com/api/v2/tasks/69aa76d0e3425abba82fe554/download?type=text")
      download_url: string;

      task_submission?: Models.TaskSubmission.BaseTaskSubmission;
    }
  }
}
