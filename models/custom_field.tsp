model CustomField {
  id: UUID;
  transition_type: JourneyTransitionType;

  @example("Start date")
  name: string;

  @example("1234")
  key: string;

  @example("Datetime")
  data_type: string;

  @example(false)
  mandatory: boolean;

  @example("salutation, nickname, title, university, current_location, employee_id, profile_photo_url, division, hire_type, company_code, relocation_type, job_profile_id")
  mapping?: string;

  @example("regexp, list_of_values_map, list, previous_date_time, future_date_time, workday_job_profile, workday_organization")
  validation_rule?: string;

  @doc("Required if validation_rule is regexp")
  @example("^[a-zA-Z0-9]+$")
  regexp_pattern?: string;

  @doc("Required if validation_rule is list")
  @example(#["a", "b", "c"])
  allowed_values: string[];

  @doc("Required if validation_rule is list_of_values_map")
  @example("LegalEntityLOV - refer to References API for more details")
  list_of_values_map_id: string;

  @example("2025-01-01")
  created_at: string;

  @example(false)
  deactivated?: boolean;

  @doc("Used in Assignment Rules")
  @example(false)
  rule_settable?: boolean;

  @doc("Used in placeholders")
  @example(false)
  placeholderable?: boolean;

  @example(#[
    "journey",
    "module",
    "child_module",
    "task",
    "communication",
    "report"
  ])
  allowed_rule_set_types: string[];

  @example(#["journey", "communication", "html_editor_task"])
  allowed_placeholder_type: string[];

  @doc("Required if validation_rule is workday_organization")
  @example("Supervisory, Pay_Group, Cost_Center, Company, Cost_Center_Hierarchy, Location_Hierarchy, External_Payroll_Company, Company_Hierarchy")
  workday_organization_type?: string;
}
