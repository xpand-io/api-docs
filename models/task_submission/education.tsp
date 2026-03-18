namespace Models {
  namespace TaskSubmission {
    model Education {
      @example("698d75a9361fc034ace53665")
      id?: string;

      @example("ABC University")
      school_name?: string;

      @example("B.Tech")
      degree?: string;

      @example("2015-08-01")
      start_date?: string;

      @example("2019-05-01")
      end_date?: string;

      @example("Computer Science")
      major?: string;

      @example(true)
      graduated?: boolean;

      @example("2019-05-01")
      graduation_date?: string;

      @example("8.5")
      gpa?: string;

      @example("https://xpand-dev-journeys.s3.amazonaws.com/marksheet.pdf")
      marksheet_url?: string;

      @example("https://xpand-dev-journeys.s3.amazonaws.com/degree_certificate.pdf")
      degree_url?: string;
    }
  }
}
