-- Table: public.registration

-- DROP TABLE IF EXISTS public.registration;

CREATE TABLE IF NOT EXISTS public.registration
(
    pid character varying collate pg_catalog."default" not null,
	school_name character varying COLLATE pg_catalog."default" NOT NULL,
	team_id character varying collate pg_catalog."default" not null, 
    student_name character varying COLLATE pg_catalog."default" NOT NULL,
    email character varying COLLATE pg_catalog."default",
    phone character varying COLLATE pg_catalog."default",
    jersey_number character varying COLLATE pg_catalog."default",
	update_time timestamp without time zone default current_timestamp,
    pid_filename character varying COLLATE pg_catalog."default",
    pid_data bytea,
    st_filename character varying COLLATE pg_catalog."default",
    st_data bytea,
    er_filename character varying COLLATE pg_catalog."default",
    er_data bytea,
	constraint registration_pkey primary key (pid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.registration
    OWNER to admin;

CREATE TABLE IF NOT EXISTS public."user"
(
    id integer NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    email character varying COLLATE pg_catalog."default" NOT NULL,
    password character varying COLLATE pg_catalog."default" NOT NULL,
    active boolean,
    name character varying COLLATE pg_catalog."default",
    team_id character varying COLLATE pg_catalog."default",
    CONSTRAINT user_pkey PRIMARY KEY (id),
    CONSTRAINT "UNI_email" UNIQUE (email)
)

TABLESPACE pg_default;

ALTER TABLE public."user"
    OWNER to admin;

CREATE TABLE IF NOT EXISTS public.role
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name character varying COLLATE pg_catalog."default" NOT NULL,
    description character varying COLLATE pg_catalog."default",
    CONSTRAINT role_pkey PRIMARY KEY (id),
    CONSTRAINT uni_role_name UNIQUE (name)
)

TABLESPACE pg_default;

ALTER TABLE public.role
    OWNER to admin;

CREATE TABLE IF NOT EXISTS public.roles_users
(
    user_id integer NOT NULL,
    role_id integer NOT NULL,
    CONSTRAINT role_user_pk PRIMARY KEY (user_id, role_id),
    CONSTRAINT roleid_fk FOREIGN KEY (role_id)
        REFERENCES public.role (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT userid_fk FOREIGN KEY (user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.roles_users
    OWNER to admin;
    