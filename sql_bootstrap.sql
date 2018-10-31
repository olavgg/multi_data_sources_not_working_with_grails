-- CREATE ROLES
CREATE USER boost WITH LOGIN PASSWORD 'boost';
CREATE USER boostqa WITH LOGIN PASSWORD 'boostqa';

-- CREATE DATABASE
CREATE DATABASE adminpanel
  WITH ENCODING='UTF8'
       OWNER=boost
       CONNECTION LIMIT=-1;

-- GRANT ACCESS
GRANT ALL ON DATABASE adminpanel TO boost;
GRANT ALL ON DATABASE adminpanel TO boostqa;

-- Connect to the new database
\connect adminpanel

-- CREATE SCHEMAS
DROP SCHEMA public CASCADE;
CREATE SCHEMA public AUTHORIZATION boost;
CREATE SCHEMA qa AUTHORIZATION boostqa;

-- SET SEARCH PATHS
ALTER USER boost SET search_path=public;
ALTER USER boostqa SET search_path=qa, public;


-- Table: public.language

-- DROP TABLE public.language;

CREATE TABLE public.language
(
    id bigint NOT NULL,
    i18n_code character varying(255) NOT NULL,
    locale_tag character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    CONSTRAINT language_pkey PRIMARY KEY (id)
);


-- Table: public.intent

-- DROP TABLE public.intent;

CREATE TABLE public.intent
(
    id bigint NOT NULL,
    date_created timestamp with time zone NOT NULL,
    deactivated boolean NOT NULL DEFAULT false,
    last_updated timestamp with time zone NOT NULL,
    parent_intent_id bigint,
    CONSTRAINT intent_pkey PRIMARY KEY (id),
    CONSTRAINT fke5h4yihn1924go73vac686e6s FOREIGN KEY (parent_intent_id)
        REFERENCES public.intent (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);


-- Index: intent_deactivated_idx

-- DROP INDEX public.intent_deactivated_idx;

CREATE INDEX intent_deactivated_idx
    ON public.intent USING btree
    (deactivated)
    TABLESPACE pg_default;

-- Index: intent_parent_intent_idx

-- DROP INDEX public.intent_parent_intent_idx;

CREATE INDEX intent_parent_intent_idx
    ON public.intent USING btree
    (parent_intent_id)
    TABLESPACE pg_default;





-- Table: public.intent_title

-- DROP TABLE public.intent_title;

CREATE TABLE public.intent_title
(
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    date_created timestamp with time zone NOT NULL,
    last_updated timestamp with time zone NOT NULL,
    intent_id bigint NOT NULL,
    language_id bigint NOT NULL,
    CONSTRAINT intent_title_pkey PRIMARY KEY (id),
    CONSTRAINT fkbug4ncaix09slh7ma6cd10km FOREIGN KEY (intent_id)
        REFERENCES public.intent (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkkkh8feniyfojisdna5yv80tyi FOREIGN KEY (language_id)
        REFERENCES public.language (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);



-- SEQUENCE: public.intent_seq

-- DROP SEQUENCE public.intent_seq;

CREATE SEQUENCE public.intent_seq;

-- SEQUENCE: public.intent_title_seq

-- DROP SEQUENCE public.intent_title_seq;

CREATE SEQUENCE public.intent_title_seq;

-- SEQUENCE: public.language_seq

-- DROP SEQUENCE public.language_seq;

CREATE SEQUENCE public.language_seq;


-- BOOTSTRAP DATA

INSERT INTO public.language VALUES (nextval('language_seq'), 'english', 'en-US', 'English');
INSERT INTO public.language VALUES (nextval('language_seq'), 'norwegian', 'no-NB', 'Norwegian');

INSERT INTO public.intent VALUES(nextval('intent_seq'), current_timestamp, FALSE, current_timestamp, NULL);
INSERT INTO public.intent_title VALUES(nextval('intent_title_seq'), 'Hello world', current_timestamp, current_timestamp, 1, 1);
INSERT INTO public.intent_title VALUES(nextval('intent_title_seq'), 'Hallo verden', current_timestamp, current_timestamp, 1, 2);

-- COPY TABLES to qa schema
CREATE TABLE qa.intent AS TABLE public.intent;
CREATE TABLE qa.intent_title AS TABLE public.intent_title;
CREATE TABLE qa.language AS TABLE public.language;

UPDATE qa.intent_title SET title = title || ' QA';