namespace Models {
  namespace TaskSubmission {
    model WorkExperience {
      @example("698d75a9361fc034ace53664")
      id?: string;

      @example("XYZ Corp")
      employer?: string;

      @example("2020-01-01")
      start_date?: string;

      @example("2023-01-01")
      end_date?: string;

      @example(true)
      current?: boolean;

      @example("Software Engineer")
      job_title?: string;

      @example("Engineering")
      department?: string;

      @example("https://xpand-dev-journeys.s3.amazonaws.com/relieving_letter.pdf")
      relieving_letter_url?: string;

      @example("https://xpand-dev-journeys.s3.amazonaws.com/service_certificate.pdf")
      service_certificate_url?: string;

      @example("https://xpand-dev-journeys.s3.amazonaws.com/resignation_acceptance.pdf")
      resignation_acceptance_url?: string;

      @example("https://xpand-dev-journeys.s3.amazonaws.com/other_document.pdf")
      other_document_url?: string;
    }
  }
}
