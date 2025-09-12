BEGIN;

CREATE TABLE "users" (
  "id" serial PRIMARY KEY,
  "email" text NOT NULL,
  "hashedPassword" text NOT NULL,
  "createdAt" timestamp without time zone NOT NULL
);

CREATE UNIQUE INDEX "users_email" ON "users" ("email");

COMMIT;
