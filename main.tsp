import "@typespec/http";
using TypeSpec.Http;

@service({
  title: "Xpand",
})
@route("/api/v1")
namespace API {
  @format("uuid")
  scalar uuid extends string;

  @format("email")
  scalar email extends string;

  @tag("Users")
  @route("/users")
  namespace Users {
    @summary("Fetch & search users Pass the query in 'filters' parameters using ids and emails.")
    op list(
      @query filter?: {
        @doc("Comma separated list of Xpand User IDs")
        ids?: uuid[];

        @doc("Comma separated list of User Emails")
        emails?: email[];
      },
      @query page?: integer = 1,
    ): {
      data: UserResponseFull[];
    };

    @summary("Create a user")
    @post
    op create(
      @body content: {
        data: {
          attributes: UserRequest;
        };
      },
    ): {
      data: UserResponseSimple;
    };

    @summary("Fetch a user")
    op read(@path id: uuid): {
      data: UserResponseFull;
    };

    @summary("Update a user")
    @patch
    op update(@path id: uuid, @body content: UserRequest): {
      data: UserResponseSimple;
    };
  }

  @tag("Offers")
  @route("/offer_letters")
  namespace Offers {
    @summary("Fetch & search offer letters. Pass the query in 'filters' parameters using ids, offer_ids, user_ids and statuses.")
    op list(
      @query filters?: {
        @doc("Comma separated list of Xpand Offer IDs")
        ids?: uuid[];

        @doc("Comma separated list of Client Offer IDs")
        offer_ids?: uuid[];

        @doc("Comma separated list of Xpand User IDs")
        user_ids?: uuid[];

        @doc("Comma separated list of Offer Statuses")
        statuses?: (
          | "pending_initiation"
          | "pending_approval"
          | "admin_approved"
          | "admin_rejected"
          | "candidate_pending"
          | "candidate_accepted"
          | "candidate_declined"
          | "rescinded"
          | "voided")[];
      },
      @query page?: integer = 1,
    ): {
      data: OfferLetterResponseFull[];
    };

    @summary("Create or update an offer letter")
    @post
    op create(
      @body content: {
        data: {
          attributes: OfferLetterRequest;
        };
      },
    ): {
      data: OfferLetterResponseSimple;
    };

    @summary("Rescind an offer letter")
    @delete
    op delete(@path id: uuid): void;
  }

  @tag("References")
  @route("/references")
  namespace References {
    @post
    op create(): void;

    @route("/job_profiles")
    op job_profiles(): void;

    @route("/office_locations")
    op office_locations(): void;
  }

  model Address {
    line_1?: string;
    line_2?: string;
    line_3?: string;
    city: string;
    state?: string;
    postal_code?: string;
    country: string;
    current?: boolean;
    permanent?: boolean;
    start_date?: plainDate;
    end_date?: plainDate;
  }

  model Attachment {
    file_name?: string;
    file_content_base64?: bytes;

    @doc("Responses provided in PDF form fields (only present when attachment is a PDF with form fields)")
    responses?: {
      field_name_1?: string;
      field_name_2?: string;
    };
  }

  model Document {
    document_type?: string;
    document_number?: string;
    document_title?: string;
    document_description?: string;
    issuer?: string;
    issuer_city?: string;
    issuer_state?: string;
    issuer_country?: string;
    issued_date?: plainDate;
    expiry_date?: plainDate;
    attachments?: Attachment[];
  }

  model Education {
    school_name?: string;
    degree?: string;
    student_id?: string;
    time_type?: string;
    major?: string;
    minor?: string;
    gpa?: float32;
    specialization?: string;
    graduation_date?: plainDate;
    grade?: string;
    name_while_attending?: string;
    start_date?: plainDate;
    end_date?: plainDate;
    address?: Address;
    attachments?: Attachment[];
  }

  model OfferLetterRequest {
    user_id: uuid;
    offer_id: string;
    job_application_id: string;
    office_location_id: {
      workday: string;
    };
    start_date: plainDate;
    legal_entity?: string;
    job_title?: string;
    currency?: string;
    base_salary?: integer;
    end_date?: plainDate;
    induction_date?: plainDate;
    expiration_date?: plainDate;
    offer_dispositioned?: string;
    campus?: string;
    compensation?: integer;
    non_compete_duration?: integer;
    supplemental_non_compete_duration?: integer;
    flsa_status?: string;
    respond_by_date?: plainDate;
    attorney_only?: boolean;
    confidential?: boolean;
    regulated?: boolean;
    regulated_status?: string;
    smcr?: boolean;
    job_profile_id?: string;
    business_unit_id?: string;
    department_code?: string;
    position_type?: string;
    pay_rate?: string;
    job_level?: string;
    cost_center_id?: string;
    time_type?: string;
    employee_type?: string;
    job_code?: string;
    target_salary?: integer;
    max_salary?: integer;
    rsu?: integer;
    annual_bonus_percent?: integer;
    signing_bonus_amount?: integer;
    commission_amount?: integer;
    car_allowance?: integer;
    relocation?: boolean;
    relocation_flex_allowance?: integer;
    work_from_home?: boolean;
    immigration?: boolean;
    visa_sponsorship_notes?: string;
    urgent?: boolean;
    is_exempt?: boolean;
    notes?: string;
    documents?: Document[]
  }

  model OfferLetterResponseFull {
    id: uuid;
    ...OfferLetterRequest;
  }

  model OfferLetterResponseSimple {
    id: uuid;
  }

  model PhoneNumber {
    @doc("E.164 Format")
    number?: string;

    type?: "mobile" | "landline" | "unknown";
    primary?: boolean;
  }

  model UserRequest {
    email: email;
    work_email?: email;
    first_name: string;
    last_name: string;
    middle_name?: string;
    start_date: plainDate;
    employee_type: string;
    candidate_status: string;
    legal_entity?: string;
    cost_center_id: string;
    relocation_type?: string;
    blocked?: boolean;
    reason_blocked?: string;
    external_ids: {
      ats_id?: string;
      hris_id?: string;
    };
    office_location_id: {
      workday: string;
    };
    recruiter_ids: {
      recruiter?: {
        hris_id?: string;
      };
      recruiting_coordinator?: {
        hris_id?: string;
      };
      recruiting_manager?: {
        hris_id?: string;
      };
    };
    manager_ids?: {
      hris_id?: string[];
    };
    documents?: Document[];
    educations?: Education[];
    work_experiences?: WorkExperience[];
    addresses?: Address[];
    phone_numbers?: PhoneNumber[];
  }

  model UserResponseFull {
    id: uuid;
    first_name: string;
    last_name: string;
    email: email;
    start_date: plainDate;
    external_ids: {
      ats_id?: string;
      hris_id?: string;
    };
    office_location_id: {
      workday: string;
    };
    recruiter_ids: {
      recruiter?: {
        hris_id?: string;
      };
      recruiting_coordinator?: {
        hris_id?: string;
      };
      recruiting_manager?: {
        hris_id?: string;
      };
    };
    manager_ids?: {
      hris_id?: string[];
    };
    documents?: Document[];
    educations?: Education[];
    work_experiences?: WorkExperience[];
    addresses?: Address[];
    phone_numbers?: PhoneNumber[];
  }

  model UserResponseSimple {
    id: uuid;
  }

  model WorkExperience {
    employer?: string;
    employee_id?: string;
    current?: boolean;
    job_title?: string;
    department?: string;
    employment_type?: string;
    reason_for_leaving?: string;
    salary?: integer;
    manager_name?: string;
    manager_phone?: string;
    manager_email?: email;
    hr_name?: string;
    hr_phone?: string;
    hr_email?: email;
    start_date?: plainDate;
    end_date?: plainDate;
    address?: Address;
    attachments?: Attachment[];
  }
}
