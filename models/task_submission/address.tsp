namespace Models {
  namespace TaskSubmission {
    model Address {
      @example("12345")
      id?: string;

      @example("123 Main St")
      line_1?: string;

      @example("Apt 4B")
      line_2?: string;

      @example("New York")
      city?: string;

      @example("NY")
      state?: string;

      @example("10001")
      postal_code?: string;

      @example("US")
      country?: string;
    }
  }
}
