namespace Models {
  namespace TaskSubmission {
    model Passport {
      @example("698d75a9361fc034ace53666")
      id?: string;

      @example("N1234567")
      number?: string;

      @example("India")
      issue_country?: string;

      @example("2018-06-15")
      issued_date?: string;

      @example("2028-06-14")
      expiry_date?: string;

      @example("Regular")
      type?: string;

      @example("Ministry of External Affairs")
      issuing_authority?: string;

      @example("https://xpand-dev-journeys.s3.amazonaws.com/passport.pdf")
      passport_url?: string;
    }
  }
}
