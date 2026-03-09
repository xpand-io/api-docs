model UserJourneyCreate {
  @example("123456")
  journey_id: string;

  @example("pre_offer")
  transition_type?: string;

  @example("123456")
  user_id?: string;

  @example(UserJourneyState.approved)
  state?: UserJourneyState;

  @example("2025-01-01")
  created_at?: string;

  office_location_id?: OfficeLocationId;

  @doc("Custom fields object for the user journey - we pass the key for any configured custom fields for this transition type.")
  custom_fields?: CustomFieldsValueObject;

  documents?: Document[];
}
