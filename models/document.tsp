model Document {
  @example("offer_letter")
  document_type?: string;

  @example("1234")
  document_number?: string;

  @example("Offer Letter")
  document_title?: string;

  @example("Offer Letter to the Joe")
  document_description?: string;

  @example("Issuer")
  issuer?: string;

  @example("New York")
  issuer_city?: string;

  @example("New York")
  issuer_state?: string;

  @example("USA")
  issuer_country?: string;

  issued_date?: Date;
  expiry_date?: Date;
  attachments?: Attachment[];
}
