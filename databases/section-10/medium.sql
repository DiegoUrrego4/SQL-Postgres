CREATE TABLE "users"
(
    "user_id"    INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    "username"   VARCHAR UNIQUE NOT NULL,
    "email"      VARCHAR UNIQUE NOT NULL,
    "password"   VARCHAR        NOT NULL,
    "name"       VARCHAR        NOT NULL,
    "role"       VARCHAR        NOT NULL,
    "gender"     VARCHAR(10)    NOT NULL,
    "avatar"     VARCHAR,
    "created_at" TIMESTAMP DEFAULT 'now()'
);

CREATE TABLE "posts"
(
    "post_id"    INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    "title"      VARCHAR(200) DEFAULT '',
    "body"       TEXT         DEFAULT '',
    "og_image"   VARCHAR,
    "slug"       VARCHAR UNIQUE NOT NULL,
    "published"  BOOLEAN,
    "created_by" INTEGER,
    "created_at" TIMESTAMP    DEFAULT 'now()'
);

CREATE TABLE "claps"
(
    "clap_id"    INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    "post_id"    INTEGER,
    "user_id"    INTEGER,
    "counter"    INTEGER DEFAULT 0,
    "created_at" TIMESTAMP
);

CREATE TABLE "comments"
(
    "comment_id"        INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    "post_id"           INTEGER,
    "user_id"           INTEGER,
    "content"           TEXT,
    "created_at"        TIMESTAMP,
    "visible"           BOOLEAN,
    "comment_parent_id" INTEGER
);

CREATE TABLE "user_lists"
(
    "user_list_id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    "user_id"      INTEGER,
    "title"        VARCHAR(100)
);

CREATE TABLE "user_list_entry"
(
    "user_list_entry" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    "user_list_id"    INTEGER,
    "post_id"         INTEGER
);

CREATE UNIQUE INDEX ON "claps" ("post_id", "user_id");

CREATE INDEX ON "claps" ("post_id");

CREATE INDEX ON "comments" ("post_id");

CREATE INDEX ON "comments" ("visible");

CREATE UNIQUE INDEX ON "user_lists" ("user_id", "title");

CREATE INDEX ON "user_lists" ("user_id");

ALTER TABLE "posts"
    ADD FOREIGN KEY ("created_by") REFERENCES "users" ("user_id");

ALTER TABLE "claps"
    ADD FOREIGN KEY ("post_id") REFERENCES "posts" ("post_id");

ALTER TABLE "claps"
    ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "comments"
    ADD FOREIGN KEY ("comment_id") REFERENCES "posts" ("post_id");

ALTER TABLE "comments"
    ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "comments"
    ADD FOREIGN KEY ("comment_parent_id") REFERENCES "comments" ("comment_id");

ALTER TABLE "user_lists"
    ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "user_list_entry"
    ADD FOREIGN KEY ("user_list_id") REFERENCES "user_lists" ("user_list_id");

ALTER TABLE "user_list_entry"
    ADD FOREIGN KEY ("post_id") REFERENCES "posts" ("post_id");
