namespace Models {
  namespace TaskSubmission {
    model NationalId {
      @example("698d75a9361fc034ace53667")
      id?: string;

      @example("A123456789")
      national_id?: string;

      @example("National Identity Authority")
      issuing_agency?: string;

      @example("IN")
      country_iso2?: string;
    }
  }
}
