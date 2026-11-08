namespace Models {
  namespace Task {
    model VideoTask extends UserJourneyTaskBase {
      @example("video")
      "type": string;

      @example("Vimeo")
      title: string;

      @example("Vimeo")
      video_type?: string;

      @example("Vimeo")
      description?: string;

      @example("watched")
      video_completion_type?: string;

      @example("")
      value?: string;

      response_thumbnail?: {
        @example("https://xpand-dev-thumbnails.s3.amazonaws.com/")
        s3_url: string;
      };
    }
  }
}
