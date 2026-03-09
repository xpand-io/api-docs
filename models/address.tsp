model Address {
  @example("31 St, 34 West")
  line_1?: string;

  @example("8th Avenue")
  line_2?: string;

  line_3?: string;

  @example("New York")
  city: string;

  @example("New York")
  state?: string;

  @example("100018")
  postal_code?: string;

  @example("USA")
  country: string;

  @example(true)
  current?: boolean;

  @example(true)
  permanent?: boolean;

  start_date?: Date;
  end_date?: Date;
}
