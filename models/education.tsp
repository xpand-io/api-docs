model Education {
  @example("School Name")
  school_name?: string;

  @example("Degree")
  degree?: string;

  @example("1001")
  student_id?: string;

  @example("Full Time")
  time_type?: string;

  @example("Communications")
  major?: string;

  @example("Publications")
  minor?: string;

  @example(4.0)
  gpa?: float32;

  @example("IT")
  specialization?: string;

  @example(plainDate.fromISO("2021-10-23"))
  graduation_date?: plainDate;

  @example("A")
  grade?: string;

  @example("Jon Doe")
  name_while_attending?: string;

  @example(plainDate.fromISO("2021-10-23"))
  start_date?: plainDate;

  @example(plainDate.fromISO("2023-10-23"))
  end_date?: plainDate;

  address?: Address;
  attachments?: Attachment[];
}
