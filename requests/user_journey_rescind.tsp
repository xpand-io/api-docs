namespace Requests {
  model UserJourneyRescind {
    @doc("Reason for rescinding the user journey.")
    @example(Enums.UserJourneyRescindReason.no_longer_needed)
    rescind_reason: Enums.UserJourneyRescindReason;
  }
}
