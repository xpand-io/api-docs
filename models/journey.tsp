model Journey {
  @example("12345")
  id: string;

  @example("Offer")
  title: string;

  @example("offer")
  transition_type: string;

  @example("unpublished, published, draft")
  publishing_state: string;

  @example("2025/01/01")
  created_at: string;
}
