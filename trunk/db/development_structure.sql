--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'Standard public schema';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: aggregation_feeds; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE aggregation_feeds (
    id integer NOT NULL,
    aggregation_id integer,
    feed_id integer
);


--
-- Name: aggregation_feeds_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE aggregation_feeds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: aggregation_feeds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE aggregation_feeds_id_seq OWNED BY aggregation_feeds.id;


--
-- Name: aggregation_top_tags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE aggregation_top_tags (
    id integer NOT NULL,
    aggregation_id integer DEFAULT 0,
    tag_id integer,
    hits integer
);


--
-- Name: aggregation_top_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE aggregation_top_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: aggregation_top_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE aggregation_top_tags_id_seq OWNED BY aggregation_top_tags.id;


--
-- Name: aggregations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE aggregations (
    id integer NOT NULL,
    name character varying(255),
    title character varying(255),
    description text,
    top_tags text,
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: aggregations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE aggregations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: aggregations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE aggregations_id_seq OWNED BY aggregations.id;


--
-- Name: entries; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE entries (
    id integer NOT NULL,
    feed_id integer NOT NULL,
    permalink character varying(2083) DEFAULT ''::character varying NOT NULL,
    author character varying(2083),
    title text NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    content text DEFAULT ''::text NOT NULL,
    unique_content boolean DEFAULT false,
    tag_list text,
    published_at timestamp without time zone NOT NULL,
    entry_updated_at timestamp without time zone,
    harvested_at timestamp without time zone,
    oai_identifier character varying(2083),
    related_entries text,
    recommender_processed boolean DEFAULT false,
    "language" character varying(255)
);


--
-- Name: entries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE entries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE entries_id_seq OWNED BY entries.id;


--
-- Name: entries_tags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE entries_tags (
    entry_id integer NOT NULL,
    tag_id integer
);


--
-- Name: entries_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE entries_users (
    id integer NOT NULL,
    entry_id integer NOT NULL,
    user_id integer DEFAULT 0,
    clicked_through boolean DEFAULT false,
    created_at timestamp without time zone
);


--
-- Name: entries_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE entries_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: entries_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE entries_users_id_seq OWNED BY entries_users.id;


--
-- Name: entry_images; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE entry_images (
    id integer NOT NULL,
    entry_id integer,
    uri character varying(2083),
    link character varying(2083),
    alt character varying(255),
    title character varying(255),
    width integer,
    height integer
);


--
-- Name: entry_images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE entry_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: entry_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE entry_images_id_seq OWNED BY entry_images.id;


--
-- Name: feed_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE feed_types (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: feed_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE feed_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: feed_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE feed_types_id_seq OWNED BY feed_types.id;


--
-- Name: feeds; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE feeds (
    id integer NOT NULL,
    uri character varying(2083),
    display_uri character varying(2083),
    title character varying(1000),
    short_title character varying(100),
    description text,
    tag_filter character varying(1000),
    top_tags text,
    priority integer DEFAULT 10,
    status integer DEFAULT 1,
    last_requested_at timestamp without time zone,
    last_harvested_at timestamp without time zone,
    harvest_interval interval DEFAULT '06:00:00'::interval,
    failed_requests integer DEFAULT 0,
    error_message text,
    service_id integer DEFAULT 0 NOT NULL,
    "login" character varying(255),
    "password" character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    feed_type_id integer
);


--
-- Name: feeds_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE feeds_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: feeds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE feeds_id_seq OWNED BY feeds.id;


--
-- Name: feeds_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE feeds_users (
    id integer NOT NULL,
    feed_id integer NOT NULL,
    user_id integer DEFAULT 0,
    created_at timestamp without time zone
);


--
-- Name: feeds_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE feeds_users_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: feeds_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE feeds_users_id_seq OWNED BY feeds_users.id;


--
-- Name: micro_concerts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE micro_concerts (
    id integer NOT NULL,
    micro_event_id integer,
    performer character varying(255),
    ticket_url character varying(2083)
);


--
-- Name: micro_concerts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE micro_concerts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: micro_concerts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE micro_concerts_id_seq OWNED BY micro_concerts.id;


--
-- Name: micro_conferences; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE micro_conferences (
    id integer NOT NULL,
    micro_event_id integer,
    theme character varying(255),
    register_by timestamp without time zone,
    submit_by timestamp without time zone
);


--
-- Name: micro_conferences_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE micro_conferences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: micro_conferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE micro_conferences_id_seq OWNED BY micro_conferences.id;


--
-- Name: micro_event_links; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE micro_event_links (
    id integer NOT NULL,
    micro_event_id integer,
    uri character varying(255),
    title character varying(255)
);


--
-- Name: micro_event_links_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE micro_event_links_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: micro_event_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE micro_event_links_id_seq OWNED BY micro_event_links.id;


--
-- Name: micro_event_people; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE micro_event_people (
    id integer NOT NULL,
    micro_event_id integer,
    name character varying(255),
    "role" character varying(255),
    email character varying(255),
    link character varying(2083),
    phone character varying(255)
);


--
-- Name: micro_event_people_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE micro_event_people_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: micro_event_people_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE micro_event_people_id_seq OWNED BY micro_event_people.id;


--
-- Name: micro_events; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE micro_events (
    id integer NOT NULL,
    entry_id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    price character varying(255),
    image text,
    address text,
    subaddress text,
    city character varying(255),
    state character varying(255),
    postcode character varying(255),
    country character varying(255),
    begins timestamp without time zone NOT NULL,
    ends timestamp without time zone,
    tags text,
    duration character varying(255),
    "location" text
);


--
-- Name: micro_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE micro_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: micro_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE micro_events_id_seq OWNED BY micro_events.id;


--
-- Name: open_id_authentication_associations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE open_id_authentication_associations (
    id integer NOT NULL,
    server_url bytea,
    handle character varying(255),
    secret bytea,
    issued integer,
    lifetime integer,
    assoc_type character varying(255)
);


--
-- Name: open_id_authentication_associations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE open_id_authentication_associations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: open_id_authentication_associations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE open_id_authentication_associations_id_seq OWNED BY open_id_authentication_associations.id;


--
-- Name: open_id_authentication_nonces; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE open_id_authentication_nonces (
    id integer NOT NULL,
    nonce character varying(255),
    created integer
);


--
-- Name: open_id_authentication_nonces_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE open_id_authentication_nonces_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: open_id_authentication_nonces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE open_id_authentication_nonces_id_seq OWNED BY open_id_authentication_nonces.id;


--
-- Name: open_id_authentication_settings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE open_id_authentication_settings (
    id integer NOT NULL,
    setting character varying(255),
    value bytea
);


--
-- Name: open_id_authentication_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE open_id_authentication_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: open_id_authentication_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE open_id_authentication_settings_id_seq OWNED BY open_id_authentication_settings.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE roles (
    id integer NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- Name: schema_info; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_info (
    version integer
);


--
-- Name: services; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE services (
    id integer NOT NULL,
    uri character varying(2083) DEFAULT ''::character varying NOT NULL,
    title character varying(1000) DEFAULT ''::character varying NOT NULL,
    api_uri character varying(2083) DEFAULT ''::character varying NOT NULL,
    uri_template character varying(2083) DEFAULT ''::character varying NOT NULL,
    icon character varying(2083),
    "sequence" integer,
    requires_password boolean DEFAULT false
);


--
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE services_id_seq OWNED BY services.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sessions (
    id integer NOT NULL,
    session_id character varying(255),
    data text,
    updated_at timestamp without time zone
);


--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sessions_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sessions_id_seq OWNED BY sessions.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tags (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone
);


--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    "login" character varying(80) DEFAULT ''::character varying NOT NULL,
    crypted_password character varying(40) DEFAULT ''::character varying NOT NULL,
    email character varying(60) DEFAULT ''::character varying NOT NULL,
    firstname character varying(40),
    lastname character varying(40),
    salt character varying(40) DEFAULT ''::character varying NOT NULL,
    verified integer DEFAULT 0,
    "role" character varying(40),
    security_token character varying(40),
    token_expiry timestamp without time zone,
    login_token character varying(40),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    logged_in_at timestamp without time zone,
    deleted integer DEFAULT 0,
    delete_after timestamp without time zone,
    image_path character varying(40) DEFAULT 'default_user_img'::character varying,
    blurb character varying(2000),
    "location" character varying(100),
    website character varying(2083),
    activated_at timestamp without time zone,
    identity_url character varying(255),
    activation_code character varying(40),
    remember_token character varying(255),
    remember_token_expires_at timestamp without time zone
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: watched_pages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE watched_pages (
    id integer NOT NULL,
    entry_id integer,
    harvested_at timestamp without time zone,
    has_microformats boolean DEFAULT false,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: watched_pages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE watched_pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: watched_pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE watched_pages_id_seq OWNED BY watched_pages.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE aggregation_feeds ALTER COLUMN id SET DEFAULT nextval('aggregation_feeds_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE aggregation_top_tags ALTER COLUMN id SET DEFAULT nextval('aggregation_top_tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE aggregations ALTER COLUMN id SET DEFAULT nextval('aggregations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE entries ALTER COLUMN id SET DEFAULT nextval('entries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE entries_users ALTER COLUMN id SET DEFAULT nextval('entries_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE entry_images ALTER COLUMN id SET DEFAULT nextval('entry_images_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE feed_types ALTER COLUMN id SET DEFAULT nextval('feed_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE feeds ALTER COLUMN id SET DEFAULT nextval('feeds_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE feeds_users ALTER COLUMN id SET DEFAULT nextval('feeds_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE micro_concerts ALTER COLUMN id SET DEFAULT nextval('micro_concerts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE micro_conferences ALTER COLUMN id SET DEFAULT nextval('micro_conferences_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE micro_event_links ALTER COLUMN id SET DEFAULT nextval('micro_event_links_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE micro_event_people ALTER COLUMN id SET DEFAULT nextval('micro_event_people_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE micro_events ALTER COLUMN id SET DEFAULT nextval('micro_events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE open_id_authentication_associations ALTER COLUMN id SET DEFAULT nextval('open_id_authentication_associations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE open_id_authentication_nonces ALTER COLUMN id SET DEFAULT nextval('open_id_authentication_nonces_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE open_id_authentication_settings ALTER COLUMN id SET DEFAULT nextval('open_id_authentication_settings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE services ALTER COLUMN id SET DEFAULT nextval('services_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE sessions ALTER COLUMN id SET DEFAULT nextval('sessions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE watched_pages ALTER COLUMN id SET DEFAULT nextval('watched_pages_id_seq'::regclass);


--
-- Name: aggregation_feeds_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY aggregation_feeds
    ADD CONSTRAINT aggregation_feeds_pkey PRIMARY KEY (id);


--
-- Name: aggregation_top_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY aggregation_top_tags
    ADD CONSTRAINT aggregation_top_tags_pkey PRIMARY KEY (id);


--
-- Name: aggregations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY aggregations
    ADD CONSTRAINT aggregations_pkey PRIMARY KEY (id);


--
-- Name: entries_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY entries
    ADD CONSTRAINT entries_pkey PRIMARY KEY (id);


--
-- Name: entries_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY entries_users
    ADD CONSTRAINT entries_users_pkey PRIMARY KEY (id);


--
-- Name: entry_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY entry_images
    ADD CONSTRAINT entry_images_pkey PRIMARY KEY (id);


--
-- Name: feed_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY feed_types
    ADD CONSTRAINT feed_types_pkey PRIMARY KEY (id);


--
-- Name: feeds_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY feeds
    ADD CONSTRAINT feeds_pkey PRIMARY KEY (id);


--
-- Name: feeds_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY feeds_users
    ADD CONSTRAINT feeds_users_pkey PRIMARY KEY (id);


--
-- Name: micro_concerts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY micro_concerts
    ADD CONSTRAINT micro_concerts_pkey PRIMARY KEY (id);


--
-- Name: micro_conferences_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY micro_conferences
    ADD CONSTRAINT micro_conferences_pkey PRIMARY KEY (id);


--
-- Name: micro_event_links_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY micro_event_links
    ADD CONSTRAINT micro_event_links_pkey PRIMARY KEY (id);


--
-- Name: micro_event_people_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY micro_event_people
    ADD CONSTRAINT micro_event_people_pkey PRIMARY KEY (id);


--
-- Name: micro_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY micro_events
    ADD CONSTRAINT micro_events_pkey PRIMARY KEY (id);


--
-- Name: open_id_authentication_associations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY open_id_authentication_associations
    ADD CONSTRAINT open_id_authentication_associations_pkey PRIMARY KEY (id);


--
-- Name: open_id_authentication_nonces_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY open_id_authentication_nonces
    ADD CONSTRAINT open_id_authentication_nonces_pkey PRIMARY KEY (id);


--
-- Name: open_id_authentication_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY open_id_authentication_settings
    ADD CONSTRAINT open_id_authentication_settings_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: services_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: watched_pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY watched_pages
    ADD CONSTRAINT watched_pages_pkey PRIMARY KEY (id);


--
-- Name: index_aggregation_feeds_on_aggregation_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_aggregation_feeds_on_aggregation_id ON aggregation_feeds USING btree (aggregation_id);


--
-- Name: index_aggregation_feeds_on_feed_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_aggregation_feeds_on_feed_id ON aggregation_feeds USING btree (feed_id);


--
-- Name: index_aggregation_top_tags_on_aggregation_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_aggregation_top_tags_on_aggregation_id ON aggregation_top_tags USING btree (aggregation_id);


--
-- Name: index_aggregation_top_tags_on_tag_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_aggregation_top_tags_on_tag_id ON aggregation_top_tags USING btree (tag_id);


--
-- Name: index_aggregations_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_aggregations_on_user_id ON aggregations USING btree (user_id);


--
-- Name: index_entries_on_feed_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_entries_on_feed_id ON entries USING btree (feed_id);


--
-- Name: index_entries_on_language; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_entries_on_language ON entries USING btree ("language");


--
-- Name: index_entries_on_oai_identifier; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_entries_on_oai_identifier ON entries USING btree (oai_identifier);


--
-- Name: index_entries_on_permalink; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_entries_on_permalink ON entries USING btree (permalink);


--
-- Name: index_entries_on_published_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_entries_on_published_at ON entries USING btree (published_at);

ALTER TABLE entries CLUSTER ON index_entries_on_published_at;


--
-- Name: index_entries_on_recommender_processed; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_entries_on_recommender_processed ON entries USING btree (recommender_processed);


--
-- Name: index_entries_tags_on_entry_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_entries_tags_on_entry_id ON entries_tags USING btree (entry_id);


--
-- Name: index_entries_tags_on_tag_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_entries_tags_on_tag_id ON entries_tags USING btree (tag_id);


--
-- Name: index_entries_users_entry_id_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_entries_users_entry_id_user_id ON entries_users USING btree (entry_id, user_id);


--
-- Name: index_entries_users_on_entry_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_entries_users_on_entry_id ON entries_users USING btree (entry_id);


--
-- Name: index_entries_users_on_feed_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_entries_users_on_feed_id ON feeds_users USING btree (feed_id);


--
-- Name: index_entries_users_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_entries_users_on_user_id ON entries_users USING btree (user_id);


--
-- Name: index_entry_images_on_entry_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_entry_images_on_entry_id ON entry_images USING btree (entry_id);


--
-- Name: index_feeds_on_feed_type_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_feeds_on_feed_type_id ON feeds USING btree (feed_type_id);


--
-- Name: index_feeds_on_service_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_feeds_on_service_id ON feeds USING btree (service_id);


--
-- Name: index_feeds_on_uri; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_feeds_on_uri ON feeds USING btree (uri);


--
-- Name: index_micro_concerts_on_micro_event_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_micro_concerts_on_micro_event_id ON micro_concerts USING btree (micro_event_id);


--
-- Name: index_micro_conferences_on_micro_event_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_micro_conferences_on_micro_event_id ON micro_conferences USING btree (micro_event_id);


--
-- Name: index_micro_event_links_on_micro_event_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_micro_event_links_on_micro_event_id ON micro_event_links USING btree (micro_event_id);


--
-- Name: index_micro_event_people_on_micro_event_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_micro_event_people_on_micro_event_id ON micro_event_people USING btree (micro_event_id);


--
-- Name: index_micro_events_on_entry_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_micro_events_on_entry_id ON micro_events USING btree (entry_id);


--
-- Name: index_sessions_on_session_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sessions_on_session_id ON sessions USING btree (session_id);


--
-- Name: index_sessions_on_updated_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sessions_on_updated_at ON sessions USING btree (updated_at);


--
-- Name: index_tags_on_lower_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tags_on_lower_name ON tags USING btree (name);

ALTER TABLE tags CLUSTER ON index_tags_on_lower_name;


--
-- Name: index_tags_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tags_on_name ON tags USING btree (name);


--
-- Name: index_watched_pages_on_entry_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_watched_pages_on_entry_id ON watched_pages USING btree (entry_id);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_info (version) VALUES (20)