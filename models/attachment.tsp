model Attachment {
  @example("abc.pdf")
  file_name?: string;

  @example("SGVsbG8gdGhlcmUgOi0pIEZpbmQgYW55dGhpbmcgZXhjaXRpbmc/")
  file_content_base64?: string;

  @doc("Responses provided in PDF form fields (only present when attachment is a PDF with form fields)")
  responses?: {
    @example("abc")
    field_name_1?: string;

    @example("cba")
    field_name_2?: string;
  };
}
