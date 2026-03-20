import "@typespec/http";
import "@typespec/openapi";

import "./scalars.tsp";
import "./enums.tsp";
import "./errors.tsp";
import "./models";
import "./requests";
import "./responses";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

@service(#{ title: "Xpand API" })
@info(#{ version: "2025-03" })
@useAuth(BearerAuth)
@route("/api")
namespace API {
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
      data: Responses.UserList[];
    };

    @summary("Fetch User")
    @doc("Fetch a User")
    op show(@path id: UUID): {
      data: Responses.UserShow;
    };

    @summary("Create User")
    @doc("Create a User")
    op create(
      @body body: {
        data: {
          attributes: Requests.UserUpsert;
        };
      },
    ): {
      data: Responses.UserCreate;
    };

    @summary("Update User")
    @doc("Update a User")
    @patch(#{ implicitOptionality: true })
    op update(
      @path id: UUID,
      @body body: {
        data: {
          attributes: Requests.UserUpsert;
        };
      },
    ): {
      data: Responses.UserUpdate;
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

        @doc("Comma separated list of transition types")
        @example("pre_offer, offer, post_offer, onboarding, offboarding")
        transition_type?: string;

        @example(true)
        published?: boolean;
      },
      @query offset?: integer = 0,
      @query limit?: integer = 50,
      @query order_by?: string = "created_at",
      @query direction?: string = "asc",
    ): {
      @statusCode statusCode: 200;
      @body body: Responses.JourneyList[];
    };

    @summary("Fetch Journey")
    @doc("Fetch a Journey")
    op show(@path id: UUID): {
      @statusCode statusCode: 200;
      @body body: Responses.JourneyShow;
    } | {
      @statusCode statusCode: 404;
      @body error: Errors.NotFoundError;
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

        @doc("Comma separated list of transition types")
        @example("pre_offer, offer, post_offer, onboarding, offboarding")
        transition_type?: string;

        @doc("Comma separated list of states")
        @example("draft, needs_attention, pending_approval, approved, rejected, rescinded, user_pending, submitted, declined, completed, voided")
        state?: string;

        custom_fields?: {
          key1?: string;
          key2?: string;
        };
      },
      @query offset?: integer = 0,
      @query limit?: integer = 50,
      @query order_by?: string = "created_at",
      @query direction?: string = "asc",
    ): {
      @statusCode statusCode: 200;
      @body body: Responses.UserJourneyList[];
    };

    @route("/{id}/tasks")
    @summary("Fetch Tasks for a User Journey")
    op tasks(@path id: string): {
      @statusCode statusCode: 200;
      @body body: Models.Task.UserJourneyTask[];
    } | {
      @statusCode statusCode: 404;
      @body error: Errors.NotFoundError;
    };

    @summary("Fetch User Journey")
    @doc("Fetch a User Journey")
    op show(@path id: UUID): {
      @statusCode statusCode: 200;
      @body body: Responses.UserJourneyShow;
    } | {
      @statusCode statusCode: 404;
      @body error: Errors.NotFoundError;
    };

    @summary("Create User Journey")
    @doc("Create a User Journey")
    op create(@body body: Requests.UserJourneyCreate): {
      @statusCode statusCode: 201;
      @body body: Responses.UserJourneyCreate;
    } | {
      @statusCode statusCode: 422;
      @body error: Errors.ValidationError;
    };

    @summary("Update User Journey")
    @doc("Update a User Journey. Cannot update User Journeys with a Voided or Rescinded state")
    @patch(#{ implicitOptionality: true })
    op update(@path id: UUID, @body body: Requests.UserJourneyUpdate): {
      @statusCode statusCode: 200;
      @body body: Responses.UserJourneyUpdate;
    } | {
      @statusCode statusCode: 404;
      @body error: Errors.NotFoundError;
    } | {
      @statusCode statusCode: 422;
      @body error: Errors.ValidationError;
    };

    @route("/{id}/rescind")
    @doc("Rescind a single user journey by ID. This operation uses rescind_reason only.")
    @summary("Rescind Single User Journey")
    @patch(#{ implicitOptionality: false })
    op rescind(
      @path id: UUID,
      @body body: Requests.UserJourneyRescind,
    ): {
      @doc("No body. Success response for rescind operations.")
      @statusCode statusCode: 204;
    } | {
      @statusCode statusCode: 401;
    } | {
      @statusCode statusCode: 404;
      @body error: Errors.NotFoundError;
    } | {
      @statusCode statusCode: 422;
      @body error: Errors.ValidationError;
    };

    @route("/rescind")
    @doc("Rescind all rescindable journeys for a user, optionally filtered by transition type. transition_type accepts a comma-separated list and spaces after commas are allowed.")
    @summary("Rescind Multiple User Journeys")
    @patch(#{ implicitOptionality: false })
    op rescindMultiple(
      @body body: Requests.UserJourneyRescindMultiple,
    ): {
      @doc("No body. Success response for rescind operations.")
      @statusCode statusCode: 204;
    } | {
      @statusCode statusCode: 401;
    } | {
      @statusCode statusCode: 404;
      @body error: Errors.NotFoundError;
    } | {
      @statusCode statusCode: 422;
      @body error: Errors.ValidationError;
    };
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

        @doc("Comma separated list of Transition Types")
        @example("pre_offer, offer, post_offer, onboarding, offboarding")
        transition_type?: string;

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
      @body body: Responses.CustomFieldList[];
    };

    @summary("Fetch Custom Field")
    @doc("Fetch a Custom Field")
    op show(@path id: UUID): {
      @statusCode statusCode: 200;
      @body body: Responses.CustomFieldShow;
    } | {
      @statusCode statusCode: 404;
      @body error: Errors.NotFoundError;
    };

    @summary("Create Custom Field")
    @doc("Creates a new custom field that can be used in user journeys or forms.")
    op create(@body body: Requests.CustomFieldCreate): {
      @statusCode statusCode: 201;
      @body body: Responses.CustomFieldCreate;
    } | {
      @statusCode statusCode: 422;
      @body error: Errors.ValidationError;
    };

    @route("/{id}/activate")
    @summary("Activate Custom Field")
    @doc("Activates a custom field.")
    @patch
    op activate(@path id: UUID): {
      @statusCode statusCode: 200;
    };

    @route("/{id}/deactivate")
    @summary("Deactivate Custom Field")
    @doc("Deactivates a custom field. This will not delete the custom field, but will make it inactive. Once deactivated it cannot be used in the Create User Journey API")
    @patch
    op deactivate(@path id: UUID): {
      @statusCode statusCode: 200;
    };
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

  #deprecated "Use Journeys"
  @tag("Offers (Deprecated)")
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
      data: Responses.OfferLetterList[];
    };

    @summary("Create/Update Offer Letter")
    @doc("Create/Update Offer Letter - Create or update an offer letter.")
    op create(
      @body body: {
        data: {
          attributes: Requests.OfferLetterUpsert;
        };
      },
    ): {
      data: Responses.OfferLetterCreate;
    };

    @summary("Rescind Offer Letter")
    @doc("Rescind an offer letter.")
    @delete
    op delete(@path id: UUID): void;
  }
}
