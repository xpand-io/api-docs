model UserRequest {
  @doc("Must be a valid email address. Must be unique for each user. Non case-sensitive. Regex validation: ^(?!...)[a-zA-Z0-9][\\w-.]@[A-Za-z\\d-]+(.[A-Za-z\\d-]+)*.[A-Za-z]+$")
  email: Email;

  @doc("Must be a valid email address. Must be unique for each user. Non case-sensitive. Regex validation: ^(?!...)[a-zA-Z0-9][\\w-.]@[A-Za-z\\d-]+(.[A-Za-z\\d-]+)*.[A-Za-z]+$")
  work_email?: Email;

  @doc("Must not contain numbers or any of the following special characters !@#$%^&*()")
  @example("Daniel")
  first_name: string;

  @doc("Must not contain numbers or any of the following special characters !@#$%^&*()")
  @example("Smith")
  last_name: string;

  @doc("Must not contain numbers or any of the following special characters !@#$%^&*()")
  @example("Jones")
  middle_name?: string;

  @doc("Format: YYYY-MM-DD. Can be present, or future dates only.")
  start_date: Date;

  @doc("See reference values here for allowed employee type values.")
  @example("Regular")
  employee_type: string;

  @doc("See reference values here for allowed candidate status values.")
  @example("offer_accepted")
  candidate_status: string;

  @doc("See reference values here for existing legal entity values.")
  @example("Xpand Limited")
  legal_entity?: string;

  @doc("See reference values here for existing cost center values.")
  @example("Cost Center")
  cost_center_id: string;

  @doc("Allowes the relocation type values.")
  @example("global_relocation")
  relocation_type?: string;

  @doc("Disable or enable a user account in Xpand.")
  @example(false)
  blocked?: boolean;

  @doc("A brief description of why the user why the user account is being disabled in Xpand")
  @example("Inactive in ATS System")
  reason_blocked?: string;

  @doc("This is the collection of unique id of the Applicant Tracking System (ATS) and employee id of the Human Resource Information Systems (HRIS)")
  external_ids: {
    @example("A-1234")
    ats_id?: string;

    @example("E-1234")
    hris_id?: string;
  };

  @doc("JSON where key is name of external service, e.g. {'HRIS_ID': 'NEWYORK'. There must be an office location in Xpand with a matching employee id. See reference values here for existing office location external ids")
  office_location_id: {
    @example("LOCATION-3-69")
    workday?: string;
  };

  @doc("JSON where key is name of external service, e.g. {:recruiter=>{'HRIS_SYS'=>'12345'}, recruiting_manager=>{'HRIS_SYS'=>'56789'}} (There must be a recruiter in Xpand or HRIS_SYS(Ex: workday) with a matching employee id)")
  recruiter_ids: {
    recruiter?: {
      @example("R-1111")
      hris_id?: string;
    };
    recruiting_coordinator?: {
      @example("R-2222")
      hris_id?: string;
    };
    recruiting_manager?: {
      @example("R-3333")
      hris_id?: string;
    };
  };

  @doc("JSON where key is name of external service, e.g. {'HRIS_SYS': ['123456', '45678']} (There must be a manager in Xpand or HRIS with a matching employee id)")
  manager_ids?: {
    @example(#["M-1111", "M-2222"])
    hris_id?: string[];
  };

  documents?: Document[];
  educations?: Education[];
  work_experiences?: WorkExperience[];
  addresses?: Address[];
  phone_numbers?: PhoneNumber[];
}
