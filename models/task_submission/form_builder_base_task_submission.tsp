namespace Models {
  namespace TaskSubmission {
    model FormBuilderBaseTaskSubmission {
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
    }
  }
}
