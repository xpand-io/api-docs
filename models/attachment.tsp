namespace Models {
  model Attachment {
    @example("abc.pdf")
    file_name?: string;

    file_content_base64?: Base64;

    @doc("Responses provided in PDF form fields (only present when attachment is a PDF with form fields)")
    responses?: {
      @example("abc")
      field_name_1?: string;

      @example("cba")
      field_name_2?: string;
    };
  }
}
