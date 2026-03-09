model JourneyList {
  id: UUID;
  transition_type: JourneyTransitionType;
  publishing_state: JourneyPublishingState;
  title: string;
  created_at: DateTime;
}
