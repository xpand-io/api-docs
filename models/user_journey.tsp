model UserJourney {
  id: UUID;
  journey_id: UUID;
  user_id: UUID;
  transition_type: JourneyTransitionType;
  state: UserJourneyState;
  created_at: Date;
  expiration_date: Date;
  office_location: OfficeLocation | null;
  custom_field_values: {
    @example("1234")
    id?: string;

    @example("custom field value")
    value?: string;

    @example("custom field name")
    name?: string;

    @example("1234")
    key?: string;
  }[];
}
