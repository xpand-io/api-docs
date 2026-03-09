namespace Models {
  model WorkExperience {
    @example("Employer")
    employer?: string;

    @example("E1234")
    employee_id?: string;

    @example(true)
    current?: boolean;

    @example("Engineer")
    job_title?: string;

    @example("Department")
    department?: string;

    @example("Regular")
    employment_type?: string;

    @example("Change in technology")
    reason_for_leaving?: string;

    @example(10000)
    salary?: integer;

    @example("Manager 1")
    manager_name?: string;

    @example("+14044578776")
    manager_phone?: string;

    manager_email?: Email;

    @example("HR 1")
    hr_name?: string;

    @example("+14044578777")
    hr_phone?: string;

    hr_email?: Email;
    start_date?: Date;
    end_date?: Date;
    address?: Models.Address;
    attachments?: Models.Attachment[];
  }
}
