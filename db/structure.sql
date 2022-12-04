SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plug; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.plug AS ENUM (
    'CHAdeMO',
    'CCS Combo 2',
    'Type 2'
);


--
-- Name: state; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.state AS ENUM (
    'disabled',
    'occupied',
    'free'
);


--
-- Name: nextval_special(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.nextval_special() RETURNS character varying
    LANGUAGE sql
    AS $$
              SELECT 'CS-'||to_char(nextval('sn_seq'), 'FM000000'); 
          $$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: adapters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.adapters (
    id bigint NOT NULL,
    plug_from public.plug NOT NULL,
    plug_to public.plug NOT NULL,
    user_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: adapters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.adapters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: adapters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.adapters_id_seq OWNED BY public.adapters.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: charging_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.charging_sessions (
    id bigint NOT NULL,
    duration_in_hours numeric(4,2),
    consumed_power numeric(6,2),
    active boolean,
    user_id bigint,
    connector_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: charging_sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.charging_sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: charging_sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.charging_sessions_id_seq OWNED BY public.charging_sessions.id;


--
-- Name: charging_stations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.charging_stations (
    id bigint NOT NULL,
    station_serial_number character varying DEFAULT public.nextval_special() NOT NULL,
    location_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: charging_stations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.charging_stations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: charging_stations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.charging_stations_id_seq OWNED BY public.charging_stations.id;


--
-- Name: connectors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.connectors (
    id bigint NOT NULL,
    current_state public.state NOT NULL,
    plug public.plug NOT NULL,
    power numeric(6,2) NOT NULL,
    charging_station_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: connectors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.connectors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: connectors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.connectors_id_seq OWNED BY public.connectors.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.locations (
    id bigint NOT NULL,
    name character varying,
    latitude numeric(8,6),
    longitude numeric(9,6),
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: sn_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sn_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    full_name character varying NOT NULL,
    phone_number character varying NOT NULL,
    plug public.plug NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: adapters id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adapters ALTER COLUMN id SET DEFAULT nextval('public.adapters_id_seq'::regclass);


--
-- Name: charging_sessions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.charging_sessions ALTER COLUMN id SET DEFAULT nextval('public.charging_sessions_id_seq'::regclass);


--
-- Name: charging_stations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.charging_stations ALTER COLUMN id SET DEFAULT nextval('public.charging_stations_id_seq'::regclass);


--
-- Name: connectors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.connectors ALTER COLUMN id SET DEFAULT nextval('public.connectors_id_seq'::regclass);


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: adapters adapters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adapters
    ADD CONSTRAINT adapters_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: charging_sessions charging_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.charging_sessions
    ADD CONSTRAINT charging_sessions_pkey PRIMARY KEY (id);


--
-- Name: charging_stations charging_stations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.charging_stations
    ADD CONSTRAINT charging_stations_pkey PRIMARY KEY (id);


--
-- Name: connectors connectors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.connectors
    ADD CONSTRAINT connectors_pkey PRIMARY KEY (id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_adapters_on_plug_from_and_plug_to; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_adapters_on_plug_from_and_plug_to ON public.adapters USING btree (plug_from, plug_to);


--
-- Name: index_adapters_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_adapters_on_user_id ON public.adapters USING btree (user_id);


--
-- Name: index_charging_sessions_on_connector_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_charging_sessions_on_connector_id ON public.charging_sessions USING btree (connector_id);


--
-- Name: index_charging_sessions_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_charging_sessions_on_user_id ON public.charging_sessions USING btree (user_id);


--
-- Name: index_charging_stations_on_location_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_charging_stations_on_location_id ON public.charging_stations USING btree (location_id);


--
-- Name: index_charging_stations_on_station_serial_number; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_charging_stations_on_station_serial_number ON public.charging_stations USING btree (station_serial_number);


--
-- Name: index_connectors_on_charging_station_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_connectors_on_charging_station_id ON public.connectors USING btree (charging_station_id);


--
-- Name: index_connectors_on_current_state_and_plug; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_connectors_on_current_state_and_plug ON public.connectors USING btree (current_state, plug);


--
-- Name: charging_stations fk_rails_0c86325662; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.charging_stations
    ADD CONSTRAINT fk_rails_0c86325662 FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- Name: connectors fk_rails_5d13be68cc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.connectors
    ADD CONSTRAINT fk_rails_5d13be68cc FOREIGN KEY (charging_station_id) REFERENCES public.charging_stations(id);


--
-- Name: adapters fk_rails_5d5bfff499; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adapters
    ADD CONSTRAINT fk_rails_5d5bfff499 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: charging_sessions fk_rails_7af8ceb67b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.charging_sessions
    ADD CONSTRAINT fk_rails_7af8ceb67b FOREIGN KEY (connector_id) REFERENCES public.connectors(id);


--
-- Name: charging_sessions fk_rails_a2619e4551; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.charging_sessions
    ADD CONSTRAINT fk_rails_a2619e4551 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20221203105943'),
('20221203124221'),
('20221204055228'),
('20221204055530'),
('20221204062118'),
('20221204063406'),
('20221204071655');


