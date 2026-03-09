model OfficeLocationId {
  @example("LOCATION-3-69")
  workday?: string;

  @example("LOCATION-3-69")
  id: string;

  external_ids: {
    @example("E-1234")
    hris_id?: string;
  };

  @example("123 Main St")
  address1?: string;

  @example("Suite 200")
  address2?: string;

  @example("Building B")
  address3?: string;

  @example("New York")
  city?: string;

  @example("NY")
  state?: string;

  @example("Northeast")
  region?: string;

  @example("USA")
  country?: string;

  @example("10001")
  postal_code?: string;

  @example("NZT")
  time_zone?: string;

  @example(3.12332)
  latitude?: float32;

  @example(3.12332)
  longitude?: float32;
}
