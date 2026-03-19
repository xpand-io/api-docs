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
        "checkbox-0": true;
        "signature-0": string;
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
