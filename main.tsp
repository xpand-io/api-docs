import "@typespec/http";
using TypeSpec.Http;

@service({
  title: "Xpand API",
  version: "v2",
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
    @summary("Search Users")
    op list(
      @query filter?: {
        @doc("Comma separated list of Xpand User IDs")
        @example("john@example.com,jane@example.com")
        ids?: string;

        @doc("Comma separated list of User Emails")
        @example("64891c74d5ee1bb16dfdafd8,64891e2ad5ee1bb16dfdafd9")
        emails?: string;
      },
      @query page?: integer = 1,
    ): {
      data: UserResponseFull[];
    };

    @summary("Create User")
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

    @summary("Fetch User")
    op read(@path id: uuid): {
      data: UserResponseFull;
    };

    @summary("Update User")
    @patch
    op update(@path id: uuid, @body content: UserRequest): {
      data: UserResponseSimple;
    };
  }

  @tag("Offers")
  @route("/offer_letters")
  namespace Offers {
    @summary("Search Offer Letters")
    op list(
      @query filters?: {
        @doc("Comma separated list of Xpand Offer IDs")
        @example("64891c74d5ee1bb16dfdafd8,64891e2ad5ee1bb16dfdafd9")
        ids?: string;

        @doc("Comma separated list of Client Offer IDs")
        @example("64891c74d5ee1bb16dfdafd8,64891e2ad5ee1bb16dfdafd9")
        offer_ids?: string;

        @doc("Comma separated list of Xpand User IDs")
        @example("64891c74d5ee1bb16dfdafd8,64891e2ad5ee1bb16dfdafd9")
        user_ids?: string;

        @doc("Comma separated list of Offer Statuses")
        // @example("pending_initiation,pending_approval")
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

    @summary("Create/Update Offer Letter")
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

    @summary("Rescind Offer Letter")
    @delete
    op delete(@path id: uuid): void;
  }

  @tag("References")
  namespace References {
    @summary("Fetch Job Profiles")
    @route("/job_profiles")
    op job_profiles(): void;

    @summary("Fetch Office Locations")
    @route("/office_locations")
    op office_locations(): void;
  }

  model Address {
    @example("31 St, 34 West")
    line_1?: string;

    @example("8th Avenue")
    line_2?: string;

    line_3?: string;

    @example("New York")
    city: string;

    @example("New York")
    state?: string;

    @example("100018")
    postal_code?: string;

    @example("USA")
    country: string;

    @example(true)
    current?: boolean;

    @example(true)
    permanent?: boolean;

    @example(plainDate.fromISO("2021-10-23"))
    start_date?: plainDate;

    @example(plainDate.fromISO("2023-10-23"))
    end_date?: plainDate;
  }

  model Attachment {
    @example("abc.pdf")
    file_name?: string;

    @example("SGVsbG8gdGhlcmUgOi0pIEZpbmQgYW55dGhpbmcgZXhjaXRpbmc/")
    file_content_base64?: string;

    @doc("Responses provided in PDF form fields (only present when attachment is a PDF with form fields)")
    responses?: {
      @example("abc")
      field_name_1?: string;

      @example("cba")
      field_name_2?: string;
    };
  }

  model Document {
    @example("offer_letter")
    document_type?: string;

    @example("1234")
    document_number?: string;

    @example("Offer Letter")
    document_title?: string;

    @example("Offer Letter to the Joe")
    document_description?: string;

    @example("Issuer")
    issuer?: string;

    @example("New York")
    issuer_city?: string;

    @example("New York")
    issuer_state?: string;

    @example("USA")
    issuer_country?: string;

    @example(plainDate.fromISO("2021-10-23"))
    issued_date?: plainDate;

    @example(plainDate.fromISO("2023-10-23"))
    expiry_date?: plainDate;

    attachments?: Attachment[];
  }

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

  model OfferLetterRequest {
    @doc("Unique ID of the user")
    @example("64892208d5ee1bb16dfdafda")
    user_id: uuid;

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
    @example(plainDate.fromISO("2023-10-23"))
    start_date: plainDate;

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
    @example(plainDate.fromISO("2023-10-23"))
    end_date?: plainDate;

    @doc("Induction Date")
    @example(plainDate.fromISO("2023-10-23"))
    induction_date?: plainDate;

    @doc("Expiration date of an offer")
    @example(plainDate.fromISO("2023-10-23"))
    expiration_date?: plainDate;

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
    @example(plainDate.fromISO("2023-10-23"))
    respond_by_date?: plainDate;

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

  model OfferLetterResponseFull {
    @example("64891c74d5ee1bb16dfdafd8")
    id: uuid;

    ...OfferLetterRequest;
  }

  model OfferLetterResponseSimple {
    @example("64891c74d5ee1bb16dfdafd8")
    id: uuid;
  }

  model PhoneNumber {
    @doc("E.164 Format")
    @example("+14044580998")
    number?: string;

    @example("mobile")
    type?: "mobile" | "landline" | "unknown";

    @example(true)
    primary?: boolean;
  }

  model UserRequest {
    @doc("Must be a valid email address. Must be unique for each user. Non case-sensitive. Regex validation: ^(?!...)[a-zA-Z0-9][\\w-.]@[A-Za-z\\d-]+(.[A-Za-z\\d-]+)*.[A-Za-z]+$")
    @example("daniel@personal.com")
    email: email;

    @doc("Must be a valid email address. Must be unique for each user. Non case-sensitive. Regex validation: ^(?!...)[a-zA-Z0-9][\\w-.]@[A-Za-z\\d-]+(.[A-Za-z\\d-]+)*.[A-Za-z]+$")
    @example("daniel@company.com")
    work_email?: email;

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
    @example(plainDate.fromISO("2023-09-08"))
    start_date: plainDate;

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

  model UserResponseFull {
    @example("64891c74d5ee1bb16dfdafd8")
    id: uuid;

    @example("John")
    first_name: string;

    @example("Doe")
    last_name: string;

    @example("john@example.com")
    email: email;

    @example(plainDate.fromISO("2023-10-23"))
    start_date: plainDate;

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

  model UserResponseSimple {
    @example("64891c74d5ee1bb16dfdafd8")
    id: uuid;
  }

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
}
