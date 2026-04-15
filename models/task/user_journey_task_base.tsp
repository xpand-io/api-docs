namespace Models {
  namespace Task {
    model UserJourneyTaskBase {
      @example("695f5f8b1b962bf3b327a043")
      id: string;

      @example("completed")
      state: string;

      @example("2026-02-12T06:39:38Z")
      completed_at?: string | null;

      @example(false)
      mandatory: boolean;

      @example("Continue")
      button_label?: string;

      @example("2026-02-10")
      submitted_at?: string | null;

      @example("2026-02-12")
      due_date?: string | null;

      @example("2026-02-14")
      resubmit_date?: string | null;

      @example("2026-02-15")
      return_date?: string | null;
    }
  }
}
