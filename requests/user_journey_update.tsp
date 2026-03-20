namespace Requests {
  model UserJourneyUpdate {
    expiration_date?: Date;
    office_location_id?: UUID | {
      @example("LOCATION-3-69")
      workday?: string;
    };

    @example(#{ key1: "Hello", key2: "World" })
    custom_fields?: Record<string>;

    documents?: {
      @example("offer_letter")
      document_type?: string;

      @example("1234")
      document_number?: string;

      @example("Offer Letter")
      document_title?: string;

      @example("Offer Letter to the Joe")
      document_description?: string;

      attachments?: {
        @example("abc.pdf")
        file_name?: string;

        file_content_base64?: Base64;
      }[];
    }[];
  }
}
