import "@typespec/http";
import "@typespec/openapi";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

@service(#{ title: "Xpand API" })
@info(#{ version: "2025-03" })
@useAuth(BearerAuth)
@route("/api")
namespace API {
  //
  // Operations
  //

  @tag("Users")
  @route("/v1/users")
  namespace Users {
    @summary("Search Users")
    @doc("Search Users - Users are the people who are part of the Xpand system.")
    op list(
      @query filter?: {
        @doc("Comma separated list of Xpand User IDs")
        @example("64891c74d5ee1bb16dfdafd8,64891e2ad5ee1bb16dfdafd9")
        ids?: string;

        @doc("Comma separated list of User Emails")
        @example("john@example.com,jane@example.com")
        emails?: string;
      },
      @query page?: integer = 1,
    ): {
      data: UserResponseFull[];
    };

    @summary("Fetch User")
    @doc("Fetch a User")
    op show(@path id: uuid): {
      data: UserResponseFull;
    };

    @summary("Create User")
    @doc("Create a User")
    op create(
      @body content: {
        data: {
          attributes: UserRequest;
        };
      },
    ): {
      data: UserResponseSimple;
    };

    @summary("Update User")
    @doc("Update a User")
    @patch
    op update(@path id: uuid, @body content: UserRequest): {
      data: UserResponseSimple;
    };
  }

  @tag("Offers")
  @route("/v1/offer_letters")
  namespace Offers {
    @summary("Search Offer Letters")
    @doc("Search Offer Letters - Offer Letters are the letters that are sent to candidates.")
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
    @doc("Create/Update Offer Letter - Create or update an offer letter.")
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
    @doc("Rescind an offer letter.")
    @delete
    op delete(@path id: uuid): void;
  }

  @tag("References")
  namespace References {
    @summary("Fetch Job Profiles")
    @doc("Fetch a Job Profile")
    @route("/v1/job_profiles")
    op job_profiles(): void;

    @summary("Fetch Office Locations")
    @doc("Fetch Office Locations")
    @route("/v1/office_locations")
    op office_locations(): void;
  }

  @tag("Custom Fields")
  @route("/v2/custom_fields")
  namespace CustomFields {
    @summary("Search Custom Fields")
    @doc("Lists custom fields that can be used in user journeys or forms. Custom fields help capture metadata unique to your organization.")
    op list(
      @query filters?: {
        @doc("Comma separated list of Custom Field IDs")
        @example("1234,123456")
        id?: string;

        @doc("Comma separated list of Journey Types")
        @example("pre_offer, offer, post_offer, onboarding, offboarding")
        sub_type?: string;

        @doc("Comma separated list of Data Types")
        @example("string, integer, big_decimal, array, hash, time, date, boolean")
        data_type?: string;

        @doc("Comma separated list of Active")
        @example("true, false")
        active?: string;
      },
      @query offset?: integer = 0,
      @query limit?: integer = 50,
      @query order_by?: string = "created_at",
      @query direction?: string = "asc",
    ): {
      @statusCode statusCode: 200;
      @body customFields: CustomField[];
    };

    @summary("Fetch Custom Field")
    @doc("Fetch a Custom Field")
    op show(@path id: string): {
      @statusCode statusCode: 200;
      @body customField: CustomField;
    } | {
      @statusCode statusCode: 404;
      @body error: NotFoundError;
    };

    @summary("Create Custom Field")
    @doc("Creates a new custom field that can be used in user journeys or forms.")
    op create(@body customField: CustomFieldCreate): {
      @statusCode statusCode: 201;
      @body newCustomField: CustomField;
    } | {
      @statusCode statusCode: 422;
      @body error: ValidationError;
    };

    @route("/{id}/activate")
    @summary("Activate Custom Field")
    @doc("Activates a custom field.")
    @patch
    op activate(@path id: string): {
      @statusCode statusCode: 200;
    };

    @route("/{id}/deactivate")
    @summary("Deactivate Custom Field")
    @doc("Deactivates a custom field. This will not delete the custom field, but will make it inactive.")
    @patch
    op deactivate(@path id: string): {
      @statusCode statusCode: 200;
    };
  }

  @tag("Journeys")
  @route("/v2/journeys")
  namespace Journeys {
    @summary("Search Journeys")
    @doc("Search Journeys - Journeys are the templates that can be used to create user journeys.")
    op list(
      @query filters?: {
        @doc("Comma separated list of title")
        @example("Offer, Next Offer")
        title?: string;

        @doc("Comma separated list of journey types")
        @example("pre_offer, offer, post_offer, onboarding, offboarding")
        journey_type?: string;

        @example(true)
        published?: boolean;
      },
      @query offset?: integer = 0,
      @query limit?: integer = 50,
      @query order_by?: string = "created_at",
      @query direction?: string = "asc",
    ): {
      @statusCode statusCode: 200;
      @body body: Journey[];
    };

    @summary("Fetch Journey")
    @doc("Fetch a Journey")
    op show(@path id: string): {
      @statusCode statusCode: 200;
      @body body: Journey;
    } | {
      @statusCode statusCode: 404;
      @body error: NotFoundError;
    };
  }

  @tag("User Journeys")
  @route("/v2/user_journeys")
  namespace UserJourneys {
    @summary("Search User Journeys")
    @doc("Search User Journeys - User Journeys are the journeys that are assigned to a user.")
    op list(
      @query filters?: {
        @doc("Comma separated list of User IDs")
        @example("64891c74d5ee1bb16dfdafd8,64891e2ad5ee1bb16dfdafd9")
        user_id?: string;

        @doc("Comma separated list of Journey IDs")
        @example("64891c74d5ee1bb16dfdafd8,64891e2ad5ee1bb16dfdafd9")
        journey_id?: string;

        @doc("Comma separated list of Office Location IDs")
        @example("64891c74d5ee1bb16dfdafd8,64891e2ad5ee1bb16dfdafd9")
        office_location_id?: string;

        @doc("Comma separated list of journey types")
        @example("pre_offer, offer, post_offer, onboarding, offboarding")
        journey_type?: string;

        @doc("Comma separated list of states")
        @example("draft, needs_attention, pending_approval, approved, rejected, rescinded, user_pending, submitted, declined, completed")
        state?: string;

        custom_fields?: CustomFieldsValueObject;
      },
      @query offset?: integer = 0,
      @query limit?: integer = 50,
      @query order_by?: string = "created_at",
      @query direction?: string = "asc",
    ): {
      @statusCode statusCode: 200;
      @body body: UserJourney[];
    };

    @summary("Fetch User Journey")
    @doc("Fetch a User Journey")
    op show(@path id: string): {
      @statusCode statusCode: 200;
      @body body: UserJourney;
    } | {
      @statusCode statusCode: 404;
      @body error: NotFoundError;
    };

    @summary("Create User Journey")
    @doc("Create a User Journey")
    op create(@body userJourney: UserJourneyCreate): {
      @statusCode statusCode: 201;
      @body body: UserJourney;
    } | {
      @statusCode statusCode: 422;
      @body error: ValidationError;
    };

    @summary("Update User Journey")
    @doc("Update a User Journey")
    @patch
    op update(@path id: string, @body userJourney: UserJourneyUpdate): {
      @statusCode statusCode: 200;
      @body body: UserJourney;
    } | {
      @statusCode statusCode: 404;
      @body error: NotFoundError;
    } | {
      @statusCode statusCode: 422;
      @body error: ValidationError;
    };

    @route("/{id}/rescind")
    @doc("Rescind User Journey")
    @summary("Rescind User Journey")
    @delete
    op rescind(
      @path id: string,
      @body body: {
        rescind_reason: string;
      },
    ): {
      @statusCode statusCode: 204;
    } | {
      @statusCode statusCode: 404;
      @body error: NotFoundError;
    } | {
      @statusCode statusCode: 422;
      @body error: ValidationError;
    };
  }

  //
  // Models
  //

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

  model CustomField {
    @example("12345")
    id: string;

    @example("offer")
    journey_type: string;

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
  model CustomFieldCreate {
    @example("offer")
    journey_type: string;

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

  model CustomFieldsValueObject {
    @example("1234")
    id: string;

    @example("custom field value")
    value: string;

    @example("custom field name")
    name: string;

    @example("1234")
    key: string;
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

  model Journey {
    @example("12345")
    id: string;

    @example("Offer")
    title: string;

    @example("offer")
    journey_type: string;

    @example("unpublished, published, draft")
    publishing_state: string;

    @example("2025/01/01")
    created_at: string;
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

  model OfficeLocationId {
    @example("LOCATION-3-69")
    workday?: string;

    @example("LOCATION-3-69")
    id: string;

    external_ids: {
      @example("E-1234")
      hris_id?: string;
    };

    @example("123 Main St")
    address1?: string;

    @example("Suite 200")
    address2?: string;

    @example("Building B")
    address3?: string;

    @example("New York")
    city?: string;

    @example("NY")
    state?: string;

    @example("Northeast")
    region?: string;

    @example("USA")
    country?: string;

    @example("10001")
    postal_code?: string;

    @example("NZT")
    time_zone?: string;

    @example(3.12332)
    latitude?: float32;

    @example(3.12332)
    longitude?: float32;
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

  model UserJourney {
    @example("123456898")
    id: string;

    @example("123456")
    journey_id: string;

    @example("pre_offer")
    journey_type?: string;

    @example("123456")
    user_id?: string;

    @example(UserJourneyState.approved)
    state?: UserJourneyState;

    @example("2025-01-01")
    created_at?: string;

    office_location?: OfficeLocationId;

    @doc("Custom fields object for the user journey - we pass the key for any configured custom fields for this journey type.")
    custom_field_values?: CustomFieldsValueObject;
  }

  model UserJourneyCreate {
    @example("123456")
    journey_id: string;

    @example("pre_offer")
    journey_type?: string;

    @example("123456")
    user_id?: string;

    @example(UserJourneyState.approved)
    state?: UserJourneyState;

    @example("2025-01-01")
    created_at?: string;

    office_location_id?: OfficeLocationId;

    @doc("Custom fields object for the user journey - we pass the key for any configured custom fields for this journey type.")
    custom_fields?: CustomFieldsValueObject;

    documents?: Document[];
  }

  model UserJourneyUpdate {
    @example("123456")
    journey_id: string;

    @example(UserJourneyState.approved)
    state?: UserJourneyState;

    @example("2025-01-01")
    created_at?: string;

    office_location_id?: OfficeLocationId;

    @doc("Custom fields object for the user journey - we pass the key for any configured custom fields for this journey type.")
    custom_fields?: CustomFieldsValueObject;

    documents?: Document[];
  }

  model UserJourneyQueryData {
    @example("12345")
    id?: string;

    @example("1234")
    user_id?: string;

    @example(UserJourneyState.draft)
    state?: UserJourneyState;

    custom_fields?: CustomFieldsValueObject;
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

  //
  // Enums
  //

  enum UserJourneyState {
    draft: "draft",
    needs_attention: "needs_attention",
    pending_approval: "pending_approval",
    approved: "approved",
    rejected: "rejected",
    rescinded: "rescinded",
    user_pending: "user_pending",
    submitted: "submitted",
    declined: "declined",
    completed: "completed",
  }
}

//
// Scalars
//

@format("uuid")
scalar uuid extends string;

@format("email")
scalar email extends string;

//
// Errors
//

@error
model NotFoundError {
  code: "NOT_FOUND";
  message: string;
}

@error
model ValidationError {
  code: "VALIDATION_ERROR";
  message: string;
  details: string[];
}
