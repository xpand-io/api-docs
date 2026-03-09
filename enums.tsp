namespace Enums {
  @example(JourneyPublishingState.published)
  enum JourneyPublishingState {
    unpublished: "unpublished",
    published: "published",
    draft: "draft",
  }

  @example(JourneyTransitionType.pre_offer)
  enum JourneyTransitionType {
    pre_offer: "pre_offer",
    offer: "offer",
    post_offer: "post_offer",
    onboarding: "onboarding",
    offboarding: "offboarding",
  }

  @example(UserJourneyState.approved)
  enum UserJourneyState {
    draft: "draft",
    needs_attention: "needs_attention",
    pending_approval: "pending_approval",
    approved: "approved",
    rejected: "rejected",
    rescinded: "rescinded",
    user_pending: "user_pending",
    submitted: "submitted",
    declined: "declined",
    completed: "completed",
  }
}
