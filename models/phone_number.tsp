model PhoneNumber {
  @doc("E.164 Format")
  @example("+14044580998")
  number?: string;

  @example("mobile")
  type?: "mobile" | "landline" | "unknown";

  @example(true)
  primary?: boolean;
}
