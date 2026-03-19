namespace Models {
  namespace TaskSubmission {
    model PhoneNumber {
      @example("698d61f5361fc034ace53231")
      id?: string;

      @example("mobile")
      phone_type?: string;

      @example("+91")
      country_code?: string | null;

      @example("0701234567")
      phone_number?: string;
    }
  }
}
