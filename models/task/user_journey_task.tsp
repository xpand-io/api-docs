namespace Models {
  namespace Task {
    alias UserJourneyTask =
      | TextTask
      | DocumentTask
      | VideoTask
      | I9Task
      | EmbeddedUrlTask
      | PowerPointTask
      | FormBuilderTask;
  }
}
