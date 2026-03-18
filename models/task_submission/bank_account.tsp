namespace Models {
  namespace TaskSubmission {
    model BankAccount {
      @example("698d75a9361fc034ace53668")
      id?: string;

      @example("Savings")
      account_type?: string;

      @example("HDFC001")
      bank_id?: string;

      @example("123456789012")
      account_number?: string;

      @example("00123")
      branch_id?: string;

      @example("7")
      check_digit?: string;

      @example("HDFC Bank")
      bank_name?: string;

      @example("Rahul Sharma")
      bank_account_name?: string;
    }
  }
}