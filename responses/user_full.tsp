model UserResponseFull {
  @example("64891c74d5ee1bb16dfdafd8")
  id: UUID;

  @example("John")
  first_name: string;

  @example("Doe")
  last_name: string;

  email: Email;
  start_date: Date;
  external_ids: {
    @example("A-1234")
    ats_id?: string;

    @example("E-1234")
    hris_id?: string;
  };
  office_location_id: {
    @example("LOCATION-3-69")
    workday?: string;
  };
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
