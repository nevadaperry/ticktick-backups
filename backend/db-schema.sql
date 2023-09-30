CREATE TABLE "user" (
	id bigserial,
	email text NOT NULL,
	deleted boolean NOT NULL DEFAULT false
);
CREATE UNIQUE INDEX user_email ON "user" (email);

CREATE TABLE user_payment (
	id bigserial,
	user_id bigint NOT NULL REFERENCES "user" (id) ON DELETE RESTRICT,
	timestamp timestamptz NOT NULL,
	reference_code text NOT NULL
);
CREATE INDEX user_thing_user_id ON user_thing (user_id);

CREATE TABLE sync (
	id bigserial,
	user_id bigint NOT NULL REFERENCES "user" (id) ON DELETE RESTRICT,
	auth_code text NOT NULL,
	deleted boolean NOT NULL DEFAULT false,
	period bigint NOT NULL,
);
CREATE INDEX sync_user_id ON sync (user_id);

CREATE TABLE sync_run (
	id bigserial,
	sync_id bigint NOT NULL REFERENCES sync (id) ON DELETE RESTRICT,
	started_at timestamptz NOT NULL,
	responsible_worker text NOT NULL,
	log text NOT NULL DEFAULT '',
	updated_at timestamptz NOT NULL,
	failed_at timestamptz,
	succeeded_at timestamptz,
	CONSTRAINT sync_run_nand_failed_at_succeeded_at (
		failed_at IS NULL OR succeeded_at IS NULL
	)
);
CREATE INDEX sync_run_sync_id_timestamp ON sync (sync_id, timestamp);
CREATE UNIQUE INDEX sync_run_sync_id_where_in_flight ON sync_run (sync_id)
	WHERE failed_at IS NULL AND succeeded_at IS NULL;
