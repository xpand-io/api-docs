@format("uuid")
@example("69ae0e64b02bfe73a44ca479")
scalar UUID extends string;

@format("email")
@example("testing@example.com")
scalar Email extends string;

@format("E.164")
@example("+14045558776")
scalar Phone extends string;

@format("iso8601")
@example("2026-02-01T01:02:03Z")
scalar DateTime extends string;

@format("YYYY-MM-DD")
@example("2026-01-01")
scalar Date extends string;

@format("Base64")
@example("WW91J3JlIGEgY3VyaW91cyBmZWxsb3cgOy0p")
scalar Base64 extends string;
