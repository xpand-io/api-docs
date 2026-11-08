namespace Models {
  namespace TaskSubmission {
    model BaseTaskSubmission {
      @example("approved")
      state: string;

      @example(null)
      pending_approval_at?: string | null;

      @example("2026-01-08T10:09:58Z")
      approved_at?: string | null;

      @example(null)
      rejected_at?: string | null;

      @example(null)
      rejection_reason?: string | null;

      responses: {
        @example(true)
        "checkbox-0": boolean;

        @example("user-signature")
        "signature-0": string;

        @example("CITIZENSHIP_STATUS-3-404")
        "Select citizenship status": string;

        @example(#["69c22d47044b57dc9f53b96b"])
        "Enter national ID aligned to this country": string[];

        @example("123456789")
        "Enter permanent resident card number": string;
      };

      addresses?: [];
      bank_accounts?: [];
      educations?: [];
      national_ids?: [];
      passports?: [];
      work_experiences?: [];
      phone_numbers?: [];
      visas?: [];
    }
  }
}
