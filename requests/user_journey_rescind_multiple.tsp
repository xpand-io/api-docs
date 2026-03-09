namespace Requests {
  model UserJourneyRescindMultiple {
    @doc("Optional comma-separated list of transition types. Spaces after commas are allowed. Allowed values are pre_offer, offer, post_offer, onboarding, offboarding.")
    @example("pre_offer, offer, post_offer, onboarding, offboarding")
    transition_type?: string;

    @doc("Reason for rescinding the journey(s). One of no_longer_needed, offered_externally.")
    @example(Enums.UserJourneyRescindReason.no_longer_needed)
    rescind_reason: Enums.UserJourneyRescindReason;

    @doc("ID of the user whose journeys will be rescinded.")
    @example("6949f4dcea80bfa3cb3c21d7")
    user_id: string;
  }
}
