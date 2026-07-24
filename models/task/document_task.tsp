namespace Models {
  namespace Task {
    model DocumentTask extends UserJourneyTaskBase {
      @example("document")
      "type": string;

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

      @example("http://s3.amazonaws.com/api/v2/tasks/69aa76d0e3425abba82fe554/download?type=document")
      download_url: string;

      task_submission?: Models.TaskSubmission.BaseTaskSubmission;
    }
  }
}
