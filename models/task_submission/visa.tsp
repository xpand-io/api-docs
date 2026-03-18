namespace Models {
  namespace TaskSubmission {
    model Visa {
      @example("698d75a9361fc034ace53662")
      id?: string;

      @example("1234567890")
      number?: string;

      @example("unknown_type")
      visa_type?: string;

      @example("IN")
      visa_issue_country?: string;

      @example("2025-01-02")
      issued_date?: string;

      @example("2035-01-02")
      expiry_date?: string;

      @example("")
      issuing_authority?: string;

      @example("Hyderabad")
      place_of_issue?: string;

      @example("https://xpand-dev-journeys.s3.amazonaws.com/")
      visa_s3_url?: string;
    }
  }
}
