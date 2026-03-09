namespace Models {
  model Journey {
    id: UUID;
    transition_type: Enums.JourneyTransitionType;
    publishing_state: Enums.JourneyPublishingState;
    title: string;
    created_at: DateTime;
  }
}
