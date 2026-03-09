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

  @example("manager@xpand.io")
  manager_email?: email;

  @example("HR 1")
  hr_name?: string;

  @example("+14044578777")
  hr_phone?: string;

  @example("hr@xpand.io")
  hr_email?: email;

  @example(plainDate.fromISO("2021-10-23"))
  start_date?: plainDate;

  @example(plainDate.fromISO("2023-10-23"))
  end_date?: plainDate;

  address?: Address;
  attachments?: Attachment[];
}
