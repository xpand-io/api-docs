namespace Models {
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

    graduation_date?: Date;

    @example("A")
    grade?: string;

    @example("Jon Doe")
    name_while_attending?: string;

    start_date?: Date;
    end_date?: Date;
    address?: Models.Address;
    attachments?: Models.Attachment[];
  }
}
