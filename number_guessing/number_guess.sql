--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(22) NOT NULL,
    games_played integer DEFAULT 0 NOT NULL,
    best_game integer
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (10, 'user_1773219886190', 1, 427);
INSERT INTO public.users VALUES (11, 'user_1773219886189', 1, 961);
INSERT INTO public.users VALUES (12, 'user_1773219939658', 1, 459);
INSERT INTO public.users VALUES (13, 'user_1773219939657', 1, 838);
INSERT INTO public.users VALUES (14, 'user_1773219986984', 1, 245);
INSERT INTO public.users VALUES (15, 'user_1773219986983', 1, 992);
INSERT INTO public.users VALUES (16, 'user_1773220034093', 1, 634);
INSERT INTO public.users VALUES (17, 'user_1773220034092', 1, 463);
INSERT INTO public.users VALUES (18, 'user_1773220058268', 1, 695);
INSERT INTO public.users VALUES (19, 'user_1773220058267', 1, 657);
INSERT INTO public.users VALUES (21, 'user_1773220160286', 2, 568);
INSERT INTO public.users VALUES (43, 'user_1773220740336', 2, 501);
INSERT INTO public.users VALUES (20, 'user_1773220160287', 5, 51);
INSERT INTO public.users VALUES (23, 'user_1773220178970', 2, 25);
INSERT INTO public.users VALUES (42, 'user_1773220740337', 5, 247);
INSERT INTO public.users VALUES (22, 'user_1773220178971', 5, 26);
INSERT INTO public.users VALUES (25, 'user_1773220213785', 2, 122);
INSERT INTO public.users VALUES (24, 'user_1773220213786', 5, 263);
INSERT INTO public.users VALUES (45, 'user_1773220753500', 2, 538);
INSERT INTO public.users VALUES (27, 'user_1773220218551', 2, 250);
INSERT INTO public.users VALUES (26, 'user_1773220218552', 5, 100);
INSERT INTO public.users VALUES (44, 'user_1773220753501', 5, 21);
INSERT INTO public.users VALUES (29, 'user_1773220223375', 2, 265);
INSERT INTO public.users VALUES (28, 'user_1773220223376', 5, 180);
INSERT INTO public.users VALUES (31, 'user_1773220353855', 2, 518);
INSERT INTO public.users VALUES (30, 'user_1773220353856', 5, 123);
INSERT INTO public.users VALUES (33, 'user_1773220364752', 2, 578);
INSERT INTO public.users VALUES (32, 'user_1773220364753', 5, 306);
INSERT INTO public.users VALUES (9, 'test', 2, 5);
INSERT INTO public.users VALUES (35, 'user_1773220612055', 2, 463);
INSERT INTO public.users VALUES (34, 'user_1773220612056', 5, 43);
INSERT INTO public.users VALUES (37, 'user_1773220688877', 2, 205);
INSERT INTO public.users VALUES (36, 'user_1773220688878', 5, 579);
INSERT INTO public.users VALUES (39, 'user_1773220696765', 2, 22);
INSERT INTO public.users VALUES (38, 'user_1773220696766', 5, 72);
INSERT INTO public.users VALUES (41, 'user_1773220714247', 2, 338);
INSERT INTO public.users VALUES (40, 'user_1773220714248', 5, 291);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 45, true);


--
-- Name: users unique_username; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT unique_username UNIQUE (username);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- PostgreSQL database dump complete
--

