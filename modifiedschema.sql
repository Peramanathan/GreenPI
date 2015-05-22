CREATE TABLE access_tokens
(
  id character varying NOT NULL,
  ttl integer,
  created timestamp with time zone,
  CONSTRAINT access_tokens_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE access_tokens
  OWNER TO postgres;

CREATE TABLE acls
(
  id serial NOT NULL,
  model character varying(1024),
  property character varying(1024),
  accesstype character varying(1024),
  permission character varying(1024),
  principaltype character varying(1024),
  principalid character varying(1024),
  CONSTRAINT acls_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE acls
  OWNER TO postgres;

CREATE TABLE household_timeseries
(
  household_id integer NOT NULL,
  pointintime timestamp without time zone NOT NULL,
  temperature real,
  consumption real,
  cost real,
  CONSTRAINT household_timeseries_pkey PRIMARY KEY (household_id, pointintime),
  CONSTRAINT household_timeseries_household_id_fkey FOREIGN KEY (household_id)
      REFERENCES households (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE household_timeseries
  OWNER TO postgres;

CREATE TABLE households
(
  id serial NOT NULL,
  address character varying NOT NULL,
  postal_code integer,
  CONSTRAINT households_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE households
  OWNER TO postgres;


CREATE TABLE role_mappings
(
  id serial NOT NULL,
  principaltype character varying(1024),
  principalid character varying(1024),
  CONSTRAINT role_mappings_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE role_mappings
  OWNER TO postgres;


CREATE TABLE roles
(
  id serial NOT NULL,
  name character varying(1024) NOT NULL,
  description character varying(1024),
  created timestamp with time zone,
  modified timestamp with time zone,
  CONSTRAINT roles_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE roles
  OWNER TO postgres;


CREATE TABLE user_household
(
  user_id integer NOT NULL,
  household_id integer NOT NULL,
  CONSTRAINT user_household_pkey PRIMARY KEY (user_id, household_id),
  CONSTRAINT user_household_household_id_fkey FOREIGN KEY (household_id)
      REFERENCES households (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT user_household_user_id_fkey FOREIGN KEY (user_id)
      REFERENCES users (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE user_household
  OWNER TO postgres;
  
  
 
CREATE TABLE users
(
  id serial NOT NULL,
  username character varying NOT NULL,
  password character varying NOT NULL,
  email character varying NOT NULL,
  accesstoken character varying,
  realm character varying(1024),
  credentials character varying(1024),
  challenges character varying(1024),
  emailverified boolean,
  verificationtoken character varying(1024),
  status character varying(1024),
  created timestamp with time zone,
  lastupdated timestamp with time zone,
  userid integer,
  userhouseholdid integer,
  CONSTRAINT users_pkey PRIMARY KEY (id),
  CONSTRAINT users_email_key UNIQUE (email),
  CONSTRAINT users_username_key UNIQUE (username)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE users
  OWNER TO postgres;



