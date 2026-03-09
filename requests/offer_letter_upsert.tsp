model OfferLetterRequest {
  @doc("Unique ID of the user")
  user_id: UUID;

  @doc("Unique ID of the Offer")
  @example("O3112-333")
  offer_id: string;

  @doc("Unique ID of the Job Application")
  @example("J-O3112")
  job_application_id: string;

  @doc("JSON where key is name of external service, e.g. {'HRIS_ID': 'NEWYORK'. There must be an office location in Xpand with a matching employee id. See reference values here for existing office location external ids")
  office_location_id: {
    @example("LOCATION-3-69")
    workday?: string;
  };

  @doc("Start date of the new hire")
  start_date: Date;

  @doc("See reference values here for existing legal entity values.")
  @example("Xpand Limited")
  legal_entity?: string;

  @doc("Job Title of the offer")
  @example("Steamboat Captain")
  job_title?: string;

  @doc("ISO 4217 Currency Code")
  @example("USD")
  currency?: string;

  @doc("Basic Salary")
  @example(45000)
  base_salary?: integer;

  @doc("End date of the new hire")
  end_date?: Date;

  @doc("Induction Date")
  induction_date?: Date;

  @doc("Expiration date of an offer")
  expiration_date?: Date;

  @doc("dispositioning the offer")
  @example("Y")
  offer_dispositioned?: string;

  @example("Y")
  campus?: string;

  @doc("Total compensation of the offer (Base + Bonus + Allowes)")
  @example(100000)
  compensation?: integer;

  @example(0)
  non_compete_duration?: integer;

  @example(1)
  supplemental_non_compete_duration?: integer;

  @doc("Exempt/Non-Exempt NY/CA wage forms")
  @example("Exempt")
  flsa_status?: string;

  @doc("Date by when action to be taken on offer")
  respond_by_date?: Date;

  @example(true)
  attorney_only?: boolean;

  @example(true)
  confidential?: boolean;

  @example(true)
  regulated?: boolean;

  @example("Active")
  regulated_status?: string;

  @doc("identify if someone is Senior Manager")
  @example(true)
  smcr?: boolean;

  @example("Job Family")
  job_profile_id?: string;

  @example("Business Unit")
  business_unit_id?: string;

  @example("Department Code")
  department_code?: string;

  @example("Position Type")
  position_type?: string;

  @example("Pay Rate")
  pay_rate?: string;

  @example("Level 1")
  job_level?: string;

  @example("Cost Center")
  cost_center_id?: string;

  @example("Full Time")
  time_type?: string;

  @example("Regular")
  employee_type?: string;

  @example("Engineer")
  job_code?: string;

  @example(10000)
  target_salary?: integer;

  @example(100000)
  max_salary?: integer;

  @example(5000)
  rsu?: integer;

  @example(10)
  annual_bonus_percent?: integer;

  @example(7000)
  signing_bonus_amount?: integer;

  @example(3000)
  commission_amount?: integer;

  @example(1000)
  car_allowance?: integer;

  @example(true)
  relocation?: boolean;

  @example(2000)
  relocation_flex_allowance?: integer;

  @example(false)
  work_from_home?: boolean;

  @example(false)
  immigration?: boolean;

  @example("Clear")
  visa_sponsorship_notes?: string;

  @example(false)
  urgent?: boolean;

  @example(false)
  is_exempt?: boolean;

  @example("Ready to send the offer")
  notes?: string;

  documents?: Document[];
}
