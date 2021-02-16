--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.21
-- Dumped by pg_dump version 9.5.23

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO postgres;

--
-- Name: features; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.features (
    id bigint NOT NULL,
    setting_id integer,
    name character varying NOT NULL,
    value character varying,
    enabled boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.features OWNER TO postgres;

--
-- Name: features_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.features_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.features_id_seq OWNER TO postgres;

--
-- Name: features_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.features_id_seq OWNED BY public.features.id;


--
-- Name: invitations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invitations (
    id bigint NOT NULL,
    email character varying NOT NULL,
    provider character varying NOT NULL,
    invite_token character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.invitations OWNER TO postgres;

--
-- Name: invitations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.invitations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.invitations_id_seq OWNER TO postgres;

--
-- Name: invitations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.invitations_id_seq OWNED BY public.invitations.id;


--
-- Name: role_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_permissions (
    id bigint NOT NULL,
    name character varying,
    value character varying DEFAULT ''::character varying,
    enabled boolean DEFAULT false,
    role_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.role_permissions OWNER TO postgres;

--
-- Name: role_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.role_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.role_permissions_id_seq OWNER TO postgres;

--
-- Name: role_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.role_permissions_id_seq OWNED BY public.role_permissions.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying,
    priority integer DEFAULT 9999,
    can_create_rooms boolean DEFAULT false,
    send_promoted_email boolean DEFAULT false,
    send_demoted_email boolean DEFAULT false,
    can_edit_site_settings boolean DEFAULT false,
    can_edit_roles boolean DEFAULT false,
    can_manage_users boolean DEFAULT false,
    colour character varying,
    provider character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_limit integer DEFAULT 100,
    time_limit integer DEFAULT 100
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: rooms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rooms (
    id bigint NOT NULL,
    user_id integer,
    name character varying,
    uid character varying,
    bbb_id character varying,
    sessions integer DEFAULT 0,
    last_session timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    room_settings character varying DEFAULT '{ }'::character varying,
    moderator_pw character varying,
    attendee_pw character varying,
    access_code character varying,
    deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public.rooms OWNER TO postgres;

--
-- Name: rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rooms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rooms_id_seq OWNER TO postgres;

--
-- Name: rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rooms_id_seq OWNED BY public.rooms.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.settings (
    id bigint NOT NULL,
    provider character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.settings OWNER TO postgres;

--
-- Name: settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.settings_id_seq OWNER TO postgres;

--
-- Name: settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.settings_id_seq OWNED BY public.settings.id;


--
-- Name: shared_accesses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shared_accesses (
    id bigint NOT NULL,
    room_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.shared_accesses OWNER TO postgres;

--
-- Name: shared_accesses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shared_accesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shared_accesses_id_seq OWNER TO postgres;

--
-- Name: shared_accesses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shared_accesses_id_seq OWNED BY public.shared_accesses.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    room_id integer,
    provider character varying,
    uid character varying,
    name character varying,
    username character varying,
    email character varying,
    social_uid character varying,
    image character varying,
    password_digest character varying,
    accepted_terms boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    email_verified boolean DEFAULT false,
    language character varying DEFAULT 'default'::character varying,
    reset_digest character varying,
    reset_sent_at timestamp without time zone,
    activation_digest character varying,
    activated_at timestamp without time zone,
    deleted boolean DEFAULT false NOT NULL,
    role_id bigint
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: users_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_roles (
    user_id integer,
    role_id integer
);


ALTER TABLE public.users_roles OWNER TO postgres;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.features ALTER COLUMN id SET DEFAULT nextval('public.features_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invitations ALTER COLUMN id SET DEFAULT nextval('public.invitations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions ALTER COLUMN id SET DEFAULT nextval('public.role_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms ALTER COLUMN id SET DEFAULT nextval('public.rooms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings ALTER COLUMN id SET DEFAULT nextval('public.settings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shared_accesses ALTER COLUMN id SET DEFAULT nextval('public.shared_accesses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	production	2020-04-03 09:12:50.501987	2020-04-03 09:12:50.501987
\.


--
-- Data for Name: features; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.features (id, setting_id, name, value, enabled, created_at, updated_at) FROM stdin;
5	1	Shared Access	\N	f	2020-04-03 10:05:02.281553	2020-04-03 10:05:02.281553
8	1	Room Authentication	\N	f	2020-04-05 20:18:08.765898	2020-04-05 20:18:08.765898
9	1	Default Recording Visibility	\N	f	2020-04-05 20:18:08.793877	2020-04-05 20:18:08.793877
1	1	Branding Image	https://meeting.wofemtech.com/images/bbb-logo.png	t	2020-04-03 09:59:08.270197	2020-04-05 20:18:43.763557
2	1	Primary Color	#61A754	t	2020-04-03 09:59:08.99911	2020-04-05 20:21:58.710636
3	1	Primary Color Lighten	#ddedda	t	2020-04-03 09:59:09.001546	2020-04-05 20:21:58.71562
4	1	Primary Color Darken	#4d8543	t	2020-04-03 09:59:09.003602	2020-04-05 20:21:58.719565
10	1	Legal URL	\N	f	2020-06-29 17:10:30.977275	2020-06-29 17:10:30.977275
11	1	Privacy Policy URL	\N	f	2020-06-29 17:10:30.980251	2020-06-29 17:10:30.980251
12	1	Room Configuration Allow Any Start	\N	f	2020-06-29 17:19:26.409631	2020-06-29 17:19:26.409631
14	1	Room Configuration Require Moderator	\N	f	2020-06-29 17:19:26.472496	2020-06-29 17:19:26.472496
6	1	Room Limit	5	t	2020-04-03 10:05:02.400098	2020-07-21 20:00:05.067241
7	1	Registration Method	0	t	2020-04-03 10:05:26.811763	2020-07-24 17:05:37.569844
15	1	Room Configuration All Join Moderator	optional	t	2020-06-29 17:19:26.474899	2020-08-10 19:00:32.229837
13	1	Room Configuration Mute On Join	optional	t	2020-06-29 17:19:26.469204	2020-08-11 18:10:04.076018
\.


--
-- Name: features_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.features_id_seq', 15, true);


--
-- Data for Name: invitations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invitations (id, email, provider, invite_token, created_at, updated_at) FROM stdin;
\.


--
-- Name: invitations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.invitations_id_seq', 1, false);


--
-- Data for Name: role_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_permissions (id, name, value, enabled, role_id, created_at, updated_at) FROM stdin;
1	can_create_rooms	true	t	1	2020-04-03 10:00:14.737068	2020-04-03 10:00:14.738216
2	can_create_rooms	true	t	2	2020-04-03 10:00:14.741078	2020-04-03 10:00:14.741845
3	send_promoted_email	true	t	2	2020-04-03 10:00:14.74337	2020-04-03 10:00:14.744049
4	send_demoted_email	true	t	2	2020-04-03 10:00:14.745431	2020-04-03 10:00:14.746196
5	can_edit_site_settings	true	t	2	2020-04-03 10:00:14.747531	2020-04-03 10:00:14.748274
6	can_edit_roles	true	t	2	2020-04-03 10:00:14.749639	2020-04-03 10:00:14.750357
7	can_manage_users	true	t	2	2020-04-03 10:00:14.7517	2020-04-03 10:00:14.752379
8	can_manage_rooms_recordings	true	t	2	2020-04-03 10:00:14.753672	2020-04-03 10:00:14.754424
9	can_create_rooms	true	t	5	2020-04-03 10:00:14.758859	2020-04-03 10:00:14.759601
10	send_promoted_email	true	t	5	2020-04-03 10:00:14.760923	2020-04-03 10:00:14.761631
11	send_demoted_email	true	t	5	2020-04-03 10:00:14.763042	2020-04-03 10:00:14.763827
12	can_edit_site_settings	true	t	5	2020-04-03 10:00:14.76516	2020-04-03 10:00:14.765841
13	can_edit_roles	true	t	5	2020-04-03 10:00:14.76726	2020-04-03 10:00:14.767964
14	can_manage_users	true	t	5	2020-04-03 10:00:14.769292	2020-04-03 10:00:14.769978
15	can_manage_rooms_recordings	true	t	5	2020-04-03 10:00:14.771356	2020-04-03 10:00:14.772138
16	can_appear_in_share_list		f	5	2020-04-03 10:05:02.381657	2020-04-03 10:05:02.381657
17	can_appear_in_share_list		f	4	2020-04-03 10:05:02.384264	2020-04-03 10:05:02.384264
18	can_appear_in_share_list		f	3	2020-04-03 10:05:02.386626	2020-04-03 10:05:02.386626
19	can_appear_in_share_list		f	2	2020-04-03 10:05:02.388859	2020-04-03 10:05:02.388859
27	can_create_rooms	true	t	6	2020-04-07 14:43:57.019222	2020-04-09 19:33:52.977322
33	send_promoted_email	false	t	6	2020-04-07 14:43:57.056461	2020-04-09 19:33:52.980474
34	send_demoted_email	false	t	6	2020-04-07 14:43:57.058541	2020-04-09 19:33:52.983022
30	can_edit_site_settings	false	t	6	2020-04-07 14:43:57.050351	2020-04-09 19:33:52.985288
31	can_edit_roles	false	t	6	2020-04-07 14:43:57.052483	2020-04-09 19:33:52.987637
28	can_manage_users	true	t	6	2020-04-07 14:43:57.045372	2020-04-09 19:33:52.989757
29	can_manage_rooms_recordings	false	t	6	2020-04-07 14:43:57.04807	2020-04-09 19:33:52.992003
32	can_appear_in_share_list	true	t	6	2020-04-07 14:43:57.054515	2020-04-09 19:33:52.994616
35	can_create_rooms	false	t	7	2020-05-06 20:34:51.495976	2020-05-06 20:35:57.523837
41	send_promoted_email	false	t	7	2020-05-06 20:34:51.510531	2020-05-06 20:35:57.526218
42	send_demoted_email	false	t	7	2020-05-06 20:34:51.512873	2020-05-06 20:35:57.529545
38	can_edit_site_settings	false	t	7	2020-05-06 20:34:51.503762	2020-05-06 20:35:57.531909
39	can_edit_roles	false	t	7	2020-05-06 20:34:51.505822	2020-05-06 20:35:57.534471
36	can_manage_users	false	t	7	2020-05-06 20:34:51.499122	2020-05-06 20:35:57.536903
37	can_manage_rooms_recordings	false	t	7	2020-05-06 20:34:51.501426	2020-05-06 20:35:57.539104
40	can_appear_in_share_list	false	t	7	2020-05-06 20:34:51.507973	2020-05-06 20:35:57.541319
25	send_promoted_email	true	t	1	2020-04-03 12:01:08.939362	2020-05-28 09:34:47.970487
26	send_demoted_email	false	t	1	2020-04-03 12:01:08.941358	2020-05-28 09:34:47.974671
23	can_edit_site_settings	false	t	1	2020-04-03 12:01:08.935311	2020-05-28 09:34:47.977262
24	can_edit_roles	false	t	1	2020-04-03 12:01:08.937271	2020-05-28 09:34:47.979859
21	can_manage_users	false	t	1	2020-04-03 12:01:08.929572	2020-05-28 09:34:47.982433
22	can_manage_rooms_recordings	false	t	1	2020-04-03 12:01:08.933074	2020-05-28 09:34:47.985065
20	can_appear_in_share_list	true	t	1	2020-04-03 10:05:02.390933	2020-05-28 09:34:47.987513
43	can_create_rooms		f	3	2020-06-29 18:49:18.160909	2020-06-29 18:49:18.160909
60	can_create_rooms	true	t	10	2020-07-13 10:40:30.100117	2020-07-13 10:40:36.265433
66	send_promoted_email	false	t	10	2020-07-13 10:40:30.129963	2020-07-13 10:40:36.26809
67	send_demoted_email	false	t	10	2020-07-13 10:40:30.132731	2020-07-13 10:40:36.270535
63	can_edit_site_settings	false	t	10	2020-07-13 10:40:30.123121	2020-07-13 10:40:36.272968
64	can_edit_roles	false	t	10	2020-07-13 10:40:30.125434	2020-07-13 10:40:36.27534
61	can_manage_users	false	t	10	2020-07-13 10:40:30.118441	2020-07-13 10:40:36.277698
62	can_manage_rooms_recordings	false	t	10	2020-07-13 10:40:30.120992	2020-07-13 10:40:36.280297
65	can_appear_in_share_list	true	t	10	2020-07-13 10:40:30.127558	2020-07-13 10:40:36.282802
52	can_create_rooms	true	t	9	2020-07-13 10:40:16.772913	2020-07-13 10:40:41.652248
58	send_promoted_email	false	t	9	2020-07-13 10:40:16.787228	2020-07-13 10:40:41.655233
59	send_demoted_email	false	t	9	2020-07-13 10:40:16.789632	2020-07-13 10:40:41.658178
55	can_edit_site_settings	false	t	9	2020-07-13 10:40:16.779797	2020-07-13 10:40:41.660995
56	can_edit_roles	false	t	9	2020-07-13 10:40:16.782197	2020-07-13 10:40:41.663937
53	can_manage_users	false	t	9	2020-07-13 10:40:16.775368	2020-07-13 10:40:41.667352
54	can_manage_rooms_recordings	false	t	9	2020-07-13 10:40:16.777494	2020-07-13 10:40:41.670062
57	can_appear_in_share_list	true	t	9	2020-07-13 10:40:16.784715	2020-07-13 10:40:41.673224
44	can_create_rooms	true	t	8	2020-07-13 10:40:02.939643	2020-07-13 10:40:46.855789
50	send_promoted_email	false	t	8	2020-07-13 10:40:02.954941	2020-07-13 10:40:46.858431
51	send_demoted_email	false	t	8	2020-07-13 10:40:02.957208	2020-07-13 10:40:46.861135
47	can_edit_site_settings	false	t	8	2020-07-13 10:40:02.948274	2020-07-13 10:40:46.863636
48	can_edit_roles	false	t	8	2020-07-13 10:40:02.950542	2020-07-13 10:40:46.866573
45	can_manage_users	false	t	8	2020-07-13 10:40:02.942819	2020-07-13 10:40:46.869195
46	can_manage_rooms_recordings	false	t	8	2020-07-13 10:40:02.94609	2020-07-13 10:40:46.871647
49	can_appear_in_share_list	true	t	8	2020-07-13 10:40:02.952697	2020-07-13 10:40:46.873969
\.


--
-- Name: role_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.role_permissions_id_seq', 67, true);


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name, priority, can_create_rooms, send_promoted_email, send_demoted_email, can_edit_site_settings, can_edit_roles, can_manage_users, colour, provider, created_at, updated_at, user_limit, time_limit) FROM stdin;
1	user	6	f	f	f	f	f	f	#868e96	greenlight	2020-04-03 10:00:14.722677	2020-07-13 10:40:29.816215	100	60
3	pending	-1	f	f	f	f	f	f	#17a2b8	greenlight	2020-04-03 10:00:14.755331	2020-04-03 10:00:14.755331	100	60
4	denied	-2	f	f	f	f	f	f	#343a40	greenlight	2020-04-03 10:00:14.756317	2020-04-03 10:00:14.756317	100	60
6	Teacher	1	f	f	f	f	f	f	#467fcf	greenlight	2020-04-07 14:43:56.523895	2020-04-09 19:33:52.946617	100	60
7	Guest	2	f	f	f	f	f	f	#467fcf	greenlight	2020-05-06 20:34:51.19693	2020-05-06 20:35:57.519165	100	60
9	Professional	4	f	f	f	f	f	f	#61A953	greenlight	2020-07-13 10:40:16.495768	2020-07-15 14:42:05.063056	150	180
10	Business	5	f	f	f	f	f	f	#61A953	greenlight	2020-07-13 10:40:29.763528	2020-07-15 14:42:15.099503	300	300
8	LITE	3	f	f	f	f	f	f	#61A953	greenlight	2020-07-13 10:40:02.632225	2020-07-15 14:42:26.948093	100	60
2	admin	0	f	f	f	f	f	f	#f1c40f	greenlight	2020-04-03 10:00:14.739289	2020-04-03 10:00:14.739289	200	2000
5	super_admin	-3	f	f	f	f	f	f	#cd201f	greenlight	2020-04-03 10:00:14.757236	2020-04-03 10:00:14.757236	200	2000
\.


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 10, true);


--
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rooms (id, user_id, name, uid, bbb_id, sessions, last_session, created_at, updated_at, room_settings, moderator_pw, attendee_pw, access_code, deleted) FROM stdin;
284	194	Home Room	geo-04g-seb	azqasesqv0t2tjdhfbasb6f1w9eng4hwavawkteh	0	\N	2020-09-09 18:20:23.549947	2020-09-09 18:20:23.549947	{ }	NWRtPyPRPzhZ	RUKjwCTZAdKT	\N	f
85	55	Home Room	row-ctw-jd4	08968e7ae4a348b7af2388f771c2852d13f53fe9	0	\N	2020-05-05 15:38:11.527613	2020-07-23 21:24:17.470441	{ }	SZsjlrdwMoSc	ziJEvkLdFUkW	\N	t
10	8	Home Room	cfd-nxd-pe2	1fff1fdf69c8e2628b419ad924d03b6d390e1a6b	0	\N	2020-04-06 02:41:20.556916	2020-04-27 15:43:53.879731	{ }	HRgXPzGPgYZP	CKLdsttnxlib	\N	t
120	84	Home Room	ash-wuc-xk3	7001d9c872dade9df8ac1be2dd9297721e9679c0	0	\N	2020-05-29 15:17:27.104062	2020-07-23 21:28:40.130775	{ }	ZMbGNFnpWtIz	VnTXmpaSDzFR	\N	t
110	74	Home Room	cjm-6e3-awk	1761fbbbc1a3402aac2bd36ba8ba02c4aa94c8d0	0	\N	2020-05-23 11:04:23.800359	2020-07-23 21:29:37.871264	{ }	aoOMqYPxxhJw	porSCkPTwXQP	\N	t
104	70	Home Room	cfh-3tj-unp	7385435c7fda6ab69739e79cdc01bcb90b1c5378	0	\N	2020-05-20 13:34:42.675373	2020-07-23 21:30:10.955402	{ }	GLNWIZXWBNAU	gcWDVWlRQZot	\N	t
4	2	Radio Schedule	cam-6zz-pmk	417c93e0ef6aad897c3158cd12a8ed818dfaa5c4	1	2020-04-05 20:51:25.477202	2020-04-05 20:51:11.192585	2020-04-05 20:51:25.478186	{"muteOnStart":true,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	ozzYBjLOlooO	iRzItWzbESRT		f
232	164	Home Room	son-fyn-qzc	ta4mdj8sgtlhyv6njacholl0hpxjtgfm6ps34pyf	0	\N	2020-07-10 22:51:21.704311	2020-07-23 21:58:30.006689	{ }	ozeMTxOTftbL	NnPTVZBFYwrb	\N	t
102	68	Home Room	c-m-jaz-9z6	f6800bfea73469a371fbc6aecedf413c5888dfb9	0	\N	2020-05-14 22:35:04.211738	2020-07-23 21:30:25.771758	{ }	EJohjdotELaJ	JvczfIZDOIlV	\N	t
2	1	openSAP Webinar	adm-xpt-jh4	fad355d960ec80347371ab83375161fefc071622	21	2020-04-17 22:37:01.405049	2020-04-05 20:39:36.53748	2020-07-30 15:28:41.218744	{"muteOnStart":true,"requireModeratorApproval":false,"anyoneCanStart":true,"joinModerator":true}	rNaOOEnvZHEO	daPhUNfCMDzc		t
27	18	KW Multicultural LSP Workshop test	kw--eqy-zf7	bab6ad16d14b009de52d771141becd66f8ea1d4e	2	2020-04-16 19:19:14.883268	2020-04-16 15:03:54.374493	2020-04-16 19:27:12.394546	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	kscIBTIctraU	HZxWeCQAyRtN	771628	t
98	64	Ev Odası	ban-wjg-ctd	85e0f4ec49d15e8599e6d1b8d06d44fca24e1a9a	0	\N	2020-05-14 16:30:21.111729	2020-07-23 21:30:51.424198	{ }	KkZtsAUASvOM	oKSfRDoaoVuI	\N	t
48	28	Home Room	hum-haf-fg2	6adca9640d1014fce48b17595d447c254e86414e	0	\N	2020-04-27 14:28:32.703787	2020-08-09 14:42:43.088123	{ }	PcjtjiJOQkdO	cBaQfZtgSOvd	\N	t
107	72	Home Room	lau-93q-29q	64401d96b3b7ed5523b7cacb04acec55f90da432	3	2020-05-29 12:50:41.10702	2020-05-21 13:27:21.019149	2020-07-23 21:31:09.24445	{ }	QOGDFhJOrUlR	ypurwgJJvzbo	\N	t
154	107	Home Room	sah-np4-73t	d4e81b833ceaf90e399a46776cb99752250f55a9	0	\N	2020-06-11 16:32:10.089976	2020-07-23 21:33:03.945974	{ }	LsvIzolQJDzY	DUNZDybjJmng	\N	t
8	6	Home Room	far-mhd-c9c	2dc50d9c9d8cc849c8aa33ae33493959346916f8	0	\N	2020-04-05 22:51:47.691356	2020-04-05 22:51:47.691356	{ }	yBipSoIjQdxI	TIUNWWTbKMbv	\N	f
123	87	Home Room	ben-fky-ahq	e8bddc60d62003629bfbb6d4cad81967c5a133e7	0	\N	2020-05-29 18:04:51.264864	2020-07-23 21:35:56.746738	{ }	vTbeLiYKmYgj	nqxOIKJLetvb	\N	t
126	88	Home Room	cry-u9v-2wr	af39b612e50bc94e8758c1fc32f35cf9e587d9a7	1	2020-06-03 01:34:33.583449	2020-05-30 12:52:07.771061	2020-07-23 21:36:32.326547	{ }	EhgZZMcCAXMv	UtJMYrUxuwiq	\N	t
198	138	Home Room	con-phn-kzp	fb870818e70de560cacd11a1ff79e5c2ca582587	0	\N	2020-06-25 14:15:23.1951	2020-09-08 16:39:10.384376	{ }	qqtSAtNpQkPe	jxvWldwdOVQy	\N	t
265	181	Home Room	rha-uce-sxn	zg9izhbckqezusq0fbmex6ndyuoow4dsdt08qh6h	1	2020-08-07 18:23:08.608042	2020-08-07 18:23:00.474109	2020-09-09 13:55:25.016788	{ }	zWNEiLXmccXk	uuauuifFbGJL	\N	t
5	3	Home Room	ros-f4f-hv3	f377b0576af426a180b65b64de6225c158a8887a	0	\N	2020-04-05 21:13:57.442648	2020-07-23 21:08:21.524029	{ }	MqmlmJVQmlXE	ghZzKFramBQy	\N	t
6	4	Home Room	les-kvw-uq2	9f2e19528966d552b5b6af61a5c6e18246f76f71	6	2020-04-05 22:42:05.490218	2020-04-05 22:10:46.035206	2020-07-23 21:08:29.148265	{ }	mbaLkepxcopP	CTZaDsjQNIsG	\N	t
7	5	Home Room	ais-yvt-2pt	13a86a9c62501923114a20ff9130ecb262d803cb	0	\N	2020-04-05 22:15:55.570141	2020-07-23 21:08:37.118765	{ }	gYKprhdZRrof	BLVAvcffOiLO	\N	t
9	7	Home Room	tif-469-jg3	bc20aa7ceef414a034b62bac470404047e498dff	1	2020-04-06 02:28:44.878604	2020-04-06 02:28:38.887084	2020-07-23 21:08:45.020451	{ }	KZRfPfPZOFPT	cmyTMdXXzTSt	\N	t
14	5	IDEA TO ACTION	ais-7qv-ezc	2c27443c16696c52d2dee0082cf1ce5c0807d9dd	1	2020-04-06 21:25:29.416173	2020-04-06 21:25:29.281053	2020-04-06 21:29:13.628868	{"muteOnStart":true,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	oeiLnPWaBzwA	uUGRulOsRfen		t
11	9	Home Room	jad-zqu-xe2	d91a679a73047079a155f1012599245ab51d947f	1	2020-04-06 16:10:58.703615	2020-04-06 16:10:07.618685	2020-07-23 21:08:56.68664	{ }	nNEKbgKKOFvd	mHdAOrQVBppm	\N	t
16	12	Home Room	mar-zhf-wmw	43e6e89d37e34e651583be1eef1b3c033e59e351	0	\N	2020-04-08 16:31:25.919451	2020-07-23 21:09:24.441023	{ }	JzIvmzuznBoy	pVOpwUQRkIZO	\N	t
17	13	Home Room	kei-p4f-cam	19ce4eee4f5e6544d1fede9b0ad1fe4e36c4d1f3	0	\N	2020-04-08 18:06:33.405779	2020-07-23 21:09:31.502157	{ }	fByFyIOxTpVr	TGflHpFkybzg	\N	t
20	15	Home Room	phi-emt-e4m	7883a29f2edefa4297a0bb10d0c69c8ec4133cfb	0	\N	2020-04-09 17:40:37.99747	2020-07-23 21:10:15.666565	{ }	FQYgQpIqCgpC	xnjDmxiFMbig	\N	t
23	16	Home Room	ben-xn6-hfg	82f9d5aefbf5c77f6a100638262d51b5a1be520a	0	\N	2020-04-13 18:20:44.221203	2020-07-23 21:11:39.341661	{ }	ykbYCNCGomCX	OZpOdxZRhaMu	\N	t
28	18	LSP Test	kw--u32-yzt	a6c20fe59097524b430786f8399faca113825c8c	5	2020-04-29 20:08:38.585339	2020-04-16 19:33:22.086726	2020-07-23 21:12:17.044018	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	WdaEzseQAbBv	UdGkVkZgGFsJ	817299	t
25	18	Home Room	kw--vm6-wew	f800ed3263f5c2a712c974d474b6251ae81ca55c	1	2020-04-16 15:01:20.713721	2020-04-15 14:29:28.85735	2020-07-23 21:12:17.045332	{ }	NozwTwpuxUKp	lggGPuUlAkEb	\N	t
26	19	Home Room	ham-vye-xgm	9c3f4b9933696ad55f68430999c0ae179beb922d	0	\N	2020-04-16 00:07:06.473134	2020-07-23 21:12:25.373972	{ }	jaqLQvqweoSR	wOECRViKkYiV	\N	t
35	24	Home Room	ann-24n-fzm	33e74ce2132a5c65103007fac86679a9920bff2f	0	\N	2020-04-18 17:01:20.176692	2020-07-23 21:15:21.031138	{ }	TowwGClyRFDN	iywMoZcocoXU	\N	t
31	21	Home Room	car-tw2-nc9	f77a2eb73a46d487cd3e3fb9f86b8f726d5b84dc	0	\N	2020-04-17 17:32:58.390277	2020-07-23 21:15:31.117398	{ }	kKYRRJYDcBGx	qEAeVLLyIFTd	\N	t
65	38	Home Room	sha-vt2-r9f	c5ee66cd62209cccba3309b9f6542038b03e72db	0	\N	2020-05-02 02:15:18.205811	2020-07-23 21:15:53.77248	{ }	cEAUExnrbhsb	hdBMgaQLEQbD	\N	t
49	29	Home Room	sam-ned-jvy	97b985235dce047de00fcaf2ee8fb39402d489d5	0	\N	2020-04-27 14:29:00.191844	2020-07-23 21:16:31.84011	{ }	dmvkPXqZXTSG	ekVElDLJEUfg	\N	t
34	23	Home Room	sol-3vt-qgy	e292ede39911e3e87257aa95939356dbc0cfedaf	0	\N	2020-04-18 16:35:53.326652	2020-07-23 21:16:43.436294	{ }	XZIiYgJkjsXE	nuTidZtkarMK	\N	t
19	14	Home Room	kim-afv-c2v	1c03c9e6d6acd9f3575992af2438b9c47bae1140	0	\N	2020-04-09 02:19:23.008588	2020-04-09 02:19:23.008588	{ }	XanBMcGtpFfZ	jXOEQypUCXqd	\N	f
33	22	Home Room	luc-he3-xdx	a52f51357b871934e635f66aa078f1bc2b787484	0	\N	2020-04-18 16:31:50.609236	2020-07-23 21:16:53.919659	{ }	vmlhrddlYeDa	ptkJGuPgUgfe	\N	t
37	26	Home Room	zet-9xj-d2a	e6718e6340c0cba8aa083923cdaeacb8473155e9	0	\N	2020-04-18 19:43:53.551631	2020-07-23 21:17:03.232808	{ }	gFAAvTXmfPvQ	wvPMRrhHHgrp	\N	t
52	32	Home Room	car-t47-vyf	6d2cf9ae220575981bceaf664d833e4b1ea3efe2	0	\N	2020-04-28 14:56:50.877411	2020-07-23 21:18:00.535121	{ }	VOZextYBjHdR	OrcYCzyGyISX	\N	t
38	10	LSP	ani-rhw-gfx	1c1e6c3c79e98f77dbfb47374ad21ddb7a264201	0	\N	2020-04-20 14:19:06.114631	2020-04-23 15:35:45.349982	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	lhpmaRHROsbZ	QXSOdlBielKY	008089	t
45	1	DJ Minks - House Party	adm-txj-k6z	543ee28d78f93d784e4dbd8ffbe6b1735bb270fe	1	2020-05-02 00:02:16.984993	2020-04-24 01:23:19.662993	2020-06-25 05:10:24.039403	{"muteOnStart":false,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	aejoxVihkOly	cLKOOBtmghIL		t
54	33	Home Room	ani-few-7ry	48793379427a2877f6abfabd460954b31ef371fb	0	\N	2020-04-29 00:15:17.533146	2020-07-23 21:18:14.373506	{ }	LjcDCbHLEXWM	wkukIDindWcP	\N	t
254	174	Home Room	gbo-i26-n57	cdildzckt71zzafqtg6wqohy8luqegd98i46caut	3	2020-07-31 23:03:53.500793	2020-07-31 22:51:58.151906	2020-09-11 18:21:35.123904	{ }	QruxOIhLnBJH	KiqiGQMSaaPl	\N	t
46	27	Testing	far-mvu-a4q	48fe67bebb553df0ed29a726e4717b8a11ad0e0f	3	2020-04-25 18:22:31.126717	2020-04-25 18:15:48.547735	2020-04-25 19:07:07.268574	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	bGmRshMzprEa	AaqvuMtwZFwR		t
99	65	Salle d’Accueil	may-vae-en4	2947aabc1228919891a94cb0025230bab61f7499	0	\N	2020-05-14 17:35:37.269982	2020-07-23 21:18:48.719352	{ }	EnldcokRPPmT	NpFvmgvrlvyj	\N	t
236	168	Home Room	mic-czm-pxh	rojev5binxcqnzxgbwwb0u8kwx1cnbatsrkr6fh2	0	\N	2020-07-14 21:16:14.747392	2020-08-09 14:40:55.14208	{ }	KiAwfBwxUgxd	qITkpZgAwAfA	\N	t
64	1	Dream Tingz	adm-txm-6gy	b7fe80f7bf4db82170f8b261d8ab8dd0493b0bd2	0	\N	2020-05-02 01:58:03.343862	2020-05-02 22:54:25.908736	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	PDRJByCoLLuL	MihuSnzlNfll	\N	t
70	43	Home Room	sid-4ej-7yh	877ad0ab33145dd60c3326b58f14679cd0da426b	0	\N	2020-05-03 02:44:36.313721	2020-05-03 02:44:36.313721	{ }	XXozzxYKjEYK	AvYmtHXXiYzP	\N	f
67	40	Home Room	tah-a7w-66z	fe65d8b9a3936364aa42f2f8f1a4c58f2f7814c6	0	\N	2020-05-02 13:17:30.358947	2020-07-23 21:24:01.75414	{ }	GRyWhOFGHQgo	zWCPgIMQnnwj	\N	t
238	166	Home Room	kan-bqm-5tu	xdwvrcw4di6o7ignstbx48iyezgosfox3ysha0pm	0	\N	2020-07-14 21:16:20.721635	2020-08-09 14:43:27.333441	{ }	lITwRjuecTuP	VQGLHGdnuWll	\N	t
68	41	Home Room	cla-qxz-3nd	7909af33e530971cabede5d1402db423d80027ff	0	\N	2020-05-02 21:12:05.224421	2020-07-23 21:24:10.847734	{ }	TYaMRQashrVp	UoKhGXQPPXTp	\N	t
71	44	Home Room	kar-wph-4ew	aa642d5687d351f32c62a79549a85c74472aed58	2	2020-05-03 03:14:21.884535	2020-05-03 03:06:50.924398	2020-07-23 21:26:26.006711	{ }	ioYUNLzmDBKv	izeZFWhGViuv	\N	t
78	50	Home Room	mic-62c-rtq	31c58acf3c995021347fb1be87aa807009f1e781	0	\N	2020-05-04 20:34:22.616496	2020-07-23 21:26:44.828222	{ }	lQkAWwoPWtSB	NdIqaqdIdofu	\N	t
75	48	Home Room	pau-znw-6nx	59c1041a1f8e47f5056ac11168034c5f908adabb	2	2020-06-25 16:06:43.8886	2020-05-04 16:47:56.991364	2020-07-23 21:26:52.61642	{ }	LTsHJtjGpmuS	VGguBVRTcTOG	\N	t
74	47	Home Room	ali-r9h-urk	31e4ccdaa2c8cf93c614d26a9d873b16cdba5eec	0	\N	2020-05-04 16:40:14.696864	2020-07-23 21:27:00.076083	{ }	VlujrpHvEcdG	olHenGkcriyb	\N	t
53	17	PEP Module 1 - Day 2	kwm-geu-akj	33ee7bceb6422461ec17cf4c9b6f30ef8f7484a9	2	2020-04-29 16:30:28.142314	2020-04-28 19:00:41.951421	2020-06-19 16:09:32.294871	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	nIxWlJqaODcO	OhhaSqRrSJEa		t
15	11	Home Room	jad-gyh-vn7	23a4028f9a749dc262d3534d515c8cdc2a045cc4	15	2020-08-21 19:33:06.565141	2020-04-08 01:30:49.539138	2020-08-21 19:33:06.566158	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	BhbmTQgITjPK	JsQzfbUTzOuS		f
61	17	Module 1 - Day 4	kwm-w6x-whj	09d2180083ed4e00f346a728dab8bf43e746ac5c	2	2020-05-01 16:29:00.201534	2020-04-30 19:57:16.364984	2020-06-19 16:09:41.381935	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	nZUpdqFjAYTm	NFZGePVJQwWU		t
116	80	Home Room	lis-htw-cfd	fb596a159756a7b9fb5f68599890cb325381fd4e	5	2020-06-30 21:50:51.264451	2020-05-28 15:13:05.677092	2020-09-08 16:39:29.242867	{ }	iwADBiTIaFpw	NyCDQaXvLfeu	\N	t
73	46	Home Room	sha-6ze-dx9	d91978ba0b375ba0a97af76fae08090a51737da4	1	2020-05-04 15:36:35.502676	2020-05-04 15:17:15.383453	2020-07-23 21:27:06.636174	{ }	HvzSzLsZfCdP	edsRYzkRHlbE	\N	t
60	17	PEP Module 1 - Day 3	kwm-pcf-a62	8acbe7a21103762244007cf0160001df3a5adf59	2	2020-04-30 16:29:28.439672	2020-04-29 20:21:24.278344	2020-06-19 16:09:56.303333	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	HlcNNnNTVWfN	qpgjdVuYmTTt		t
69	42	Home Room	ive-rmy-cyt	7eb8559687370a68dfabdfc30f504019a82dd32e	0	\N	2020-05-02 21:32:26.410479	2020-07-23 21:27:17.294983	{ }	eITuWEEclnGQ	BTkDscnbnbSn	\N	t
55	27	test	far-n97-t4e	93125381adb73cd1b6d276a9fecac5c9053594c3	1	2020-04-29 04:46:40.803404	2020-04-29 04:46:34.851838	2020-04-29 04:51:53.231439	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	mtHwZYOscDMr	mmXNbVYCWnmR		t
111	75	Home Room	ter-dxp-j6c	57b0f9484bb0086ec4051e6334ff4b4f7792eec9	0	\N	2020-05-23 23:25:52.266038	2020-07-23 21:28:16.078215	{ }	BIPWIuPbEyyE	fHqtSIclUEQo	\N	t
114	78	Home Room	kyr-mmg-dh6	3ae3f399a9b2dbd49342448166fae2147024ffd0	0	\N	2020-05-27 16:58:54.261174	2020-07-23 21:29:22.826424	{ }	jYAOceZrFVcu	xphOZnEpndWC	\N	t
103	69	Home Room	jus-2kd-jf6	238d943de6082783e15153d8513e1314f0c60a56	0	\N	2020-05-15 17:58:57.358139	2020-07-23 21:31:00.398752	{ }	BiGomkcBKbtY	vVdSwyxZiYZC	\N	t
199	139	Home Room	fel-qdp-dmc	5e8022da4c581a94ae8649f21b2a2d0bd0df1a76	0	\N	2020-06-26 14:57:08.320505	2020-07-23 21:37:28.979833	{ }	rclUZVopiczK	nRSakDSjQqtE	\N	t
266	182	Home Room	kay-z8v-psq	mltc0fj2cpjsc56spzt7f25tnfoveklsxe9bfl9w	1	2020-08-07 18:29:33.054398	2020-08-07 18:29:27.683577	2020-09-09 13:55:16.161784	{ }	AZUxnvkoCMIg	lxVMnZajPMJE	\N	t
58	2	KWMC	cam-rem-rha	dfe2e14db07e472c44f8b922b587bece0746abec	1	2020-04-29 19:44:31.324045	2020-04-29 19:43:37.87094	2020-04-29 19:44:31.325216	{"muteOnStart":false,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	DcXFesAAkGnT	GklzglqSDfXs		f
77	49	Home Room	cin-dnz-4ch	e045157662cbe9857c8208b5c5f212efb0e44f69	0	\N	2020-05-04 19:19:19.886341	2020-07-21 23:31:40.332601	{ }	zOmbMZxGDoKn	QrklAysqgkAi	\N	t
233	163	Home Room	sco-vqu-5w5	cayu6fjmktj4ntjp8fob9lauwgzywnlt6uwoenef	0	\N	2020-07-10 22:51:26.492142	2020-07-23 21:08:04.432445	{ }	sESNGXcsVjlL	rveROlqXAQKK	\N	t
13	10	Home Room	ani-znh-ee3	de0b62ab17910b15a46f586413d061af77357cf8	31	2020-05-07 16:40:22.710986	2020-04-06 17:56:09.46758	2020-07-23 21:09:04.251034	{"muteOnStart":true,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	UEbADSuDNzGB	WybNbEITRFvR		t
66	39	Home Room	jor-zea-mrn	9925d6182a557006899cd946a810273d8caa0e95	0	\N	2020-05-02 03:27:07.519145	2020-07-23 21:15:46.673138	{ }	GuCtXRSXFSQD	VnZlENAuWnDG	\N	t
62	37	Home Room	tri-ke9-w9k	e8c706d7aa1fc445256982a06c884228c48cf014	0	\N	2020-05-01 05:46:59.516784	2020-07-23 21:16:00.370037	{ }	hMhHdwHkVjLq	vIsQaVNtAoJL	\N	t
57	35	Home Room	suh-hkd-7h3	70b6f0eaeeb85c0e597bef95e0205f396febcb94	0	\N	2020-04-29 16:13:05.043233	2020-07-23 21:16:16.590305	{ }	fmItFXPgAHVL	oXKJmRGEPJhR	\N	t
43	27	Home Room	far-446-2e6	78464729c91c085ba1c74e59d8021907548583c4	1	2020-04-25 19:08:07.505668	2020-04-23 01:31:27.68007	2020-07-23 21:17:12.227731	{ }	IdtbPvDbJuPC	DqaffWpMUgkh	\N	t
171	121	Home Room	emi-rkd-yhn	dbb7ea6f336a42e529e484c9a5246cd185f4a5cd	2	2020-07-01 13:28:42.947259	2020-06-19 14:20:10.147988	2020-07-23 21:43:43.481238	{ }	txFpjKmupdqH	vJHdgwSFwvGN	\N	t
50	30	Home Room	kha-apq-nfa	f645a73c7742caaa4196155fe29d0ec029a364b0	0	\N	2020-04-27 16:41:25.576389	2020-07-23 21:17:25.892523	{ }	YGiPBNGKZHbD	JsVLiCfcEzqV	\N	t
56	34	Home Room	had-u2e-6xr	c8835b18698b6612ab63e6445901c2c535b98de7	0	\N	2020-04-29 14:18:19.681621	2020-07-23 21:18:07.821264	{ }	qHGByOgtrseN	BPhBsDvyYmUF	\N	t
63	17	Friday test	kwm-96z-c3f	a84ef7345004b734a2618fda5b78be63fc228a82	2	2020-05-01 13:55:27.609214	2020-05-01 13:32:42.735302	2020-05-01 16:28:52.798885	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	EHOHJOjIvLeF	aqnDQGUlSzhY		t
105	48	Curls Understood	pau-tk9-7ag	13ec65f534d6114a023bde572bf80a8e74ea18be	2	2020-05-26 18:02:14.162999	2020-05-20 14:31:02.008592	2020-07-23 21:26:52.619152	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	ssmnotRtfUJP	JHojxkrYsDYE		t
121	85	Home Room	dom-kn4-tmy	8323fe2450b628351e390c51d161bdcce10d515b	0	\N	2020-05-29 16:01:23.320241	2020-07-23 21:28:23.675408	{ }	nnfEJipWtkBI	RfItJPxOMDZR	\N	t
117	81	Home Room	san-g7f-zzf	e915b9ca07d11031a423d4d6396fbfcbcab506bc	0	\N	2020-05-28 18:47:18.012837	2020-07-23 21:28:56.373303	{ }	OPmQRAKuxcZv	IFYHPoQXGneh	\N	t
212	149	Home Room	ali-noe-w8k	h9djpw86tlrywjbwb7linjb0twetzodmlvzgnh66	0	\N	2020-07-02 19:28:29.013218	2020-08-09 14:41:58.228344	{ }	neQGKgiKgPJJ	WRrJZnugzzSS	\N	t
219	152	Home Room	kar-twe-kly	oj00fnyavww1mwmm6qnnirhupnzivuikzsth55ky	0	\N	2020-07-06 13:06:54.031911	2020-07-23 21:46:58.583686	{ }	YgoqVxgvLadX	eOfNzArQyXZN	\N	t
124	1	Mink’s Birthday Celebration	adm-ety-caf	6b6046275bea43a15e332b917e960e09c74a3681	3	2020-06-12 12:34:05.964064	2020-05-29 22:23:00.23454	2020-06-25 05:09:59.488864	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	izUraZdTnRKW	KpBWQUoyDkZA		t
127	1	You Are Tech: Technically Speaking	adm-f3u-79e	77012de39aa54b652edf58f777b94c74b922019a	2	2020-06-04 16:39:05.735423	2020-06-01 17:57:33.004216	2020-06-25 05:10:13.762748	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	TqTGEUypMbKl	IrzsAeNwTdiM		t
133	1	OYW North America 	adm-cze-zqz	3b787034e28c3d3a885accbcf45af6bb86792d6c	3	2020-06-11 18:40:12.723439	2020-06-04 21:19:17.23666	2020-06-25 05:10:50.788805	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	FJYpXKYnGzDP	ugFkpQiYzifF	287086	t
112	76	Home Room	ton-xee-uj6	754afca06a59fa28d8532393d8f641af9075e8d3	0	\N	2020-05-24 01:41:25.750077	2020-07-23 21:29:55.620456	{ }	imsvwVenogZk	QYnSppoQiaSV	\N	t
139	9	Black Girl Like Me: Virtual Connect	jad-t69-qwz	2b109a6040c31b29d7121ff74c03c262551a4df4	0	\N	2020-06-08 17:17:19.033662	2020-07-23 21:08:56.685405	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	wjmSDqCNBDDG	swesHgHCYtIy		t
200	140	Home Room	nic-2u3-k9r	4a7ab38a441c01bc8df66147aeaba14f79e402fe	0	\N	2020-06-26 20:01:16.74979	2020-07-23 21:58:45.76447	{ }	ohnJnVahWtGy	QtbIgxnYTnBh	\N	t
22	1	KomiDemo	adm-4uj-6kw	a739e9a73f611e1e6f48e5d231395c582ff9539e	17	2020-06-01 17:51:38.904856	2020-04-13 15:04:38.444867	2020-06-01 17:56:28.593425	{"muteOnStart":false,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	PybDLTTzndmD	roOAnPMVLJDN		t
12	1	KW Multicultural Centre	adm-g3g-9m2	5c6f2d905a42f4b47a0fcbb5f319707d9caded8e	6	2020-04-29 19:30:46.625103	2020-04-06 16:54:47.01936	2020-06-01 17:56:43.922343	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	vcIMpstolqSG	gmqQOzfDoAwO		t
76	1	Reception House	adm-kvp-9kn	349e4373c5f67e66e2013b6494f1f716cc0bb03c	3	2020-05-05 13:23:44.702681	2020-05-04 17:38:08.542941	2020-06-01 17:56:50.44199	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	zqFjunIBXBOv	fJhdfJPizZBS		t
108	17	Getting Connected	kwm-ema-jzr	a7aa28841e49402976575163ba783eb3fd8883ab	2	2020-05-28 13:27:48.768258	2020-05-21 13:51:56.599997	2020-07-24 15:26:12.77577	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	rtGBIFdDboiK	YvzrnDmzZYDG		t
30	10	Let's Talk Program	ani-nwh-wge	07a42a0b6e664c8846705ea64bf508ee1127a24d	12	2020-05-19 18:00:20.380596	2020-04-17 16:19:49.266586	2020-07-23 21:09:04.248982	{"muteOnStart":true,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	NaWinYgIZgmS	BThBcJCXXLeU		t
285	195	Home Room	rya-dgx-gt6	mxjtsxagadok4kidb9stoboxkvkmnhruv4qn14rr	1	2020-09-13 02:39:30.857235	2020-09-13 02:39:26.568828	2020-09-13 02:39:30.858019	{ }	MuiEDVCNCVBZ	TkyPTJFBwHcF	\N	f
288	196	Home Room	gre-gax-iuf	pfgu6eoj0kdm6gf5rfwinmsufdnsvfbvwrkn9per	0	\N	2020-09-16 14:35:38.792427	2020-09-16 14:35:38.792427	{ }	hCoKMCdfLAjH	LeafpKNyWvVB	\N	f
272	187	Home Room	sha-he8-1xf	tzrwcimzfu3jrgganm3uupdcen8trdv7oycvyfpf	0	\N	2020-08-13 21:32:23.723987	2020-09-09 13:54:38.594054	{ }	ohOcWFonbAVE	gtSOyIyXTLSx	\N	t
267	183	Home Room	nat-kzu-h3d	rpxwn8qn9rzz6dzmjdp44ly5tqt0wfozb5ke4fnu	0	\N	2020-08-10 18:30:49.016257	2020-09-09 13:55:09.354162	{ }	NXGulwyaRTnA	ssxVobUCRWSR	\N	t
59	36	Home Room	sha-392-y23	8de9d28fef00b759b1a5affbcd61ac0ce9111514	1	2020-06-08 17:06:10.29409	2020-04-29 19:45:17.029345	2020-07-23 21:16:06.734239	{ }	gVooTKpiOElJ	FKlnbWdTlvfw	\N	t
152	106	Home Room	ade-jtw-d24	fb44cae1c5b688a8894f6916b899708d62bbf146	1	2020-06-12 21:00:09.729781	2020-06-10 22:30:24.675423	2020-07-23 21:33:12.181591	{ }	WPXbxeVZYRHE	NyWhUFYamuYs	\N	t
151	105	Home Room	eln-kym-yep	c240187bd443c15b6cfabfecb5f9693eee0c7d51	0	\N	2020-06-10 19:23:40.393553	2020-07-23 21:33:30.472615	{ }	uNVVvRGVHYiH	PAnuXCOknGZc	\N	t
150	104	Home Room	eln-jv2-pxn	66c988a1b3159323eb7b5ae3912ed89269f51125	0	\N	2020-06-10 19:21:36.262191	2020-07-23 21:33:48.515371	{ }	DchVyDOEWOCF	GuGcKDuyNVLu	\N	t
297	198	Home Room	ash-npo-44e	njkq8fmazu46kbtubv8xpln3i6mab2pre3dro22y	0	\N	2020-09-24 00:23:56.021968	2020-09-24 00:23:56.021968	{ }	JgiBoBLdgsit	MhaviHHNBcKd	\N	f
148	102	Home Room	kad-k2p-6fd	ee70464910c1611791649994d86f2b4a1ef63c53	0	\N	2020-06-10 14:36:13.856057	2020-07-23 21:33:55.75618	{ }	SYbBKhMdmApJ	GyyLKkjpYIdt	\N	t
144	99	غرفة الإستقبال	kha-xmt-fed	00e8aea152ef79e3fb472b1beab7acc95faae464	0	\N	2020-06-09 00:56:21.04715	2020-07-23 21:34:03.324896	{ }	tHIEfRJkkrIu	LyeGOdNmbELR	\N	t
141	96	Home Room	moh-gkr-zmu	9eca933100cd72eb11720c862738fcd255d00018	0	\N	2020-06-08 19:08:46.787847	2020-07-23 21:34:15.215875	{ }	zYSFipKWGvFB	HrlQznAQbxLT	\N	t
149	103	Home Room	tan-27h-ah4	359a007392806e2a5b9d7319563b75c59a88a33b	0	\N	2020-06-10 19:15:48.613118	2020-07-23 21:34:30.170746	{ }	BnUIpuwnqkfs	JJUKOhlXdXCA	\N	t
146	100	Home Room	isl-jhw-vw7	bcdd9dbd709de80daaf1c164517d4f182e9b81b6	0	\N	2020-06-09 13:27:24.34465	2020-07-23 21:34:45.321	{ }	AmMJrxtwXOYW	hIRkPpQcDuuL	\N	t
142	97	Home Room	tha-3x6-ev9	c1dd50f3c4c8bf7c2b4f0857ad77d5517f248e93	3	2020-06-09 15:12:37.81138	2020-06-08 19:11:20.389907	2020-07-23 21:35:26.36603	{ }	FyOdTRmIZIam	iPXnQdVvuUZv	\N	t
145	97	تدريب السيفتي 	tha-4jj-2ug	c46015a5ff70371ff34dbeeee2eb94506cbe651d	4	2020-06-09 15:11:23.433479	2020-06-09 11:52:09.750034	2020-07-23 21:35:26.367235	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	KWiSjmEjnKbP	uXRYXWEYROXJ		t
129	88	HoneyBooks	cry-uj7-a4j	e257fae3492c41a27c99de17759f6803b3304d0f	3	2020-06-03 01:14:06.199695	2020-06-03 00:56:49.266371	2020-07-23 21:36:32.327898	{"muteOnStart":false,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	FVffbSnnyMCG	rzZMbeJxBOhB		t
135	31	Call with AkhyRal	ech-zcc-2dw	4fc350ddaf810e2dbd1a2488bddd9fa508b86d14	1	2020-06-05 19:06:40.497982	2020-06-05 19:06:40.389988	2020-06-05 19:07:20.700348	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":true,"joinModerator":false}	XmAyFBYmmvRR	YNbWVMCGNORw		t
143	98	غرفة الإستقبال	abd-vzx-ch9	44fbcb5145c9e0b5eef3f38da6ad32f78160a5dd	0	\N	2020-06-08 22:19:05.366691	2020-07-23 21:36:52.66657	{ }	vTFODghZXRXb	LIEsSDOiVMqO	\N	t
131	91	Home Room	aly-zdy-hnx	229b91a1678eb00fee02da471f46a77b25273cfe	0	\N	2020-06-03 15:15:05.739967	2020-07-23 21:37:08.274338	{ }	rEbYWSShAcOR	YxnpynqFixXF	\N	t
136	31	Call with AkhyRal	ech-t4z-hd7	9f4f49d7f253b4512aff4213683bbb522f7ad1da	1	2020-06-05 19:07:47.980371	2020-06-05 19:07:47.909672	2020-06-05 19:21:36.934701	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":true,"joinModerator":false}	UGeAjUOdRkwd	jfdzVqlIlbNv	467447	t
36	25	Home Room	med-xzk-y33	81902354f86335d0b9a0ae78ce047af6e349cf9b	9	2020-08-14 17:59:04.085247	2020-04-18 19:42:53.524579	2020-09-27 13:19:24.915344	{ }	dJONWHfStgFx	biTUhLzeqzIv	\N	f
242	170	Home Room	ani-v1u-fjz	vwki6k6nygpc9ejhujszruo4oklya1zl0mbahr7f	0	\N	2020-07-21 02:54:07.947305	2020-08-09 14:40:21.237315	{ }	bMOjydtHreFH	JqvSCYfdjGXp	\N	t
237	167	Home Room	dan-wpq-uro	hy5yveki7mpwkhl4gdjhftlwjflsvlui628vpwty	2	2020-07-14 21:21:36.158708	2020-07-14 21:16:18.109617	2020-08-09 14:41:40.066701	{ }	QfMBTKUDVKja	nnqYCfcIGBdo	\N	t
247	172	Home Room	zer-6j7-2zx	pm7w4hjpohfzelfhxcl80ne64nuhbhvrltwjfcpm	0	\N	2020-07-27 05:18:49.817918	2020-09-11 18:20:55.114729	{ }	qDawofBWSobE	WSNTcGujMrBx	\N	t
132	1	Healing Circle	adm-69q-w4j	8a3e20bdcd82b09486295dc798e068695f5aa163	1	2020-06-06 15:23:06.67054	2020-06-04 20:11:59.731225	2020-06-25 05:10:35.948047	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	OiHWjHVmBUXl	bNNCDHFFFcSv		t
40	1	Design Team Call	adm-af3-xxz	6fff033dc3dbb95c40c7c706c7f5b2f184d0c629	5	2020-05-28 23:12:18.041431	2020-04-20 19:46:51.955348	2020-06-25 05:11:00.140248	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	YAyuVgTVhoqR	rpwDgtsnaWhd		t
286	1	Pittsburgh Conference	adm-h9y-e2y	bondaxzuoanewa0rheuppxr35bnrxc1drcnqzoru	1	2020-09-15 15:21:21.737462	2020-09-15 15:20:53.798084	2020-09-15 15:21:21.73899	{"muteOnStart":false,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	syFpTJCSuyhQ	CMlxiDoQNRuO		f
94	61	Home Room	tan-txy-vaf	f00e43c71cbbc0dca22f622543f9308b93bd1f23	0	\N	2020-05-09 00:42:34.969627	2020-07-21 23:32:11.068011	{ }	qNlmRUINgZxP	uaZIZPoyOUaE	\N	t
101	67	Home Room	wil-nce-yh6	347da32a40f876e747f259d1dddd2cf78da6015a	0	\N	2020-05-14 20:38:47.560794	2020-07-23 21:18:28.171149	{ }	GIzhRfeakZAW	OLZFytxMVmxF	\N	t
125	1	The Innovation Continues	adm-uh7-wmd	a7f1d8f0e34f907cea7f3907a4469c5c6fc15d32	0	\N	2020-05-29 23:34:58.771711	2020-05-29 23:34:58.771711	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	xLBLgNdKhtNx	NTsrMHvNjqHS		f
88	57	Home Room	sha-6na-4tr	e0494b0d6e018948d5172e84b5fc1d3fa18ca513	0	\N	2020-05-06 05:13:54.810869	2020-07-23 21:18:36.525648	{ }	ANTCmpMULJLi	IYavzvOBTXxZ	\N	t
100	66	Home Room	tai-rq2-f2n	3bf5b8846fd71c3157739670024ddc39cdc4fc00	0	\N	2020-05-14 20:31:05.288183	2020-07-23 21:18:42.099765	{ }	SWqxxeNodRgs	LYPHuLStrOSS	\N	t
201	141	Salle d’Accueil	han-mga-fqj	5e2d6b07d16503979e5c908b6b8a30440f8e63f2	0	\N	2020-06-26 22:36:23.892523	2020-07-23 21:23:36.984937	{ }	wIawVwBdlDsL	TChVgHGxgUuS	\N	t
86	55	Full Moon Ceremony	row-gwe-ynj	a6124f1fc50cdb4564923a64761f47d6fcade475	3	2020-05-07 23:51:26.726922	2020-05-05 18:26:12.056148	2020-07-23 21:24:17.469236	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	DkpSqZYmUPDG	eYUxjVuYJzmL		t
83	54	Home Room	kaz-pgu-qxp	4365d255d79ce0e905b39e9893284273d9489c97	30	2020-06-30 20:42:18.901585	2020-05-05 14:21:11.091813	2020-07-23 21:24:24.815962	{ }	OxxobvnolQMc	XcBhGdFpsOHc	\N	t
82	53	Salle d’Accueil	cat-wgq-37a	ff17f4438f93011677a7dd9f0fe9ab01b0133331	0	\N	2020-05-05 03:41:41.14435	2020-07-23 21:24:32.389514	{ }	ppjsJhFDAvdm	owDXYDkZVCYA	\N	t
81	52	Home Room	mic-cea-nkc	2a2ca0cf7370ea098ac68097aa85874e22ca7895	0	\N	2020-05-05 00:35:14.585711	2020-07-23 21:24:39.793011	{ }	gUHeksAvKxlN	ubhjJFtxdLPJ	\N	t
80	51	Basher Sesh	orn-ddh-kwh	29e84c52a8b05bfb7a156d963789032392068e8c	0	\N	2020-05-05 00:30:17.719877	2020-07-23 21:26:33.709028	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	hCmEcKCGkNpA	eixnLYaGaPqi		t
79	51	Home Room	orn-uft-c44	4929ee53c4150c57e9402d4c40879757b79b9bcc	0	\N	2020-05-04 23:02:32.996563	2020-07-23 21:26:33.710258	{ }	xUhDWySakFqu	DYNWxseHxeZx	\N	t
84	48	Curls Understood Youth Edition	pau-ah6-6d9	a0a42e44d4d26fcf94263ea18e0637a467ba3c69	4	2020-05-26 20:04:28.20559	2020-05-05 15:16:49.647966	2020-07-23 21:26:52.618379	{"muteOnStart":false,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	NVqevZvkbobE	dVausJeJNzjs		t
91	17	PEP Module 2 	kwm-v2r-pk3	252c47eb6a0b39814ef6b8fea721017a0386a86f	8	2020-05-15 13:21:14.51929	2020-05-08 13:11:06.120948	2020-06-24 16:34:41.318293	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	GjMxVkdYCiIk	CKgTWgGczvzM		t
3	2	Home Room	cam-zxx-xzr	c9e6d57a4d6a3bd42706c871a4eb449216b634e2	4	2020-07-09 20:18:09.028723	2020-04-05 20:49:40.782549	2020-07-09 20:18:09.029605	{ }	eGqAxlZnUeBG	FwlwFmquuDqI	\N	f
72	45	Home Room	rhe-az4-e3r	3c96451ef28917784dbdc3584da7b26fff0669dc	18	2020-07-03 17:17:43.465785	2020-05-03 20:58:44.729193	2020-07-23 21:27:30.02725	{ }	tSjlMOVBPtYi	ddFMFYulppwW	\N	t
97	56	Jennifer & Khayriyyah	jen-k3p-6za	debe5f11d4829e54d7f0eb5cb06785a1b9e17c4a	0	\N	2020-05-11 17:23:54.243999	2020-07-23 21:27:41.981987	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	CRTsGRrQHxJK	BbfbWGDmvbUn		t
87	56	Home Room	jen-wty-qp7	0b49ccc23c738a939a543f8f00492a68f5bd981d	0	\N	2020-05-05 21:50:16.874606	2020-07-23 21:27:41.983236	{ }	lmSLIKLAuZOt	nZVvIgLYgWtq	\N	t
90	58	Home Room	ili-jqn-r3k	f81003a4121a5713798eb26719af47d5b4ecbc21	0	\N	2020-05-07 22:03:34.91416	2020-07-23 21:27:59.8147	{ }	LuneZBohHMcb	mBLdRssPPJPw	\N	t
92	59	Home Room	ann-q7f-fyp	7595385bdaf901d1b20cd279fbed598bf215c9af	0	\N	2020-05-08 19:21:58.428964	2020-07-23 21:28:08.080615	{ }	MlJsGqqQIgbf	WlbcoTNUIOYQ	\N	t
119	83	Home Room	tel-92j-cxn	8fa932c6a316e33e4bb3866287a4f00b21cc0ad3	11	2020-05-29 18:21:11.270861	2020-05-28 21:01:40.653016	2020-07-23 21:28:47.011145	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	sHeJSnbbNLEI	HkfbTigRhtHP		t
115	79	Home Room	jan-q2k-vua	1797d421699cfba53628c306eb95763fcd699f98	2	2020-05-29 01:01:30.648916	2020-05-27 21:07:10.463083	2020-07-23 21:29:16.147768	{ }	rJpjpuLNqatE	JqnPcifkLlVb	\N	t
109	73	Sala inicial	fer-646-vc9	2b02891209606506a7819440399870b196e33cf0	0	\N	2020-05-22 22:30:42.971358	2020-07-23 21:29:48.661441	{ }	KyuGIjolqSAM	jddinESnLVoW	\N	t
106	71	Home Room	chr-qfp-7a7	6ff7c4e63d423cfd295fd3c78088b0dd1b1ad3c6	0	\N	2020-05-21 09:28:22.855896	2020-07-23 21:30:03.441632	{ }	EVyKdsMFaVOw	kpGYthMiNQSj	\N	t
95	62	Home Room	mel-2qm-nap	0685bbc7d1403b599dfb5564969bd30bd4333ef5	3	2020-05-12 23:44:06.583705	2020-05-09 12:54:13.168277	2020-07-23 21:30:18.846163	{ }	iyVtZoEQtPqM	ISrouontqFSM	\N	t
93	60	Home Room	phi-gnt-hm9	509be593f691ad4eb6bf394bb3debff7704e829b	0	\N	2020-05-08 22:05:06.309498	2020-07-23 21:30:33.767591	{ }	cwTUAfJSooPL	zbWKRuWqPTgU	\N	t
156	109	Home Room	kin-6ur-juf	c4f579822bdf3216e2b616bcc6f5a910687e5e07	0	\N	2020-06-12 00:32:47.218632	2020-07-23 21:31:44.851217	{ }	olIpNnDoyIJB	VAkHmnytGaXu	\N	t
138	94	Home Room	nas-3p9-gya	f3db0953b75a4607ee98e4f953f0b288db5e4aba	0	\N	2020-06-08 16:32:39.71709	2020-07-23 21:35:16.78215	{ }	pNPbJyOgmrKk	CJEesqMAKzUB	\N	t
137	93	Salle d’Accueil	mar-grk-ent	67835b4770328ad9b13adddc1efccfe5da362053	0	\N	2020-06-05 22:51:16.626881	2020-07-23 21:35:47.230629	{ }	CMKShvKrnnbu	ylEzvrHmjcBO	\N	t
134	92	Home Room	afo-tkv-mdn	82658f73647169dccbac65269751d0f48d84effb	0	\N	2020-06-05 18:20:06.959189	2020-07-23 21:36:07.286277	{ }	DQfHGPxjIuqm	mVgDscuYzdve	\N	t
128	89	Home Room	ele-crp-7ka	dd41df3484c9d75172c526b952aaf12b489c6bd4	0	\N	2020-06-02 22:07:19.829809	2020-07-23 21:36:14.064466	{ }	jZEVWrgCVpZX	DwWMClljKlBv	\N	t
122	86	Home Room	nin-uhg-wm7	e70438a429f9381bcc1db47adaf0bbbc4a0a6051	0	\N	2020-05-29 17:42:51.566692	2020-07-23 21:36:25.135317	{ }	mgOWXXwtqUxz	fDiJybOHYagv	\N	t
130	90	Home Room	che-6mg-2ra	433246fb74eef73618bc0b0be8b47f59f6ebc236	0	\N	2020-06-03 12:03:04.67617	2020-07-23 21:36:44.333131	{ }	nFpKwwrOgotG	CkLajeZVwahT	\N	t
140	95	Home Room	moh-pac-hun	70d184d7b1e5adff2c50ac2d29c415893cc0f51b	0	\N	2020-06-08 19:05:16.71955	2020-07-23 21:37:00.401086	{ }	EJbflRqmnjro	PqgCjpzXpDGK	\N	t
173	122	Home Room	fra-g2c-h2q	4dadd1135770a3e2e8145e004ee7f68fc399267e	0	\N	2020-06-20 18:50:48.873987	2020-07-23 21:19:36.283788	{ }	sLmbdivtgImA	schvgdNtDNeY	\N	t
157	110	Home Room	amb-2ru-744	e5c4427923c7c58cf50c710d444c0d0cb7dc5049	0	\N	2020-06-12 11:14:39.032637	2020-06-25 03:42:20.179339	{ }	etoAdEjcUoKc	fdHmuBXLWKrh	\N	t
202	142	Home Room	car-xaf-2vh	dbe16f834c9ded0e4602878e375bbe727201dad5	0	\N	2020-06-27 18:55:02.489468	2020-07-23 21:23:27.699235	{ }	NhXmyqUBeryf	zXdqrzDZBgPy	\N	t
177	118	Radical Health Room	ive-nmc-cqu	356e0e71eb8c14d5c38000bb9e4366da81ce0aa7	24	2020-07-22 14:03:49.451226	2020-06-22 15:56:30.116739	2020-07-23 21:44:12.817632	{"muteOnStart":true,"requireModeratorApproval":false,"anyoneCanStart":true,"joinModerator":false}	EmiqyqNwlRBW	GSuuRAFEeBsx		t
182	1	Frank Meeting	adm-3qz-4jh	71f9b13e1ea02b24bf2618ffea1a0a4ae356465d	1	2020-06-22 23:33:01.57126	2020-06-22 23:32:50.135338	2020-06-25 05:10:05.705051	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	PvyqrhMXpuIb	GSuQuZQBXDmK		t
206	141	Le Sisterhood Virtuel	han-vh7-dcz	573a145c4f3f7e16e8a7d3ba266e7c512773786f	1	2020-06-28 23:11:08.893853	2020-06-28 23:11:08.820929	2020-07-23 21:23:36.983719	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	qyKaioloPUMo	xNoQYcvipyYg		t
164	48	NPUJ	pau-dcw-vy4	0adc9b9f79001b592447b8112f14df57260217ed	1	2020-06-13 17:34:22.972723	2020-06-13 17:28:01.228414	2020-07-23 21:26:52.617543	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	eZXlXBQFvSri	JNmuqOknMwjU		t
159	112	Home Room	lac-ewz-2e4	34e3464c8dbf1c90f496481c61adb808bff58b44	0	\N	2020-06-12 12:10:54.54885	2020-07-23 21:31:37.442327	{ }	sEBntgtroTcz	LiJNmYAIaheW	\N	t
192	135	Home Room	leo-wnv-jp6	d308ec4ce6035f80db78507dc498978bb98a4f79	1	2020-06-23 22:01:34.459911	2020-06-23 21:41:23.962811	2020-07-23 21:37:53.289839	{ }	bmJFjvQwnBto	ZqCHtHyZyPYK	\N	t
190	133	Home Room	tan-gfd-tw7	d93f4cb890333cd1a8b3932f202e743564677732	0	\N	2020-06-23 12:59:47.930458	2020-07-23 21:39:35.569517	{ }	xDkAFitNnSux	JJHwJlKRhQzN	\N	t
189	132	Home Room	tam-46y-eta	2e54c3b5e8325a45d3e51300c724c66ed73333fe	0	\N	2020-06-23 12:49:17.301879	2020-07-23 21:39:44.896017	{ }	fpCUcWztxJSe	jpCuyGpOkQSD	\N	t
188	131	Home Room	ale-y3n-hhq	e1a5af33167b25228724a515796a95b6313b9868	0	\N	2020-06-23 11:15:56.604172	2020-07-23 21:39:55.105401	{ }	NjaPnTvCARdJ	ABzvrOyumEQs	\N	t
166	118	Home Room	ive-har-2wt	642ecb5b67fbc95bbe6e5ec72abbb3364e6ad310	4	2020-07-16 14:07:14.052863	2020-06-16 19:10:16.338688	2020-07-23 21:44:12.818734	{ }	pcfajmmqMdjo	WUMRnqulNpLZ	\N	t
163	116	Home Room	nik-y9u-naw	9fa9a9020079969e863ec635af3c1880ed44fb11	0	\N	2020-06-13 01:27:47.323778	2020-07-23 21:44:21.190777	{ }	yDPMKfHxnMds	dRGbRNIpTmDq	\N	t
187	130	Home Room	lak-2gc-f7e	729b0c8c944405ca794562e9965771e20d1e9b21	0	\N	2020-06-23 03:38:21.559185	2020-07-23 21:40:02.009529	{ }	cSsBtYJfLMjC	DDSExcfoVKpg	\N	t
155	108	Home Room	kin-4eu-7yr	a8615539d25b11ae73df0663a451eb0cdf99796b	0	\N	2020-06-12 00:30:59.496171	2020-06-15 15:49:40.869846	{ }	zgnyaWBCBdog	xuALKRhFjewa	\N	t
185	129	Home Room	ten-vja-9rt	d207592c70b068a7531f03218152d2d810695fd4	0	\N	2020-06-23 01:38:52.114225	2020-07-23 21:42:56.119626	{ }	vWztDuKtEHgD	TUMigCoKHbJf	\N	t
165	117	Home Room	emi-fa4-ftc	c2da36848b804dec509dcf6607d815522540860a	1	2020-06-18 21:02:12.908956	2020-06-15 21:30:38.972594	2020-07-23 21:44:30.52335	{ }	IQmjQCbNyQqE	MTUTSbSFVerL	\N	t
184	128	Home Room	cha-7x6-w9f	8ef52c5c2b66d1c7df3000faebd9d8f8821c814d	0	\N	2020-06-22 23:48:40.950811	2020-07-23 21:43:03.307648	{ }	qUvuISzjzAiF	sNazrQtgHPFK	\N	t
183	127	Home Room	ger-9kf-3yr	3c4c9c693bca9d5ff6203f242cc56d9efabc72e6	0	\N	2020-06-22 23:32:54.535694	2020-07-23 21:43:11.274753	{ }	OjmOmQznSNYi	bXNRzIizlWFx	\N	t
181	126	Home Room	ell-teu-qdy	024df13fa0f764c3f453c08e460b5872def4d414	0	\N	2020-06-22 23:21:16.269862	2020-07-23 21:43:19.357062	{ }	KKQQkDfZWagy	YhtlsoQxuGDR	\N	t
162	115	Home Room	wal-4qg-edx	af371af64f5b8d524cbd9e60e70420e12e1f843e	0	\N	2020-06-13 00:58:51.136494	2020-07-23 21:44:37.481757	{ }	peWLyqjrJHtS	wNRYPOVDmmNa	\N	t
161	114	Home Room	jal-qqa-cyg	2d4cdbbf30b0f52009acdba63b68e249ee2f3fc2	1	2020-06-16 14:19:30.319467	2020-06-12 22:31:24.313946	2020-07-23 21:44:44.329843	{ }	DvDAmnxEllJF	zKwCRvnqfKME	\N	t
168	11	Project Grant Webinar	jad-7kz-wuw	6d344dc3a595271175a8a2d2d02340ea78dba9d4	4	2020-07-03 18:46:46.766327	2020-06-16 20:45:17.540612	2020-07-15 18:35:14.819572	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	gFsBfHvSkzwW	eVIkNVnmUWSY		t
172	11	Cassandra: Volunteer Opportunity	jad-rh7-wjf	6ffb99fe445647abfe8cd9dc95624811a6f2a8af	1	2020-06-25 15:01:41.964935	2020-06-19 21:21:50.587626	2020-07-15 18:35:22.844486	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	uEOAGRaOOHQM	fHSmFkDeJOvx		t
248	173	Home Room	olu-r3h-nnv	aqvkmknahneu0paq4r551idzybpscmg4v7fdep06	0	\N	2020-07-27 11:54:58.046116	2020-07-27 11:54:58.046116	{ }	tqPcUvFTSQVL	NZsjkTDuPSBh	\N	f
18	1	Emerging YGL Accelerator - Summer 2020	adm-qf9-9yk	c58b9fbcb471b1b48e310ef7a0fd84169ac923a6	41	2020-08-11 18:47:16.067414	2020-04-08 20:49:44.073983	2020-08-12 02:22:06.128801	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":true}	mTUtCCLCHjAi	ZUkfzWRvvYxb		t
167	11	For Us Girls Check In	jad-9zy-rgq	7f5c13e5e8ea6b77493e085f8e4311f23dd7f415	1	2020-06-30 19:01:08.159526	2020-06-16 20:42:26.526721	2020-07-15 18:36:08.716647	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	clDEmkfamRWr	EhrNbrNNywhw		t
118	82	Home Room	mon-q7k-e7q	1910f3d0b48fd710c4dc6753b4b71cd7186baad9	12	2020-06-24 15:48:15.064002	2020-05-28 20:53:20.876905	2020-09-08 16:39:19.758208	{ }	yNoVsmQtPgzb	xTKsNfvtzyqi	\N	t
180	125	Home Room	nki-kev-gaw	2acbe60dc0e7ba30cf8ee34a7f60c959bbb24624	0	\N	2020-06-22 22:26:34.060976	2020-07-23 21:43:28.364771	{ }	qKiDxEyOSmSf	pvgFhFxbWEDq	\N	t
179	124	Home Room	jac-76u-9nh	9fbcc3bce1e012809e41b110c4739625c65ff819	0	\N	2020-06-22 22:19:20.942854	2020-07-23 21:43:35.814977	{ }	aXGWWOzAjmws	kjtPjBnNZLNl	\N	t
178	121	Strategy Session	emi-3z7-q66	b60aa4c74023257e374621660d33df172ca7c42a	2	2020-07-01 13:40:13.541237	2020-06-22 16:55:53.868306	2020-07-23 21:43:43.480003	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	aEVbLTKOPkCO	aGLbksmEwGbE		t
224	156	Home Room	sha-lxk-yjk	6rihonicbinchy4qvqpoomimjy6f8qxty1shekgm	10	2020-09-24 17:00:28.552999	2020-07-08 00:28:54.415546	2020-09-24 17:00:28.553832	{ }	jAmVNsNdomZP	NFJWreLaXUAC	\N	f
176	123	Home Room	pau-zjj-mmc	cbe5d2ab72f5c40848c9097284695feea465a173	0	\N	2020-06-22 04:49:34.416199	2020-07-23 21:43:49.753057	{ }	mrsAyCDmBMqY	UMApNLqCxMHN	\N	t
170	120	Home Room	asc-c4a-txm	8da2f3b789ff950ec48fc4d5a75fe95cee8c8358	0	\N	2020-06-18 20:46:09.021863	2020-07-23 21:43:56.978043	{ }	mgpakvJMGZYF	VhzfpaOdlHtt	\N	t
169	119	Home Room	nak-9ug-gdf	5017ba26574237ea803bce2f98ed3185cb35e6b9	0	\N	2020-06-18 15:05:02.839627	2020-07-23 21:44:03.880579	{ }	OvEuiZNWCCGn	ziKilbNXhjJN	\N	t
174	1	Board of Directors Meeting	adm-cxu-hq3	18498a09e13643fe829d9ee1b7938f490c880ae1	2	2020-07-27 13:43:35.124658	2020-06-21 14:50:40.72186	2020-07-27 13:43:35.125824	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":true,"joinModerator":false}	fZQnYEtESObg	fYdUvCbasGEo		f
47	17	PEP Module 1 Workshop - Day 1 	kwm-pwh-nfr	f55e6af9833697d3b7e141426cd278698d633158	3	2020-06-19 14:43:52.404934	2020-04-27 13:41:08.538958	2020-08-05 19:18:18.76803	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	qkiAHxXApBTA	CaunSuhislat		t
191	134	Home Room	may-nqm-jw3	cb3875c3e48c0b6dcc00173932f26e63acd3cf16	0	\N	2020-06-23 20:00:18.410772	2020-06-23 20:00:18.410772	{ }	pKWVdypYTeKj	KXlYDukTICDO	\N	f
229	160	Testing	kim-yqf-isi	acyvsbwiyvx5tbtnug6sxpzxgacoewk6a8b9rwno	1	2020-07-08 20:26:01.585613	2020-07-08 20:25:49.970268	2020-07-23 21:45:36.382152	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	KcRDIRRyfDQA	lIJfSLLllUNx		t
263	179	Home Room	sen-zrx-vls	yxd18yejfivf9pnfvysycx2nhlpllhnkastmw7p6	1	2020-08-07 18:05:37.086529	2020-08-07 18:05:20.476751	2020-09-09 13:56:32.665616	{ }	IgGypEZGGXGl	gcDiqDxdUnJw	\N	t
262	178	Home Room	sha-ege-muy	vxweq9us10h66i5latm2pwfcq219c1tozwpsyzmi	1	2020-08-07 18:03:00.397363	2020-08-07 18:02:49.425027	2020-09-09 13:56:39.351626	{ }	BuJUPuZrSlsI	AFrtHJxQoDWs	\N	t
203	143	Home Room	las-z72-4qa	09218e6154668ae0715bd8e0b4447bc8de83f6c5	0	\N	2020-06-28 14:23:18.263826	2020-07-23 21:20:55.873675	{ }	fLAvYcyvfKoI	tGrqcRoHVCXp	\N	t
113	77	Home Room	lau-jau-pct	4cc27222489b462f569f11a9f6333687ca0f0062	1	2020-07-21 15:58:45.004382	2020-05-26 23:31:01.113167	2020-07-23 21:29:30.874108	{ }	yNfvWvFKXkvP	HLVPYTcaeLdF	\N	t
96	63	Salle d’Accueil	chr-emh-pqq	018a7a545d57d7998e3d5a99fe93190c39b5d9f3	3	2020-07-22 22:00:20.369694	2020-05-11 12:35:55.67487	2020-07-23 21:30:42.721462	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":true,"joinModerator":false}	SPqALubPHyfg	NGswGUBsajWh		t
227	160	Home Room	kim-fpu-1kv	skeayrlu0pf6g3vemvlbeffv4kusrmhfgljj3cak	1	2020-07-08 20:23:33.901275	2020-07-08 20:21:31.525695	2020-07-23 21:45:36.383337	{ }	xVGtdqvxoAHy	zQmzjmTsfRYa	\N	t
228	159	Home Room	gbo-gyg-cys	wmiep7enjdf451lb5epv5kxeejoum9ioxmhppgga	0	\N	2020-07-08 20:21:37.087221	2020-07-23 21:46:05.677816	{ }	OqpOGhydcYej	fGlgYaKpKdur	\N	t
234	164	OYW Webinar - Role of technology in the fight against COVID-19	son-svv-nbv	mojqag7ofv0szlabzvwooxfnvhq6siyhyz55kmmq	1	2020-07-10 23:00:13.291176	2020-07-10 23:00:13.190081	2020-07-23 21:58:30.007867	{"muteOnStart":true,"requireModeratorApproval":false,"anyoneCanStart":true,"joinModerator":false}	rdXNlEilzCJU	hrzcCfNHDQfT		t
259	17	Appointment Meeting	kwm-qxy-sqz	1n7aepm5xhdcxwsdilmpavawc3qaeygbm3qgxb1l	6	2020-09-09 17:08:20.091415	2020-08-06 17:07:28.489814	2020-09-09 17:08:20.092492	{"muteOnStart":false,"requireModeratorApproval":true,"anyoneCanStart":true,"joinModerator":false}	ZHpfOhJwFdCp	AcWZRBxVXAMo		f
255	174	Winning with real estate as a tool.	gbo-l0a-ukf	5ozjghkyfc8yabi3gvvv8lnuubnz33t67nwaj4xs	1	2020-07-31 23:08:43.401099	2020-07-31 23:08:43.348566	2020-09-11 18:21:35.125299	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	EivnsRlnCQsX	SEUKFPNkFSRc		t
24	17	Home Room	kwm-n7y-3kd	1c115527989accac86cda6cff29f8e0279083f88	18	2020-09-15 17:38:44.844572	2020-04-14 19:54:56.040577	2020-09-15 17:38:44.845496	{"muteOnStart":false,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	dJZootiSCjbN	tEKWQaUuaNvo		f
245	11	Conversations & Storytelling	jad-q1k-vrf	snazh80mvm0dcqd04zforsyqk0vuef5hd9ahemt4	10	2020-09-18 22:00:48.943468	2020-07-22 16:27:21.357609	2020-09-18 22:00:48.944213	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	tkPqMdmWXlkv	ZafQRyzaTiRR		f
273	25	Breakout room 1	med-lsx-hbz	sycs1fkyfz1knwkpngkipek0cd8pqyvo12grcdbn	0	\N	2020-08-14 17:58:19.984541	2020-09-27 13:19:24.918665	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	GljUduPTiRIQ	lVcoOYmQchol		f
29	20	Home Room	jay-a39-mr9	32d9c82e67173bbc1f905e00101b524e9b5db7b6	6	2020-07-07 21:24:45.245233	2020-04-17 15:38:05.769357	2020-07-23 21:12:34.914703	{ }	JsXFUQSWETTA	GNeWEoUdyprU	\N	t
213	31	Digital Storytelling Series Interview	ech-eus-ppx	4srudsabb5cuhjdzlkwhrbrsnlvmnpabp3inxurx	1	2020-07-03 16:04:33.829146	2020-07-03 16:04:33.71343	2020-07-23 21:17:51.36423	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	vHMeAREEZrLb	KUsKCjCIKbPG		t
51	31	Partnership Call with memebers of the Canadian Black Chamber of Commerce	ech-43w-e2v	560e006085d0a0aa26f69d08cc0f59ef107e4afc	1	2020-06-06 12:58:35.732161	2020-04-27 19:51:24.688037	2020-07-23 21:17:51.365413	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":true,"joinModerator":false}	ZOsanHSxhGzo	RvxeZNMFhXsz		t
39	1	A NEW REALITY: Virtual Summit	adm-dfd-e94	4bc134617e39ba8f3b2bd2eb52cc39c171f516af	15	2020-05-29 17:05:27.633424	2020-04-20 19:27:21.86278	2020-08-12 02:22:14.423167	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	tIfzCBjNKZgX	BNpGKhSvtiKN		t
250	173	USER ROOM 	olu-ycz-mrr	wf9bleohvj5jkxv2xt5mrqjpzwxgiipyajam4z6d	1	2020-07-27 11:57:58.534936	2020-07-27 11:57:28.219258	2020-07-27 12:04:22.106904	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	ErpFUInYPyAt	aISmbxtQldCz	705464	t
249	173	ROOM NAME	olu-gke-eju	kobhdvv3mtqi8dwgiaaukvcaacfuarex9y1luelf	0	\N	2020-07-27 11:56:51.579398	2020-07-27 12:04:28.586173	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	QPIzbRrNfSUb	UIDnPDccAwFp	611884	t
251	173	example room 1	olu-djd-y17	uqnymezfwjbm3iltpyhnrxjtc3xwjzgmibrru2ps	1	2020-07-27 12:02:49.530341	2020-07-27 12:02:39.705263	2020-07-27 12:04:33.690312	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	oJBJGoAoNZuX	IMjcjcADJcYn	851620	t
220	1	FourBrownGirls - Healing Sessions	adm-pxl-w4u	e0anwaig0nfozsuey5jpy6lpzn1azwrvf6sucfnh	2	2020-07-07 18:31:14.059048	2020-07-06 14:53:48.523171	2020-07-30 15:28:48.515403	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	ZCuuePeyaoev	tFxuWyKYHUVr		t
252	173	Room 1	olu-iwg-rif	heryb3jn0tzvb2dqg6e3ncnmx5dt3cnlgbxgb41z	1	2020-07-27 12:07:44.683577	2020-07-27 12:07:33.677038	2020-08-21 11:46:22.647458	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	fSVLYwHYKmff	RZpoDAxirGnN	826300	t
208	1	FourBrownGirls Series	adm-6ts-iot	m7ji5d8emmsdito9ecyfkuj6lbe7iorkjiaxihxb	1	2020-06-29 18:20:17.742745	2020-06-29 18:20:14.370263	2020-07-30 15:28:55.430395	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	tqQZNDDopdnS	ToLMgbbUuaKp	176619	t
244	11	ForUsGirls Check In	jad-wgv-vcm	s2po0fswzytnztwiy6c97wwiqml12sbzs16gxzaq	1	2020-08-05 19:30:11.419034	2020-07-21 20:20:02.287108	2020-08-05 19:30:11.42005	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	lqoIcpFkQDZV	vBwxDIqtbAyG		f
257	17	Module 2:  August 11 - 14th, 2020	kwm-mgb-ap3	7w8ygtnkjqd1hmwjjle8aahug6jjkukrl7fyvh4x	9	2020-08-14 13:55:35.938606	2020-08-05 19:18:56.107682	2020-08-14 13:55:35.940015	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	jUVMplRzXzNu	dfAfUwVJgtmd		f
253	173	room example	olu-bjy-kui	zfwbamhzvyshiz5evywhsq3syy96rmwoecrs7lxg	1	2020-07-27 12:14:04.205341	2020-07-27 12:13:51.717141	2020-08-21 11:46:16.165662	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":true,"joinModerator":true}	MIWqREDeYSYZ	WFBkGBEleiVL	764984	t
239	156	Different Sides of Learning	sha-dfi-zli	ts6fbqmg5axvx5vuc8mgwxthkdneyhwsn63iwe98	9	2020-09-04 18:24:32.550199	2020-07-15 13:28:58.82405	2020-09-04 18:24:32.551279	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	POXWUkBpVgjD	cklyLZlGRPhf	527795	f
175	80	Technically Speaking	lis-jqm-9qr	cd4faf6494f925c621a278e0a29d2980d9eede26	6	2020-06-30 22:26:00.528265	2020-06-22 04:40:26.786012	2020-09-08 16:39:29.244123	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	zBrhVRahyMPt	AnUjivulAGpG		t
271	186	Home Room	cyn-wzz-c8i	scd5xmdutch5v36no1hnoykpfo6fipsapcca38qi	3	2020-08-14 20:24:45.532091	2020-08-13 15:06:40.628254	2020-09-09 13:54:47.012295	{ }	ybrzPXAPtRYr	rxjJCNYCLzgb	\N	t
268	184	Home Room	kat-opk-fgw	ga9n8p8chfplogbngaoqgneaspsuthzjescwi2wo	1	2020-08-17 19:07:10.4229	2020-08-10 20:46:56.73325	2020-09-09 13:55:01.38492	{ }	NEfrUyIiCdTT	QPwBSSzKqGNR	\N	t
261	177	Home Room	car-wwm-ywr	imxn7avqhc7cm8pnqktupgiigbwr37fpnoh931cx	0	\N	2020-08-06 18:30:56.459969	2020-09-09 13:56:53.200701	{ }	hAztmxymPCZw	PGNMOhrfQTyJ	\N	t
243	171	Home Room	amp-l10-nxs	cmc1y06hpoe3xsy76p9caxspvn4jtiyknxdh2n4x	0	\N	2020-07-21 19:17:13.543774	2020-08-09 14:38:44.42462	{ }	lTdAOooLjNTg	JAZdljIMDDKi	\N	t
226	157	Home Room	kim-1s6-0sx	0jzbjkh6dy7re6kkfsn4ifb2wi9apu5scln2trlr	0	\N	2020-07-08 00:52:46.074099	2020-07-23 21:46:14.409749	{ }	pWNNsXAuVHgx	rhldLriRuEfE	\N	t
222	154	Home Room	yen-yyk-s59	a2told3c7oxdhjd4lncalscn1azeszbxonhceso7	0	\N	2020-07-07 23:01:17.507895	2020-07-23 21:46:24.729527	{ }	FHxWPTKSHYVv	UAfSaJBeFCIZ	\N	t
241	169	Home Room	dee-5pi-ntf	7cwwjruepvoy43nq3ngc2qrlly9ixmzrf7m5izey	0	\N	2020-07-17 01:29:16.357771	2020-08-09 14:40:41.022576	{ }	xYUbmsnTMhzw	aysoyHNgLDCl	\N	t
186	122	AMAN Impact Strategy	fra-mcj-dt3	558509e1985455bfaec365c0b89de3969dbf3baa	3	2020-06-23 23:57:00.698378	2020-06-23 03:23:46.230025	2020-07-23 21:19:36.28252	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	uiJirqkYhjhe	jgbQiUWOzHPA	773933	t
223	153	Home Room	mar-aqe-swa	vltuvvljmvfxoiwogvy5isccll5x0lw4oe2bcqx3	0	\N	2020-07-07 23:01:20.269659	2020-07-23 21:46:37.932614	{ }	pJyLnbmsTesl	VvuNnEcjuCul	\N	t
260	176	Home Room	sho-29p-l9x	jysptlieoifpwhqbrvimuif7dxn41j09s3airtpc	0	\N	2020-08-06 18:27:22.202713	2020-09-09 13:56:59.573679	{ }	qORNptCBaNor	CcpDMhCjryCD	\N	t
197	84	test	ash-h2x-du7	a52e24129a5f715208df0dec324f3b52781baa2e	0	\N	2020-06-24 15:49:08.403321	2020-06-24 15:49:21.586899	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	eVAIGQSrMbkB	yBTZCvZNIacO		t
214	151	Home Room	lis-rtz-q7f	p1fkcxgqmnqjrcaf5gcc2lyr4rse2ge3wcnrjhvf	0	\N	2020-07-04 23:47:40.947824	2020-07-23 21:47:08.03632	{ }	qQgWblZtvHlg	QljIpcyWVpHE	\N	t
210	146	Home Room	ari-olr-4rb	bmukzm38cexbqxz8txtea3nvnxmj3st1y7dy3ra5	0	\N	2020-06-29 19:46:28.40949	2020-07-23 21:20:06.218781	{ }	XvKbxJYJbLZr	KhdayVnsGvpi	\N	t
209	147	Home Room	for-em3-vp4	rm1ljgqpzsy6sudbrjz7pa3kgcdwb7vslnke1rze	0	\N	2020-06-29 19:46:25.595399	2020-06-29 19:46:25.595399	{ }	VIQtjFSWxoBg	warmBYRMnmrH	\N	f
215	150	Home Room	amp-6w2-rvf	7tqlyhzmj4i4wn6ywzpjozbpr2aup5xakikiphwu	0	\N	2020-07-04 23:47:46.945059	2020-07-23 21:47:17.623117	{ }	ORpCkOjkzWPr	BwGxaCguPflW	\N	t
256	1	Program Mentors Training	adm-t2z-zmg	80f2mkr3u6hixbmtfdt51hswjkdggaujxvvfhm1a	3	2020-08-09 18:01:40.744322	2020-08-01 14:43:41.333099	2020-08-09 18:01:40.74527	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	gSUHfGJAvrqC	deAltHcHRwYv		f
258	175	Home Room	tob-e9c-l3i	qibjmp942jk3qhpcr5hez8stobuyqtcbbwhhzksl	0	\N	2020-08-06 16:42:57.712391	2020-09-11 18:21:26.555171	{ }	ikBxXhxagnof	efNdmjKcxFrA	\N	t
230	161	Home Room	hed-apj-i7l	2un40h01wgbwdcdaguqpu2mpmo6ofalvtwg2wqig	0	\N	2020-07-09 13:06:36.361939	2020-07-23 21:20:20.26609	{ }	DSXsLSKOnAIz	PVJhHeZiFiam	\N	t
235	165	Home Room	dhy-wfi-jft	o5a2ww6eeymqlbr5dbh4gl4dw3ols2glrvjgreyi	0	\N	2020-07-13 10:39:01.083502	2020-07-13 10:39:01.083502	{ }	aLPEgRtdNfXr	GaWBVSGEZuKr	\N	f
147	101	Home Room	dhy-k4j-xj2	c2569d90e5e776ef9add6f1be4a56b976c9742c9	6	2020-07-13 10:48:12.633048	2020-06-09 15:35:44.98979	2020-07-13 10:48:12.634269	{ }	gqosSYwZbwbN	muxsEpOaNsWu	\N	f
216	20	Healing Through Branding	jay-rfx-bfh	prscgiaaspyh5bfoeu4tsxsyoedza2rwnkiisgd8	1	2020-07-05 15:56:08.13745	2020-07-05 15:56:08.016873	2020-07-05 15:56:56.441594	{"muteOnStart":true,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	kUWbAfGMsZGC	XpGCZMNeQYfh		t
225	158	Home Room	tif-pqb-goe	7op2h9nkyig1ytiuywui3od4blnzkr9inijakwcc	0	\N	2020-07-08 00:52:35.59287	2020-07-23 21:20:39.851119	{ }	wskBUPJZcxty	XomjBWpeqpQk	\N	t
196	84	The Miseducation of Brown Girls	ash-myz-2fm	38d3bc68c0644de366119fcd019bba8b13e13b04	1	2020-06-24 15:48:45.198019	2020-06-24 15:48:45.165505	2020-07-23 21:28:40.129619	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	VvghXAdIDIgn	mldfvSXMQONQ	606592	t
195	137	Home Room	ele-gjg-4mr	8f954ac92e31b4b9f4e87262a4447df1e50fceed	1	2020-06-24 18:16:31.464496	2020-06-24 11:01:45.229413	2020-07-23 21:37:37.097059	{ }	WOtkfeaumPDV	IoXzluUxeIpS	\N	t
194	136	Home Room	mon-hpu-nyp	7eaf877d1310f736e7199b442c7943951b4c722d	1	2020-06-23 21:54:10.782902	2020-06-23 21:52:10.335739	2020-07-23 21:37:46.355179	{ }	wPUufCITrLsk	PMpPzImWuSyS	\N	t
193	135	BOLD	leo-mvk-wwa	005ffeabbcb5ef734ec9a18bc417bee842340bd8	1	2020-06-23 21:45:15.702792	2020-06-23 21:45:15.592574	2020-07-23 21:37:53.290961	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	TfNjcGcTjOFG	TJowExPPWLMm		t
211	148	Home Room	tam-rym-csf	66viqyfw6vttupjb4n7ptylbzdz1vomawbuujtbw	0	\N	2020-07-01 12:24:29.437328	2020-07-23 21:47:33.429828	{ }	GJwJwSzvrVFS	dzpSlekhtFGc	\N	t
42	11	Test call	jad-nte-4pv	946be6963b13ceb56fb2002b4ee7746178e6d4e8	1	2020-04-23 01:10:42.039208	2020-04-23 01:07:45.470876	2020-07-15 18:35:33.860436	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	HHDMJHYKbMmT	SUqCnefiNMGi		t
204	144	Home Room	mon-39v-z2r	f38776bc9da62e25f2619cea63218013647b68a0	0	\N	2020-06-28 14:44:40.687257	2020-07-23 21:47:51.953632	{ }	BtgYWjDBvUGo	mnIIEzGQeHsK	\N	t
231	162	Home Room	dhy-cc9-non	tk0gbsilrvm8htom2r5qfh7pm319mgehx3jnpyrh	3	2020-09-25 21:04:39.390535	2020-07-09 18:43:29.897385	2020-09-25 21:04:39.391374	{ }	GcJuCglbyIec	FQoIAziOIjKO	\N	f
160	113	Home Room	kev-4am-g7z	0d648031c937b44a8c7217811d31ac2b75f6a63f	0	\N	2020-06-12 16:08:42.269517	2020-07-21 23:32:33.158528	{ }	mZajhKZqeAof	ccmosgagBbqq	\N	t
205	145	Home Room	est-f3p-6fk	d4346709b1115bcf7ee6a12f50870c075c270103	0	\N	2020-06-28 14:47:02.946827	2020-07-23 21:48:04.171324	{ }	uVgACMdfcIzi	mhnyKRaZrkLi	\N	t
21	5	P2G	ais-74h-7j4	bbbab869a249c0aad0949b719a664fd9f0c89a20	1	2020-04-10 22:02:58.443705	2020-04-10 21:27:37.413864	2020-07-23 21:08:37.119895	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	cldPuHiXsRJk	OFAobFrndWqM		t
44	10	Community Collaboration	ani-p4r-vp2	448fad9ec6a0d70a00fa2622350f04a2db4fc242	1	2020-04-30 16:57:20.169333	2020-04-23 15:35:37.586304	2020-07-23 21:09:04.251866	{"muteOnStart":true,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	QOhyOKpJShvz	fiEiTqAuQSGc		t
218	20	Pull Up & Heal: Healing Through Hustle & Grind	jay-fco-xji	wmowpfb5r6iphawga1yxhfcriisyibydc9du3sef	7	2020-07-08 00:04:17.373172	2020-07-05 15:57:27.22265	2020-07-23 21:12:34.912343	{"muteOnStart":true,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	BYSbtpEncBPy	aTldwKJTxEnX		t
217	20	Pull Up & Heal: Healing Through Branding	jay-tbm-m8e	ig80kwha6tsalaevow6wbx1hiphvxjme6uft0dan	6	2020-07-07 22:09:34.138636	2020-07-05 15:56:47.075704	2020-07-23 21:12:34.913684	{"muteOnStart":true,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	XxQKGPFZJAFx	PqUNmHAeAUGi		t
221	155	She Sharp	ama-xdx-8cl	midbgxc4djogpwsfqe4mbia0veiv0shmruiluhym	3	2020-08-12 16:11:27.031459	2020-07-07 23:01:13.628009	2020-09-08 16:39:01.676848	{"muteOnStart":true,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":true}	TveDWYBCKmav	YBHBXtnqrqMX		t
32	1	ForUsGirls - HTML/CSS Workshop	adm-ef9-693	1b3715eb2adfb185cc98344c6198fa41389d4a7d	2	2020-04-18 19:46:32.348101	2020-04-18 03:08:37.419783	2020-07-30 15:29:03.78163	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	jFELRkfLBGOu	rmidfGRjLqmN	825351	t
41	17	Amazon Hiring Needs 	kwm-fph-zgj	aaa6e0d96bd20664dc7c317c5c1a050a8b269dd5	11	2020-07-24 14:45:40.17741	2020-04-21 14:53:38.071877	2020-08-06 17:07:02.841216	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	eprYQbWJrBoI	lkCcJsaEVHXH		t
264	180	Home Room	ife-kfu-zim	yszqlwbhp1p7jlodyvcfqqjfdhxrufxvowgdd0xe	1	2020-08-07 18:11:19.943881	2020-08-07 18:11:08.268114	2020-09-09 13:56:26.486479	{ }	EXIoqWbXNkqm	LDUXrIUlBAIC	\N	t
281	173	MEETING A	olu-zyw-otu	h4ulv0xvtvcvoz4pqtncruv9glrjwfwaplfwzmww	3	2020-09-09 14:27:34.771506	2020-08-23 20:15:16.502831	2020-09-09 14:27:34.772612	{"muteOnStart":false,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	nSbToEirPEcc	JuRriOsPZSVj	071629	f
207	1	Snap Coding Series	adm-axm-mv7	30b21e15cb4466430db5d5583bf5f49f95d1965d	13	2020-08-07 18:14:06.94541	2020-06-29 12:19:41.972642	2020-08-07 18:14:06.946388	{"muteOnStart":true,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	hAaTevkuQbUk	gxOqDEdsGwdg		f
280	192	Home Room	dhe-fcn-0sq	h2e5qd0pv7u8gfdq8jdwe18hvmb4xdi5xinnsncc	0	\N	2020-08-21 18:59:36.196569	2020-09-11 18:21:05.062091	{ }	ZMwBCikcyyOm	QdVNHkKCnyFL	\N	t
89	17	Module 2 June	kwm-dn3-nvu	98cc24afcc4b6359e5dffc15c863f0e6df96dcad	34	2020-09-15 17:43:15.95918	2020-05-06 19:42:23.035764	2020-09-15 17:43:49.231322	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	CJLRMwmQSEOP	gmVZFXfmGGhX		t
282	111	Greenwood Week 2020	kha-ync-bqi	wkjbewv5tfxy52kl8yxzba5us2rjd9vzdhp8fcau	0	\N	2020-08-24 18:54:57.024794	2020-09-16 14:36:01.087657	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	DaqEijIDPqfu	pziZTyfXJJbh		f
240	156	Special Compass 	sha-rvq-lji	byifnxnlrjpabxwmu5ohacyud7vpoctqc1kqancp	0	\N	2020-07-15 13:32:27.402119	2020-08-20 22:25:02.519893	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	OqXahKkaECqa	UgmjMUAFawfK	182294	f
292	196	Business Continuity and Contingency Planning	gre-li5-pl6	idwxyx7ywks00yax5fweslmshan0ribql5bmjuaj	0	\N	2020-09-16 14:40:26.26545	2020-09-16 14:41:07.409797	{"muteOnStart":true,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	MEZTgmYtRFOp	SVtTIeleRoET	395467	t
293	196	Greenwood Week Pittsburgh 2020	gre-hgm-u0g	zlp8tasgae7dqkomfa0qr023ay226uapqhh8dose	0	\N	2020-09-16 14:41:45.618354	2020-09-16 14:41:45.618354	{"muteOnStart":true,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	KbJxnWeAEZbM	cWguncpHuAdN	833647	f
291	196	Accounting and Bookkeeping-Managing Finances	gre-1wp-tdf	uwmukrrmuppjrrbssqlbwja2okuiy0zfvcxcittw	0	\N	2020-09-16 14:38:52.394179	2020-09-16 14:41:54.064045	{"muteOnStart":true,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	apoWPIUJqDVt	OpDVvzfyaRlH	940371	t
278	173	Room One	olu-dal-fts	tbxexcd9zjqvcifqzrq4suuwrzugjybzjihs8rzv	1	2020-08-21 11:50:12.811814	2020-08-21 11:46:44.516454	2020-08-21 12:47:26.108313	{"muteOnStart":false,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	aINaQGkdWTeu	FRHuUTmhUfKI	020060	t
269	147	Emerging Young Global Leaders Accelerator 	for-xux-67i	xya90syfpko9xbeqea5tr8tgkdammfzm7iiz2uqe	10	2020-08-21 18:45:42.256711	2020-08-11 18:11:07.493766	2020-08-21 18:45:42.257986	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	MmzhEkEBxaYx	IsdDQHpulcLf		f
279	173	ROOM 1	olu-c4w-pcv	wzba4mwdcmluap607zzazxooszarbul6mrco7xht	1	2020-08-23 20:09:41.396367	2020-08-21 12:47:16.363324	2020-08-23 20:09:41.397419	{"muteOnStart":false,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	oNveafxMkwBZ	DnMpFWMVYePh	818369	f
290	196	The Art of Lifestyle Mastery as an Entrepreneur	gre-ose-hid	zsoghnnqxm3nnwok0xkwb5pjpd7ljsrjduv0hzx9	0	\N	2020-09-16 14:38:01.380326	2020-09-16 14:42:01.265765	{"muteOnStart":true,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	WFBjGThhnVyT	UBbETRONodRM	023307	t
289	196	Panel Discussion on Ecosystem Building	gre-pgn-nic	gtowl7bhy23cqvehwq5517xcof5nlo3b0iz6g7j7	0	\N	2020-09-16 14:37:15.0296	2020-09-16 14:42:16.292936	{"muteOnStart":true,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	ulRsXPKiwEWA	qXGJxREaiTga	751896	t
294	196	Greenwood Week Committee Meeting Room	gre-lng-2ro	qbhno0zpos6seln4oaugkqtav4ybl3qlmfh1yzcq	0	\N	2020-09-16 14:42:42.195559	2020-09-16 14:42:42.195559	{"muteOnStart":true,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	JjeVZkyNrELy	AhtNXMCveiCH		f
158	111	Khamil's Meeting Room	kha-wxf-6wf	f7b7d4462429300dfae8cefbfb372498f14569aa	11	2020-09-17 15:29:58.862664	2020-06-12 11:23:47.849588	2020-09-17 15:29:58.863551	{"muteOnStart":true,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	ngcjcIzbgigH	wXGKCXdXnKXJ		f
287	17	Getting Connected (September 17th)	kwm-8xd-atp	vdwsa8mt1ndldmsy5ao82z2x7rfn5cp75ac71nic	1	2020-09-17 17:12:09.162811	2020-09-15 17:44:37.44196	2020-09-17 17:12:09.163717	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	tOhbstgiVLsn	otDdExQwRbHq		f
283	193	Home Room	ash-szb-do7	oh7zkdfwau71xhzruk5jeb06qofssddj08x3civ6	1	2020-08-31 00:34:38.652875	2020-08-31 00:33:50.260328	2020-08-31 00:34:38.653972	{ }	DcVjfZIFFMIY	meVEjeBBxpeY	\N	f
153	82	Face time with Canadian singer Crystal Shawanda and her manager Rob Pattee	mon-4ew-kah	333d6cf505168ced01e941da22c2fd1a1ecd51bf	1	2020-06-11 14:44:59.276113	2020-06-11 14:40:45.752278	2020-09-08 16:39:19.757029	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	LznbvWtxRXnb	DmFylYZYhIFu		t
277	191	Home Room	rae-m2j-b2i	ascxccf2i3uo06jgityd89yhzjqzay1z021wbzas	0	\N	2020-08-19 06:29:49.174443	2020-09-09 13:54:09.720144	{ }	nsQAnxiZuNqC	twXNGtRMlECG	\N	t
276	190	Home Room	kem-ty8-wbm	4yjrtndmtfwuiyvr3zvx0vkdwhbqn0hzigg5wlh6	0	\N	2020-08-18 19:14:09.159629	2020-09-09 13:54:16.449088	{ }	zdaFEHwiNsGz	CNSIJOTaxzHX	\N	t
275	189	Home Room	syl-ca1-n7b	ksj8co0gwteh8gfp52skwylvzwm6cozwosxllyaz	0	\N	2020-08-17 15:15:10.953043	2020-09-09 13:54:23.132001	{ }	UCHiLGchiZqZ	VzLydiXmzobK	\N	t
274	188	Home Room	dan-fu5-qgl	kwrvfgopslcto1bn5vbobibvwuydfheav7omyb7k	0	\N	2020-08-14 18:57:13.887611	2020-09-09 13:54:31.348295	{ }	zEiAcgxyNIoS	EqOwTsRXyrOc	\N	t
270	185	Home Room	car-cnv-its	tshwwm5veph1w9fqfmyrzbexm1p96ds4qqtdnbii	1	2020-08-11 19:04:02.068634	2020-08-11 19:03:57.351125	2020-09-09 13:54:53.543734	{ }	lzLHyAudptnV	eZtLWzEZVFWE	\N	t
295	197	Home Room	sal-tsh-xcr	v16cezk4emjrwjamfrgksre44c5xdeuhsilatakx	1	2020-09-18 02:14:31.451871	2020-09-18 02:14:18.577059	2020-09-18 02:14:31.452721	{ }	IYUlFkwXdUza	sBTjMCVLKqxc	\N	f
246	17	Module 1 - September 28 - October 1, 2020	kwm-bha-fle	jvqclrvu4ebcbs8cjpuuzwokfoggtu2vbalcck7e	13	2020-08-04 14:53:11.291283	2020-07-24 15:26:54.457647	2020-09-24 19:33:45.670929	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	qxmzJJXJDqWM	pYqIXesuIDVd		f
1	1	Home Room	adm-6px-9ap	7161cf926d02d613fde8ba01aadae55db11b7569	111	2020-09-25 00:30:42.040219	2020-04-03 10:00:14.634883	2020-09-25 00:30:42.041278	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	LfElBqJZZmcP	VYZcktvRvMez		f
296	196	Wofemtech Walkthrough	gre-7ts-uu2	me7yqwyhijvmll1acor3l2qifvpwnfu6vgy5srp1	4	2020-09-26 13:59:56.562711	2020-09-22 16:25:44.986295	2020-09-26 13:59:56.563507	{"muteOnStart":true,"requireModeratorApproval":false,"anyoneCanStart":false,"joinModerator":false}	EMSvqaEjciFC	FfOmpuCVJrGg		f
298	196	Presenter Practice Room	gre-juz-pb1	wdmycgnvpotwptzhshtwiq5g44gtadgq7eunnw4b	1	2020-09-26 14:51:19.412152	2020-09-26 14:16:49.263726	2020-09-26 14:51:19.4132	{"muteOnStart":false,"requireModeratorApproval":false,"anyoneCanStart":true,"joinModerator":true}	XhIxLthjpNDs	jqLpoeJEAREf	663204	f
\.


--
-- Name: rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rooms_id_seq', 298, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version) FROM stdin;
20200130144841
20180504131648
20191023172511
20190206210049
20190522193828
20190326144939
20190711192033
20190828153347
20180920193451
20191128212935
20181113174230
20190822134205
20190507190710
20181217142710
20190522195242
20190312003555
20190522194445
20180504131705
20190726153012
20190522194037
20190314152108
20190122210632
20200413150518
20200712093616
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.settings (id, provider, created_at, updated_at) FROM stdin;
1	greenlight	2020-04-03 09:59:07.934036	2020-04-03 09:59:07.934036
\.


--
-- Name: settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.settings_id_seq', 1, true);


--
-- Data for Name: shared_accesses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shared_accesses (id, room_id, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: shared_accesses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shared_accesses_id_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, room_id, provider, uid, name, username, email, social_uid, image, password_digest, accepted_terms, created_at, updated_at, email_verified, language, reset_digest, reset_sent_at, activation_digest, activated_at, deleted, role_id) FROM stdin;
91	131	greenlight	gl-ifgzxvglogei	Alyssa Frampton	\N	alyssaframpton@outlook.com	\N	\N	$2a$12$12gK7zWlYivk.7wmeT77lur5/cnMmO5IMg5no2htusG/1TIXRnP/W	f	2020-06-03 15:15:05.738136	2020-07-23 21:37:08.277355	f	default	\N	\N	\N	\N	t	1
152	219	greenlight	gl-depivnnperau	Karlet Hewitt	\N	kreid@thepurpointgroup.com	\N	\N	$2a$12$1AdVB2PuwGcvly5qdZS4buXbMOyIDnBz/lHMVK3Qbm2VP6UW05H6S	f	2020-07-06 09:41:21.485848	2020-07-23 21:46:58.590297	f	default	\N	\N	\N	\N	t	1
194	284	greenlight	gl-cwfmclfmnzaj	Georgie-Ann Getton-Mckoy	\N	georgie@gsdwithgeorgie.com	\N	\N	$2a$12$8v22yQ9WAXm7vEeGi3Tzt.pawoFmbED3RVYmVBOn7wvjqjZ08KdLa	f	2020-09-09 18:20:23.53898	2020-09-09 18:20:23.557338	f	default	\N	\N	\N	\N	f	1
174	254	greenlight	gl-qqapzfzhbkcr	GboyegaLawson	\N	gboyelawson@gmail.com	\N	\N	$2a$12$BQsc6tgnAXRuxyqo00CA9ufyWv1SMTQXRU3ZBk6IQLBD20.B8nYDu	f	2020-07-31 22:51:58.118391	2020-09-11 18:21:35.12944	f	default	\N	\N	\N	\N	t	1
146	210	greenlight	gl-qiypxtenguqw	Ariane Bossekota	\N	ariane@fourbrowngirls.com	\N	\N	$2a$12$u6oMurL4htf9tW5Rjky.CetzMtSOqToz3x4KjMGKiv92p/TfuLsaW	f	2020-06-29 18:49:18.125708	2020-07-23 21:20:06.221971	f	default	\N	\N	\N	\N	t	1
158	225	greenlight	gl-jcfcpopzumqr	Tiffany Thompson	\N	tiffanythompson72@gmail.com	\N	\N	$2a$12$SOFzo72XW9GkBJFBrrllk.rGRm5bJcrIRTFo/gew33VMkJWzvEHkS	f	2020-07-08 00:50:32.324904	2020-07-23 21:20:39.87592	f	default	\N	\N	\N	\N	t	1
168	236	greenlight	gl-waqgkpnvkqrv	michele	\N	manager@blackhistorysociety.ca	\N	\N	$2a$12$EecXO46bjZQCqUORI2ZMTubihFCBo0Ii7L9sFzszWM9aIAFQ35Wd6	f	2020-07-14 15:41:04.734726	2020-08-09 14:40:55.174073	f	default	\N	\N	\N	\N	t	1
166	238	greenlight	gl-keohafxsdhai	Kaniya Samm	\N	kaniya@radical-health.com	\N	\N	$2a$12$IohkI0/QqdUJtFY.1pw3P.swX3frLskC4kN8sKM17MG2WVcmQk6Ni	f	2020-07-14 14:12:43.476841	2020-08-09 14:43:27.337262	f	default	\N	\N	\N	\N	t	1
195	285	greenlight	gl-saxbsohtabso	Ryan Knight	\N	ryan.knight99@gmail.com	\N	\N	$2a$12$PzcyQzQK8qZwmrgrZ2BXh.F87hiIZ6.zplE7OAtUCl7x4iTv9Foq2	f	2020-09-13 02:39:26.557654	2020-09-13 02:39:26.638889	f	default	\N	\N	\N	\N	f	1
25	36	greenlight	gl-idiqixrwwdjz	Medina del Castillo	\N	medina.fredericks@gmail.com	\N		$2a$12$GU5s2TzpnIByo2UUNjqGzO9RXufctsfscEYRQOtOXfa1KJvbmFfL.	f	2020-04-18 19:42:53.522522	2020-09-27 13:19:24.909831	f	default	\N	\N	\N	\N	f	8
101	147	greenlight	gl-hxbaphcsldnq	Dhyey	\N	dhyey.bhanvadiya36@gmail.com	\N		$2a$12$YFoRzVPqD8BsH0pDug32bOn7bKYqQ2dlIjFwIKxOO7JT7UUaZxPkm	f	2020-06-09 15:35:44.987977	2020-07-13 10:47:19.454902	f	default	\N	\N	\N	\N	f	8
162	231	greenlight	gl-fghezbwbfmxy	Dhyey	\N	dhyeybhanvadiya4@gmail.com	\N		$2a$12$cBx9CFOj4PxZnBJ77K25I.Hmn66Bz9jlC6nixdiRm5bqf5AAdnKk2	f	2020-07-09 18:40:42.887122	2020-07-13 10:47:29.774195	f	default	\N	\N	\N	\N	f	9
189	275	greenlight	gl-quzsowmtxkcu	Sylvie Racine	\N	sylvie.racine@international.gc.ca	\N	\N	$2a$12$n0SjTrYYj4SOGo0tgvUmN..sNSy9O8ObF9S6iqte61Sg1K6rT0MSu	f	2020-08-17 15:15:10.941029	2020-09-09 13:54:23.135251	f	default	\N	\N	\N	\N	t	1
184	268	greenlight	gl-tbwamjhghsrm	Katherine Liu	\N	kathliu13@gmail.com	\N	\N	$2a$12$CEvCLjF7f6NhcdTV0u3pi.gt0zENPeOueUDcruHMUZRXwxuHpr8Wy	f	2020-08-10 20:46:56.686433	2020-09-09 13:55:01.386917	f	default	\N	\N	\N	\N	t	1
159	228	greenlight	gl-jeetzykntcgx	Gboyega Lawson 	\N	gboyega07@yahoo.ca	\N	\N	$2a$12$hr2pNkhUfR4MYjaIbg95nOVx.kleC4NdtHOfKDCU8.KVh7f4NW21q	f	2020-07-08 03:24:50.265863	2020-07-23 21:46:05.680872	f	default	\N	\N	\N	\N	t	1
153	223	greenlight	gl-axnbxgvwezwu	Marilyn Ahun	\N	marilyn.ahun@mail.mcgill.ca	\N	\N	$2a$12$qxdeRAIvZzgtrn9XwJIiOuE0UcgxlLvDiaqtuTqVTVwM3ww9PJfaG	f	2020-07-06 19:40:18.777377	2020-07-23 21:46:37.960041	f	default	\N	\N	\N	\N	t	1
172	247	greenlight	gl-jlknmfuwwknf	Zeravan Aswad	\N	zer.aswad@gmail.com	\N	\N	$2a$12$lg.3eYLcRknvPpyVUwFx2un3NU41/ns3VnqZnzhI4f45ynTYy.8OG	f	2020-07-27 05:18:49.807907	2020-09-11 18:20:55.118544	f	default	\N	\N	\N	\N	t	1
175	258	greenlight	gl-uoyqmhwkvtrb	Tobi Ojomo	\N	tobsmarth@gmail.com	\N	\N	$2a$12$Lpmx01P10cTHZlo9tptRpe3KFwh/.tpX8BQHsX.e4Dw92JZW8oYnO	f	2020-08-06 16:42:57.702376	2020-09-11 18:21:26.60364	f	default	\N	\N	\N	\N	t	1
196	288	greenlight	gl-cexjapqbqwiq	Greenwood Week Pittsburgh	\N	info@greenwoodweekpgh.com	\N	\N	$2a$12$tSwYBhrHgNJWQ3mR6ZiYQ.EED2YIVpHi0zoVKVGOaeDJDGlq1u17C	f	2020-09-16 14:35:38.762693	2020-09-16 14:35:38.799041	f	default	\N	\N	\N	\N	f	1
163	233	greenlight	gl-lobwypcowhyb	Scott Lehman	\N	scott.lehman@oneyoungworld.com	\N	\N	$2a$12$d1ybj3dymlrwXFSXgmIsOebhdyu.r/kN6w2oF4cnyVd8sFDRXb5me	f	2020-07-10 21:35:47.974233	2020-07-23 21:08:04.472089	f	default	\N	\N	\N	\N	t	1
169	241	greenlight	gl-opwnxnxxugfl	Dee Baptiste	\N	dee@pelau.com	\N	\N	$2a$12$oX0a0sS4ngQQFmOOZVliSe22uI8pwb.Pe.CL5w0PY3VAGpGW1J7Ze	f	2020-07-16 21:41:33.20341	2020-08-09 14:40:41.024993	f	default	\N	\N	\N	\N	t	1
167	237	greenlight	gl-zdwhrusesexj	Danielle	\N	daniellesuccess4@gmail.com	\N	\N	$2a$12$rd9YAAQnYBuhS5GTRkG1r.0b75UInhvS6bZ4hiIfpxpvKXL0nTKp2	f	2020-07-14 15:13:53.626059	2020-08-09 14:41:40.106595	f	default	\N	\N	\N	\N	t	1
147	209	greenlight	gl-xoflafgmuiuh	ForUsGirls	\N	info@forusgirls.org	\N		$2a$12$AC8MiElutrOj9YslA7z1s.zCqhLW2BCsdvdDj/mGjHwrP6UUIWaPW	f	2020-06-29 19:35:06.115296	2020-08-11 18:08:24.862152	f	default	\N	\N	\N	\N	f	10
190	276	greenlight	gl-chhsctozwaaq	Kemi Adetu	\N	kemiadetu@gmail.com	\N	\N	$2a$12$7iXAE9QWeHfQ/mmDAEGSr.EQkpNEQEUOwYDa1wy4SwemIfOtzlJo.	f	2020-08-18 19:14:09.124098	2020-09-09 13:54:16.451055	f	default	\N	\N	\N	\N	t	1
185	270	greenlight	gl-jfuskohgyfkf	Caroline Wong	\N	hello.carolinewong@gmail.com	\N	\N	$2a$12$HGu5uHiOiHWxNsCqZEfS0OY4yUIshM2PK0TH2ctsJvB8c/8Q72bK2	f	2020-08-11 19:03:57.341355	2020-09-09 13:54:53.546711	f	default	\N	\N	\N	\N	t	1
60	93	greenlight	gl-dsenwutnfumt	Philippe Charles	\N	phil@phildcharles.com	\N	\N	$2a$12$RTBMva0OyeQO.Aq/yly5rupCeBhWm70uPsBDsrTnoB4b6T2VJLJlW	f	2020-05-08 22:05:06.307788	2020-07-23 21:30:33.80659	f	default	\N	\N	\N	\N	t	1
129	185	greenlight	gl-ekrgqtjzrdyh	Tenika Chavis	\N	tenikachavis@gmail.com	\N	\N	$2a$12$oPBDG7f/xnvQLsLA6VumuOLenPDvRNnsUyK7Cp0FjUINiQ2BBAb0a	f	2020-06-23 01:38:52.112387	2020-07-23 21:42:56.122865	f	default	\N	\N	\N	\N	t	1
160	227	greenlight	gl-hkhjrmwyovdv	Kimberley Miller	\N	kimberleym@spotify.com	\N	\N	$2a$12$puslWiF2ZDBOhpd3rCHMuOcJzKfbSXuHcdAI2hCz4dqZaQcYUuBcC	f	2020-07-08 16:25:14.84052	2020-07-23 21:45:36.387691	f	default	\N	\N	\N	\N	t	1
15	20	greenlight	gl-gttiiumhigty	Philippe Charles	\N	philippe.d.charles@gmail.com	\N	\N	$2a$12$Y9Q03h1zBX6Joe8ME7tHjeg/sTeG8eAuRd.YXZkzgm6uTlRoejfVu	f	2020-04-09 17:40:37.995743	2020-07-23 21:10:15.669532	f	default	\N	\N	\N	\N	t	1
16	23	greenlight	gl-hbabknqpjzpa	Ben Christensen	\N	ben.christensen@sap.com	\N	\N	$2a$12$jqt32HL0qWtXaPCFX8gydOIuoAlC9wg/aDe3HJd4qsowii4DmFg7i	f	2020-04-13 18:20:44.219266	2020-07-23 21:11:39.369199	f	default	\N	\N	\N	\N	t	1
24	35	greenlight	gl-wjkifhlfepht	Annick Bissainthe	\N	mysocialinterests@gmail.com	\N	\N	$2a$12$8i26lJrHWJXZnqCCR0Abj.lFGnCbsvACY7Zw0jyQxmikhA6fi8Nle	f	2020-04-18 17:01:20.174671	2020-07-23 21:15:21.033683	f	default	\N	\N	\N	\N	t	1
170	242	greenlight	gl-fkgwphoitezt	Anita Brown Levels	\N	anitalevels@gmail.com	\N	\N	$2a$12$.qNZFtmRbPnpB4HYbwZ2Hu/sKRw8b8FTER94K1.wGsZnlKc1Pc0Y6	f	2020-07-20 16:33:41.334059	2020-08-09 14:40:21.241302	f	default	\N	\N	\N	\N	t	1
17	24	greenlight	gl-soouvxbjgeed	KWMC Pre-Employment Program	\N	pep@kwmc-on.com	\N		$2a$12$f85qWbTv3mw5wcyLSfk0U.HqwsNlgJkcyQ6R.IwWjRLt2y8w4x28.	f	2020-04-14 19:54:56.038611	2020-07-23 21:11:18.73235	f	default	\N	\N	\N	\N	f	9
18	25	greenlight	gl-cpulkippqwad	KW Multicultural Settlement Services	\N	settlement@kwmulticultural.ca	\N	assets.adobe.com/32085322-1808-4cff-ac43-0176c1689bb1	$2a$12$3tMNTLqqSzp9m.ZiIDLGwO/c/K7Le79cSi0N6WNl25/4v2HRpLX3C	f	2020-04-15 14:29:28.855383	2020-07-23 21:12:17.049129	f	default	\N	\N	\N	\N	t	1
19	26	greenlight	gl-vwunwqtlfigi	Hamoon Ekhtiari	\N	hamoon.e@gmail.com	\N	\N	$2a$12$Myxi7LxPkM9WsctW..tPW.qNCS3NSRMQj0STBx58noOHbvvFoyky6	f	2020-04-16 00:07:06.471296	2020-07-23 21:12:25.376438	f	default	\N	\N	\N	\N	t	1
28	48	greenlight	gl-sdenangessti	Humna	\N	humna.shaikh@canada.ca	\N	\N	$2a$12$1l1uPPdAC7Okh4DRD5zs2OMLfdvFMvPsDs5uohUGzzxFe98JQVMue	f	2020-04-27 14:28:32.701949	2020-08-09 14:42:43.119032	f	default	\N	\N	\N	\N	t	1
20	29	greenlight	gl-rdxsywkesxvt	Simone Noble	\N	jayne.mandat@gmail.com	\N		$2a$12$JVjJmzmPzqqyutmpwm7jwuy8b8K5/WJHBYzLMqWv/s4HRjElr0CtW	f	2020-04-17 15:38:05.767628	2020-07-23 21:12:34.955	f	default	\N	\N	\N	\N	t	1
21	31	greenlight	gl-fzuswxnacajo	Carl Cadogan	\N	carl@receptionhouse.ca	\N	\N	$2a$12$pY6eT/fZnA6TDbwqScxHbOICgjW04aRQHCn2R9l8jqvNKShoVpwP6	f	2020-04-17 17:32:58.388539	2020-07-23 21:15:31.140229	f	default	\N	\N	\N	\N	t	1
154	222	greenlight	gl-psjcyljmogvl	Yenisi Onabolu	\N	yenisionabolu@gmail.com	\N	\N	$2a$12$zbom0i.DFym1kIdBwEQKM.zaQyJfOEqRucMgIJjNm03Qhs3rI4H8S	f	2020-07-06 22:29:54.020803	2020-07-23 21:46:24.771867	f	default	\N	\N	\N	\N	t	1
148	211	greenlight	gl-ryjzzhkwoauw	Tameka Vasquez	\N	tameka.vasquez1@gmail.com	\N	\N	$2a$12$oiCeAx.qNKahzb/XnXnShuxs75xHBn0t9DF6LrTO/D8vf0ns1zTVO	f	2020-06-30 21:54:03.53301	2020-07-23 21:47:33.432724	f	default	\N	\N	\N	\N	t	1
164	232	greenlight	gl-vwoehxcqakpg	Sonal Sharma	\N	usa3@oneyoungworld.com	\N	\N	$2a$12$RnWv5P4eiuphU.LYHaYZWu5abn.z1BhHUTEO5sBL834s5Dt5nDA3K	f	2020-07-10 22:39:36.156783	2020-07-23 21:58:30.041514	f	default	\N	\N	\N	\N	t	1
173	248	greenlight	gl-zjjyxfziplho	Olumayowa Oluwasanmi	\N	olumayowa.oluwasanmi@dal.ca	\N	\N	$2a$12$XbJRf8NrW4mw9gussPgCDezmhCWMDb3CQvNxWTazr1n3uKH566.Tm	f	2020-07-27 11:54:58.035519	2020-07-27 11:54:58.053485	f	default	\N	\N	\N	\N	f	1
14	19	greenlight	gl-vinsnrhwjvny	Kim Test	\N	aminka.belvitt@wofemtech.com	\N		$2a$12$IRMa5xyAmCdKs0sGuGrkvuBp99FvVQBnXIO00DdUFHEgm/gt3g.PG	f	2020-04-09 02:19:23.006892	2020-09-09 13:56:19.370315	f	default	\N	\N	\N	\N	f	2
8	10	greenlight	gl-immfblxizlma	Cfdbjk	\N	vfd@fgfs.com	\N	\N	$2a$12$Oxno9cwgurgJgDBkqNLvO.flX0dR3O0MGw772MDXV6RpFC57QPLTO	f	2020-04-06 02:41:20.555203	2020-06-29 17:09:32.094362	f	default	\N	\N	\N	\N	t	1
39	66	greenlight	gl-doqjilikmmop	Joree	\N	jp_dvsd@yahoo.com	\N	\N	$2a$12$f.dTdc2fyWFLo5XhefDNkO0QTwWcv/TIvIVadcOG3fh7rKn8fmG82	f	2020-05-02 03:27:07.517208	2020-07-23 21:15:46.677921	f	default	\N	\N	\N	\N	t	1
38	65	greenlight	gl-gzrsxwelnavd	Shauna	\N	svassell25@gmail.com	\N	\N	$2a$12$v4nx.S0H2qEWmm9YhK.YPuOurTblgXR3n9VMxpsqupr1RCU9oZOxK	f	2020-05-02 02:15:18.203051	2020-07-23 21:15:53.775943	f	default	\N	\N	\N	\N	t	1
37	62	greenlight	gl-sgspgurwivkx	Trisha Doharty	\N	trishadoharty@thewiseinitiative.org	\N	\N	$2a$12$iiP15NUQvO60sPX2eGwyFu2iqOOyZkwbLgOIHXMM52j3pxRRfGkca	f	2020-05-01 05:46:59.515007	2020-07-23 21:16:00.399616	f	default	\N	\N	\N	\N	t	1
36	59	greenlight	gl-cgdqlqppkucm	Sharnay Hearn Davis	\N	sharnaylhearn@gmail.com	\N	\N	$2a$12$kY/caVxAO42T/R1qU6ecueBMyWm4rfge.QNr5/o1TGOy55ME3f9Di	f	2020-04-29 19:45:17.027619	2020-07-23 21:16:06.759777	f	default	\N	\N	\N	\N	t	1
35	57	greenlight	gl-zgxbncmmlrcc	Suha Al-Hindawi	\N	suha@kwmulticultura.co	\N	\N	$2a$12$8Z3qN14nvefD/L9nPrZrA.k4ixnqLB5l3LuIFRmMaidi/0FOu9f1a	f	2020-04-29 16:13:05.04138	2020-07-23 21:16:16.593284	f	default	\N	\N	\N	\N	t	1
29	49	greenlight	gl-qnablsjctdux	samuel redae	\N	samyredae@gmail.com	\N	\N	$2a$12$YwzNKN0zvXYsuygybLc6aeWlU5B0oBRuWwH5KWji9DeGosrAIxX8.	f	2020-04-27 14:29:00.190175	2020-07-23 21:16:31.876645	f	default	\N	\N	\N	\N	t	1
23	34	greenlight	gl-kvaehyteurvl	Sol Koltu	\N	koltu@hotmail.com	\N	\N	$2a$12$jV4F4Lu9Pwq.O4l2sFqV/Oc2HdGbksU8OsS8.2k7avFAutZ9WmEH6	f	2020-04-18 16:35:53.324373	2020-07-23 21:16:43.440082	f	default	\N	\N	\N	\N	t	1
22	33	greenlight	gl-htjkihkxrxey	Lucy Silversides	\N	lucy.silversides@gmail.com	\N	\N	$2a$12$bvvpQVeT0rzZ98zmawUy5eSDr2yQhvWGSiPPHJokEUxkLgQQ3yhsK	f	2020-04-18 16:31:50.607136	2020-07-23 21:16:53.949243	f	default	\N	\N	\N	\N	t	1
26	37	greenlight	gl-qvyevfqjsnio	Zet Mayuga	\N	zettiemayuga@gmail.com	\N	\N	$2a$12$4TIZQa8C9aqxNWvoUg4Vme1ExMOxtrg0GmgkRaJZ9S06Tx1LslzLa	f	2020-04-18 19:43:53.54961	2020-07-23 21:17:03.257343	f	default	\N	\N	\N	\N	t	1
27	43	greenlight	gl-fgajvxmlqpmv	fariba kazemi	\N	faribakp@hotmail.com	\N	\N	$2a$12$qSzjoio9Q8iq9O0kklWOZ.XR5yl9Qw2yYZRcSXJkxqujBPs0HGPyK	f	2020-04-23 01:31:27.678015	2020-07-23 21:17:12.230291	f	default	\N	\N	\N	\N	t	1
30	50	greenlight	gl-rzizwbflyipb	khalidah	\N	damilola0103@yahoo.ca	\N	\N	$2a$12$xslNZoptV5bxQay38yT7jet1.IkbetNVQmkop72iFt3ow7P.ahP76	f	2020-04-27 16:41:25.574538	2020-07-23 21:17:25.929479	f	default	\N	\N	\N	\N	t	1
31	51	greenlight	gl-zgdfurlieavj	Echo Jiang	\N	jiangtingxuan725@gmail.com	\N		$2a$12$oPx13jdKLceL5eJZKctNyud3pFhMhmSr71UbLM2FqXpp1U5DeW6XO	f	2020-04-27 19:51:24.685697	2020-07-23 21:17:51.368131	f	en	\N	\N	\N	\N	t	1
32	52	greenlight	gl-mxmynjfhkakj	Carolina Balcazar	\N	cbalcazg@gmail.com	\N	\N	$2a$12$19XX/DGpb8Fwqct0ZYIo5eI.L84R4wGwm3Mn9WZZEjW65SsRvY34.	f	2020-04-28 14:56:50.875483	2020-07-23 21:18:00.537975	f	default	\N	\N	\N	\N	t	1
34	56	greenlight	gl-alvbuzidarhl	Hadembes Yebetit	\N	hadembesy@yahoo.ca	\N	\N	$2a$12$Wr8I1/FqiVPUsVYOXJXIXOx7vVu3O8ust.1Qr80VRW7dJVT3YyUIa	f	2020-04-29 14:18:19.679671	2020-07-23 21:18:07.863094	f	default	\N	\N	\N	\N	t	1
33	54	greenlight	gl-gufwqzeogtlx	Anina Monteforte	\N	anina.monteforte@gmail.com	\N	\N	$2a$12$UhV2WpLTqzEznkRFh5k5iOHLvONVyp9ovrkaKmL8QvAYAxgq58mMS	f	2020-04-29 00:15:17.531362	2020-07-23 21:18:14.415081	f	default	\N	\N	\N	\N	t	1
59	92	greenlight	gl-pfromadtpavx	Anne-Edma Louis	\N	anne.edma.louis@live.ca	\N	\N	$2a$12$g43sBZ0P7g9N6qHl9ckwm.ksk.Hz2C9igVdhLN76xdSJ96ISuAk5S	f	2020-05-08 19:21:58.427093	2020-07-23 21:28:08.083119	f	default	\N	\N	\N	\N	t	1
75	111	greenlight	gl-lelcprgqzzqq	Terrie Brookins	\N	tieras@gmail.com	\N	\N	$2a$12$5/GYuyu4nHGSqviTTtaxsuZHVpIS7WTqk68NQp0VCL7IiJlvhq312	f	2020-05-23 23:25:52.26411	2020-07-23 21:28:16.080801	f	default	\N	\N	\N	\N	t	1
177	261	greenlight	gl-emxyhxqkrgzo	Caroline Wong	\N	caroline.wong@ylabsglobal.org	\N	\N	$2a$12$8bb2BH8/hOeUe1ZwSByLce7eEppXB7Ghxc8MbNc5bIi6yAKy7TvE.	f	2020-08-06 18:30:56.451532	2020-09-09 13:56:53.210496	f	default	\N	\N	\N	\N	t	1
176	260	greenlight	gl-idtmkpwneyjf	Shola Olabode-Dada	\N	shola.dada@ylabsglobal.org	\N	\N	$2a$12$WQJjeOuuSdGy2Iaw9TrsAu24/OvqS.aQVs2hLpk9mpAUNSlNZyzw2	f	2020-08-06 18:27:22.192677	2020-09-09 13:56:59.580088	f	default	\N	\N	\N	\N	t	1
197	295	greenlight	gl-bznawaazmaai	Sally Dimachki	\N	sallydimachki@gmail.com	\N	\N	$2a$12$a9NPwlok5aI522jBiYJli.N/Y0BkV05hyRkZ0MM9/iFie8eOxM7C6	f	2020-09-18 02:14:18.56746	2020-09-18 02:14:18.583754	f	default	\N	\N	\N	\N	f	1
161	230	greenlight	gl-itqfyatuuwrp	Hedda Fehrm	\N	hedda@spotify.com	\N	\N	$2a$12$BmOgNZQANMP3uNw82zkcG.jyS4abXyd8REbMi2YwP4OpPSqwB8K7a	f	2020-07-09 09:07:29.319412	2020-07-23 21:20:20.269104	f	default	\N	\N	\N	\N	t	1
171	243	greenlight	gl-esucoaagsmej	Amplify Montreal	\N	amplifymtl@gmail.com	\N	\N	$2a$12$0NpQfPKQcaHLaoAa4Rv2tOLdlmN774KcaM8HEcXtzdcJH5//qL5em	f	2020-07-21 16:43:51.058685	2020-08-09 14:38:44.42988	f	default	\N	\N	\N	\N	t	1
149	212	greenlight	gl-uyimertbscum	Alix ADRIEN	\N	alix.adrien1959@gmail.com	\N	\N	$2a$12$x9yyJ.I8gaS/USg/W.0iGuZ69e.bQ9zvud2GY6vl2jfJ/iYKciTA.	f	2020-07-01 12:49:37.912308	2020-08-09 14:41:58.232631	f	default	\N	\N	\N	\N	t	1
165	235	greenlight	gl-doigcylzemzx	Dhyey	\N	dhyey@gmail.com	\N	\N	$2a$12$UfWn9hzNnl2J/DYOFfgq3.wH1DySC/zXf0Nm9kHwZNIwsG679H/dK	t	2020-07-13 10:39:01.014187	2020-07-13 10:39:01.154056	t	default	\N	\N	\N	\N	f	2
155	221	greenlight	gl-uvgvljdibrtc	Amanda Marochko	\N	amanda@shesharp.co	\N		$2a$12$7SU4KreH7H0QdXT5h8ly6OCXuW.FybgJl2ScFTbb/.7/wwd5GtDRi	f	2020-07-07 17:42:40.264687	2020-09-08 16:39:01.681011	f	default	\N	\N	\N	\N	t	9
191	277	greenlight	gl-rmhavplpjdkx	RaeAnne LeBrun	\N	culturalwellness@unya.bc.ca	\N	\N	$2a$12$4YsiFuxssxaKaqI0mW0ssuzp1ctZZZ5b6Va24RS7WCPhQISHI3fh6	f	2020-08-19 06:29:49.16349	2020-09-09 13:54:09.724629	f	default	\N	\N	\N	\N	t	1
186	271	greenlight	gl-himpmstjawav	Cynthia Dam	\N	cynthia@hive.co	\N	\N	$2a$12$I/cNdr4q9Hzm4Kt9.zkHfexA1DI.93JqpA536ECrcpdKA9uBaOLI2	f	2020-08-13 15:06:40.591743	2020-09-09 13:54:47.015042	f	default	\N	\N	\N	\N	t	1
150	215	greenlight	gl-htgpjbnippfd	Amplify Mtl	\N	mtlrise@apathyisboring.com	\N	\N	$2a$12$cdthGakVMK4Ty49SBd.glubgcmlByuTBI8MUMFmaFEw1WcKrERARG	f	2020-07-02 22:34:36.482066	2020-07-23 21:47:17.650694	f	default	\N	\N	\N	\N	t	1
179	263	greenlight	gl-ythdufsubeop	Senthilkumar Palaniani	\N	senthil2278@gmail.com	\N	\N	$2a$12$BLD6zW77EwI0C5jHQ//o5uBuDQfWQJkmjjDcx5SDpaOPlsHfKidda	f	2020-08-07 18:05:20.429856	2020-09-09 13:56:32.667646	f	default	\N	\N	\N	\N	t	1
49	77	greenlight	gl-ocxlqohkztfs	Cindy Adem	\N	adem@village2nation.com	\N	\N	$2a$12$3iQSJSWI4A9S1AWlo2i8w.b8jKxnDZOv.SVGMDdO3bWoYo8lcDnvu	f	2020-05-04 19:19:19.88452	2020-07-21 23:31:40.389615	f	default	\N	\N	\N	\N	t	1
3	5	greenlight	gl-wfvqkzhetrur	Roselle Boucher	\N	roselleboucher@hotmail.com	\N	\N	$2a$12$/fzXAed9MioVEBObOS/q8.MX.Ujte.TusKV89e.j83M4o0h26cOQK	f	2020-04-05 21:13:57.44093	2020-07-23 21:08:21.540493	f	default	\N	\N	\N	\N	t	1
178	262	greenlight	gl-ykxkrkaxqzwv	Shadine Barnes	\N	shadineb@gmail.com	\N	\N	$2a$12$PSDsNOJnwKZHfYgApQ8K0OGCJ.S5peRxm497RnCvwy/vCprZJiaD2	f	2020-08-07 18:02:49.415349	2020-09-09 13:56:39.354541	f	default	\N	\N	\N	\N	t	1
4	6	greenlight	gl-ctmykvzaekqt	Lesa-Marie	\N	lesamarie.andrew@gmail.com	\N	\N	$2a$12$B4EMYzYVFlUxeOtLaru9seQedrq0WAVOLb.SG4jZQLFDeLMfhvqs2	f	2020-04-05 22:10:46.033458	2020-07-23 21:08:29.193938	f	default	\N	\N	\N	\N	t	1
5	7	greenlight	gl-mcixkmohmyrl	Aisha 	\N	aaddo20@gmail.com	\N	\N	$2a$12$NGpCqQinJZpFY9VcJR8uEeMgR3BDhNz69Kw.ekA2AKN4tmd.OCSVO	f	2020-04-05 22:15:55.568372	2020-07-23 21:08:37.124504	f	default	\N	\N	\N	\N	t	1
7	9	greenlight	gl-kuiybbeuubqc	Tiffany Lucey	\N	tlucey@trschools.com	\N	\N	$2a$12$OUfHimQD4D.a/2mx40nbmes.CGI4yhnoVr4oxfyB3I.lNuJ/FSyjW	f	2020-04-06 02:28:38.885493	2020-07-23 21:08:45.048461	f	default	\N	\N	\N	\N	t	1
9	11	greenlight	gl-hyjhyztlijnz	Jade Parkinson Gayle 	\N	jade.parkinson-gayle@ymcaquebec.org	\N	\N	$2a$12$VyGeGRbeNSOm6YPA4eoNDe6C8wpYeF8XFosiC4Zv5a4d/lU6yfzHK	f	2020-04-06 16:10:07.61672	2020-07-23 21:08:56.712723	f	default	\N	\N	\N	\N	t	1
192	280	greenlight	gl-fcmwuvuousdo	Dheman Abdi	\N	dhemanabdi@yahoo.com	\N	\N	$2a$12$4ZXMLs/bJOGG5GCTYB6Y5eMZymoMg1pLgQbUBKLvXlKrOe1Djko1m	f	2020-08-21 18:59:36.185759	2020-09-11 18:21:05.08764	f	default	\N	\N	\N	\N	t	1
6	8	greenlight	gl-jialtzbeegxg	Farida Asgarzade	\N	farida.asgarzade@gmail.com	\N	\N	$2a$12$PbSDZ50LJtYI9L3n6sjKJ.rTfI9s8.PsCLn.LKUwRh82gci2nuzRm	f	2020-04-05 22:51:47.689383	2020-07-09 04:02:05.045004	f	default	\N	\N	\N	\N	f	4
10	13	greenlight	gl-opcyfrucgbeq	Anika Williams-Hewitt 	\N	anika@kwmc-on.com	\N	\N	$2a$12$9kO7.oAiMDM85g/bzm5iV.2vnE9eKhbjYbFSBUartFEumyTzOm7XK	f	2020-04-06 17:56:09.465839	2020-07-23 21:09:04.255221	f	default	\N	\N	\N	\N	t	1
12	16	greenlight	gl-nwrastnejwvw	Maram Kassab	\N	maram@kwmc-on.com	\N	\N	$2a$12$vBQ/W421FERQKNgZz75bh.37dKTRwVVw6eQdXvfhIBLJg.IlbuA/6	f	2020-04-08 16:31:25.91763	2020-07-23 21:09:24.444165	f	default	\N	\N	\N	\N	t	1
13	17	greenlight	gl-mqstfbayhxst	Keith Summers	\N	keith@kwmulticultural.ca	\N	\N	$2a$12$adwbDm1WqNdWYjkzrdlhC.cjX/2vUgSoouIxpgiJQPn0BpD5CK/3m	f	2020-04-08 18:06:33.404036	2020-07-23 21:09:31.504688	f	default	\N	\N	\N	\N	t	1
198	297	greenlight	gl-rytejlnflbjj	Ashan Dorsett	\N	ashandorsett@gmail.com	\N	\N	$2a$12$dvL1ndUOSOe0IafEaKDobe/f4SmbN3esPAlKoNugoO8o0XCgCel2y	f	2020-09-24 00:23:56.009113	2020-09-24 00:23:56.030983	f	default	\N	\N	\N	\N	f	1
181	265	greenlight	gl-dyxiqteciher	Rhaine Aspen	\N	rhaineaspen1@icloud.com	\N	\N	$2a$12$oftZfx2LCKaSRDi7G1pQE.qtf.Hlc39JX4RfDTJeTazz11O/Da3qa	f	2020-08-07 18:23:00.463882	2020-09-09 13:55:25.031511	f	default	\N	\N	\N	\N	t	1
1	1	greenlight	gl-nacbvqutyskk	Administrator	\N	admin@example.com	\N		$2a$12$D3TJ8e1y7ZlfEaz3bV4pVOXDSMsvpAm/VWSEAuzMwlseK0H4iZE26	f	2020-04-03 10:00:14.598601	2020-06-29 17:09:32.059743	t	default	\N	\N	\N	\N	f	2
180	264	greenlight	gl-czgtamjufypu	Ife	\N	indiearts@icloud.com	\N	\N	$2a$12$wvbwn.g106C11cr6fOi2P.uF0kUTg3zw1hnCK7MQB4MU7uScwIcGy	f	2020-08-07 18:11:08.235756	2020-09-09 13:56:26.488479	f	default	\N	\N	\N	\N	t	1
156	224	greenlight	gl-doypylindwcw	Shakira Rouse	\N	excel@specialcompass.ca	\N		$2a$12$LC8ANSdL7JZvSgltmS496.0zYpz.SoeCRFH4xbx9kySyANpGLwq6G	f	2020-07-08 00:19:11.033065	2020-08-20 22:26:25.938731	f	default	\N	\N	\N	\N	f	8
11	15	greenlight	gl-xfqfssaburyw	Jade Parkinson Gayle	\N	jadeparkinsongayle@gmail.com	\N		$2a$12$Y6./J7tWiwPHbQZUANhVVeYbGzIEYKFcyY/.MNJwhq98W9c3LoNFK	f	2020-04-08 01:30:49.537317	2020-08-21 19:29:59.380741	f	default	\N	\N	\N	\N	f	8
2	3	greenlight	gl-kluzfgsokejx	Camille	\N	aminka.belvitt@gmail.com	\N		$2a$12$wBxaiAU4OjYNVupqYUy8ruZoTEG6cVGjML67C2nax9KfAumCk98qC	f	2020-04-05 20:49:40.780616	2020-06-29 17:09:32.070196	f	default	\N	\N	\N	\N	f	2
187	272	greenlight	gl-kmfsuurujaeq	Sharon Beason	\N	sharon@womeneur.com	\N	\N	$2a$12$B9/iqylRyYMRBnUjcFrE8uk30OKOKxDJSZlWr6sKtAsuDYCePktzq	f	2020-08-13 21:32:23.682959	2020-09-09 13:54:38.622084	f	default	\N	\N	\N	\N	t	1
182	266	greenlight	gl-ouoyixtztedr	kayson	\N	kayson.d@icloud.com	\N	\N	$2a$12$Cfze8F2tTjLsZ15MXfmKqOstv7MTq.p27Wgec0WOrFs7s6IDpM.9q	f	2020-08-07 18:29:27.646196	2020-09-09 13:55:16.166092	f	default	\N	\N	\N	\N	t	1
74	110	greenlight	gl-msfzoxsgdfgy	CJM	\N	cmejiasmitchell1@outlook.com	\N	\N	$2a$12$QVoJkcihDF.Vm8f9WKoWWujj49w3cNzLhEHqPf3SeUZ3Y0YrDwsOe	f	2020-05-23 11:04:23.798414	2020-07-23 21:29:37.873774	f	default	\N	\N	\N	\N	t	1
73	109	greenlight	gl-xqmxztfeyaxm	Fernanda Goes	\N	fernandasgoes@gmail.com	\N	\N	$2a$12$TAkVwy0wrmjx9NkBwOSbK.Rk5LWfPrXD4jN7H5wWZusBvFHIEtY6m	f	2020-05-22 22:30:42.969471	2020-07-23 21:29:48.700481	f	default	\N	\N	\N	\N	t	1
71	106	greenlight	gl-tbinmpyqoczv	Christiana 	\N	omalichristie@gmail.com	\N	\N	$2a$12$jY3MihhwohAwJhZBN2tSleyfrkAKT5J7HoUDHatsZftvMRq/dit8a	f	2020-05-21 09:28:22.853858	2020-07-23 21:30:03.444052	f	default	\N	\N	\N	\N	t	1
70	104	greenlight	gl-clkmanhpfjbv	CFHI	\N	info@cfhinitiative.org	\N	\N	$2a$12$WP3JPEo6.2h6fYrEjv.5vuXHKLBrxkZOzwHPWHrV0Zqm.RJLVATSK	f	2020-05-20 13:34:42.671586	2020-07-23 21:30:10.95832	f	default	\N	\N	\N	\N	t	1
43	70	greenlight	gl-annipgbcbxvu	Sidick	\N	a.sidick@oshara.ca	\N	\N	$2a$12$pd.MPc.NW/evXSkP1ic13OxgyPR44vJKOcdj50.OS/snsLN988YPa	f	2020-05-03 02:44:36.311879	2020-06-29 17:09:32.117643	f	default	\N	\N	\N	\N	f	4
62	95	greenlight	gl-umreyrwpdbuo	Melika forde	\N	melika.forde@gmail.com	\N	\N	$2a$12$.OD8BzTCxdtdtDnplbY./OVG2QhIbMsHfIu6tEe3YP8VSpHUHBH8u	f	2020-05-09 12:54:13.166335	2020-07-23 21:30:18.848843	f	default	\N	\N	\N	\N	t	1
68	102	greenlight	gl-eplvethpbzop	C.M.A	\N	anguchi@yahoo.com	\N	\N	$2a$12$qci5wKXaA6M1VUDT2HiyluWYZtVJd4i6QhO6fZWR/OsngeApmdTje	f	2020-05-14 22:35:04.2096	2020-07-23 21:30:25.820135	f	default	\N	\N	\N	\N	t	1
63	96	greenlight	gl-avrryhekmarm	Christelle Lorraine Dossa	\N	cldossa@gmail.com	\N	\N	$2a$12$L.0mZsuMxSJVbXEZhfx9vu0tgCjSlFvpwWm55q3D99VrpbathnCv2	f	2020-05-11 12:35:55.672864	2020-07-23 21:30:42.763494	f	default	\N	\N	\N	\N	t	1
64	98	greenlight	gl-cjyvabtjolzs	Banu Vardar	\N	banuvardar2@gmail.com	\N	\N	$2a$12$LHMejEXgfjszir11aCHOM.Bv4GICDP1XcRsJIAt0ntY19MeT6a51y	f	2020-05-14 16:30:21.108191	2020-07-23 21:30:51.447928	f	default	\N	\N	\N	\N	t	1
69	103	greenlight	gl-ncripddltikm	Justin Garrett Moore	\N	jgmoore@gmail.com	\N	\N	$2a$12$P45Rs2CQDpyvPCp8ZUmF3e3yF0VZNi09sZIKwHO2fONLm9VlIB6WG	f	2020-05-15 17:58:57.355554	2020-07-23 21:31:00.42383	f	default	\N	\N	\N	\N	t	1
72	107	greenlight	gl-omhdtevcwwua	Laura Corrales	\N	lauraalejandra.corrales@gmail.com	\N	\N	$2a$12$rZ07f4Qy.YwwPjT/W3MwyOnq0qPP18XArckrIw7BtHZcgf6mESw3a	f	2020-05-21 13:27:21.017228	2020-07-23 21:31:09.270383	f	default	\N	\N	\N	\N	t	1
136	194	greenlight	gl-gmcwjydqeixg	Monyel Edwards	\N	hoodyco7@icloud.com	\N	\N	$2a$12$Y9dCy5kPXISPxgfMqjh8Cu2WKYEZ7AiT8wxi9CnrLVoKj/dfdj6i6	f	2020-06-23 21:52:10.334092	2020-07-23 21:37:46.357995	f	default	\N	\N	\N	\N	t	1
132	189	greenlight	gl-oeigufgzkuvn	Tamira Moore	\N	moore.tamira@gmail.com	\N	\N	$2a$12$jyJa1l/jH1WXVlNvrPyjOOsg3U8rOqH6sqlKXzSoqsgBmvEK9QbQ2	f	2020-06-23 12:49:17.30021	2020-07-23 21:39:44.923665	f	default	\N	\N	\N	\N	t	1
130	187	greenlight	gl-fyhvlupksgfi	LaKeisha Wolf	\N	lakeisha.wolf@gmail.com	\N	\N	$2a$12$cazJbLlKAYvJGgfqqsOb9.C8G1CFwpNNy5iduXiN7kpLD6LwEBSZK	f	2020-06-23 03:38:21.557525	2020-07-23 21:40:02.038313	f	default	\N	\N	\N	\N	t	1
134	191	greenlight	gl-uoqbsfdlvzkb	Mayowa Oluwasanmi	\N	oluwasanmimayowa@yahoo.co.uk	\N	\N	$2a$12$Qi8VNzPKXLJ.Bb7zpva1seh7uKEIfX9xX3.X0.HE0FlDXhC/vRGWC	f	2020-06-23 20:00:18.409151	2020-06-29 17:09:32.166937	f	default	\N	\N	\N	\N	f	1
61	94	greenlight	gl-ewfukharghbo	Tani Chambers	\N	info@tanichambers.com	\N	\N	$2a$12$Oe7tvN7KdMhjSMjSuWk02OeeChhqTSpVRbwe/RFk9uiS3d/LLzQqG	f	2020-05-09 00:42:34.967192	2020-07-21 23:32:11.071441	f	default	\N	\N	\N	\N	t	1
67	101	greenlight	gl-kuzghhhxzter	Will Greenwood	\N	will@intermediaagency.ca	\N	\N	$2a$12$pj7DCScM4stDLJPU5b3NtOb/OY8oRdLxPvSBzrvUdaZ0rUWj4cR8C	f	2020-05-14 20:38:47.558891	2020-07-23 21:18:28.174309	f	default	\N	\N	\N	\N	t	1
57	88	greenlight	gl-xqcxyimvevlh	Shayna Peters	\N	gevelle.shay@gmail.com	\N	\N	$2a$12$mjEvgioIf2nRwpc02ZnbD.oKI/oTqn/Lvq5k888qK8E39FCctAwbG	f	2020-05-06 05:13:54.807504	2020-07-23 21:18:36.551081	f	default	\N	\N	\N	\N	t	1
66	100	greenlight	gl-bsbhwyhesetb	Tairis Rodriguez	\N	tqr5001@gmail.com	\N	\N	$2a$12$2DuQ.Pi2RrZS3Ldyc.hBeesSmRVnCEsm6ikWGWjwr.MUkkW6jyWHm	f	2020-05-14 20:31:05.286383	2020-07-23 21:18:42.1021	f	default	\N	\N	\N	\N	t	1
65	99	greenlight	gl-zsaxoplfudlk	Maylis Yangni-Angaté	\N	myangate@gmail.com	\N	\N	$2a$12$W7cQVv3kGIMiNXgIPJNGq.hbjpeZPVqEsXCCTA0YKQS5u73pZCEj2	f	2020-05-14 17:35:37.268108	2020-07-23 21:18:48.722504	f	default	\N	\N	\N	\N	t	1
40	67	greenlight	gl-jhojapnlfylj	Tahira White	\N	tahira@19parkinc.com	\N	\N	$2a$12$fPQxyFAZLcAa1.Xgt6GUr.RYybqaPneUKWI2tJTZiWuxMCBNfgGyq	f	2020-05-02 13:17:30.35726	2020-07-23 21:24:01.782727	f	default	\N	\N	\N	\N	t	1
41	68	greenlight	gl-xhfsywtdpdzs	Claudia Pilgrim	\N	claudia@mscopywriter.com	\N	\N	$2a$12$tQIEK7pOuIkNG9eq8cWkVOAK9efS7a8Qg4tHUAJcQ9KyYtk1Pxfv6	f	2020-05-02 21:12:05.222505	2020-07-23 21:24:10.850637	f	default	\N	\N	\N	\N	t	1
55	85	greenlight	gl-knyzdgqqdsit	Rowan Asad	\N	rowan@museselfcare.com	\N	\N	$2a$12$JuFbgQGJJ0v94bf3PYbODeJ4YLl9siN1oiHSAegGSGuJUXdbk0SsG	f	2020-05-05 15:38:11.525752	2020-07-23 21:24:17.472747	f	default	\N	\N	\N	\N	t	1
54	83	greenlight	gl-kygjlkaqedwh	kazem sidiq	\N	kazemsidiq@gmail.com	\N	\N	$2a$12$z25r7NWXnF0nNVPmdvxdKu2NoRrgT.9tJbBf0.sD9AvcR0mh9qe96	f	2020-05-05 14:21:11.088333	2020-07-23 21:24:24.842864	f	default	\N	\N	\N	\N	t	1
53	82	greenlight	gl-zyszoweyoiid	Catherine K	\N	catherine@sifn-montreal.com	\N	\N	$2a$12$BhVp.FpS5Kl0eV7XVB37Me7Vz08DclhektOdWD4PCOW3FeWLdbjaS	f	2020-05-05 03:41:41.142583	2020-07-23 21:24:32.418779	f	default	\N	\N	\N	\N	t	1
52	81	greenlight	gl-gypwgpufiegn	Micheal Reid 	\N	davian.reid555@gmail.com	\N	\N	$2a$12$ogvDbOW66Yn700YXzCRkY.hYmKKKCW2QOl9XlRdNos7i9D3zG2uWq	f	2020-05-05 00:35:14.583987	2020-07-23 21:24:39.824251	f	default	\N	\N	\N	\N	t	1
44	71	greenlight	gl-uppmovdnhxnn	Karon	\N	karon.03@hotmail.com	\N	\N	$2a$12$5FC0wdbcrsbY7OiaanrgPOpoxJ9LBAGCXZRTY4RG.kB7h2eZMQUqa	f	2020-05-03 03:06:50.922684	2020-07-23 21:26:26.009138	f	default	\N	\N	\N	\N	t	1
51	79	greenlight	gl-tqvjodttzoam	Ornella Horimbere	\N	horimbereo@gmail.com	\N	\N	$2a$12$xQk1WumH2RX9b7FVlf3P0e2hE6xut/8SPuAdzWqcFwgFtp88fFDj.	f	2020-05-04 23:02:32.994841	2020-07-23 21:26:33.713255	f	default	\N	\N	\N	\N	t	1
50	78	greenlight	gl-qapwhskaqfae	Micheal Reid 	\N	micheal.reid62@hotmail.com	\N		$2a$12$a9EDsfhl2RMy137.BDSexeui/J5vu4aVGeX1JugQRB3YfhLn1gaTu	f	2020-05-04 20:34:22.614676	2020-07-23 21:26:44.831555	f	default	\N	\N	\N	\N	t	1
48	75	greenlight	gl-ogoysdbmwksq	Paula Whitelocke	\N	curlyhairdesigns@gmail.com	\N	\N	$2a$12$suoozHo3Se5V6N8h1po2AedgCcfeIfa2t3fovwx.tst4LUBpQa.V2	f	2020-05-04 16:47:56.989319	2020-07-23 21:26:52.657793	f	default	\N	\N	\N	\N	t	1
47	74	greenlight	gl-sglpqznguirm	Alicia Wynter	\N	a.wynterphotos@gmail.com	\N	\N	$2a$12$nbHJg1f.acMmRv.J9vR72.crb/DQYSVQ/p02k8j0kRq.7wjNxs0bu	f	2020-05-04 16:40:14.695084	2020-07-23 21:27:00.079204	f	default	\N	\N	\N	\N	t	1
46	73	greenlight	gl-jewhtaztczrq	Sharricka belvitt	\N	shareen_b@icloud.com	\N	\N	$2a$12$SHZdUsxWLv4XGBtuuntQ1OwvJdY7P3qaTGwfMoigbU5HWKwgEk3Vu	f	2020-05-04 15:17:15.381649	2020-07-23 21:27:06.639631	f	default	\N	\N	\N	\N	t	1
42	69	greenlight	gl-eclctsdvsute	Ivelyse Andino	\N	ivelyse@radical-health.com	\N	\N	$2a$12$c1YVdzaGGPdwWknbSdEf5ORloKW98Adq1kjzjH03hyld/AoGyEt9a	f	2020-05-02 21:32:26.404687	2020-07-23 21:27:17.297711	f	default	\N	\N	\N	\N	t	1
45	72	greenlight	gl-webotphgrrcy	Rhenie Bih	\N	rheniebih94@gmail.com	\N	\N	$2a$12$MFOM7X2q.AOMdo.WV4XhQOaRf3KzRnh69RsqUo8HdAS.B4IlWugxa	f	2020-05-03 20:58:44.727218	2020-07-23 21:27:30.029766	f	default	\N	\N	\N	\N	t	1
56	87	greenlight	gl-vzljxfnpnomg	Jennifer Abu	\N	jenniferoabu7@gmail.com	\N	\N	$2a$12$0qlE4IWsyyNMYHzOClR5X.2RHh.Z0fd5nKwixJdtqGoQZ/9X4x8WO	f	2020-05-05 21:50:16.870026	2020-07-23 21:27:41.985512	f	default	\N	\N	\N	\N	t	1
58	90	greenlight	gl-ugwwryoxftdw	ilias	\N	ilias@mtlnewtech.com	\N	\N	$2a$12$UCTL/FOnS55VekHqQi.Dj.GOSRKiJStGg26kiGnJRTmpFvJIWI71O	f	2020-05-07 22:03:34.912044	2020-07-23 21:27:59.852722	f	default	\N	\N	\N	\N	t	1
85	121	greenlight	gl-ijofucofnyrf	Dominique Walton	\N	waltond1015@gmail.com	\N	\N	$2a$12$9lepk.qrWBGKAVKXFMOFK.wCJxGRSRwFRxE5Os9US9AAbe3dpxtrO	f	2020-05-29 16:01:23.317947	2020-07-23 21:28:23.713918	f	default	\N	\N	\N	\N	t	1
84	120	greenlight	gl-pqsyyfbskoip	Asha Boston	\N	aboston08@gmail.com	\N	\N	$2a$12$OqBBX4ER0FEo/VCiRSV2cehAZncYh6BudjTRMTHP3bD0Z7hZDuo7m	f	2020-05-29 15:17:27.102279	2020-07-23 21:28:40.135168	f	default	\N	\N	\N	\N	t	1
110	157	greenlight	gl-eglcwctkvtbs	Amber Thompson	\N	amthomp7@gmail.com	\N	\N	$2a$12$KvJLsHR8VNnKLKBP4iDpPeZFXzVWvDKR2MsOADE4KeZL9hcNAzWvW	f	2020-06-12 11:14:39.030653	2020-06-29 17:09:32.17822	f	default	\N	\N	\N	\N	t	1
193	283	greenlight	gl-ywkgmjtcozpj	Ashley Turner	\N	bvdturner@gmail.com	\N	\N	$2a$12$vR2tw54MtQcgiXDFDZytwe7ouW9mYzBq7k5tzm1Hou6mwKbY2Jgsu	f	2020-08-31 00:33:50.250094	2020-08-31 00:33:50.267129	f	default	\N	\N	\N	\N	f	1
80	116	greenlight	gl-oqkesycuichc	Lisa G	\N	lisa@youaretech.com	\N	\N	$2a$12$7LkPWC.gGBzZAlUmgKJ.ou2fwM7K7FJdUtlCkPu6TbgoN2SJex1iS	f	2020-05-28 15:13:05.674841	2020-09-08 16:39:29.246512	f	default	\N	\N	\N	\N	t	1
143	203	greenlight	gl-kbeqwtjwmikg	LaShesia	\N	lashesia@napturalbeautysupply.com	\N	\N	$2a$12$55OrbUGJOAjt81Dz0RNWp.Fk963vZTXPh6l3XdIpvFcGIkoLiwCG6	f	2020-06-28 14:23:18.262004	2020-07-23 21:20:55.877349	f	default	\N	\N	\N	\N	t	1
141	201	greenlight	gl-rjeznnlfgljq	hanna che	\N	hanna@neverwasaverage.com	\N	\N	$2a$12$RdpMpx.55C6nKG6Fx0bW1eV/Q/HTmXc8Pp/NIKWRNW1SLViuKOsfi	f	2020-06-26 22:36:23.890944	2020-07-23 21:23:36.991444	f	default	\N	\N	\N	\N	t	1
83	119	greenlight	gl-xfwdihigqgek	TeLisa Daughtry	\N	telisad@flytechnista.com	\N	\N	$2a$12$LtYJhzgyNZg0XYOSi1pa8OSqmAY0wzpixy3E8SiUNid7M.DM2dtmq	f	2020-05-28 21:01:40.651136	2020-07-23 21:28:47.047034	f	default	\N	\N	\N	\N	t	1
81	117	greenlight	gl-tgcplmxibtef	Sandra Moerch	\N	sandra.moerch-petersen@sap.com	\N	\N	$2a$12$Pcvvyiihds51nkrvqRlanOjekJdagyty.FTlrMEQtQZHuf5tB86ye	f	2020-05-28 18:47:18.011056	2020-07-23 21:28:56.403762	f	default	\N	\N	\N	\N	t	1
79	115	greenlight	gl-ghokparwnpbe	Janani Shivakumar	\N	jananishiva18@gmail.com	\N	\N	$2a$12$86e4VVMPkfi3ekvEpOxqNuzF/p1bZNGis5KYmJpMJrb7l/4zswuae	f	2020-05-27 21:07:10.461175	2020-07-23 21:29:16.150138	f	default	\N	\N	\N	\N	t	1
78	114	greenlight	gl-nvbvnllhssuz	Kyra Barker	\N	strategist@kyra-barker.com	\N	\N	$2a$12$mba0oUBtyioGw2zlSUEeMOihoJK/ZXcMphx6tI6CjoP59t.v13/oW	f	2020-05-27 16:58:54.259249	2020-07-23 21:29:22.850813	f	default	\N	\N	\N	\N	t	1
77	113	greenlight	gl-pcmfnzxxpdad	laura	\N	lgaitan@mun.ca	\N	\N	$2a$12$Np8b70Dsr15LMUYrijnqBeqlXvpORpPIIw2Fix95ZR47qK380/ZKa	f	2020-05-26 23:31:01.110233	2020-07-23 21:29:30.903792	f	default	\N	\N	\N	\N	t	1
76	112	greenlight	gl-iehingwmjbjx	Tony Njoroge	\N	tonymnjoroge@gmail.com	\N	\N	$2a$12$xiEyPC4oKxV4nVjNVYQDKe/AjtCM/LcVSPIdpAZdyz0GmjIKe3rKW	f	2020-05-24 01:41:25.748111	2020-07-23 21:29:55.651979	f	default	\N	\N	\N	\N	t	1
109	156	greenlight	gl-cnixlciewzyg	Kingsley	\N	trebbletest@gmail.com	\N	\N	$2a$12$5j6GhWC5jT3jcakXLuDFPuHK7cckurjIJqXc1HOCuwi2Q9USWzfEK	f	2020-06-12 00:32:47.21646	2020-07-23 21:31:44.872576	f	default	\N	\N	\N	\N	t	1
107	154	greenlight	gl-xdemspeypjtu	sahar elhaj	\N	sahar.elhaj@triosstudent.com	\N	\N	$2a$12$5kIHLDFDMvEwC.T9MtnlvuaBJwUPRX8eTmtzIoC4VerJAZTI15hhO	f	2020-06-11 16:32:10.088141	2020-07-23 21:33:03.973867	f	default	\N	\N	\N	\N	t	1
106	152	greenlight	gl-tnrscfvfffea	Adeola Hammed Giwa	\N	esiayoentertainmenttv@hotmail.com	\N	\N	$2a$12$wNPM3oJIOjTh9hGAdMiNuO66PWmel.6oqOpOFdR2uNDmDSxk7OE9y	f	2020-06-10 22:30:24.673054	2020-07-23 21:33:12.184501	f	default	\N	\N	\N	\N	t	1
105	151	greenlight	gl-xiddtrvobrzi	Elna M	\N	ellymaro96@ymail.com	\N	\N	$2a$12$OOGcjSfFa/d68whpfo8rJeUHz35ErklBATUbMOG/VTNHbI8VkBBWq	f	2020-06-10 19:23:40.391777	2020-07-23 21:33:30.496672	f	default	\N	\N	\N	\N	t	1
104	150	greenlight	gl-jdepnhezsbdc	Elna Maro	\N	ellymaro96@gmail.com	\N	\N	$2a$12$RQrf7runGTSZPHVWFsKdI.2DFfP1PtrzKOTe3Ophki11hGo2sVHzm	f	2020-06-10 19:21:36.260546	2020-07-23 21:33:48.541878	f	default	\N	\N	\N	\N	t	1
102	148	greenlight	gl-kihwkucakhie	Kadine Cunningham	\N	kadinecunningham@gmail.com	\N	\N	$2a$12$GdTPkqmVkb/JYXTq236txOp65bE8QBZ1Y4GQWRExmVKvtzrZzT60u	f	2020-06-10 14:36:13.854103	2020-07-23 21:33:55.759411	f	default	\N	\N	\N	\N	t	1
99	144	greenlight	gl-gxbtbwvwxwdc	Khaled Akkash	\N	kkash499@gmail.com	\N	\N	$2a$12$9WTboDaYGhRVnytaeIntYOcXxVnTgfbx2vvStbw5CCmRb9Mn0PGVy	f	2020-06-09 00:56:21.045374	2020-07-23 21:34:03.350614	f	default	\N	\N	\N	\N	t	1
96	141	greenlight	gl-wiuamjerzkov	Mohamad bnaye	\N	mhma197898@gmail.com	\N	\N	$2a$12$KrD6ZDIHjRGRU53K1vKdY.1DdFUz./FPLlGlnbAJhORtauNO9RuUe	f	2020-06-08 19:08:46.785987	2020-07-23 21:34:15.218225	f	default	\N	\N	\N	\N	t	1
103	149	greenlight	gl-rdxovqbdwsjt	Tanaka Chitanda	\N	tanakachit@gmail.com	\N	\N	$2a$12$hLaK4GCwl57mShRHpOeJWuRhuVL0AQxKX.mFE1Hde0PtFyRjPydUy	f	2020-06-10 19:15:48.611299	2020-07-23 21:34:30.173916	f	default	\N	\N	\N	\N	t	1
100	146	greenlight	gl-nseihaupszxs	Islam FAKOUSA	\N	i.a.fakousa@gmail.com	\N	\N	$2a$12$skg2NBJXJ9wY6RGr0u0e3O3M7Q8r/Fu5eYohpJlBIRB2xsNqhuqK6	f	2020-06-09 13:27:24.342663	2020-07-23 21:34:45.323846	f	default	\N	\N	\N	\N	t	1
94	138	greenlight	gl-nypjatmzhxaq	Nashara Peaet	\N	peartnal@gmail.com	\N	\N	$2a$12$uxsVv0uN0NiGVShY6pWISuX1ergdX7Xoch4AKIZptjyVETcD9TZla	f	2020-06-08 16:32:39.715316	2020-07-23 21:35:16.784485	f	default	\N	\N	\N	\N	t	1
97	142	greenlight	gl-xbxsuyxiypdf	Thaer 	\N	thaer@receptionhouse.ca	\N	\N	$2a$12$SaNeN.ihM/G/IX4rLEB3xOdJDmoxbtIQM7SDVMSyZK.ECGlJBQoue	f	2020-06-08 19:11:20.388264	2020-07-23 21:35:26.36955	f	default	\N	\N	\N	\N	t	1
93	137	greenlight	gl-nuceamnlzpwg	Martin Wenzel	\N	martin.wenzel999@gmail.com	\N	\N	$2a$12$rBimjlXYdjV1ptgaDftsguO0YaLVt.uIQZjcnuQWyBH8Gv0PgMPY.	f	2020-06-05 22:51:16.620417	2020-07-23 21:35:47.257942	f	default	\N	\N	\N	\N	t	1
87	123	greenlight	gl-wkhdpqyuclbi	Ben Christensen	\N	b@rev.li	\N	\N	$2a$12$jZDg0mZUICrs93lMj1jaLOEUsH73jM1UhxO8mDKhxe8nl3ajfvToO	f	2020-05-29 18:04:51.262271	2020-07-23 21:35:56.749968	f	default	\N	\N	\N	\N	t	1
92	134	greenlight	gl-rffchjowgron	Afoali NGWAKUM AKISA	\N	afoalingwakum@gmail.com	\N	\N	$2a$12$RM6royvd.4FvihVUyo0mc.Oe1n1gBbCqID9gFBh3aQCJwQbEljuOO	f	2020-06-05 18:20:06.957154	2020-07-23 21:36:07.325734	f	default	\N	\N	\N	\N	t	1
89	128	greenlight	gl-pkczfwqnlsya	Elena Minnow	\N	eminnow@gmail.com	\N	\N	$2a$12$JQLwQXLGlqNmDzIt5woeKeiArZXndfvRlLGioCdSwAPbwHwXWS6Am	f	2020-06-02 22:07:19.82778	2020-07-23 21:36:14.067973	f	default	\N	\N	\N	\N	t	1
86	122	greenlight	gl-dsfrangbdfoi	Nina Afriye	\N	nafriyie4628@tywls.org	\N	\N	$2a$12$HzUZJfI13djNTMyo0ilxV.mhjOTWaCBG.WLehfMqg2bakFOir6aZS	f	2020-05-29 17:42:51.562938	2020-07-23 21:36:25.184933	f	default	\N	\N	\N	\N	t	1
88	126	greenlight	gl-rpjalfkhseqr	Crystal Charles	\N	honeybooksca@gmail.com	\N	\N	$2a$12$gDBXFDRekfdpxCPKQoxhbOBFs6oCoMdnvFi.DQzcXow7SYlJUdYNC	f	2020-05-30 12:52:07.769043	2020-07-23 21:36:32.333302	f	default	\N	\N	\N	\N	t	1
90	130	greenlight	gl-xgrwlxrkvcws	Chelsea Carter	\N	chelseacarter93@gmail.com	\N	\N	$2a$12$LQRznmBJ.GUTQl3aL5dM1eosvRSvox.ZjSG3XcbeJ6YNO2pI.TL5W	f	2020-06-03 12:03:04.674365	2020-07-23 21:36:44.376949	f	default	\N	\N	\N	\N	t	1
98	143	greenlight	gl-mkordglyzoyl	Abdulkader Badlli	\N	abomajed1977@gmail.com	\N	\N	$2a$12$36PURTRubaHV0OT138KHc.ZSxrtWacWOncY00TEzhlnhpOT7oLnL.	f	2020-06-08 22:19:05.364763	2020-07-23 21:36:52.670973	f	default	\N	\N	\N	\N	t	1
95	140	greenlight	gl-jpjjmdoqssli	Mohamad bnaye	\N	m.adour@hotmail.com	\N	\N	$2a$12$tU5zJpySKOQN6rSqgH0MwO6XHDgOTy66Tfmk.cww6Z2h5ClA8K/TG	f	2020-06-08 19:05:16.717564	2020-07-23 21:37:00.403815	f	default	\N	\N	\N	\N	t	1
139	199	greenlight	gl-ybspkwfhknix	Felice (Goddess) Webster	\N	goddessw@goddessqueenmother.com	\N	\N	$2a$12$rOqI44wVByTiDB2equfgAuxBl1YD3i/MAzf9o/1T/gAAh5c5A99Pa	f	2020-06-26 14:57:08.318838	2020-07-23 21:37:28.982726	f	default	\N	\N	\N	\N	t	1
108	155	greenlight	gl-ceqmgxvofzer	Kingsley	\N	gchb@gmail.com	\N	\N	$2a$12$ZzMPQEXVTfP/mzZqSOBaX.ePmrM1CcnqUwcDpAf3EHhjkwmecNndG	f	2020-06-12 00:30:59.492109	2020-06-29 17:09:32.224054	f	default	\N	\N	\N	\N	t	1
111	158	greenlight	gl-wmmkockdzimw	Khamil Scantling	\N	khamil@cocoapreneur.com	\N		$2a$12$SCjjjiDLBxfe/ZWGX3YkzOdoyR3/dNSl1Q/jhWnNY7OJIbveq3xFi	f	2020-06-12 11:23:47.84768	2020-09-16 14:36:01.045986	f	default	\N	\N	\N	\N	f	8
138	198	greenlight	gl-xbpjiklfgpnj	Consulate General	\N	atntageneral@gmail.com	\N	\N	$2a$12$LJhq0cvr//BXXd0NDxHJx.iKsPYPTyWu8VGKpGDsY8bh5SJDCp/hq	f	2020-06-25 14:15:23.189319	2020-09-08 16:39:10.410464	f	default	\N	\N	\N	\N	t	1
82	118	greenlight	gl-vkhcsphacpce	Monika Lantai	\N	monika.lantai@international.gc.ca	\N	\N	$2a$12$VULBJJzNJ/Ziey.JxzuZK.DmTFjI6/TafEiyZDXe76ovfYs/6krcq	f	2020-05-28 20:53:20.874894	2020-09-08 16:39:19.762351	f	default	\N	\N	\N	\N	t	1
188	274	greenlight	gl-olixntaifqzv	Danica Nelson	\N	hey@watchdanicawork.com	\N	\N	$2a$12$B2.T6KfVvXJGM1v//IEYS.rHXzZzocrG9Gmhk0wZxhsc3IrbVASxu	f	2020-08-14 18:57:13.877414	2020-09-09 13:54:31.350518	f	default	\N	\N	\N	\N	t	1
183	267	greenlight	gl-inxmskjuafbc	Natasya Aulia	\N	natasyarizky29@gmail.com	\N	\N	$2a$12$qrkpfmyHTxRzif56Igj3iuTUbUZHqo/pXErCZhOcjBaqNH4ol7Mcy	f	2020-08-10 18:30:49.005665	2020-09-09 13:55:09.35697	f	default	\N	\N	\N	\N	t	1
112	159	greenlight	gl-xrxnamdgviya	Lachelle Binion	\N	lnbinion@gmail.com	\N	\N	$2a$12$HYU2YdapKwSgKbr774duou7wr2bs/IgVtU/7NPhv5nJiiM7SU/EvK	f	2020-06-12 12:10:54.54717	2020-07-23 21:31:37.475774	f	default	\N	\N	\N	\N	t	1
137	195	greenlight	gl-vzxsbzdaflso	Elesha Jacobs	\N	innovategysolutions@gmail.com	\N	\N	$2a$12$JrX7wdWAQ.fYrrfUw5tSy.tfBPHNags8Pc/mGh5/Af4k7ygRRFyRK	f	2020-06-24 11:01:45.227713	2020-07-23 21:37:37.100499	f	default	\N	\N	\N	\N	t	1
113	160	greenlight	gl-nmfmohqmymdq	Kevin Roberts	\N	kevin_roberts@hotmail.com	\N	\N	$2a$12$VFAHqxfC9kVeVNwJViNxQeTxdAGYKqpBWulL8j01sAVXtoLbCjEzu	f	2020-06-12 16:08:42.267255	2020-07-21 23:32:33.181992	f	default	\N	\N	\N	\N	t	1
122	173	greenlight	gl-lerjolrxyhwi	Frank Fredericks	\N	frankiefredericks@gmail.com	\N	\N	$2a$12$Wy9t35jJ2Qw2Iu1gJ2XjQu92PyaMp8XOb4EqTD.r/.n6o3vuqeynu	f	2020-06-20 18:50:48.872287	2020-07-23 21:19:36.287179	f	default	\N	\N	\N	\N	t	1
142	202	greenlight	gl-njrzbalvekjg	Carmen Turner	\N	info@moneychoicestoday.com	\N	\N	$2a$12$wJEMZQlIDWlna00MDDZnmu9bSoq4vk931E3ajYpC8uqyqvU1fFfpa	f	2020-06-27 18:55:02.487864	2020-07-23 21:23:27.70301	f	default	\N	\N	\N	\N	t	1
135	192	greenlight	gl-uumnarzeryna	Leonard Washington	\N	mrlmwjr@gmail.com	\N	\N	$2a$12$2OWMaRt95y3T9K1jD0ydUONjXbbHRu7O2cYsJsz8V7CAjRID19T2C	f	2020-06-23 21:41:23.960974	2020-07-23 21:37:53.293227	f	default	\N	\N	\N	\N	t	1
133	190	greenlight	gl-yrnyxlvjzitm	Taneshia Laird	\N	tnlaird@newarksymphonyhall.org	\N	\N	$2a$12$luA.1NbNPXS5DwiL8VZDweiIByg0p6raZl50OnLrJPf.V6Mizk5mK	f	2020-06-23 12:59:47.928835	2020-07-23 21:39:35.600698	f	default	\N	\N	\N	\N	t	1
131	188	greenlight	gl-tcguonkwwjqh	Alexis Russell	\N	alexis@russellgc.com	\N	\N	$2a$12$O2gjo26EF3G3ZlgaHxhqmuTBIMIoJC2ksGvZBTm51lwWJX4X7SqFO	f	2020-06-23 11:15:56.602593	2020-07-23 21:39:55.108037	f	default	\N	\N	\N	\N	t	1
128	184	greenlight	gl-nywjsbrfckjs	Chaka Poole	\N	chaka_brownagency@outlook.com	\N	\N	$2a$12$pCbLHPpJw2q/9HmYkTTCUu4p/wKWaWVzGX43BGKyQryNZxjKo3mKq	f	2020-06-22 23:48:40.948859	2020-07-23 21:43:03.312539	f	default	\N	\N	\N	\N	t	1
127	183	greenlight	gl-ojocqlstdivv	Gerria Coffee	\N	gcoffee@genesisbirth.org	\N	\N	$2a$12$B7KCw3uLOb2cNRI5kYxtMeW.IFWgKKExJjojWaXjOV3sUDUu2AxCa	f	2020-06-22 23:32:54.53404	2020-07-23 21:43:11.315569	f	default	\N	\N	\N	\N	t	1
126	181	greenlight	gl-fggewyebpuhm	Elle Allen	\N	larita.allen@gmail.com	\N	\N	$2a$12$Q0hODtbIRkFAO9hV3IPMY.DrMdoq8NoJxf1sU3Qncm9Nn2gGhdUwC	f	2020-06-22 23:21:16.267969	2020-07-23 21:43:19.384096	f	default	\N	\N	\N	\N	t	1
125	180	greenlight	gl-bglyrapbgovy	Nkiru Asika	\N	nkirua@gmail.com	\N	\N	$2a$12$yF7OaF7B45h9edCF/J0J6O9vOZvelWQWkMFy2QmAE92YOb.DB3dou	f	2020-06-22 22:26:34.059301	2020-07-23 21:43:28.367133	f	default	\N	\N	\N	\N	t	1
124	179	greenlight	gl-qywkfjpslrqo	Jackie Page-Heidelberg	\N	loverockscafe@gmail.com	\N	\N	$2a$12$uk.LNgJFQr8p4kIBowsTQuIrhOZ9hphO0k0eQevvWxsNBtHY3G5DC	f	2020-06-22 22:19:20.941042	2020-07-23 21:43:35.854793	f	default	\N	\N	\N	\N	t	1
121	171	greenlight	gl-yimlswtuejxi	Emily Marko	\N	emily@emilymarko.com	\N	\N	$2a$12$NCtiBQaqTAcucliNwF7MG.4vNke8rItY3Ad95rgL4pPkffy5OZ8qG	f	2020-06-19 14:20:10.146325	2020-07-23 21:43:43.483609	f	default	\N	\N	\N	\N	t	1
123	176	greenlight	gl-eiafwglwercm	Paul Martin	\N	hiprofileweb@gmail.com	\N	\N	$2a$12$j6UjxGubyeXFVVCuQRx22OH3ZjAlDASBgSFFvS76mvmzSKAX9Bmcm	f	2020-06-22 04:49:34.414379	2020-07-23 21:43:49.778533	f	default	\N	\N	\N	\N	t	1
120	170	greenlight	gl-nkadpgaqvibn	ASC	\N	afrosocialcentric@gmail.com	\N	\N	$2a$12$/aQ3QJKNb.EbGqSFJ3CB6ue.xppWG2aXObaABjavcQefeL5mK.maS	f	2020-06-18 20:46:09.020225	2020-07-23 21:43:57.002481	f	default	\N	\N	\N	\N	t	1
119	169	greenlight	gl-lhdolavuully	Nakeshia Betsill	\N	betsillns@gmail.com	\N	\N	$2a$12$1H1CCm2q0U.CM4KX1SnLjO3/W3k5Ewad7UqhuL.1bNo/c9RAXEbBe	f	2020-06-18 15:05:02.837938	2020-07-23 21:44:03.908229	f	default	\N	\N	\N	\N	t	1
118	166	greenlight	gl-msaioevkrlxj	Ivelyse Andino	\N	hello@radical-health.com	\N	\N	$2a$12$bxf/tOda.m8B3LfSeUl7TeRPeGWx72KsIEfdB.mPj.7m092bNC85G	f	2020-06-16 19:10:16.336891	2020-07-23 21:44:12.820897	f	default	\N	\N	\N	\N	t	1
116	163	greenlight	gl-tybhkvzjqemz	Nikkia Ingram 	\N	ningram@cultivatingresilientyouth.org	\N	\N	$2a$12$yVNzNcP3TOKLgJSdbJeGZe4ZGtxBCyrU5/TeSi1mdMmGEl1sfprSG	f	2020-06-13 01:27:47.32193	2020-07-23 21:44:21.202923	f	default	\N	\N	\N	\N	t	1
117	165	greenlight	gl-mtxejwrtiqbn	Emily Ahn Levy	\N	emilyalevy@gmail.com	\N	\N	$2a$12$JuZ0LPWiHdhsmYQFkSINQuzeQJbQSvZ0PjpHjE2w7skd/KXsg5HaS	f	2020-06-15 21:30:38.969752	2020-07-23 21:44:30.548647	f	default	\N	\N	\N	\N	t	1
115	162	greenlight	gl-qyyoyoravdrl	Walter Lewis	\N	wlewis@hcvpgh.org	\N	\N	$2a$12$t0n2keIJ3qgk/odHghdPourFqcI8ju6UjiFvatqzPEG/1qmjTsbFy	f	2020-06-13 00:58:51.134223	2020-07-23 21:44:37.5067	f	default	\N	\N	\N	\N	t	1
114	161	greenlight	gl-xjhjhxnvrbir	JaLissa Coffee	\N	jcoffee@hcvpgh.org	\N	\N	$2a$12$0moDVpau8LVeh1/oESW5I.o4YWXKbq2rORsBOKoAOsDbWddAMe2PS	f	2020-06-12 22:31:24.311855	2020-07-23 21:44:44.332107	f	default	\N	\N	\N	\N	t	1
157	226	greenlight	gl-hzosgokattuj	kimberly mitchell	\N	echelongroupinc@gmail.com	\N	\N	$2a$12$6sl42p1Y4/dlBWgWkwlcY.XSuuUGvD7Bj3rB2lPTzlq1yd3kWumBa	f	2020-07-08 00:35:04.718915	2020-07-23 21:46:14.412093	f	default	\N	\N	\N	\N	t	1
151	214	greenlight	gl-hfhbmmxbwosl	lisa Ogbole	\N	lisaogbole@gmail.com	\N	\N	$2a$12$WvwWNq.EqYfRqQR39Mdn5OpQ2RPxHxb9/bRH4TVjfBPC8oHCqtdIq	f	2020-07-03 19:05:54.099305	2020-07-23 21:47:08.041573	f	default	\N	\N	\N	\N	t	1
144	204	greenlight	gl-jbhezjzqatpm	Monique Smith	\N	moniquessmith.8@gmail.com	\N	\N	$2a$12$K1kB89wJGkvM9Te7NFI3EOUVvsvM4/cNJyLrzpGzefmk7ErutLbBq	f	2020-06-28 14:44:40.685665	2020-07-23 21:47:51.984103	f	default	\N	\N	\N	\N	t	1
145	205	greenlight	gl-ndsoqzkrkffv	Esther Scott	\N	estherscott@jewelshsfd.com	\N	\N	$2a$12$y24gYJOa11cm96LeM6lgV.dE.KmnRD7KLkqeKauDMaMoJYAUjim7K	f	2020-06-28 14:47:02.945198	2020-07-23 21:48:04.174697	f	default	\N	\N	\N	\N	t	1
140	200	greenlight	gl-gfjugkvgbtsm	Nicole	\N	antoine_nicole@hotmail.com	\N	\N	$2a$12$zRw1cBQ//GI5loqnxrXHsu.6wPHXCPm8k89pO4M0ufWlqnAVE8t5K	f	2020-06-26 20:01:16.747773	2020-07-23 21:58:45.789503	f	default	\N	\N	\N	\N	t	1
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 198, true);


--
-- Data for Name: users_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_roles (user_id, role_id) FROM stdin;
1	1
1	2
2	1
3	1
4	1
5	1
6	1
7	1
8	1
9	1
10	1
2	2
11	1
80	1
12	1
13	1
81	1
14	1
15	1
82	1
16	1
17	1
83	1
18	1
19	1
84	1
20	1
21	1
85	1
22	1
23	1
86	1
24	1
25	1
87	1
26	1
27	1
88	1
28	1
29	1
89	1
30	1
31	1
90	1
32	1
33	1
91	1
34	1
35	1
92	1
36	1
37	1
93	1
38	1
39	1
94	1
40	1
41	1
95	1
42	1
96	1
44	1
97	1
45	1
46	1
98	1
47	1
48	1
99	1
49	1
50	1
100	1
43	4
51	1
52	1
101	1
53	1
54	1
102	1
55	1
56	1
103	1
57	1
58	1
104	1
59	1
60	1
105	1
61	1
62	1
106	1
63	1
64	1
107	1
65	1
66	1
108	1
67	1
68	1
69	1
70	1
109	1
71	1
72	1
110	1
73	1
74	1
111	1
75	1
76	1
112	1
77	1
78	1
113	1
79	1
114	1
115	1
116	1
117	1
118	1
119	1
120	1
121	1
122	1
123	1
124	1
125	1
126	1
127	1
128	1
129	1
130	1
131	1
132	1
133	1
134	1
135	1
136	1
137	1
138	1
139	1
140	1
141	1
142	1
143	1
144	1
145	1
\.


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: features_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.features
    ADD CONSTRAINT features_pkey PRIMARY KEY (id);


--
-- Name: invitations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invitations
    ADD CONSTRAINT invitations_pkey PRIMARY KEY (id);


--
-- Name: role_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- Name: shared_accesses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shared_accesses
    ADD CONSTRAINT shared_accesses_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_features_on_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_features_on_name ON public.features USING btree (name);


--
-- Name: index_features_on_setting_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_features_on_setting_id ON public.features USING btree (setting_id);


--
-- Name: index_invitations_on_invite_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_invitations_on_invite_token ON public.invitations USING btree (invite_token);


--
-- Name: index_invitations_on_provider; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_invitations_on_provider ON public.invitations USING btree (provider);


--
-- Name: index_role_permissions_on_role_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_role_permissions_on_role_id ON public.role_permissions USING btree (role_id);


--
-- Name: index_roles_on_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_roles_on_name ON public.roles USING btree (name);


--
-- Name: index_roles_on_name_and_provider; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_roles_on_name_and_provider ON public.roles USING btree (name, provider);


--
-- Name: index_roles_on_priority_and_provider; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_roles_on_priority_and_provider ON public.roles USING btree (priority, provider);


--
-- Name: index_rooms_on_bbb_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_rooms_on_bbb_id ON public.rooms USING btree (bbb_id);


--
-- Name: index_rooms_on_deleted; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_rooms_on_deleted ON public.rooms USING btree (deleted);


--
-- Name: index_rooms_on_last_session; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_rooms_on_last_session ON public.rooms USING btree (last_session);


--
-- Name: index_rooms_on_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_rooms_on_name ON public.rooms USING btree (name);


--
-- Name: index_rooms_on_sessions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_rooms_on_sessions ON public.rooms USING btree (sessions);


--
-- Name: index_rooms_on_uid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_rooms_on_uid ON public.rooms USING btree (uid);


--
-- Name: index_rooms_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_rooms_on_user_id ON public.rooms USING btree (user_id);


--
-- Name: index_settings_on_provider; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_settings_on_provider ON public.settings USING btree (provider);


--
-- Name: index_shared_accesses_on_room_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_shared_accesses_on_room_id ON public.shared_accesses USING btree (room_id);


--
-- Name: index_shared_accesses_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_shared_accesses_on_user_id ON public.shared_accesses USING btree (user_id);


--
-- Name: index_users_on_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_created_at ON public.users USING btree (created_at);


--
-- Name: index_users_on_deleted; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_deleted ON public.users USING btree (deleted);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_password_digest; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_password_digest ON public.users USING btree (password_digest);


--
-- Name: index_users_on_provider; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_provider ON public.users USING btree (provider);


--
-- Name: index_users_on_role_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_role_id ON public.users USING btree (role_id);


--
-- Name: index_users_on_room_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_room_id ON public.users USING btree (room_id);


--
-- Name: index_users_roles_on_role_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_roles_on_role_id ON public.users_roles USING btree (role_id);


--
-- Name: index_users_roles_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_roles_on_user_id ON public.users_roles USING btree (user_id);


--
-- Name: index_users_roles_on_user_id_and_role_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_roles_on_user_id_and_role_id ON public.users_roles USING btree (user_id, role_id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

