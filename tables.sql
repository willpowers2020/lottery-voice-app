--
-- PostgreSQL database dump
--

\restrict zzfjtASqYEgdJ8yAkkApr1pCmWnWIuNafkit4Q2OZLp56HBDp7A5KdVsXjORuRX

-- Dumped from database version 16.11 (Homebrew)
-- Dumped by pg_dump version 18.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: games; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.games (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    state_id integer NOT NULL,
    game_type character varying(20) DEFAULT 'unknown'::character varying NOT NULL,
    numbers_count smallint DEFAULT 4 NOT NULL,
    number_range_min smallint DEFAULT 0,
    number_range_max smallint DEFAULT 9 NOT NULL,
    bonus_numbers_count smallint DEFAULT 0,
    bonus_range_max smallint,
    game_key text,
    tod text,
    params jsonb,
    active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    game_name character varying
);


--
-- Name: states; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.states (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


--
-- Name: games_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.games_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: games_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.games_id_seq OWNED BY public.games.id;


--
-- Name: states_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.states_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: states_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.states_id_seq OWNED BY public.states.id;


--
-- Name: games id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.games ALTER COLUMN id SET DEFAULT nextval('public.games_id_seq'::regclass);


--
-- Name: states id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.states ALTER COLUMN id SET DEFAULT nextval('public.states_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.games VALUES (701, 'Pick 3 Midday', 132, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Midday', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:25.609302', '2025-12-11 06:17:25.609302', NULL);
INSERT INTO public.games VALUES (702, 'Pick 3 Evening', 132, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Evening', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:25.67422', '2025-12-11 06:17:25.67422', NULL);
INSERT INTO public.games VALUES (703, 'Pick 4 Midday', 132, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Midday', '', '{"game_type": "pick4"}', true, '2025-12-11 06:17:25.693843', '2025-12-11 06:17:25.693843', NULL);
INSERT INTO public.games VALUES (704, 'Kentucky 5', 163, 'unknown', 4, 0, 9, 0, NULL, 'Kentucky5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:25.727017', '2025-12-11 06:17:25.727017', NULL);
INSERT INTO public.games VALUES (705, 'Tri-State Pick 3 Day', 126, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Day', 'Day', '{"game_type": "pick3"}', true, '2025-12-11 06:17:25.761359', '2025-12-11 06:17:25.761359', NULL);
INSERT INTO public.games VALUES (706, 'Tri-State Pick 4 Evening', 126, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:25.785927', '2025-12-11 06:17:25.785927', NULL);
INSERT INTO public.games VALUES (707, 'Pick 4 Evening', 132, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Evening', '', '{"game_type": "pick4"}', true, '2025-12-11 06:17:25.801553', '2025-12-11 06:17:25.801553', NULL);
INSERT INTO public.games VALUES (708, 'Badger 5', 132, 'unknown', 4, 0, 9, 0, NULL, 'Badger5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:25.834449', '2025-12-11 06:17:25.834449', NULL);
INSERT INTO public.games VALUES (709, 'Daily Tennessee Jackpot', 141, 'unknown', 4, 0, 9, 0, NULL, 'DailyTennesseeJackpot', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:25.861877', '2025-12-11 06:17:25.861877', NULL);
INSERT INTO public.games VALUES (710, 'Cash 3 Evening', 173, 'pick3', 3, 0, 9, 0, NULL, 'Cash3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:25.9001', '2025-12-11 06:17:25.9001', NULL);
INSERT INTO public.games VALUES (711, 'Cash Pop Evening', 173, 'unknown', 4, 0, 9, 0, NULL, 'CashPopEvening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:25.936872', '2025-12-11 06:17:25.936872', NULL);
INSERT INTO public.games VALUES (712, 'Cash Pop Midday', 173, 'unknown', 4, 0, 9, 0, NULL, 'CashPopMidday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:25.950897', '2025-12-11 06:17:25.950897', NULL);
INSERT INTO public.games VALUES (713, 'Cash 4 Evening', 173, 'pick4', 4, 0, 9, 0, NULL, 'Cash4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:25.974389', '2025-12-11 06:17:25.974389', NULL);
INSERT INTO public.games VALUES (714, 'SuperLotto Plus', 121, 'unknown', 4, 0, 9, 0, NULL, 'SuperLottoPlus', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:25.991029', '2025-12-11 06:17:25.991029', NULL);
INSERT INTO public.games VALUES (715, 'Atlantic 49', 123, 'unknown', 4, 0, 9, 0, NULL, 'Atlantic49', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:26.017962', '2025-12-11 06:17:26.017962', NULL);
INSERT INTO public.games VALUES (716, 'Super Cash', 132, 'unknown', 4, 0, 9, 0, NULL, 'SuperCash', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:26.043421', '2025-12-11 06:17:26.043421', NULL);
INSERT INTO public.games VALUES (717, 'Megabucks', 132, 'unknown', 4, 0, 9, 0, NULL, 'Megabucks', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:26.063925', '2025-12-11 06:17:26.063925', NULL);
INSERT INTO public.games VALUES (718, 'All or Nothing Mid', 132, 'unknown', 4, 0, 9, 0, NULL, 'AllorNothingMid', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:26.088888', '2025-12-11 06:17:26.088888', NULL);
INSERT INTO public.games VALUES (719, 'All or Nothing Eve', 132, 'unknown', 4, 0, 9, 0, NULL, 'AllorNothingEve', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:26.114552', '2025-12-11 06:17:26.114552', NULL);
INSERT INTO public.games VALUES (720, 'Cash Pop Morning', 169, 'unknown', 4, 0, 9, 0, NULL, 'CashPopMorning', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:26.132621', '2025-12-11 06:17:26.132621', NULL);
INSERT INTO public.games VALUES (721, 'Cash Pop Matinee', 169, 'unknown', 4, 0, 9, 0, NULL, 'CashPopMatinee', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:26.155889', '2025-12-11 06:17:26.155889', NULL);
INSERT INTO public.games VALUES (722, 'Cash Pop Afternoon', 169, 'unknown', 4, 0, 9, 0, NULL, 'CashPopAfternoon', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:26.182211', '2025-12-11 06:17:26.182211', NULL);
INSERT INTO public.games VALUES (723, 'Cash Pop Evening', 169, 'unknown', 4, 0, 9, 0, NULL, 'CashPopEvening', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:26.195437', '2025-12-11 06:17:26.195437', NULL);
INSERT INTO public.games VALUES (783, 'Play 3 Day', 130, 'pick3', 3, 0, 9, 0, NULL, 'Play3Day', 'Day', '{"game_type": "pick3"}', true, '2025-12-11 06:17:28.2951', '2025-12-11 06:17:28.2951', NULL);
INSERT INTO public.games VALUES (724, 'Cash Pop Late Night', 169, 'unknown', 4, 0, 9, 0, NULL, 'CashPopLateNight', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:26.213527', '2025-12-11 06:17:26.213527', NULL);
INSERT INTO public.games VALUES (725, 'Pick 5 Night', 138, 'pick5', 5, 0, 9, 0, NULL, 'Pick5Night', 'Night', '{"game_type": "pick5"}', true, '2025-12-11 06:17:26.24022', '2025-12-11 06:17:26.24022', NULL);
INSERT INTO public.games VALUES (726, 'Pick 5 Day', 138, 'pick5', 5, 0, 9, 0, NULL, 'Pick5Day', 'Day', '{"game_type": "pick5"}', true, '2025-12-11 06:17:26.287489', '2025-12-11 06:17:26.287489', NULL);
INSERT INTO public.games VALUES (727, 'Powerball Double Play', 171, 'unknown', 4, 0, 9, 0, NULL, 'PowerballDoublePlay', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:26.314389', '2025-12-11 06:17:26.314389', NULL);
INSERT INTO public.games VALUES (728, 'Powerball Double Play', 155, 'unknown', 4, 0, 9, 0, NULL, 'PowerballDoublePlay', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:26.345953', '2025-12-11 06:17:26.345953', NULL);
INSERT INTO public.games VALUES (729, 'Powerball Double Play', 153, 'unknown', 4, 0, 9, 0, NULL, 'PowerballDoublePlay', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:26.370301', '2025-12-11 06:17:26.370301', NULL);
INSERT INTO public.games VALUES (730, 'DC-3 11:30pm', 136, 'pick3', 3, 0, 9, 0, NULL, 'DC311:30pm', '11:30pm', '{"game_type": "pick3"}', true, '2025-12-11 06:17:26.47873', '2025-12-11 06:17:26.47873', NULL);
INSERT INTO public.games VALUES (731, 'DC-4 11:30pm', 136, 'pick4', 4, 0, 9, 0, NULL, 'DC411:30pm', '11:30pm', '{"game_type": "pick3"}', true, '2025-12-11 06:17:26.608421', '2025-12-11 06:17:26.608421', NULL);
INSERT INTO public.games VALUES (732, 'DC-4 1:50pm', 136, 'pick4', 4, 0, 9, 0, NULL, 'DC41:50pm', '1:50pm', '{"game_type": "pick5"}', true, '2025-12-11 06:17:26.622444', '2025-12-11 06:17:26.622444', NULL);
INSERT INTO public.games VALUES (733, 'DC-2 7:50pm', 136, 'pick2', 2, 0, 9, 0, NULL, 'DC27:50pm', '7:50pm', '{"game_type": "pick5"}', true, '2025-12-11 06:17:26.6361', '2025-12-11 06:17:26.6361', NULL);
INSERT INTO public.games VALUES (734, 'DC-5 1:50pm', 136, 'pick5', 5, 0, 9, 0, NULL, 'DC51:50pm', '1:50pm', '{"game_type": "pick5"}', true, '2025-12-11 06:17:26.683617', '2025-12-11 06:17:26.683617', NULL);
INSERT INTO public.games VALUES (735, 'Daily 3 Midday', 168, 'pick3', 3, 0, 9, 0, NULL, 'Daily3Midday', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:26.705545', '2025-12-11 06:17:26.705545', NULL);
INSERT INTO public.games VALUES (736, 'Daily 3 Evening', 168, 'pick3', 3, 0, 9, 0, NULL, 'Daily3Evening', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:26.730525', '2025-12-11 06:17:26.730525', NULL);
INSERT INTO public.games VALUES (737, 'Daily 4 Midday', 168, 'pick4', 4, 0, 9, 0, NULL, 'Daily4Midday', '', '{"game_type": "pick4"}', true, '2025-12-11 06:17:26.763468', '2025-12-11 06:17:26.763468', NULL);
INSERT INTO public.games VALUES (738, 'Daily 4 Evening', 168, 'pick4', 4, 0, 9, 0, NULL, 'Daily4Evening', '', '{"game_type": "pick4"}', true, '2025-12-11 06:17:26.789945', '2025-12-11 06:17:26.789945', NULL);
INSERT INTO public.games VALUES (739, 'Cash 5', 168, 'unknown', 4, 0, 9, 0, NULL, 'Cash5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:26.812852', '2025-12-11 06:17:26.812852', NULL);
INSERT INTO public.games VALUES (740, 'Hoosier Lotto', 168, 'unknown', 4, 0, 9, 0, NULL, 'HoosierLotto', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:26.827161', '2025-12-11 06:17:26.827161', NULL);
INSERT INTO public.games VALUES (741, 'Hoosier Lotto +PLUS', 168, 'unknown', 4, 0, 9, 0, NULL, 'HoosierLotto+PLUS', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:26.854516', '2025-12-11 06:17:26.854516', NULL);
INSERT INTO public.games VALUES (742, 'Quick Draw Midday', 168, 'unknown', 4, 0, 9, 0, NULL, 'QuickDrawMidday', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:26.879542', '2025-12-11 06:17:26.879542', NULL);
INSERT INTO public.games VALUES (743, 'Quick Draw Evening', 168, 'unknown', 4, 0, 9, 0, NULL, 'QuickDrawEvening', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:26.899756', '2025-12-11 06:17:26.899756', NULL);
INSERT INTO public.games VALUES (744, 'Cash4Life', 168, 'unknown', 4, 0, 9, 0, NULL, 'Cash4Life', '', '{"game_type": "pick4"}', true, '2025-12-11 06:17:26.926137', '2025-12-11 06:17:26.926137', NULL);
INSERT INTO public.games VALUES (745, 'Powerball Double Play', 168, 'unknown', 4, 0, 9, 0, NULL, 'PowerballDoublePlay', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:26.953517', '2025-12-11 06:17:26.953517', NULL);
INSERT INTO public.games VALUES (746, 'DC-3 7:50pm', 136, 'pick3', 3, 0, 9, 0, NULL, 'DC37:50pm', '7:50pm', '{"game_type": "pick5"}', true, '2025-12-11 06:17:26.984273', '2025-12-11 06:17:26.984273', NULL);
INSERT INTO public.games VALUES (747, 'Pick 4 Midday', 164, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Midday', '', '{"game_type": "pick4"}', true, '2025-12-11 06:17:27.022355', '2025-12-11 06:17:27.022355', NULL);
INSERT INTO public.games VALUES (748, 'Pick 4 Evening', 164, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Evening', '', '{"game_type": "pick4"}', true, '2025-12-11 06:17:27.04131', '2025-12-11 06:17:27.04131', NULL);
INSERT INTO public.games VALUES (749, 'MillionDay Midday', 165, 'unknown', 4, 0, 9, 0, NULL, 'MillionDayMidday', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:27.062555', '2025-12-11 06:17:27.062555', NULL);
INSERT INTO public.games VALUES (750, 'MillionDay Night', 165, 'unknown', 4, 0, 9, 0, NULL, 'MillionDayNight', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:27.103515', '2025-12-11 06:17:27.103515', NULL);
INSERT INTO public.games VALUES (751, 'Pick 3', 125, 'pick3', 3, 0, 9, 0, NULL, 'Pick3', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:27.129826', '2025-12-11 06:17:27.129826', NULL);
INSERT INTO public.games VALUES (752, 'Fantasy 5', 125, 'unknown', 4, 0, 9, 0, NULL, 'Fantasy5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:27.152089', '2025-12-11 06:17:27.152089', NULL);
INSERT INTO public.games VALUES (753, 'Triple Twist', 125, 'unknown', 4, 0, 9, 0, NULL, 'TripleTwist', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:27.179276', '2025-12-11 06:17:27.179276', NULL);
INSERT INTO public.games VALUES (754, 'The Pick', 125, 'unknown', 4, 0, 9, 0, NULL, 'ThePick', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:27.212839', '2025-12-11 06:17:27.212839', NULL);
INSERT INTO public.games VALUES (755, 'Canada Lotto 6/49', 124, 'unknown', 4, 0, 9, 0, NULL, 'CanadaLotto6/49', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:27.241688', '2025-12-11 06:17:27.241688', NULL);
INSERT INTO public.games VALUES (756, 'Bucko', 123, 'unknown', 4, 0, 9, 0, NULL, 'Bucko', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:27.280558', '2025-12-11 06:17:27.280558', NULL);
INSERT INTO public.games VALUES (757, 'Lotto 4', 123, 'pick4', 4, 0, 9, 0, NULL, 'Lotto4', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:27.302784', '2025-12-11 06:17:27.302784', NULL);
INSERT INTO public.games VALUES (758, 'Lucky for Life', 126, 'unknown', 4, 0, 9, 0, NULL, 'LuckyforLife', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:27.335985', '2025-12-11 06:17:27.335985', NULL);
INSERT INTO public.games VALUES (759, 'DC-3 1:50pm', 136, 'pick3', 3, 0, 9, 0, NULL, 'DC31:50pm', '1:50pm', '{"game_type": "pick5"}', true, '2025-12-11 06:17:27.371347', '2025-12-11 06:17:27.371347', NULL);
INSERT INTO public.games VALUES (760, 'DC-5 7:50pm', 136, 'pick5', 5, 0, 9, 0, NULL, 'DC57:50pm', '7:50pm', '{"game_type": "pick5"}', true, '2025-12-11 06:17:27.398489', '2025-12-11 06:17:27.398489', NULL);
INSERT INTO public.games VALUES (761, 'Cash 4 Evening', 125, 'pick4', 4, 0, 9, 0, NULL, 'Cash4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:27.432569', '2025-12-11 06:17:27.432569', NULL);
INSERT INTO public.games VALUES (762, 'Cash 3 Evening', 125, 'pick3', 3, 0, 9, 0, NULL, 'Cash3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:27.470088', '2025-12-11 06:17:27.470088', NULL);
INSERT INTO public.games VALUES (763, 'Triple Twist', 119, 'unknown', 4, 0, 9, 0, NULL, 'TripleTwist', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:27.601877', '2025-12-11 06:17:27.601877', NULL);
INSERT INTO public.games VALUES (764, 'The Pick', 119, 'unknown', 4, 0, 9, 0, NULL, 'ThePick', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:27.662502', '2025-12-11 06:17:27.662502', NULL);
INSERT INTO public.games VALUES (765, 'Powerball', 126, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:27.677139', '2025-12-11 06:17:27.677139', NULL);
INSERT INTO public.games VALUES (766, 'Fantasy 5', 119, 'unknown', 4, 0, 9, 0, NULL, 'Fantasy5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:27.69649', '2025-12-11 06:17:27.69649', NULL);
INSERT INTO public.games VALUES (767, 'Cash 4 Night', 127, 'pick4', 4, 0, 9, 0, NULL, 'Cash4Night', 'Night', '{"game_type": "pick4"}', true, '2025-12-11 06:17:27.727329', '2025-12-11 06:17:27.727329', NULL);
INSERT INTO public.games VALUES (768, 'Cash 3 Midday', 127, 'pick3', 3, 0, 9, 0, NULL, 'Cash3Midday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:27.74975', '2025-12-11 06:17:27.74975', NULL);
INSERT INTO public.games VALUES (769, 'Cash 3 Night', 127, 'pick3', 3, 0, 9, 0, NULL, 'Cash3Night', 'Night', '{"game_type": "pick3"}', true, '2025-12-11 06:17:27.851794', '2025-12-11 06:17:27.851794', NULL);
INSERT INTO public.games VALUES (770, 'Jackpot Triple Play', 128, 'unknown', 4, 0, 9, 0, NULL, 'JackpotTriplePlay', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:27.89154', '2025-12-11 06:17:27.89154', NULL);
INSERT INTO public.games VALUES (771, 'Cash4Life', 126, 'unknown', 4, 0, 9, 0, NULL, 'Cash4Life', '', '{"game_type": "pick4"}', true, '2025-12-11 06:17:27.91719', '2025-12-11 06:17:27.91719', NULL);
INSERT INTO public.games VALUES (772, 'Pick 5 Midday', 128, 'pick5', 5, 0, 9, 0, NULL, 'Pick5Midday', 'Midday', '{"game_type": "pick5"}', true, '2025-12-11 06:17:27.94132', '2025-12-11 06:17:27.94132', NULL);
INSERT INTO public.games VALUES (773, 'Pick 4 Midday', 128, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Midday', 'Midday', '{"game_type": "pick4"}', true, '2025-12-11 06:17:27.990413', '2025-12-11 06:17:27.990413', NULL);
INSERT INTO public.games VALUES (774, 'Pick 3 Evening', 128, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:28.053667', '2025-12-11 06:17:28.053667', NULL);
INSERT INTO public.games VALUES (775, 'Pick 2 Evening', 128, 'pick2', 2, 0, 9, 0, NULL, 'Pick2Evening', 'Evening', '{"game_type": "pick2"}', true, '2025-12-11 06:17:28.098396', '2025-12-11 06:17:28.098396', NULL);
INSERT INTO public.games VALUES (776, 'Multi-Win Lotto', 129, 'unknown', 4, 0, 9, 0, NULL, 'MultiWinLotto', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:28.140523', '2025-12-11 06:17:28.140523', NULL);
INSERT INTO public.games VALUES (777, 'Lotto America', 126, 'unknown', 4, 0, 9, 0, NULL, 'LottoAmerica', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:28.175995', '2025-12-11 06:17:28.175995', NULL);
INSERT INTO public.games VALUES (778, 'Play 4 Day', 129, 'pick4', 4, 0, 9, 0, NULL, 'Play4Day', 'Day', '{"game_type": "pick4"}', true, '2025-12-11 06:17:28.200424', '2025-12-11 06:17:28.200424', NULL);
INSERT INTO public.games VALUES (779, 'Play 3 Day', 129, 'pick3', 3, 0, 9, 0, NULL, 'Play3Day', 'Day', '{"game_type": "pick3"}', true, '2025-12-11 06:17:28.22275', '2025-12-11 06:17:28.22275', NULL);
INSERT INTO public.games VALUES (780, 'Lotto', 130, 'unknown', 4, 0, 9, 0, NULL, 'Lotto', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:28.239695', '2025-12-11 06:17:28.239695', NULL);
INSERT INTO public.games VALUES (781, 'Cash 5', 130, 'unknown', 4, 0, 9, 0, NULL, 'Cash5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:28.253734', '2025-12-11 06:17:28.253734', NULL);
INSERT INTO public.games VALUES (782, 'Play 4 Day', 130, 'pick4', 4, 0, 9, 0, NULL, 'Play4Day', 'Day', '{"game_type": "pick4"}', true, '2025-12-11 06:17:28.278644', '2025-12-11 06:17:28.278644', NULL);
INSERT INTO public.games VALUES (784, 'Colorado Lotto+', 120, 'unknown', 4, 0, 9, 0, NULL, 'ColoradoLotto+', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:28.327428', '2025-12-11 06:17:28.327428', NULL);
INSERT INTO public.games VALUES (785, 'Pick 4 4pm', 131, 'pick4', 4, 0, 9, 0, NULL, 'Pick44pm', '4pm', '{"game_type": "pick4"}', true, '2025-12-11 06:17:28.359918', '2025-12-11 06:17:28.359918', NULL);
INSERT INTO public.games VALUES (786, 'Pick 4 1pm', 131, 'pick4', 4, 0, 9, 0, NULL, 'Pick41pm', '1pm', '{"game_type": "pick4"}', true, '2025-12-11 06:17:28.387034', '2025-12-11 06:17:28.387034', NULL);
INSERT INTO public.games VALUES (787, 'All or Nothing Eve', 133, 'unknown', 4, 0, 9, 0, NULL, 'AllorNothingEve', 'Eve', '{"game_type": "pick3"}', true, '2025-12-11 06:17:28.416141', '2025-12-11 06:17:28.416141', NULL);
INSERT INTO public.games VALUES (788, 'Megabucks', 133, 'unknown', 4, 0, 9, 0, NULL, 'Megabucks', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:28.456435', '2025-12-11 06:17:28.456435', NULL);
INSERT INTO public.games VALUES (789, 'Super Cash', 133, 'unknown', 4, 0, 9, 0, NULL, 'SuperCash', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:28.469861', '2025-12-11 06:17:28.469861', NULL);
INSERT INTO public.games VALUES (790, 'Pick 4 Evening', 133, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:28.487317', '2025-12-11 06:17:28.487317', NULL);
INSERT INTO public.games VALUES (791, 'Pick 3 Evening', 133, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:28.517562', '2025-12-11 06:17:28.517562', NULL);
INSERT INTO public.games VALUES (792, 'Pick 3 Midday', 133, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Midday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:28.541104', '2025-12-11 06:17:28.541104', NULL);
INSERT INTO public.games VALUES (793, 'Western 49', 134, 'unknown', 4, 0, 9, 0, NULL, 'Western49', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:28.597437', '2025-12-11 06:17:28.597437', NULL);
INSERT INTO public.games VALUES (794, 'Pick 4', 134, 'pick4', 4, 0, 9, 0, NULL, 'Pick4', '', '{"game_type": "pick4"}', true, '2025-12-11 06:17:28.639916', '2025-12-11 06:17:28.639916', NULL);
INSERT INTO public.games VALUES (795, 'Pick 2', 134, 'pick2', 2, 0, 9, 0, NULL, 'Pick2', '', '{"game_type": "pick2"}', true, '2025-12-11 06:17:28.653454', '2025-12-11 06:17:28.653454', NULL);
INSERT INTO public.games VALUES (796, 'Daily 4', 135, 'pick4', 4, 0, 9, 0, NULL, 'Daily4', '', '{"game_type": "pick4"}', true, '2025-12-11 06:17:28.675744', '2025-12-11 06:17:28.675744', NULL);
INSERT INTO public.games VALUES (797, 'Daily Keno', 137, 'unknown', 4, 0, 9, 0, NULL, 'DailyKeno', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:28.693179', '2025-12-11 06:17:28.693179', NULL);
INSERT INTO public.games VALUES (798, 'Hit 5', 137, 'unknown', 4, 0, 9, 0, NULL, 'Hit5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:28.707705', '2025-12-11 06:17:28.707705', NULL);
INSERT INTO public.games VALUES (799, 'Match 4', 137, 'unknown', 4, 0, 9, 0, NULL, 'Match4', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:28.724977', '2025-12-11 06:17:28.724977', NULL);
INSERT INTO public.games VALUES (800, 'Bank a Million', 138, 'unknown', 4, 0, 9, 0, NULL, 'BankaMillion', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:28.753802', '2025-12-11 06:17:28.753802', NULL);
INSERT INTO public.games VALUES (801, 'Pick 4 Night', 138, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Night', 'Night', '{"game_type": "pick4"}', true, '2025-12-11 06:17:28.775589', '2025-12-11 06:17:28.775589', NULL);
INSERT INTO public.games VALUES (802, 'Pick 3 Night', 138, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Night', 'Night', '{"game_type": "pick3"}', true, '2025-12-11 06:17:28.790251', '2025-12-11 06:17:28.790251', NULL);
INSERT INTO public.games VALUES (803, 'Pick 3 Day', 138, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Day', 'Day', '{"game_type": "pick3"}', true, '2025-12-11 06:17:28.812324', '2025-12-11 06:17:28.812324', NULL);
INSERT INTO public.games VALUES (804, 'Lotto HotPicks', 139, 'unknown', 4, 0, 9, 0, NULL, 'LottoHotPicks', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:28.82999', '2025-12-11 06:17:28.82999', NULL);
INSERT INTO public.games VALUES (805, 'Lotto', 139, 'unknown', 4, 0, 9, 0, NULL, 'Lotto', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:28.84697', '2025-12-11 06:17:28.84697', NULL);
INSERT INTO public.games VALUES (806, 'Set for Life', 139, 'unknown', 4, 0, 9, 0, NULL, 'SetforLife', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:28.864022', '2025-12-11 06:17:28.864022', NULL);
INSERT INTO public.games VALUES (807, 'All or Nothing Night', 140, 'unknown', 4, 0, 9, 0, NULL, 'AllorNothingNight', 'Night', '{"game_type": "pick3"}', true, '2025-12-11 06:17:28.885752', '2025-12-11 06:17:28.885752', NULL);
INSERT INTO public.games VALUES (808, 'All or Nothing Evening', 140, 'unknown', 4, 0, 9, 0, NULL, 'AllorNothingEvening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:28.913894', '2025-12-11 06:17:28.913894', NULL);
INSERT INTO public.games VALUES (809, 'All or Nothing Morning', 140, 'unknown', 4, 0, 9, 0, NULL, 'AllorNothingMorning', 'Morning', '{"game_type": "pick3"}', true, '2025-12-11 06:17:28.931232', '2025-12-11 06:17:28.931232', NULL);
INSERT INTO public.games VALUES (810, 'Lotto Texas', 140, 'unknown', 4, 0, 9, 0, NULL, 'LottoTexas', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:28.961212', '2025-12-11 06:17:28.961212', NULL);
INSERT INTO public.games VALUES (811, 'Cash 5', 140, 'unknown', 4, 0, 9, 0, NULL, 'Cash5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:28.975845', '2025-12-11 06:17:28.975845', NULL);
INSERT INTO public.games VALUES (812, 'Daily 4 Evening', 140, 'pick4', 4, 0, 9, 0, NULL, 'Daily4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:28.994771', '2025-12-11 06:17:28.994771', NULL);
INSERT INTO public.games VALUES (813, 'Daily 4 Day', 140, 'pick4', 4, 0, 9, 0, NULL, 'Daily4Day', 'Day', '{"game_type": "pick4"}', true, '2025-12-11 06:17:29.02674', '2025-12-11 06:17:29.02674', NULL);
INSERT INTO public.games VALUES (814, 'Pick 3 Evening', 140, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:29.04757', '2025-12-11 06:17:29.04757', NULL);
INSERT INTO public.games VALUES (815, 'Pick 3 Night', 140, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Night', 'Night', '{"game_type": "pick3"}', true, '2025-12-11 06:17:29.065074', '2025-12-11 06:17:29.065074', NULL);
INSERT INTO public.games VALUES (816, 'Daily 4', 121, 'pick4', 4, 0, 9, 0, NULL, 'Daily4', '', '{"game_type": "pick4"}', true, '2025-12-11 06:17:29.090261', '2025-12-11 06:17:29.090261', NULL);
INSERT INTO public.games VALUES (817, 'Pick 3 Morning', 140, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Morning', 'Morning', '{"game_type": "pick3"}', true, '2025-12-11 06:17:29.106026', '2025-12-11 06:17:29.106026', NULL);
INSERT INTO public.games VALUES (818, 'Cash 4 Evening', 141, 'pick4', 4, 0, 9, 0, NULL, 'Cash4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:29.131132', '2025-12-11 06:17:29.131132', NULL);
INSERT INTO public.games VALUES (819, 'Cash 4 Midday', 141, 'pick4', 4, 0, 9, 0, NULL, 'Cash4Midday', 'Midday', '{"game_type": "pick4"}', true, '2025-12-11 06:17:29.153001', '2025-12-11 06:17:29.153001', NULL);
INSERT INTO public.games VALUES (820, 'Cash 3 Evening', 141, 'pick3', 3, 0, 9, 0, NULL, 'Cash3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:29.182544', '2025-12-11 06:17:29.182544', NULL);
INSERT INTO public.games VALUES (821, 'Cash 3 Midday', 141, 'pick3', 3, 0, 9, 0, NULL, 'Cash3Midday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:29.214628', '2025-12-11 06:17:29.214628', NULL);
INSERT INTO public.games VALUES (822, 'Palmetto Cash 5', 143, 'unknown', 4, 0, 9, 0, NULL, 'PalmettoCash5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:29.245968', '2025-12-11 06:17:29.245968', NULL);
INSERT INTO public.games VALUES (823, 'Pick 4 Evening', 143, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:29.278594', '2025-12-11 06:17:29.278594', NULL);
INSERT INTO public.games VALUES (824, 'Pick 3 Evening', 143, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:29.295295', '2025-12-11 06:17:29.295295', NULL);
INSERT INTO public.games VALUES (825, 'Wild Money', 144, 'unknown', 4, 0, 9, 0, NULL, 'WildMoney', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:29.313814', '2025-12-11 06:17:29.313814', NULL);
INSERT INTO public.games VALUES (826, 'Numbers Game Midday', 144, 'pick4', 4, 0, 9, 0, NULL, 'NumbersGameMidday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:29.341712', '2025-12-11 06:17:29.341712', NULL);
INSERT INTO public.games VALUES (827, 'Tout ou Rien', 145, 'unknown', 4, 0, 9, 0, NULL, 'ToutouRien', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:29.373714', '2025-12-11 06:17:29.373714', NULL);
INSERT INTO public.games VALUES (828, 'Banco', 145, 'unknown', 4, 0, 9, 0, NULL, 'Banco', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:29.404201', '2025-12-11 06:17:29.404201', NULL);
INSERT INTO public.games VALUES (829, 'La Mini', 145, 'unknown', 4, 0, 9, 0, NULL, 'LaMini', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:29.425031', '2025-12-11 06:17:29.425031', NULL);
INSERT INTO public.games VALUES (830, 'Québec 49', 145, 'unknown', 4, 0, 9, 0, NULL, 'Québec49', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:29.453479', '2025-12-11 06:17:29.453479', NULL);
INSERT INTO public.games VALUES (831, 'Sprinto', 145, 'unknown', 4, 0, 9, 0, NULL, 'Sprinto', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:29.485582', '2025-12-11 06:17:29.485582', NULL);
INSERT INTO public.games VALUES (832, 'DC-2 1:50pm', 136, 'pick2', 2, 0, 9, 0, NULL, 'DC21:50pm', '1:50pm', '{"game_type": "pick5"}', true, '2025-12-11 06:17:29.504853', '2025-12-11 06:17:29.504853', NULL);
INSERT INTO public.games VALUES (833, 'DC-4 7:50pm', 136, 'pick4', 4, 0, 9, 0, NULL, 'DC47:50pm', '7:50pm', '{"game_type": "pick5"}', true, '2025-12-11 06:17:29.523391', '2025-12-11 06:17:29.523391', NULL);
INSERT INTO public.games VALUES (834, 'Quotidienne 3', 145, 'pick3', 3, 0, 9, 0, NULL, 'Quotidienne3', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:29.560131', '2025-12-11 06:17:29.560131', NULL);
INSERT INTO public.games VALUES (835, 'Revancha', 146, 'unknown', 4, 0, 9, 0, NULL, 'Revancha', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:29.583099', '2025-12-11 06:17:29.583099', NULL);
INSERT INTO public.games VALUES (836, 'Loto Cash', 146, 'unknown', 4, 0, 9, 0, NULL, 'LotoCash', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:29.599986', '2025-12-11 06:17:29.599986', NULL);
INSERT INTO public.games VALUES (837, 'Pega 3 Día', 146, 'pick3', 3, 0, 9, 0, NULL, 'Pega3Día', 'Día', '{"game_type": "pick3"}', true, '2025-12-11 06:17:29.62005', '2025-12-11 06:17:29.62005', NULL);
INSERT INTO public.games VALUES (838, 'Pega 4 Noche', 146, 'pick4', 4, 0, 9, 0, NULL, 'Pega4Noche', 'Noche', '{"game_type": "pick3"}', true, '2025-12-11 06:17:29.650511', '2025-12-11 06:17:29.650511', NULL);
INSERT INTO public.games VALUES (839, 'Match 6', 147, 'unknown', 4, 0, 9, 0, NULL, 'Match6', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:29.666935', '2025-12-11 06:17:29.666935', NULL);
INSERT INTO public.games VALUES (840, 'Cash 5', 147, 'unknown', 4, 0, 9, 0, NULL, 'Cash5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:29.693952', '2025-12-11 06:17:29.693952', NULL);
INSERT INTO public.games VALUES (841, 'Pick 5 Day', 147, 'pick5', 5, 0, 9, 0, NULL, 'Pick5Day', 'Day', '{"game_type": "pick5"}', true, '2025-12-11 06:17:29.750198', '2025-12-11 06:17:29.750198', NULL);
INSERT INTO public.games VALUES (842, 'Pick 4 Evening', 147, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:29.783887', '2025-12-11 06:17:29.783887', NULL);
INSERT INTO public.games VALUES (843, 'Pick 3 Evening', 147, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:29.80383', '2025-12-11 06:17:29.80383', NULL);
INSERT INTO public.games VALUES (844, 'Pick 2 Evening', 147, 'pick2', 2, 0, 9, 0, NULL, 'Pick2Evening', 'Evening', '{"game_type": "pick2"}', true, '2025-12-11 06:17:29.833055', '2025-12-11 06:17:29.833055', NULL);
INSERT INTO public.games VALUES (845, 'Pick 2 Day', 147, 'pick2', 2, 0, 9, 0, NULL, 'Pick2Day', 'Day', '{"game_type": "pick2"}', true, '2025-12-11 06:17:29.86587', '2025-12-11 06:17:29.86587', NULL);
INSERT INTO public.games VALUES (846, 'Pick 4 10pm', 131, 'pick4', 4, 0, 9, 0, NULL, 'Pick410pm', '10pm', '{"game_type": "pick4"}', true, '2025-12-11 06:17:29.899564', '2025-12-11 06:17:29.899564', NULL);
INSERT INTO public.games VALUES (847, 'Win For Life', 131, 'unknown', 4, 0, 9, 0, NULL, 'WinForLife', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:29.919993', '2025-12-11 06:17:29.919993', NULL);
INSERT INTO public.games VALUES (848, 'Montana Cash', 156, 'unknown', 4, 0, 9, 0, NULL, 'MontanaCash', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:29.948528', '2025-12-11 06:17:29.948528', NULL);
INSERT INTO public.games VALUES (849, 'Show Me Cash', 157, 'unknown', 4, 0, 9, 0, NULL, 'ShowMeCash', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:29.97063', '2025-12-11 06:17:29.97063', NULL);
INSERT INTO public.games VALUES (850, 'Pick 4 Midday', 157, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Midday', 'Midday', '{"game_type": "pick4"}', true, '2025-12-11 06:17:29.996797', '2025-12-11 06:17:29.996797', NULL);
INSERT INTO public.games VALUES (851, 'Pick 3 Evening', 157, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:30.021356', '2025-12-11 06:17:30.021356', NULL);
INSERT INTO public.games VALUES (852, 'Northstar Cash', 158, 'unknown', 4, 0, 9, 0, NULL, 'NorthstarCash', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:30.04383', '2025-12-11 06:17:30.04383', NULL);
INSERT INTO public.games VALUES (853, 'Daily 3', 158, 'pick3', 3, 0, 9, 0, NULL, 'Daily3', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:30.064534', '2025-12-11 06:17:30.064534', NULL);
INSERT INTO public.games VALUES (854, 'Keno', 159, 'unknown', 4, 0, 9, 0, NULL, 'Keno', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:30.088328', '2025-12-11 06:17:30.088328', NULL);
INSERT INTO public.games VALUES (855, 'Fantasy 5', 159, 'unknown', 4, 0, 9, 0, NULL, 'Fantasy5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:30.102037', '2025-12-11 06:17:30.102037', NULL);
INSERT INTO public.games VALUES (856, 'Daily 4 Midday', 159, 'pick4', 4, 0, 9, 0, NULL, 'Daily4Midday', 'Midday', '{"game_type": "pick4"}', true, '2025-12-11 06:17:30.121273', '2025-12-11 06:17:30.121273', NULL);
INSERT INTO public.games VALUES (857, 'Daily 3 Evening', 159, 'pick3', 3, 0, 9, 0, NULL, 'Daily3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:30.141534', '2025-12-11 06:17:30.141534', NULL);
INSERT INTO public.games VALUES (858, 'Megabucks Doubler', 160, 'unknown', 4, 0, 9, 0, NULL, 'MegabucksDoubler', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:30.162739', '2025-12-11 06:17:30.162739', NULL);
INSERT INTO public.games VALUES (859, 'Numbers Game Evening', 160, 'pick4', 4, 0, 9, 0, NULL, 'NumbersGameEvening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:30.187607', '2025-12-11 06:17:30.187607', NULL);
INSERT INTO public.games VALUES (860, 'Numbers Game Midday', 160, 'pick4', 4, 0, 9, 0, NULL, 'NumbersGameMidday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:30.205398', '2025-12-11 06:17:30.205398', NULL);
INSERT INTO public.games VALUES (861, 'Bonus Match 5', 161, 'unknown', 4, 0, 9, 0, NULL, 'BonusMatch5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:30.229902', '2025-12-11 06:17:30.229902', NULL);
INSERT INTO public.games VALUES (862, 'Pick 4 Midday', 161, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Midday', 'Midday', '{"game_type": "pick4"}', true, '2025-12-11 06:17:30.25553', '2025-12-11 06:17:30.25553', NULL);
INSERT INTO public.games VALUES (863, 'Pick 3 Evening', 161, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:30.281422', '2025-12-11 06:17:30.281422', NULL);
INSERT INTO public.games VALUES (864, 'Gimme 5', 126, 'unknown', 4, 0, 9, 0, NULL, 'Gimme5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:30.294392', '2025-12-11 06:17:30.294392', NULL);
INSERT INTO public.games VALUES (865, 'Lotto', 162, 'unknown', 4, 0, 9, 0, NULL, 'Lotto', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:30.313208', '2025-12-11 06:17:30.313208', NULL);
INSERT INTO public.games VALUES (866, 'Easy 5', 162, 'unknown', 4, 0, 9, 0, NULL, 'Easy5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:30.330363', '2025-12-11 06:17:30.330363', NULL);
INSERT INTO public.games VALUES (867, 'Pick 4', 162, 'pick4', 4, 0, 9, 0, NULL, 'Pick4', '', '{"game_type": "pick4"}', true, '2025-12-11 06:17:30.35173', '2025-12-11 06:17:30.35173', NULL);
INSERT INTO public.games VALUES (868, 'Cash Ball 225', 163, 'unknown', 4, 0, 9, 0, NULL, 'CashBall225', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:30.379892', '2025-12-11 06:17:30.379892', NULL);
INSERT INTO public.games VALUES (869, 'Pick 4 Midday', 163, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Midday', 'Midday', '{"game_type": "pick4"}', true, '2025-12-11 06:17:30.425467', '2025-12-11 06:17:30.425467', NULL);
INSERT INTO public.games VALUES (870, 'Pick 3 Midday', 163, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Midday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:30.451619', '2025-12-11 06:17:30.451619', NULL);
INSERT INTO public.games VALUES (871, 'Pick 3 Evening', 164, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:30.473246', '2025-12-11 06:17:30.473246', NULL);
INSERT INTO public.games VALUES (872, 'SiVinceTutto', 165, 'unknown', 4, 0, 9, 0, NULL, 'SiVinceTutto', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:30.494204', '2025-12-11 06:17:30.494204', NULL);
INSERT INTO public.games VALUES (873, 'Lotto Plus 2', 166, 'unknown', 4, 0, 9, 0, NULL, 'LottoPlus2', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:30.523431', '2025-12-11 06:17:30.523431', NULL);
INSERT INTO public.games VALUES (874, 'Lotto Plus 1', 166, 'unknown', 4, 0, 9, 0, NULL, 'LottoPlus1', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:30.553251', '2025-12-11 06:17:30.553251', NULL);
INSERT INTO public.games VALUES (875, 'Daily Million Plus 9pm', 166, 'unknown', 4, 0, 9, 0, NULL, 'DailyMillionPlus9pm', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:30.574856', '2025-12-11 06:17:30.574856', NULL);
INSERT INTO public.games VALUES (876, 'Euro Millions', 167, 'unknown', 4, 0, 9, 0, NULL, 'EuroMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:30.601486', '2025-12-11 06:17:30.601486', NULL);
INSERT INTO public.games VALUES (877, 'Plus', 166, 'unknown', 4, 0, 9, 0, NULL, 'Plus', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:30.626685', '2025-12-11 06:17:30.626685', NULL);
INSERT INTO public.games VALUES (878, 'Pick 4 Midday', 168, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Midday', 'Midday', '{"game_type": "pick4"}', true, '2025-12-11 06:17:30.653987', '2025-12-11 06:17:30.653987', NULL);
INSERT INTO public.games VALUES (879, 'Pick 3 Evening', 168, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:30.681954', '2025-12-11 06:17:30.681954', NULL);
INSERT INTO public.games VALUES (880, 'Quick Draw Evening', 169, 'unknown', 4, 0, 9, 0, NULL, 'QuickDrawEvening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:30.727312', '2025-12-11 06:17:30.727312', NULL);
INSERT INTO public.games VALUES (881, 'Hoosier Lotto', 169, 'unknown', 4, 0, 9, 0, NULL, 'HoosierLotto', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:30.749758', '2025-12-11 06:17:30.749758', NULL);
INSERT INTO public.games VALUES (882, 'Cash 5', 169, 'unknown', 4, 0, 9, 0, NULL, 'Cash5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:30.779104', '2025-12-11 06:17:30.779104', NULL);
INSERT INTO public.games VALUES (883, 'Daily 3 Evening', 169, 'pick3', 3, 0, 9, 0, NULL, 'Daily3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:30.80411', '2025-12-11 06:17:30.80411', NULL);
INSERT INTO public.games VALUES (884, 'Daily 3 Midday', 169, 'pick3', 3, 0, 9, 0, NULL, 'Daily3Midday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:30.827171', '2025-12-11 06:17:30.827171', NULL);
INSERT INTO public.games VALUES (885, 'Lotto', 170, 'unknown', 4, 0, 9, 0, NULL, 'Lotto', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:30.843826', '2025-12-11 06:17:30.843826', NULL);
INSERT INTO public.games VALUES (886, 'Lucky Day Lotto Midday', 170, 'unknown', 4, 0, 9, 0, NULL, 'LuckyDayLottoMidday', 'Day', '{"game_type": "pick5"}', true, '2025-12-11 06:17:30.884552', '2025-12-11 06:17:30.884552', NULL);
INSERT INTO public.games VALUES (887, 'Pick 4 Evening', 170, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:30.944429', '2025-12-11 06:17:30.944429', NULL);
INSERT INTO public.games VALUES (888, 'Pick 3 Evening', 170, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:30.964339', '2025-12-11 06:17:30.964339', NULL);
INSERT INTO public.games VALUES (889, 'Pick 3 Midday', 120, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Midday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:30.991888', '2025-12-11 06:17:30.991888', NULL);
INSERT INTO public.games VALUES (890, 'Pick 3', 119, 'pick3', 3, 0, 9, 0, NULL, 'Pick3', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:31.019802', '2025-12-11 06:17:31.019802', NULL);
INSERT INTO public.games VALUES (891, 'Pick 3 Evening', 120, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:31.034244', '2025-12-11 06:17:31.034244', NULL);
INSERT INTO public.games VALUES (892, 'Lotto 6aus49', 172, 'unknown', 4, 0, 9, 0, NULL, 'Lotto6aus49', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:31.058793', '2025-12-11 06:17:31.058793', NULL);
INSERT INTO public.games VALUES (893, 'Super 6', 172, 'unknown', 4, 0, 9, 0, NULL, 'Super6', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:31.085395', '2025-12-11 06:17:31.085395', NULL);
INSERT INTO public.games VALUES (894, 'EuroJackpot', 167, 'unknown', 4, 0, 9, 0, NULL, 'EuroJackpot', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:31.129443', '2025-12-11 06:17:31.129443', NULL);
INSERT INTO public.games VALUES (895, 'Jumbo Bucks Lotto', 127, 'unknown', 4, 0, 9, 0, NULL, 'JumboBucksLotto', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:31.180579', '2025-12-11 06:17:31.180579', NULL);
INSERT INTO public.games VALUES (896, 'Cash Pop Primetime', 127, 'unknown', 4, 0, 9, 0, NULL, 'CashPopPrimetime', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:31.216347', '2025-12-11 06:17:31.216347', NULL);
INSERT INTO public.games VALUES (897, 'Cash Pop Drive Time', 127, 'unknown', 4, 0, 9, 0, NULL, 'CashPopDriveTime', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:31.270448', '2025-12-11 06:17:31.270448', NULL);
INSERT INTO public.games VALUES (898, 'Cash Pop Early Bird', 127, 'unknown', 4, 0, 9, 0, NULL, 'CashPopEarlyBird', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:31.311764', '2025-12-11 06:17:31.311764', NULL);
INSERT INTO public.games VALUES (899, 'Hoosier Lotto +PLUS', 169, 'unknown', 4, 0, 9, 0, NULL, 'HoosierLotto+PLUS', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:31.347995', '2025-12-11 06:17:31.347995', NULL);
INSERT INTO public.games VALUES (900, 'Georgia Five Midday', 127, 'pick5', 5, 0, 9, 0, NULL, 'GeorgiaFiveMidday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:31.406636', '2025-12-11 06:17:31.406636', NULL);
INSERT INTO public.games VALUES (901, 'Georgia Five Evening', 127, 'pick5', 5, 0, 9, 0, NULL, 'GeorgiaFiveEvening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:31.43314', '2025-12-11 06:17:31.43314', NULL);
INSERT INTO public.games VALUES (902, 'Pick 5', 155, 'pick5', 5, 0, 9, 0, NULL, 'Pick5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:31.465114', '2025-12-11 06:17:31.465114', NULL);
INSERT INTO public.games VALUES (903, 'Daily 3 Midday', 121, 'pick3', 3, 0, 9, 0, NULL, 'Daily3Midday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:31.497648', '2025-12-11 06:17:31.497648', NULL);
INSERT INTO public.games VALUES (904, 'BC/49', 122, 'unknown', 4, 0, 9, 0, NULL, 'BC/49', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:31.526506', '2025-12-11 06:17:31.526506', NULL);
INSERT INTO public.games VALUES (905, 'Hit or Miss', 123, 'unknown', 4, 0, 9, 0, NULL, 'HitorMiss', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:31.563673', '2025-12-11 06:17:31.563673', NULL);
INSERT INTO public.games VALUES (906, 'Lotto Max', 124, 'unknown', 4, 0, 9, 0, NULL, 'LottoMax', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:31.582113', '2025-12-11 06:17:31.582113', NULL);
INSERT INTO public.games VALUES (907, 'Daily Keno Midday', 148, 'unknown', 4, 0, 9, 0, NULL, 'DailyKenoMidday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:31.604684', '2025-12-11 06:17:31.604684', NULL);
INSERT INTO public.games VALUES (908, 'Lottario', 148, 'unknown', 4, 0, 9, 0, NULL, 'Lottario', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:31.636914', '2025-12-11 06:17:31.636914', NULL);
INSERT INTO public.games VALUES (909, 'Powerball', 155, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:31.672129', '2025-12-11 06:17:31.672129', NULL);
INSERT INTO public.games VALUES (910, 'MegaDice Lotto', 148, 'unknown', 4, 0, 9, 0, NULL, 'MegaDiceLotto', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:31.695416', '2025-12-11 06:17:31.695416', NULL);
INSERT INTO public.games VALUES (911, 'Pick 4 Evening', 148, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:31.739487', '2025-12-11 06:17:31.739487', NULL);
INSERT INTO public.games VALUES (912, 'Pick 3 Evening', 148, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:31.777672', '2025-12-11 06:17:31.777672', NULL);
INSERT INTO public.games VALUES (913, 'Pick 3 Midday', 148, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Midday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:31.80201', '2025-12-11 06:17:31.80201', NULL);
INSERT INTO public.games VALUES (914, 'Pick 2 Midday', 148, 'pick2', 2, 0, 9, 0, NULL, 'Pick2Midday', 'Midday', '{"game_type": "pick2"}', true, '2025-12-11 06:17:31.828578', '2025-12-11 06:17:31.828578', NULL);
INSERT INTO public.games VALUES (915, 'Cash 5', 149, 'unknown', 4, 0, 9, 0, NULL, 'Cash5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:31.858963', '2025-12-11 06:17:31.858963', NULL);
INSERT INTO public.games VALUES (916, 'Classic Lotto', 150, 'unknown', 4, 0, 9, 0, NULL, 'ClassicLotto', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:31.897354', '2025-12-11 06:17:31.897354', NULL);
INSERT INTO public.games VALUES (917, 'Rolling Cash 5', 150, 'unknown', 4, 0, 9, 0, NULL, 'RollingCash5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:31.940816', '2025-12-11 06:17:31.940816', NULL);
INSERT INTO public.games VALUES (918, 'Pick 5 Midday', 150, 'pick5', 5, 0, 9, 0, NULL, 'Pick5Midday', 'Midday', '{"game_type": "pick5"}', true, '2025-12-11 06:17:31.958238', '2025-12-11 06:17:31.958238', NULL);
INSERT INTO public.games VALUES (919, 'Pick 4 Midday', 150, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Midday', 'Midday', '{"game_type": "pick4"}', true, '2025-12-11 06:17:32.078128', '2025-12-11 06:17:32.078128', NULL);
INSERT INTO public.games VALUES (920, 'Pick 3 Evening', 150, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:32.103403', '2025-12-11 06:17:32.103403', NULL);
INSERT INTO public.games VALUES (921, 'Cash 5', 151, 'unknown', 4, 0, 9, 0, NULL, 'Cash5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:32.138251', '2025-12-11 06:17:32.138251', NULL);
INSERT INTO public.games VALUES (922, 'Pega 2 con Palé', 146, 'unknown', 4, 0, 9, 0, NULL, 'Pega2conPalé', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:32.160824', '2025-12-11 06:17:32.160824', NULL);
INSERT INTO public.games VALUES (923, 'Pick 4 Daytime', 151, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Daytime', 'Daytime', '{"game_type": "pick4"}', true, '2025-12-11 06:17:32.179965', '2025-12-11 06:17:32.179965', NULL);
INSERT INTO public.games VALUES (924, 'Pick 3 Daytime', 151, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Daytime', 'Daytime', '{"game_type": "pick3"}', true, '2025-12-11 06:17:32.205719', '2025-12-11 06:17:32.205719', NULL);
INSERT INTO public.games VALUES (925, 'Pick 10', 152, 'unknown', 4, 0, 9, 0, NULL, 'Pick10', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:32.234419', '2025-12-11 06:17:32.234419', NULL);
INSERT INTO public.games VALUES (926, 'Take 5', 152, 'unknown', 4, 0, 9, 0, NULL, 'Take5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:32.257369', '2025-12-11 06:17:32.257369', NULL);
INSERT INTO public.games VALUES (927, 'Win 4 Midday', 152, 'pick4', 4, 0, 9, 0, NULL, 'Win4Midday', 'Midday', '{"game_type": "pick4"}', true, '2025-12-11 06:17:32.281011', '2025-12-11 06:17:32.281011', NULL);
INSERT INTO public.games VALUES (928, 'Numbers Midday', 152, 'pick3', 3, 0, 9, 0, NULL, 'NumbersMidday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:32.302172', '2025-12-11 06:17:32.302172', NULL);
INSERT INTO public.games VALUES (929, 'Road Runner Cash', 153, 'unknown', 4, 0, 9, 0, NULL, 'RoadRunnerCash', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:32.329583', '2025-12-11 06:17:32.329583', NULL);
INSERT INTO public.games VALUES (930, 'Pick 6', 154, 'unknown', 4, 0, 9, 0, NULL, 'Pick6', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:32.357486', '2025-12-11 06:17:32.357486', NULL);
INSERT INTO public.games VALUES (931, 'Jersey Cash 5', 154, 'unknown', 4, 0, 9, 0, NULL, 'JerseyCash5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:32.389573', '2025-12-11 06:17:32.389573', NULL);
INSERT INTO public.games VALUES (932, 'Pick 4 Midday', 154, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Midday', 'Midday', '{"game_type": "pick4"}', true, '2025-12-11 06:17:32.421774', '2025-12-11 06:17:32.421774', NULL);
INSERT INTO public.games VALUES (933, 'Pick 3 Midday', 154, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Midday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:32.450007', '2025-12-11 06:17:32.450007', NULL);
INSERT INTO public.games VALUES (934, 'Extra', 122, 'unknown', 4, 0, 9, 0, NULL, 'Extra', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:32.483404', '2025-12-11 06:17:32.483404', NULL);
INSERT INTO public.games VALUES (935, 'Tri-State Pick 3 Evening', 175, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:32.519271', '2025-12-11 06:17:32.519271', NULL);
INSERT INTO public.games VALUES (936, 'Tri-State Pick 4 Day', 126, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Day', 'Day', '{"game_type": "pick4"}', true, '2025-12-11 06:17:32.553779', '2025-12-11 06:17:32.553779', NULL);
INSERT INTO public.games VALUES (937, 'Tri-State Pick 4 Day', 175, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Day', 'Day', '{"game_type": "pick4"}', true, '2025-12-11 06:17:32.600388', '2025-12-11 06:17:32.600388', NULL);
INSERT INTO public.games VALUES (938, 'Powerball', 128, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:32.665545', '2025-12-11 06:17:32.665545', NULL);
INSERT INTO public.games VALUES (939, 'Tri-State Pick 3 Evening', 126, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:32.696291', '2025-12-11 06:17:32.696291', NULL);
INSERT INTO public.games VALUES (940, 'Keno Atlantic', 123, 'unknown', 4, 0, 9, 0, NULL, 'KenoAtlantic', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:32.72993', '2025-12-11 06:17:32.72993', NULL);
INSERT INTO public.games VALUES (941, 'Tag', 123, 'unknown', 4, 0, 9, 0, NULL, 'Tag', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:32.758626', '2025-12-11 06:17:32.758626', NULL);
INSERT INTO public.games VALUES (942, 'Daily Grand', 124, 'unknown', 4, 0, 9, 0, NULL, 'DailyGrand', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:32.801298', '2025-12-11 06:17:32.801298', NULL);
INSERT INTO public.games VALUES (943, 'Big Sky Bonus', 156, 'unknown', 4, 0, 9, 0, NULL, 'BigSkyBonus', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:32.846098', '2025-12-11 06:17:32.846098', NULL);
INSERT INTO public.games VALUES (944, 'Pick 4 Day', 153, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Day', 'Day', '{"game_type": "pick4"}', true, '2025-12-11 06:17:32.861326', '2025-12-11 06:17:32.861326', NULL);
INSERT INTO public.games VALUES (945, 'Match 5', 173, 'unknown', 4, 0, 9, 0, NULL, 'Match5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:32.897793', '2025-12-11 06:17:32.897793', NULL);
INSERT INTO public.games VALUES (946, 'Cash 3', 173, 'pick3', 3, 0, 9, 0, NULL, 'Cash3', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:32.913107', '2025-12-11 06:17:32.913107', NULL);
INSERT INTO public.games VALUES (947, 'Fantasy 5', 128, 'unknown', 4, 0, 9, 0, NULL, 'Fantasy5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:32.942782', '2025-12-11 06:17:32.942782', NULL);
INSERT INTO public.games VALUES (948, 'Fantasy 5', 121, 'unknown', 4, 0, 9, 0, NULL, 'Fantasy5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:32.979244', '2025-12-11 06:17:32.979244', NULL);
INSERT INTO public.games VALUES (949, 'Daily 3 Evening', 121, 'pick3', 3, 0, 9, 0, NULL, 'Daily3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:33.021987', '2025-12-11 06:17:33.021987', NULL);
INSERT INTO public.games VALUES (950, 'Cash 3 Evening', 127, 'pick3', 3, 0, 9, 0, NULL, 'Cash3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:33.038461', '2025-12-11 06:17:33.038461', NULL);
INSERT INTO public.games VALUES (951, 'Pick 4 Evening', 128, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:33.060716', '2025-12-11 06:17:33.060716', NULL);
INSERT INTO public.games VALUES (952, 'Numbers Game Evening', 144, 'pick4', 4, 0, 9, 0, NULL, 'NumbersGameEvening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:33.093817', '2025-12-11 06:17:33.093817', NULL);
INSERT INTO public.games VALUES (953, 'Kicker', 150, 'unknown', 4, 0, 9, 0, NULL, 'Kicker', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:33.121114', '2025-12-11 06:17:33.121114', NULL);
INSERT INTO public.games VALUES (954, 'Pick 3 Midday', 161, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Midday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:33.159484', '2025-12-11 06:17:33.159484', NULL);
INSERT INTO public.games VALUES (955, 'Pick 3', 162, 'pick3', 3, 0, 9, 0, NULL, 'Pick3', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:33.229509', '2025-12-11 06:17:33.229509', NULL);
INSERT INTO public.games VALUES (956, 'Pick 4 Evening', 163, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:33.332983', '2025-12-11 06:17:33.332983', NULL);
INSERT INTO public.games VALUES (957, 'Pick 4 Evening', 168, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:33.381835', '2025-12-11 06:17:33.381835', NULL);
INSERT INTO public.games VALUES (958, 'Lucky Day Lotto Evening', 170, 'unknown', 4, 0, 9, 0, NULL, 'LuckyDayLottoEvening', 'Day', '{"game_type": "pick5"}', true, '2025-12-11 06:17:33.403733', '2025-12-11 06:17:33.403733', NULL);
INSERT INTO public.games VALUES (959, 'Take 5 Midday', 152, 'unknown', 4, 0, 9, 0, NULL, 'Take5Midday', 'Midday', '{"game_type": "pick5"}', true, '2025-12-11 06:17:33.433928', '2025-12-11 06:17:33.433928', NULL);
INSERT INTO public.games VALUES (960, 'Pick 5 Midday', 161, 'pick5', 5, 0, 9, 0, NULL, 'Pick5Midday', 'Midday', '{"game_type": "pick5"}', true, '2025-12-11 06:17:33.458442', '2025-12-11 06:17:33.458442', NULL);
INSERT INTO public.games VALUES (961, 'Lotto 6/49 Guaranteed Prize Draw', 122, 'unknown', 4, 0, 9, 0, NULL, 'Lotto6/49GuaranteedPrizeDraw', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:33.48059', '2025-12-11 06:17:33.48059', NULL);
INSERT INTO public.games VALUES (962, 'Extra', 134, 'unknown', 4, 0, 9, 0, NULL, 'Extra', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:33.504428', '2025-12-11 06:17:33.504428', NULL);
INSERT INTO public.games VALUES (963, 'MyDaY', 155, 'unknown', 4, 0, 9, 0, NULL, 'MyDaY', 'DaY', '{"game_type": "pick3"}', true, '2025-12-11 06:17:33.537364', '2025-12-11 06:17:33.537364', NULL);
INSERT INTO public.games VALUES (964, 'Lucky for Life', 174, 'unknown', 4, 0, 9, 0, NULL, 'LuckyforLife', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:33.557101', '2025-12-11 06:17:33.557101', NULL);
INSERT INTO public.games VALUES (965, 'Powerball Double Play', 157, 'unknown', 4, 0, 9, 0, NULL, 'PowerballDoublePlay', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:33.584528', '2025-12-11 06:17:33.584528', NULL);
INSERT INTO public.games VALUES (966, 'Powerball Double Play', 154, 'unknown', 4, 0, 9, 0, NULL, 'PowerballDoublePlay', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:33.64318', '2025-12-11 06:17:33.64318', NULL);
INSERT INTO public.games VALUES (967, 'Lotto America', 142, 'unknown', 4, 0, 9, 0, NULL, 'LottoAmerica', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:33.683701', '2025-12-11 06:17:33.683701', NULL);
INSERT INTO public.games VALUES (968, 'Powerball', 120, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:33.719061', '2025-12-11 06:17:33.719061', NULL);
INSERT INTO public.games VALUES (969, 'Lotto America', 164, 'unknown', 4, 0, 9, 0, NULL, 'LottoAmerica', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:33.764511', '2025-12-11 06:17:33.764511', NULL);
INSERT INTO public.games VALUES (970, 'Powerball', 164, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:33.81056', '2025-12-11 06:17:33.81056', NULL);
INSERT INTO public.games VALUES (971, 'Powerball Double Play', 156, 'unknown', 4, 0, 9, 0, NULL, 'PowerballDoublePlay', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:33.869973', '2025-12-11 06:17:33.869973', NULL);
INSERT INTO public.games VALUES (972, 'Natural State Jackpot', 125, 'unknown', 4, 0, 9, 0, NULL, 'NaturalStateJackpot', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:33.912763', '2025-12-11 06:17:33.912763', NULL);
INSERT INTO public.games VALUES (973, 'Cash 4 Midday', 125, 'pick4', 4, 0, 9, 0, NULL, 'Cash4Midday', 'Midday', '{"game_type": "pick4"}', true, '2025-12-11 06:17:33.936112', '2025-12-11 06:17:33.936112', NULL);
INSERT INTO public.games VALUES (974, 'Cash 3 Midday', 125, 'pick3', 3, 0, 9, 0, NULL, 'Cash3Midday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:34.052756', '2025-12-11 06:17:34.052756', NULL);
INSERT INTO public.games VALUES (975, 'Mega Millions', 126, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:34.086139', '2025-12-11 06:17:34.086139', NULL);
INSERT INTO public.games VALUES (976, 'Cash 4 Midday', 127, 'pick4', 4, 0, 9, 0, NULL, 'Cash4Midday', 'Midday', '{"game_type": "pick4"}', true, '2025-12-11 06:17:34.116841', '2025-12-11 06:17:34.116841', NULL);
INSERT INTO public.games VALUES (977, 'Cash 4 Evening', 127, 'pick4', 4, 0, 9, 0, NULL, 'Cash4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:34.137146', '2025-12-11 06:17:34.137146', NULL);
INSERT INTO public.games VALUES (978, 'Lotto', 128, 'unknown', 4, 0, 9, 0, NULL, 'Lotto', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:34.162628', '2025-12-11 06:17:34.162628', NULL);
INSERT INTO public.games VALUES (979, 'Pick 5 Evening', 128, 'pick5', 5, 0, 9, 0, NULL, 'Pick5Evening', 'Evening', '{"game_type": "pick5"}', true, '2025-12-11 06:17:34.193847', '2025-12-11 06:17:34.193847', NULL);
INSERT INTO public.games VALUES (980, 'Pick 3 Midday', 128, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Midday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:34.236158', '2025-12-11 06:17:34.236158', NULL);
INSERT INTO public.games VALUES (981, 'Pick 2 Midday', 128, 'pick2', 2, 0, 9, 0, NULL, 'Pick2Midday', 'Midday', '{"game_type": "pick2"}', true, '2025-12-11 06:17:34.272853', '2025-12-11 06:17:34.272853', NULL);
INSERT INTO public.games VALUES (982, 'Play 4 Night', 129, 'pick4', 4, 0, 9, 0, NULL, 'Play4Night', 'Night', '{"game_type": "pick4"}', true, '2025-12-11 06:17:34.314021', '2025-12-11 06:17:34.314021', NULL);
INSERT INTO public.games VALUES (983, 'Play 3 Night', 129, 'pick3', 3, 0, 9, 0, NULL, 'Play3Night', 'Night', '{"game_type": "pick3"}', true, '2025-12-11 06:17:34.338823', '2025-12-11 06:17:34.338823', NULL);
INSERT INTO public.games VALUES (984, 'Play 4 Night', 130, 'pick4', 4, 0, 9, 0, NULL, 'Play4Night', 'Night', '{"game_type": "pick4"}', true, '2025-12-11 06:17:34.367986', '2025-12-11 06:17:34.367986', NULL);
INSERT INTO public.games VALUES (985, 'Play 3 Night', 130, 'pick3', 3, 0, 9, 0, NULL, 'Play3Night', 'Night', '{"game_type": "pick3"}', true, '2025-12-11 06:17:34.393365', '2025-12-11 06:17:34.393365', NULL);
INSERT INTO public.games VALUES (986, 'Pick 4 7pm', 131, 'pick4', 4, 0, 9, 0, NULL, 'Pick47pm', '7pm', '{"game_type": "pick4"}', true, '2025-12-11 06:17:34.429065', '2025-12-11 06:17:34.429065', NULL);
INSERT INTO public.games VALUES (987, 'Cowboy Draw', 132, 'unknown', 4, 0, 9, 0, NULL, 'CowboyDraw', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:34.484454', '2025-12-11 06:17:34.484454', NULL);
INSERT INTO public.games VALUES (988, 'All or Nothing Mid', 133, 'unknown', 4, 0, 9, 0, NULL, 'AllorNothingMid', 'Mid', '{"game_type": "pick3"}', true, '2025-12-11 06:17:34.547412', '2025-12-11 06:17:34.547412', NULL);
INSERT INTO public.games VALUES (989, 'Badger 5', 133, 'unknown', 4, 0, 9, 0, NULL, 'Badger5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:34.582293', '2025-12-11 06:17:34.582293', NULL);
INSERT INTO public.games VALUES (990, 'Pick 4 Midday', 133, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Midday', 'Midday', '{"game_type": "pick4"}', true, '2025-12-11 06:17:34.641522', '2025-12-11 06:17:34.641522', NULL);
INSERT INTO public.games VALUES (991, 'Western Max', 134, 'unknown', 4, 0, 9, 0, NULL, 'WesternMax', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:34.674825', '2025-12-11 06:17:34.674825', NULL);
INSERT INTO public.games VALUES (992, 'Pick 3', 134, 'pick3', 3, 0, 9, 0, NULL, 'Pick3', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:34.693491', '2025-12-11 06:17:34.693491', NULL);
INSERT INTO public.games VALUES (993, 'Cash 25', 135, 'unknown', 4, 0, 9, 0, NULL, 'Cash25', '', '{"game_type": "pick2"}', true, '2025-12-11 06:17:34.720888', '2025-12-11 06:17:34.720888', NULL);
INSERT INTO public.games VALUES (994, 'Daily 3', 135, 'pick3', 3, 0, 9, 0, NULL, 'Daily3', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:34.744022', '2025-12-11 06:17:34.744022', NULL);
INSERT INTO public.games VALUES (995, 'Lotto', 137, 'unknown', 4, 0, 9, 0, NULL, 'Lotto', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:34.774153', '2025-12-11 06:17:34.774153', NULL);
INSERT INTO public.games VALUES (996, 'Pick 3', 137, 'pick3', 3, 0, 9, 0, NULL, 'Pick3', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:34.792878', '2025-12-11 06:17:34.792878', NULL);
INSERT INTO public.games VALUES (997, 'Cash 5', 138, 'unknown', 4, 0, 9, 0, NULL, 'Cash5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:34.8258', '2025-12-11 06:17:34.8258', NULL);
INSERT INTO public.games VALUES (998, 'Pick 4 Day', 138, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Day', 'Day', '{"game_type": "pick4"}', true, '2025-12-11 06:17:34.862096', '2025-12-11 06:17:34.862096', NULL);
INSERT INTO public.games VALUES (999, 'Thunderball', 139, 'unknown', 4, 0, 9, 0, NULL, 'Thunderball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:34.892869', '2025-12-11 06:17:34.892869', NULL);
INSERT INTO public.games VALUES (1000, 'EuroMillions HotPicks', 139, 'unknown', 4, 0, 9, 0, NULL, 'EuroMillionsHotPicks', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:34.932613', '2025-12-11 06:17:34.932613', NULL);
INSERT INTO public.games VALUES (1001, 'All or Nothing Day', 140, 'unknown', 4, 0, 9, 0, NULL, 'AllorNothingDay', 'Day', '{"game_type": "pick3"}', true, '2025-12-11 06:17:34.965346', '2025-12-11 06:17:34.965346', NULL);
INSERT INTO public.games VALUES (1002, 'Texas Two Step', 140, 'unknown', 4, 0, 9, 0, NULL, 'TexasTwoStep', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:34.996225', '2025-12-11 06:17:34.996225', NULL);
INSERT INTO public.games VALUES (1003, 'Daily 4 Night', 140, 'pick4', 4, 0, 9, 0, NULL, 'Daily4Night', 'Night', '{"game_type": "pick4"}', true, '2025-12-11 06:17:35.029144', '2025-12-11 06:17:35.029144', NULL);
INSERT INTO public.games VALUES (1004, 'Daily 4 Morning', 140, 'pick4', 4, 0, 9, 0, NULL, 'Daily4Morning', 'Morning', '{"game_type": "pick4"}', true, '2025-12-11 06:17:35.047326', '2025-12-11 06:17:35.047326', NULL);
INSERT INTO public.games VALUES (1005, 'Pick 3 Day', 140, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Day', 'Day', '{"game_type": "pick3"}', true, '2025-12-11 06:17:35.067502', '2025-12-11 06:17:35.067502', NULL);
INSERT INTO public.games VALUES (1006, 'Tennessee Cash', 141, 'unknown', 4, 0, 9, 0, NULL, 'TennesseeCash', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:35.101094', '2025-12-11 06:17:35.101094', NULL);
INSERT INTO public.games VALUES (1007, 'Cash 4 Morning', 141, 'pick4', 4, 0, 9, 0, NULL, 'Cash4Morning', 'Morning', '{"game_type": "pick4"}', true, '2025-12-11 06:17:35.127467', '2025-12-11 06:17:35.127467', NULL);
INSERT INTO public.games VALUES (1008, 'Cash 3 Morning', 141, 'pick3', 3, 0, 9, 0, NULL, 'Cash3Morning', 'Morning', '{"game_type": "pick3"}', true, '2025-12-11 06:17:35.175951', '2025-12-11 06:17:35.175951', NULL);
INSERT INTO public.games VALUES (1009, 'Dakota Cash', 142, 'unknown', 4, 0, 9, 0, NULL, 'DakotaCash', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:35.221922', '2025-12-11 06:17:35.221922', NULL);
INSERT INTO public.games VALUES (1010, 'Pick 4 Midday', 143, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Midday', 'Midday', '{"game_type": "pick4"}', true, '2025-12-11 06:17:35.287708', '2025-12-11 06:17:35.287708', NULL);
INSERT INTO public.games VALUES (1011, 'Cash Pop Early Bird', 157, 'unknown', 4, 0, 9, 0, NULL, 'CashPopEarlyBird', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:35.351658', '2025-12-11 06:17:35.351658', NULL);
INSERT INTO public.games VALUES (1012, 'Pick 3 Midday', 168, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Midday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:35.427742', '2025-12-11 06:17:35.427742', NULL);
INSERT INTO public.games VALUES (1013, 'Cash Pop Late Morning', 157, 'unknown', 4, 0, 9, 0, NULL, 'CashPopLateMorning', 'Morning', '{"game_type": "pick3"}', true, '2025-12-11 06:17:35.477924', '2025-12-11 06:17:35.477924', NULL);
INSERT INTO public.games VALUES (1014, 'Cash Pop Matinee', 157, 'unknown', 4, 0, 9, 0, NULL, 'CashPopMatinee', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:35.502236', '2025-12-11 06:17:35.502236', NULL);
INSERT INTO public.games VALUES (1015, 'Cash Pop Prime Time', 157, 'unknown', 4, 0, 9, 0, NULL, 'CashPopPrimeTime', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:35.538221', '2025-12-11 06:17:35.538221', NULL);
INSERT INTO public.games VALUES (1016, 'Cash Pop Night Owl', 157, 'unknown', 4, 0, 9, 0, NULL, 'CashPopNightOwl', 'Night', '{"game_type": "pick3"}', true, '2025-12-11 06:17:35.565696', '2025-12-11 06:17:35.565696', NULL);
INSERT INTO public.games VALUES (1017, 'Pick 3 Midday', 143, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Midday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:35.597875', '2025-12-11 06:17:35.597875', NULL);
INSERT INTO public.games VALUES (1018, 'Québec Max', 145, 'unknown', 4, 0, 9, 0, NULL, 'QuébecMax', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:35.633465', '2025-12-11 06:17:35.633465', NULL);
INSERT INTO public.games VALUES (1019, 'Triplex', 145, 'unknown', 4, 0, 9, 0, NULL, 'Triplex', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:35.678631', '2025-12-11 06:17:35.678631', NULL);
INSERT INTO public.games VALUES (1020, 'Quotidienne 4', 145, 'pick4', 4, 0, 9, 0, NULL, 'Quotidienne4', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:35.703623', '2025-12-11 06:17:35.703623', NULL);
INSERT INTO public.games VALUES (1021, 'Quotidienne 2', 145, 'pick2', 2, 0, 9, 0, NULL, 'Quotidienne2', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:35.7267', '2025-12-11 06:17:35.7267', NULL);
INSERT INTO public.games VALUES (1022, 'Pega 4 Día', 146, 'pick4', 4, 0, 9, 0, NULL, 'Pega4Día', 'Día', '{"game_type": "pick3"}', true, '2025-12-11 06:17:35.788875', '2025-12-11 06:17:35.788875', NULL);
INSERT INTO public.games VALUES (1023, 'Pega 2 Día', 146, 'pick2', 2, 0, 9, 0, NULL, 'Pega2Día', 'Día', '{"game_type": "pick3"}', true, '2025-12-11 06:17:35.849935', '2025-12-11 06:17:35.849935', NULL);
INSERT INTO public.games VALUES (1024, 'Pick 5 Evening', 147, 'pick5', 5, 0, 9, 0, NULL, 'Pick5Evening', 'Evening', '{"game_type": "pick5"}', true, '2025-12-11 06:17:35.907495', '2025-12-11 06:17:35.907495', NULL);
INSERT INTO public.games VALUES (1025, 'Treasure Hunt', 147, 'unknown', 4, 0, 9, 0, NULL, 'TreasureHunt', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:35.958479', '2025-12-11 06:17:35.958479', NULL);
INSERT INTO public.games VALUES (1026, 'Pick 4 Day', 147, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Day', 'Day', '{"game_type": "pick4"}', true, '2025-12-11 06:17:36.022929', '2025-12-11 06:17:36.022929', NULL);
INSERT INTO public.games VALUES (1027, 'Pick 3 Day', 147, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Day', 'Day', '{"game_type": "pick3"}', true, '2025-12-11 06:17:36.04906', '2025-12-11 06:17:36.04906', NULL);
INSERT INTO public.games VALUES (1028, 'Megabucks', 131, 'unknown', 4, 0, 9, 0, NULL, 'Megabucks', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:36.073013', '2025-12-11 06:17:36.073013', NULL);
INSERT INTO public.games VALUES (1029, 'Daily Keno Evening', 148, 'unknown', 4, 0, 9, 0, NULL, 'DailyKenoEvening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:36.095409', '2025-12-11 06:17:36.095409', NULL);
INSERT INTO public.games VALUES (1030, 'Ontario 49', 148, 'unknown', 4, 0, 9, 0, NULL, 'Ontario49', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:36.118394', '2025-12-11 06:17:36.118394', NULL);
INSERT INTO public.games VALUES (1031, 'Early Bird', 148, 'unknown', 4, 0, 9, 0, NULL, 'EarlyBird', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:36.144741', '2025-12-11 06:17:36.144741', NULL);
INSERT INTO public.games VALUES (1032, 'Pick 4 Midday', 148, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Midday', 'Midday', '{"game_type": "pick4"}', true, '2025-12-11 06:17:36.175915', '2025-12-11 06:17:36.175915', NULL);
INSERT INTO public.games VALUES (1033, 'Pick 2 Evening', 148, 'pick2', 2, 0, 9, 0, NULL, 'Pick2Evening', 'Evening', '{"game_type": "pick2"}', true, '2025-12-11 06:17:36.202858', '2025-12-11 06:17:36.202858', NULL);
INSERT INTO public.games VALUES (1034, 'Pick 3', 149, 'pick3', 3, 0, 9, 0, NULL, 'Pick3', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:36.231681', '2025-12-11 06:17:36.231681', NULL);
INSERT INTO public.games VALUES (1035, 'Pick 5 Evening', 150, 'pick5', 5, 0, 9, 0, NULL, 'Pick5Evening', 'Evening', '{"game_type": "pick5"}', true, '2025-12-11 06:17:36.283954', '2025-12-11 06:17:36.283954', NULL);
INSERT INTO public.games VALUES (1036, 'Pick 4 Evening', 150, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:36.343572', '2025-12-11 06:17:36.343572', NULL);
INSERT INTO public.games VALUES (1037, 'Pick 3 Midday', 150, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Midday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:36.384172', '2025-12-11 06:17:36.384172', NULL);
INSERT INTO public.games VALUES (1038, 'Pick 4 Evening', 151, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:36.433296', '2025-12-11 06:17:36.433296', NULL);
INSERT INTO public.games VALUES (1039, 'Pick 3 Evening', 151, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:36.546939', '2025-12-11 06:17:36.546939', NULL);
INSERT INTO public.games VALUES (1040, 'Lotto', 152, 'unknown', 4, 0, 9, 0, NULL, 'Lotto', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:36.578894', '2025-12-11 06:17:36.578894', NULL);
INSERT INTO public.games VALUES (1041, 'Win 4 Evening', 152, 'pick4', 4, 0, 9, 0, NULL, 'Win4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:36.616848', '2025-12-11 06:17:36.616848', NULL);
INSERT INTO public.games VALUES (1042, 'Numbers Evening', 152, 'pick3', 3, 0, 9, 0, NULL, 'NumbersEvening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:36.64609', '2025-12-11 06:17:36.64609', NULL);
INSERT INTO public.games VALUES (1043, 'Pick 3 Evening', 153, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:36.665675', '2025-12-11 06:17:36.665675', NULL);
INSERT INTO public.games VALUES (1044, 'Pick 4 Evening', 154, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:36.695621', '2025-12-11 06:17:36.695621', NULL);
INSERT INTO public.games VALUES (1045, 'Pick 3 Evening', 154, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:36.725424', '2025-12-11 06:17:36.725424', NULL);
INSERT INTO public.games VALUES (1046, 'Pick 3', 155, 'pick3', 3, 0, 9, 0, NULL, 'Pick3', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:36.747744', '2025-12-11 06:17:36.747744', NULL);
INSERT INTO public.games VALUES (1047, 'Lotto', 157, 'unknown', 4, 0, 9, 0, NULL, 'Lotto', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:36.78788', '2025-12-11 06:17:36.78788', NULL);
INSERT INTO public.games VALUES (1048, 'Pick 4 Evening', 157, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:36.85099', '2025-12-11 06:17:36.85099', NULL);
INSERT INTO public.games VALUES (1049, 'Pick 3 Midday', 157, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Midday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:36.881788', '2025-12-11 06:17:36.881788', NULL);
INSERT INTO public.games VALUES (1050, 'Gopher 5', 158, 'unknown', 4, 0, 9, 0, NULL, 'Gopher5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:36.918011', '2025-12-11 06:17:36.918011', NULL);
INSERT INTO public.games VALUES (1051, 'Lotto 47', 159, 'unknown', 4, 0, 9, 0, NULL, 'Lotto47', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:36.954747', '2025-12-11 06:17:36.954747', NULL);
INSERT INTO public.games VALUES (1052, 'Daily 4 Evening', 159, 'pick4', 4, 0, 9, 0, NULL, 'Daily4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:36.993191', '2025-12-11 06:17:36.993191', NULL);
INSERT INTO public.games VALUES (1053, 'Daily 3 Midday', 159, 'pick3', 3, 0, 9, 0, NULL, 'Daily3Midday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:37.044608', '2025-12-11 06:17:37.044608', NULL);
INSERT INTO public.games VALUES (1054, 'Mass Cash', 160, 'unknown', 4, 0, 9, 0, NULL, 'MassCash', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:37.175259', '2025-12-11 06:17:37.175259', NULL);
INSERT INTO public.games VALUES (1055, 'Multi-Match', 161, 'unknown', 4, 0, 9, 0, NULL, 'MultiMatch', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:37.208302', '2025-12-11 06:17:37.208302', NULL);
INSERT INTO public.games VALUES (1056, 'Pick 4 Evening', 161, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:37.242184', '2025-12-11 06:17:37.242184', NULL);
INSERT INTO public.games VALUES (1057, 'Tri-State Megabucks Plus', 126, 'unknown', 4, 0, 9, 0, NULL, 'MegabucksPlus', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:37.269193', '2025-12-11 06:17:37.269193', NULL);
INSERT INTO public.games VALUES (1058, 'Pick 3 Evening', 163, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:37.285396', '2025-12-11 06:17:37.285396', NULL);
INSERT INTO public.games VALUES (1059, 'Super Kansas Cash', 164, 'unknown', 4, 0, 9, 0, NULL, 'SuperKansasCash', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:37.318335', '2025-12-11 06:17:37.318335', NULL);
INSERT INTO public.games VALUES (1060, 'SuperEnalotto', 165, 'unknown', 4, 0, 9, 0, NULL, 'SuperEnalotto', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:37.344965', '2025-12-11 06:17:37.344965', NULL);
INSERT INTO public.games VALUES (1061, 'Lotto', 166, 'unknown', 4, 0, 9, 0, NULL, 'Lotto', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:37.399111', '2025-12-11 06:17:37.399111', NULL);
INSERT INTO public.games VALUES (1062, 'Daily Million 9pm', 166, 'unknown', 4, 0, 9, 0, NULL, 'DailyMillion9pm', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:37.441294', '2025-12-11 06:17:37.441294', NULL);
INSERT INTO public.games VALUES (1063, 'Quick Draw Midday', 169, 'unknown', 4, 0, 9, 0, NULL, 'QuickDrawMidday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:37.470746', '2025-12-11 06:17:37.470746', NULL);
INSERT INTO public.games VALUES (1064, 'Powerball', 146, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:37.496138', '2025-12-11 06:17:37.496138', NULL);
INSERT INTO public.games VALUES (1065, 'Daily 4 Evening', 169, 'pick4', 4, 0, 9, 0, NULL, 'Daily4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:37.533306', '2025-12-11 06:17:37.533306', NULL);
INSERT INTO public.games VALUES (1066, 'Daily 4 Midday', 169, 'pick4', 4, 0, 9, 0, NULL, 'Daily4Midday', 'Midday', '{"game_type": "pick4"}', true, '2025-12-11 06:17:37.566175', '2025-12-11 06:17:37.566175', NULL);
INSERT INTO public.games VALUES (1067, 'Pick 4 Midday', 170, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Midday', 'Midday', '{"game_type": "pick4"}', true, '2025-12-11 06:17:37.598497', '2025-12-11 06:17:37.598497', NULL);
INSERT INTO public.games VALUES (1068, 'Pick 3 Midday', 170, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Midday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:37.647725', '2025-12-11 06:17:37.647725', NULL);
INSERT INTO public.games VALUES (1069, 'Weekly Grand', 171, 'unknown', 4, 0, 9, 0, NULL, 'WeeklyGrand', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:37.685155', '2025-12-11 06:17:37.685155', NULL);
INSERT INTO public.games VALUES (1070, '2by2', 126, 'unknown', 4, 0, 9, 0, NULL, '2by2', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:37.742259', '2025-12-11 06:17:37.742259', NULL);
INSERT INTO public.games VALUES (1071, 'Toto Auswahlwette', 172, 'unknown', 4, 0, 9, 0, NULL, 'TotoAuswahlwette', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:37.839762', '2025-12-11 06:17:37.839762', NULL);
INSERT INTO public.games VALUES (1072, 'Plus 5', 172, 'pick5', 5, 0, 9, 0, NULL, 'Plus5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:37.886556', '2025-12-11 06:17:37.886556', NULL);
INSERT INTO public.games VALUES (1073, 'Fantasy 5', 127, 'unknown', 4, 0, 9, 0, NULL, 'Fantasy5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:37.938533', '2025-12-11 06:17:37.938533', NULL);
INSERT INTO public.games VALUES (1074, 'Cash 5', 120, 'unknown', 4, 0, 9, 0, NULL, 'Cash5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:37.957496', '2025-12-11 06:17:37.957496', NULL);
INSERT INTO public.games VALUES (1075, 'Cash Pop Night Owl', 127, 'unknown', 4, 0, 9, 0, NULL, 'CashPopNightOwl', 'Night', '{"game_type": "pick3"}', true, '2025-12-11 06:17:37.973104', '2025-12-11 06:17:37.973104', NULL);
INSERT INTO public.games VALUES (1076, 'Cash Pop Matinee', 127, 'unknown', 4, 0, 9, 0, NULL, 'CashPopMatinee', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:37.996008', '2025-12-11 06:17:37.996008', NULL);
INSERT INTO public.games VALUES (1077, 'Pick 4 Evening', 153, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:38.025248', '2025-12-11 06:17:38.025248', NULL);
INSERT INTO public.games VALUES (1078, 'Pick 3 Day', 153, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Day', 'Day', '{"game_type": "pick3"}', true, '2025-12-11 06:17:38.045275', '2025-12-11 06:17:38.045275', NULL);
INSERT INTO public.games VALUES (1079, 'Pick 3 Midday', 164, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Midday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:38.076616', '2025-12-11 06:17:38.076616', NULL);
INSERT INTO public.games VALUES (1080, 'MillionDay', 165, 'unknown', 4, 0, 9, 0, NULL, 'MillionDay', 'Day', '{"game_type": "pick3"}', true, '2025-12-11 06:17:38.10559', '2025-12-11 06:17:38.10559', NULL);
INSERT INTO public.games VALUES (1081, 'VinciCasa', 165, 'unknown', 4, 0, 9, 0, NULL, 'VinciCasa', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:38.145416', '2025-12-11 06:17:38.145416', NULL);
INSERT INTO public.games VALUES (1082, 'Daily Million Plus 2pm', 166, 'unknown', 4, 0, 9, 0, NULL, 'DailyMillionPlus2pm', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:38.179567', '2025-12-11 06:17:38.179567', NULL);
INSERT INTO public.games VALUES (1083, 'Daily Million 2pm', 166, 'unknown', 4, 0, 9, 0, NULL, 'DailyMillion2pm', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:38.219159', '2025-12-11 06:17:38.219159', NULL);
INSERT INTO public.games VALUES (1084, 'Idaho Cash', 171, 'unknown', 4, 0, 9, 0, NULL, 'IdahoCash', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:38.250805', '2025-12-11 06:17:38.250805', NULL);
INSERT INTO public.games VALUES (1085, '5 Star Draw', 171, 'unknown', 4, 0, 9, 0, NULL, '5StarDraw', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:38.285695', '2025-12-11 06:17:38.285695', NULL);
INSERT INTO public.games VALUES (1086, 'Pick 4 Night', 171, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Night', 'Night', '{"game_type": "pick4"}', true, '2025-12-11 06:17:38.312535', '2025-12-11 06:17:38.312535', NULL);
INSERT INTO public.games VALUES (1087, 'Pick 4 Day', 171, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Day', 'Day', '{"game_type": "pick4"}', true, '2025-12-11 06:17:38.348862', '2025-12-11 06:17:38.348862', NULL);
INSERT INTO public.games VALUES (1088, 'Take 5 Evening', 152, 'unknown', 4, 0, 9, 0, NULL, 'Take5Evening', 'Evening', '{"game_type": "pick5"}', true, '2025-12-11 06:17:38.379458', '2025-12-11 06:17:38.379458', NULL);
INSERT INTO public.games VALUES (1089, 'Pick 5', 162, 'pick5', 5, 0, 9, 0, NULL, 'Pick5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:38.424548', '2025-12-11 06:17:38.424548', NULL);
INSERT INTO public.games VALUES (1090, 'Powerball Double Play', 126, 'unknown', 4, 0, 9, 0, NULL, 'PowerballDoublePlay', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:38.52879', '2025-12-11 06:17:38.52879', NULL);
INSERT INTO public.games VALUES (1091, 'Cash Pop Matinée', 128, 'unknown', 4, 0, 9, 0, NULL, 'CashPopMatinée', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:38.682165', '2025-12-11 06:17:38.682165', NULL);
INSERT INTO public.games VALUES (1092, 'Cash Pop Evening', 128, 'unknown', 4, 0, 9, 0, NULL, 'CashPopEvening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:38.736259', '2025-12-11 06:17:38.736259', NULL);
INSERT INTO public.games VALUES (1093, 'Cash Pop Afternoon', 128, 'unknown', 4, 0, 9, 0, NULL, 'CashPopAfternoon', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:38.770818', '2025-12-11 06:17:38.770818', NULL);
INSERT INTO public.games VALUES (1094, 'Cash Pop Late Night', 128, 'unknown', 4, 0, 9, 0, NULL, 'CashPopLateNight', 'Night', '{"game_type": "pick3"}', true, '2025-12-11 06:17:38.802981', '2025-12-11 06:17:38.802981', NULL);
INSERT INTO public.games VALUES (1095, 'Cash Pop Morning', 128, 'unknown', 4, 0, 9, 0, NULL, 'CashPopMorning', 'Morning', '{"game_type": "pick3"}', true, '2025-12-11 06:17:38.832591', '2025-12-11 06:17:38.832591', NULL);
INSERT INTO public.games VALUES (1096, 'Tri-State Pick 3 Evening', 174, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:38.859801', '2025-12-11 06:17:38.859801', NULL);
INSERT INTO public.games VALUES (1097, 'Tri-State Pick 3 Day', 174, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Day', 'Day', '{"game_type": "pick3"}', true, '2025-12-11 06:17:38.886213', '2025-12-11 06:17:38.886213', NULL);
INSERT INTO public.games VALUES (1098, 'Daily Derby', 121, 'unknown', 4, 0, 9, 0, NULL, 'DailyDerby', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:38.934749', '2025-12-11 06:17:38.934749', NULL);
INSERT INTO public.games VALUES (1099, 'Cash 4', 173, 'pick4', 4, 0, 9, 0, NULL, 'Cash4', '', '{"game_type": "pick4"}', true, '2025-12-11 06:17:38.949884', '2025-12-11 06:17:38.949884', NULL);
INSERT INTO public.games VALUES (1100, 'Cash Pop Matinee', 128, 'unknown', 4, 0, 9, 0, NULL, 'CashPopMatinee', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:38.975076', '2025-12-11 06:17:38.975076', NULL);
INSERT INTO public.games VALUES (1101, 'Cash Pop Evening', 143, 'unknown', 4, 0, 9, 0, NULL, 'CashPopEvening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:39.004976', '2025-12-11 06:17:39.004976', NULL);
INSERT INTO public.games VALUES (1102, 'Cash Pop Midday', 143, 'unknown', 4, 0, 9, 0, NULL, 'CashPopMidday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:39.044001', '2025-12-11 06:17:39.044001', NULL);
INSERT INTO public.games VALUES (1103, 'Cash Pop After Hours', 138, 'unknown', 4, 0, 9, 0, NULL, 'CashPopAfterHours', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:39.103578', '2025-12-11 06:17:39.103578', NULL);
INSERT INTO public.games VALUES (1104, 'Cash Pop Prime Time', 138, 'unknown', 4, 0, 9, 0, NULL, 'CashPopPrimeTime', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:39.138265', '2025-12-11 06:17:39.138265', NULL);
INSERT INTO public.games VALUES (1105, 'Cash Pop Rush Hour', 138, 'unknown', 4, 0, 9, 0, NULL, 'CashPopRushHour', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:39.173752', '2025-12-11 06:17:39.173752', NULL);
INSERT INTO public.games VALUES (1106, 'Cash Pop Lunch Break', 138, 'unknown', 4, 0, 9, 0, NULL, 'CashPopLunchBreak', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:39.199768', '2025-12-11 06:17:39.199768', NULL);
INSERT INTO public.games VALUES (1107, 'Cash Pop Coffee Break', 138, 'unknown', 4, 0, 9, 0, NULL, 'CashPopCoffeeBreak', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:39.232679', '2025-12-11 06:17:39.232679', NULL);
INSERT INTO public.games VALUES (1108, 'Pick 5 Evening', 161, 'pick5', 5, 0, 9, 0, NULL, 'Pick5Evening', 'Evening', '{"game_type": "pick5"}', true, '2025-12-11 06:17:39.290456', '2025-12-11 06:17:39.290456', NULL);
INSERT INTO public.games VALUES (1109, 'Astro', 145, 'unknown', 4, 0, 9, 0, NULL, 'Astro', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:39.317234', '2025-12-11 06:17:39.317234', NULL);
INSERT INTO public.games VALUES (1110, 'Canada Lotto 6/49', 145, 'unknown', 4, 0, 9, 0, NULL, 'CanadaLotto6/49', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:39.334444', '2025-12-11 06:17:39.334444', NULL);
INSERT INTO public.games VALUES (1111, 'Daily Grand', 145, 'unknown', 4, 0, 9, 0, NULL, 'DailyGrand', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:39.363114', '2025-12-11 06:17:39.363114', NULL);
INSERT INTO public.games VALUES (1112, 'Extra', 145, 'unknown', 4, 0, 9, 0, NULL, 'Extra', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:39.388467', '2025-12-11 06:17:39.388467', NULL);
INSERT INTO public.games VALUES (1113, 'Lotto 6/49 Guaranteed Prize Draw', 145, 'unknown', 4, 0, 9, 0, NULL, 'Lotto6/49GuaranteedPrizeDraw', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:39.426216', '2025-12-11 06:17:39.426216', NULL);
INSERT INTO public.games VALUES (1114, 'Lotto :D', 145, 'unknown', 4, 0, 9, 0, NULL, 'Lotto:D', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:39.45825', '2025-12-11 06:17:39.45825', NULL);
INSERT INTO public.games VALUES (1115, 'Lotto Max', 145, 'unknown', 4, 0, 9, 0, NULL, 'LottoMax', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:39.493241', '2025-12-11 06:17:39.493241', NULL);
INSERT INTO public.games VALUES (1116, 'Lotto Poker', 145, 'unknown', 4, 0, 9, 0, NULL, 'LottoPoker', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:39.525222', '2025-12-11 06:17:39.525222', NULL);
INSERT INTO public.games VALUES (1117, 'Canada Lotto 6/49', 148, 'unknown', 4, 0, 9, 0, NULL, 'CanadaLotto6/49', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:39.55347', '2025-12-11 06:17:39.55347', NULL);
INSERT INTO public.games VALUES (1118, 'Daily Grand', 148, 'unknown', 4, 0, 9, 0, NULL, 'DailyGrand', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:39.595227', '2025-12-11 06:17:39.595227', NULL);
INSERT INTO public.games VALUES (1119, 'Encore Evening', 148, 'unknown', 4, 0, 9, 0, NULL, 'EncoreEvening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:39.62292', '2025-12-11 06:17:39.62292', NULL);
INSERT INTO public.games VALUES (1120, 'Encore Midday', 148, 'unknown', 4, 0, 9, 0, NULL, 'EncoreMidday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:39.671657', '2025-12-11 06:17:39.671657', NULL);
INSERT INTO public.games VALUES (1121, 'Lotto 6/49 Guaranteed Prize Draw', 148, 'unknown', 4, 0, 9, 0, NULL, 'Lotto6/49GuaranteedPrizeDraw', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:39.749819', '2025-12-11 06:17:39.749819', NULL);
INSERT INTO public.games VALUES (1122, 'Lotto Max', 148, 'unknown', 4, 0, 9, 0, NULL, 'LottoMax', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:39.79687', '2025-12-11 06:17:39.79687', NULL);
INSERT INTO public.games VALUES (1123, 'Poker Lotto', 148, 'unknown', 4, 0, 9, 0, NULL, 'PokerLotto', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:39.84375', '2025-12-11 06:17:39.84375', NULL);
INSERT INTO public.games VALUES (1124, 'Wheel of Fortune Lotto', 148, 'unknown', 4, 0, 9, 0, NULL, 'WheelofFortuneLotto', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:39.884813', '2025-12-11 06:17:39.884813', NULL);
INSERT INTO public.games VALUES (1125, 'Canada Lotto 6/49', 122, 'unknown', 4, 0, 9, 0, NULL, 'CanadaLotto6/49', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:39.935733', '2025-12-11 06:17:39.935733', NULL);
INSERT INTO public.games VALUES (1126, 'Daily Grand', 122, 'unknown', 4, 0, 9, 0, NULL, 'DailyGrand', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:39.975626', '2025-12-11 06:17:39.975626', NULL);
INSERT INTO public.games VALUES (1127, 'Lotto Max', 122, 'unknown', 4, 0, 9, 0, NULL, 'LottoMax', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:40.024063', '2025-12-11 06:17:40.024063', NULL);
INSERT INTO public.games VALUES (1128, 'Poker Lotto', 122, 'unknown', 4, 0, 9, 0, NULL, 'PokerLotto', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:40.069109', '2025-12-11 06:17:40.069109', NULL);
INSERT INTO public.games VALUES (1129, 'Canada Lotto 6/49', 134, 'unknown', 4, 0, 9, 0, NULL, 'CanadaLotto6/49', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:40.141173', '2025-12-11 06:17:40.141173', NULL);
INSERT INTO public.games VALUES (1130, 'Daily Grand', 134, 'unknown', 4, 0, 9, 0, NULL, 'DailyGrand', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:40.196865', '2025-12-11 06:17:40.196865', NULL);
INSERT INTO public.games VALUES (1131, 'Lotto 6/49 Guaranteed Prize Draw', 134, 'unknown', 4, 0, 9, 0, NULL, 'Lotto6/49GuaranteedPrizeDraw', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:40.234011', '2025-12-11 06:17:40.234011', NULL);
INSERT INTO public.games VALUES (1132, 'Lotto Max', 134, 'unknown', 4, 0, 9, 0, NULL, 'LottoMax', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:40.275967', '2025-12-11 06:17:40.275967', NULL);
INSERT INTO public.games VALUES (1133, 'Poker Lotto', 134, 'unknown', 4, 0, 9, 0, NULL, 'PokerLotto', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:40.309994', '2025-12-11 06:17:40.309994', NULL);
INSERT INTO public.games VALUES (1134, 'Atlantic 49 Guaranteed Prize Draw', 123, 'unknown', 4, 0, 9, 0, NULL, 'Atlantic49GuaranteedPrizeDraw', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:40.35137', '2025-12-11 06:17:40.35137', NULL);
INSERT INTO public.games VALUES (1135, 'Canada Lotto 6/49', 123, 'unknown', 4, 0, 9, 0, NULL, 'CanadaLotto6/49', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:40.373628', '2025-12-11 06:17:40.373628', NULL);
INSERT INTO public.games VALUES (1136, 'Daily Grand', 123, 'unknown', 4, 0, 9, 0, NULL, 'DailyGrand', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:40.397484', '2025-12-11 06:17:40.397484', NULL);
INSERT INTO public.games VALUES (1137, 'Lotto 6/49 Guaranteed Prize Draw', 123, 'unknown', 4, 0, 9, 0, NULL, 'Lotto6/49GuaranteedPrizeDraw', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:40.418171', '2025-12-11 06:17:40.418171', NULL);
INSERT INTO public.games VALUES (1138, 'Lotto Max', 123, 'unknown', 4, 0, 9, 0, NULL, 'LottoMax', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:40.438842', '2025-12-11 06:17:40.438842', NULL);
INSERT INTO public.games VALUES (1139, 'Poker Lotto', 123, 'unknown', 4, 0, 9, 0, NULL, 'PokerLotto', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:40.47561', '2025-12-11 06:17:40.47561', NULL);
INSERT INTO public.games VALUES (1140, 'Salsa Bingo', 123, 'unknown', 4, 0, 9, 0, NULL, 'SalsaBingo', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:40.508249', '2025-12-11 06:17:40.508249', NULL);
INSERT INTO public.games VALUES (1141, 'Mega Millions', 119, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:40.539539', '2025-12-11 06:17:40.539539', NULL);
INSERT INTO public.games VALUES (1142, 'Powerball', 119, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:40.581938', '2025-12-11 06:17:40.581938', NULL);
INSERT INTO public.games VALUES (1143, 'Cash4Life', 161, 'unknown', 4, 0, 9, 0, NULL, 'Cash4Life', '', '{"game_type": "pick4"}', true, '2025-12-11 06:17:40.622564', '2025-12-11 06:17:40.622564', NULL);
INSERT INTO public.games VALUES (1144, 'Mega Millions', 161, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:40.654123', '2025-12-11 06:17:40.654123', NULL);
INSERT INTO public.games VALUES (1145, 'Powerball', 161, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:40.742071', '2025-12-11 06:17:40.742071', NULL);
INSERT INTO public.games VALUES (1146, 'Powerball Double Play', 161, 'unknown', 4, 0, 9, 0, NULL, 'PowerballDoublePlay', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:40.80586', '2025-12-11 06:17:40.80586', NULL);
INSERT INTO public.games VALUES (1147, 'Lucky for Life', 150, 'unknown', 4, 0, 9, 0, NULL, 'LuckyforLife', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:40.83923', '2025-12-11 06:17:40.83923', NULL);
INSERT INTO public.games VALUES (1148, 'Mega Millions', 150, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:40.871708', '2025-12-11 06:17:40.871708', NULL);
INSERT INTO public.games VALUES (1149, 'Powerball', 150, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:40.920769', '2025-12-11 06:17:40.920769', NULL);
INSERT INTO public.games VALUES (1150, 'Lucky for Life', 160, 'unknown', 4, 0, 9, 0, NULL, 'LuckyforLife', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:40.942656', '2025-12-11 06:17:40.942656', NULL);
INSERT INTO public.games VALUES (1151, 'Mega Millions', 160, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:40.968963', '2025-12-11 06:17:40.968963', NULL);
INSERT INTO public.games VALUES (1152, 'Powerball', 160, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:41.00369', '2025-12-11 06:17:41.00369', NULL);
INSERT INTO public.games VALUES (1153, 'Cash4Life', 127, 'unknown', 4, 0, 9, 0, NULL, 'Cash4Life', '', '{"game_type": "pick4"}', true, '2025-12-11 06:17:41.045474', '2025-12-11 06:17:41.045474', NULL);
INSERT INTO public.games VALUES (1154, 'Mega Millions', 127, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:41.110832', '2025-12-11 06:17:41.110832', NULL);
INSERT INTO public.games VALUES (1155, 'Powerball', 127, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:41.172848', '2025-12-11 06:17:41.172848', NULL);
INSERT INTO public.games VALUES (1156, 'Lucky Lines', 131, 'unknown', 4, 0, 9, 0, NULL, 'LuckyLines', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:41.22362', '2025-12-11 06:17:41.22362', NULL);
INSERT INTO public.games VALUES (1157, 'Mega Millions', 131, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:41.267118', '2025-12-11 06:17:41.267118', NULL);
INSERT INTO public.games VALUES (1158, 'Powerball', 131, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:41.289934', '2025-12-11 06:17:41.289934', NULL);
INSERT INTO public.games VALUES (1159, '2by2', 155, 'unknown', 4, 0, 9, 0, NULL, '2by2', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:41.329742', '2025-12-11 06:17:41.329742', NULL);
INSERT INTO public.games VALUES (1160, 'Lucky for Life', 155, 'unknown', 4, 0, 9, 0, NULL, 'LuckyforLife', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:41.364374', '2025-12-11 06:17:41.364374', NULL);
INSERT INTO public.games VALUES (1161, 'Mega Millions', 155, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:41.400741', '2025-12-11 06:17:41.400741', NULL);
INSERT INTO public.games VALUES (1162, 'Mega Millions', 121, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:41.443231', '2025-12-11 06:17:41.443231', NULL);
INSERT INTO public.games VALUES (1163, 'Powerball', 121, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:41.502247', '2025-12-11 06:17:41.502247', NULL);
INSERT INTO public.games VALUES (1164, 'Gimme 5', 174, 'unknown', 4, 0, 9, 0, NULL, 'Gimme5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:41.535467', '2025-12-11 06:17:41.535467', NULL);
INSERT INTO public.games VALUES (1165, 'Mega Millions', 174, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:41.560111', '2025-12-11 06:17:41.560111', NULL);
INSERT INTO public.games VALUES (1166, 'Powerball', 174, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:41.594532', '2025-12-11 06:17:41.594532', NULL);
INSERT INTO public.games VALUES (1167, 'Tri-State Megabucks Plus', 174, 'unknown', 4, 0, 9, 0, NULL, 'MegabucksPlus', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:41.628529', '2025-12-11 06:17:41.628529', NULL);
INSERT INTO public.games VALUES (1168, 'Mega Millions', 133, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:41.677151', '2025-12-11 06:17:41.677151', NULL);
INSERT INTO public.games VALUES (1169, 'Powerball', 133, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:41.701086', '2025-12-11 06:17:41.701086', NULL);
INSERT INTO public.games VALUES (1170, 'Mega Millions', 162, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:41.732818', '2025-12-11 06:17:41.732818', NULL);
INSERT INTO public.games VALUES (1171, 'Powerball', 162, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:41.777963', '2025-12-11 06:17:41.777963', NULL);
INSERT INTO public.games VALUES (1172, 'Mega Millions', 137, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:41.804314', '2025-12-11 06:17:41.804314', NULL);
INSERT INTO public.games VALUES (1173, 'Powerball', 137, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:41.835572', '2025-12-11 06:17:41.835572', NULL);
INSERT INTO public.games VALUES (1174, 'Tri-State Pick 4 Evening', 174, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:41.86469', '2025-12-11 06:17:41.86469', NULL);
INSERT INTO public.games VALUES (1175, 'Tri-State Pick 4 Day', 174, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Day', 'Day', '{"game_type": "pick4"}', true, '2025-12-11 06:17:41.944574', '2025-12-11 06:17:41.944574', NULL);
INSERT INTO public.games VALUES (1176, 'Tri-State Pick 4 Evening', 175, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:41.971485', '2025-12-11 06:17:41.971485', NULL);
INSERT INTO public.games VALUES (1177, 'Mega Millions', 130, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:42.003771', '2025-12-11 06:17:42.003771', NULL);
INSERT INTO public.games VALUES (1178, 'Powerball Double Play', 137, 'unknown', 4, 0, 9, 0, NULL, 'PowerballDoublePlay', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:42.04894', '2025-12-11 06:17:42.04894', NULL);
INSERT INTO public.games VALUES (1179, 'Cash4Life', 157, 'unknown', 4, 0, 9, 0, NULL, 'Cash4Life', '', '{"game_type": "pick4"}', true, '2025-12-11 06:17:42.090464', '2025-12-11 06:17:42.090464', NULL);
INSERT INTO public.games VALUES (1180, 'Mega Millions', 157, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:42.144059', '2025-12-11 06:17:42.144059', NULL);
INSERT INTO public.games VALUES (1181, 'Powerball', 157, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:42.19141', '2025-12-11 06:17:42.19141', NULL);
INSERT INTO public.games VALUES (1182, 'Lotto America', 158, 'unknown', 4, 0, 9, 0, NULL, 'LottoAmerica', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:42.247', '2025-12-11 06:17:42.247', NULL);
INSERT INTO public.games VALUES (1183, 'Mega Millions', 158, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:42.290887', '2025-12-11 06:17:42.290887', NULL);
INSERT INTO public.games VALUES (1184, 'Powerball', 158, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:42.334728', '2025-12-11 06:17:42.334728', NULL);
INSERT INTO public.games VALUES (1185, 'Cash4Life', 152, 'unknown', 4, 0, 9, 0, NULL, 'Cash4Life', '', '{"game_type": "pick4"}', true, '2025-12-11 06:17:42.36441', '2025-12-11 06:17:42.36441', NULL);
INSERT INTO public.games VALUES (1186, 'Mega Millions', 152, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:42.399785', '2025-12-11 06:17:42.399785', NULL);
INSERT INTO public.games VALUES (1187, 'Powerball', 152, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:42.437027', '2025-12-11 06:17:42.437027', NULL);
INSERT INTO public.games VALUES (1188, 'Gimme 5', 175, 'unknown', 4, 0, 9, 0, NULL, 'Gimme5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:42.467757', '2025-12-11 06:17:42.467757', NULL);
INSERT INTO public.games VALUES (1189, 'Lotto America', 175, 'unknown', 4, 0, 9, 0, NULL, 'LottoAmerica', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:42.500087', '2025-12-11 06:17:42.500087', NULL);
INSERT INTO public.games VALUES (1190, 'Lucky for Life', 175, 'unknown', 4, 0, 9, 0, NULL, 'LuckyforLife', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:42.539448', '2025-12-11 06:17:42.539448', NULL);
INSERT INTO public.games VALUES (1191, 'Mega Millions', 175, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:42.600483', '2025-12-11 06:17:42.600483', NULL);
INSERT INTO public.games VALUES (1192, 'Powerball', 175, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:42.727809', '2025-12-11 06:17:42.727809', NULL);
INSERT INTO public.games VALUES (1193, 'Tri-State Megabucks Plus', 175, 'unknown', 4, 0, 9, 0, NULL, 'MegabucksPlus', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:42.76948', '2025-12-11 06:17:42.76948', NULL);
INSERT INTO public.games VALUES (1194, 'World Poker Tour', 175, 'unknown', 4, 0, 9, 0, NULL, 'WorldPokerTour', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:42.797526', '2025-12-11 06:17:42.797526', NULL);
INSERT INTO public.games VALUES (1195, 'Lotto America', 168, 'unknown', 4, 0, 9, 0, NULL, 'LottoAmerica', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:42.834291', '2025-12-11 06:17:42.834291', NULL);
INSERT INTO public.games VALUES (1196, 'Lucky for Life', 168, 'unknown', 4, 0, 9, 0, NULL, 'LuckyforLife', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:42.853118', '2025-12-11 06:17:42.853118', NULL);
INSERT INTO public.games VALUES (1197, 'Mega Millions', 168, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:42.87786', '2025-12-11 06:17:42.87786', NULL);
INSERT INTO public.games VALUES (1198, 'Powerball', 168, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:42.900821', '2025-12-11 06:17:42.900821', NULL);
INSERT INTO public.games VALUES (1199, 'Mega Millions', 170, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:42.929934', '2025-12-11 06:17:42.929934', NULL);
INSERT INTO public.games VALUES (1200, 'Powerball', 170, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:42.964368', '2025-12-11 06:17:42.964368', NULL);
INSERT INTO public.games VALUES (1201, 'Mega Millions', 173, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.004301', '2025-12-11 06:17:43.004301', NULL);
INSERT INTO public.games VALUES (1202, 'Powerball', 173, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.085161', '2025-12-11 06:17:43.085161', NULL);
INSERT INTO public.games VALUES (1203, 'Lucky for Life', 136, 'unknown', 4, 0, 9, 0, NULL, 'LuckyforLife', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.125814', '2025-12-11 06:17:43.125814', NULL);
INSERT INTO public.games VALUES (1204, 'Mega Millions', 136, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.143797', '2025-12-11 06:17:43.143797', NULL);
INSERT INTO public.games VALUES (1205, 'Powerball', 136, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.177601', '2025-12-11 06:17:43.177601', NULL);
INSERT INTO public.games VALUES (1206, 'Lucky for Life', 151, 'unknown', 4, 0, 9, 0, NULL, 'LuckyforLife', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.194374', '2025-12-11 06:17:43.194374', NULL);
INSERT INTO public.games VALUES (1207, 'Mega Millions', 151, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.210404', '2025-12-11 06:17:43.210404', NULL);
INSERT INTO public.games VALUES (1208, 'Powerball', 151, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.236677', '2025-12-11 06:17:43.236677', NULL);
INSERT INTO public.games VALUES (1209, 'Cash4Life', 154, 'unknown', 4, 0, 9, 0, NULL, 'Cash4Life', '', '{"game_type": "pick4"}', true, '2025-12-11 06:17:43.273624', '2025-12-11 06:17:43.273624', NULL);
INSERT INTO public.games VALUES (1210, 'Mega Millions', 154, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.29444', '2025-12-11 06:17:43.29444', NULL);
INSERT INTO public.games VALUES (1211, 'Powerball', 154, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.31764', '2025-12-11 06:17:43.31764', NULL);
INSERT INTO public.games VALUES (1212, 'Lucky for Life', 142, 'unknown', 4, 0, 9, 0, NULL, 'LuckyforLife', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.344645', '2025-12-11 06:17:43.344645', NULL);
INSERT INTO public.games VALUES (1213, 'Mega Millions', 142, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.368003', '2025-12-11 06:17:43.368003', NULL);
INSERT INTO public.games VALUES (1214, 'Powerball', 142, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.392862', '2025-12-11 06:17:43.392862', NULL);
INSERT INTO public.games VALUES (1215, 'Powerball Double Play', 142, 'unknown', 4, 0, 9, 0, NULL, 'PowerballDoublePlay', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.414495', '2025-12-11 06:17:43.414495', NULL);
INSERT INTO public.games VALUES (1216, 'Lucky for Life', 125, 'unknown', 4, 0, 9, 0, NULL, 'LuckyforLife', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.446321', '2025-12-11 06:17:43.446321', NULL);
INSERT INTO public.games VALUES (1217, 'Mega Millions', 125, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.475525', '2025-12-11 06:17:43.475525', NULL);
INSERT INTO public.games VALUES (1218, 'Powerball', 125, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.496684', '2025-12-11 06:17:43.496684', NULL);
INSERT INTO public.games VALUES (1219, 'Mega Millions', 140, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.523554', '2025-12-11 06:17:43.523554', NULL);
INSERT INTO public.games VALUES (1220, 'Powerball', 140, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.551815', '2025-12-11 06:17:43.551815', NULL);
INSERT INTO public.games VALUES (1221, '2by2', 171, 'unknown', 4, 0, 9, 0, NULL, '2by2', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.580972', '2025-12-11 06:17:43.580972', NULL);
INSERT INTO public.games VALUES (1222, 'Lotto America', 171, 'unknown', 4, 0, 9, 0, NULL, 'LottoAmerica', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:43.60852', '2025-12-11 06:17:43.60852', NULL);
INSERT INTO public.games VALUES (1223, 'Lucky for Life', 171, 'unknown', 4, 0, 9, 0, NULL, 'LuckyforLife', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.630867', '2025-12-11 06:17:43.630867', NULL);
INSERT INTO public.games VALUES (1224, 'Mega Millions', 171, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.657045', '2025-12-11 06:17:43.657045', NULL);
INSERT INTO public.games VALUES (1225, 'Powerball', 171, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.682524', '2025-12-11 06:17:43.682524', NULL);
INSERT INTO public.games VALUES (1226, 'Cash4Life', 169, 'unknown', 4, 0, 9, 0, NULL, 'Cash4Life', '', '{"game_type": "pick4"}', true, '2025-12-11 06:17:43.709674', '2025-12-11 06:17:43.709674', NULL);
INSERT INTO public.games VALUES (1227, 'Mega Millions', 169, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.732016', '2025-12-11 06:17:43.732016', NULL);
INSERT INTO public.games VALUES (1228, 'Powerball', 169, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.768247', '2025-12-11 06:17:43.768247', NULL);
INSERT INTO public.games VALUES (1229, 'Powerball Double Play', 169, 'unknown', 4, 0, 9, 0, NULL, 'PowerballDoublePlay', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.805882', '2025-12-11 06:17:43.805882', NULL);
INSERT INTO public.games VALUES (1230, 'Lotto America', 135, 'unknown', 4, 0, 9, 0, NULL, 'LottoAmerica', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:43.856257', '2025-12-11 06:17:43.856257', NULL);
INSERT INTO public.games VALUES (1231, 'Mega Millions', 135, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.890095', '2025-12-11 06:17:43.890095', NULL);
INSERT INTO public.games VALUES (1232, 'Powerball', 135, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:43.947421', '2025-12-11 06:17:43.947421', NULL);
INSERT INTO public.games VALUES (1233, 'Cash4Life', 138, 'unknown', 4, 0, 9, 0, NULL, 'Cash4Life', '', '{"game_type": "pick4"}', true, '2025-12-11 06:17:43.990721', '2025-12-11 06:17:43.990721', NULL);
INSERT INTO public.games VALUES (1234, 'Mega Millions', 138, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:44.037704', '2025-12-11 06:17:44.037704', NULL);
INSERT INTO public.games VALUES (1235, 'Powerball', 138, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:44.088152', '2025-12-11 06:17:44.088152', NULL);
INSERT INTO public.games VALUES (1236, 'Mega Millions', 143, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:44.137513', '2025-12-11 06:17:44.137513', NULL);
INSERT INTO public.games VALUES (1237, 'Powerball', 143, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:44.175973', '2025-12-11 06:17:44.175973', NULL);
INSERT INTO public.games VALUES (1238, 'Powerball Double Play', 143, 'unknown', 4, 0, 9, 0, NULL, 'PowerballDoublePlay', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:44.215918', '2025-12-11 06:17:44.215918', NULL);
INSERT INTO public.games VALUES (1239, 'Cash4Life', 147, 'unknown', 4, 0, 9, 0, NULL, 'Cash4Life', '', '{"game_type": "pick4"}', true, '2025-12-11 06:17:44.252144', '2025-12-11 06:17:44.252144', NULL);
INSERT INTO public.games VALUES (1240, 'Mega Millions', 147, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:44.290298', '2025-12-11 06:17:44.290298', NULL);
INSERT INTO public.games VALUES (1241, 'Powerball', 147, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:44.309398', '2025-12-11 06:17:44.309398', NULL);
INSERT INTO public.games VALUES (1242, 'Powerball Double Play', 147, 'unknown', 4, 0, 9, 0, NULL, 'PowerballDoublePlay', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:44.3357', '2025-12-11 06:17:44.3357', NULL);
INSERT INTO public.games VALUES (1243, '2by2', 132, 'unknown', 4, 0, 9, 0, NULL, '2by2', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:44.359554', '2025-12-11 06:17:44.359554', NULL);
INSERT INTO public.games VALUES (1244, 'Lucky for Life', 132, 'unknown', 4, 0, 9, 0, NULL, 'LuckyforLife', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:44.391273', '2025-12-11 06:17:44.391273', NULL);
INSERT INTO public.games VALUES (1245, 'Mega Millions', 132, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:44.42859', '2025-12-11 06:17:44.42859', NULL);
INSERT INTO public.games VALUES (1246, 'Powerball', 132, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:44.4591', '2025-12-11 06:17:44.4591', NULL);
INSERT INTO public.games VALUES (1247, 'Cash4Life', 128, 'unknown', 4, 0, 9, 0, NULL, 'Cash4Life', '', '{"game_type": "pick4"}', true, '2025-12-11 06:17:44.491952', '2025-12-11 06:17:44.491952', NULL);
INSERT INTO public.games VALUES (1248, 'Mega Millions', 128, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:44.518333', '2025-12-11 06:17:44.518333', NULL);
INSERT INTO public.games VALUES (1249, 'Powerball Double Play', 128, 'unknown', 4, 0, 9, 0, NULL, 'PowerballDoublePlay', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:44.544258', '2025-12-11 06:17:44.544258', NULL);
INSERT INTO public.games VALUES (1250, 'Lotto America', 129, 'unknown', 4, 0, 9, 0, NULL, 'LottoAmerica', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:44.576339', '2025-12-11 06:17:44.576339', NULL);
INSERT INTO public.games VALUES (1251, 'Lucky for Life', 129, 'unknown', 4, 0, 9, 0, NULL, 'LuckyforLife', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:44.6091', '2025-12-11 06:17:44.6091', NULL);
INSERT INTO public.games VALUES (1252, 'Mega Millions', 129, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:44.635754', '2025-12-11 06:17:44.635754', NULL);
INSERT INTO public.games VALUES (1253, 'Powerball', 129, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:44.67321', '2025-12-11 06:17:44.67321', NULL);
INSERT INTO public.games VALUES (1254, 'Lucky for Life', 130, 'unknown', 4, 0, 9, 0, NULL, 'LuckyforLife', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:44.705941', '2025-12-11 06:17:44.705941', NULL);
INSERT INTO public.games VALUES (1255, 'Powerball', 130, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:44.731286', '2025-12-11 06:17:44.731286', NULL);
INSERT INTO public.games VALUES (1256, 'Lucky for Life', 144, 'unknown', 4, 0, 9, 0, NULL, 'LuckyforLife', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:44.764518', '2025-12-11 06:17:44.764518', NULL);
INSERT INTO public.games VALUES (1257, 'Mega Millions', 144, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:44.808875', '2025-12-11 06:17:44.808875', NULL);
INSERT INTO public.games VALUES (1258, 'Tri-State Pick 3 Day', 175, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Day', 'Day', '{"game_type": "pick3"}', true, '2025-12-11 06:17:44.904198', '2025-12-11 06:17:44.904198', NULL);
INSERT INTO public.games VALUES (1259, 'My3 Midday', 170, 'unknown', 4, 0, 9, 0, NULL, 'My3Midday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:44.929733', '2025-12-11 06:17:44.929733', NULL);
INSERT INTO public.games VALUES (1260, 'My3 Evening', 170, 'unknown', 4, 0, 9, 0, NULL, 'My3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:44.985553', '2025-12-11 06:17:44.985553', NULL);
INSERT INTO public.games VALUES (1261, 'Pick 3 Night', 171, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Night', 'Night', '{"game_type": "pick3"}', true, '2025-12-11 06:17:45.022478', '2025-12-11 06:17:45.022478', NULL);
INSERT INTO public.games VALUES (1262, 'Pick 3 Day', 171, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Day', 'Day', '{"game_type": "pick3"}', true, '2025-12-11 06:17:45.060401', '2025-12-11 06:17:45.060401', NULL);
INSERT INTO public.games VALUES (1263, 'Keno', 172, 'unknown', 4, 0, 9, 0, NULL, 'Keno', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:45.095613', '2025-12-11 06:17:45.095613', NULL);
INSERT INTO public.games VALUES (1264, 'Tri-State Pick 3 Day', 176, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Day', 'Day', '{"game_type": "pick3"}', true, '2025-12-11 06:17:45.129112', '2025-12-11 06:17:45.129112', NULL);
INSERT INTO public.games VALUES (1265, 'Tri-State Pick 4 Midday', 175, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Midday', 'Midday', '{"game_type": "pick4"}', true, '2025-12-11 06:17:45.182594', '2025-12-11 06:17:45.182594', NULL);
INSERT INTO public.games VALUES (1266, 'Tri-State Pick 4 Midday', 176, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Midday', 'Midday', '{"game_type": "pick4"}', true, '2025-12-11 06:17:45.232307', '2025-12-11 06:17:45.232307', NULL);
INSERT INTO public.games VALUES (1267, 'Tri-State Pick 4 Evening', 176, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:45.326313', '2025-12-11 06:17:45.326313', NULL);
INSERT INTO public.games VALUES (1268, 'Tri-State Pick 3 Evening', 176, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:45.376063', '2025-12-11 06:17:45.376063', NULL);
INSERT INTO public.games VALUES (1269, 'Tri-State Pick 3 Midday', 176, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Midday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:45.427991', '2025-12-11 06:17:45.427991', NULL);
INSERT INTO public.games VALUES (1270, 'Tri-State Pick 4 Day', 176, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Day', 'Day', '{"game_type": "pick4"}', true, '2025-12-11 06:17:45.460899', '2025-12-11 06:17:45.460899', NULL);
INSERT INTO public.games VALUES (1271, 'Tri-State Pick 3 Midday', 175, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Midday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:45.500607', '2025-12-11 06:17:45.500607', NULL);
INSERT INTO public.games VALUES (1272, 'Powerball', 144, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:45.569736', '2025-12-11 06:17:45.569736', NULL);
INSERT INTO public.games VALUES (1273, 'Lotto America', 149, 'unknown', 4, 0, 9, 0, NULL, 'LottoAmerica', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:45.635172', '2025-12-11 06:17:45.635172', NULL);
INSERT INTO public.games VALUES (1274, 'Lucky for Life', 149, 'unknown', 4, 0, 9, 0, NULL, 'LuckyforLife', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:45.689497', '2025-12-11 06:17:45.689497', NULL);
INSERT INTO public.games VALUES (1275, 'Mega Millions', 149, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:45.738432', '2025-12-11 06:17:45.738432', NULL);
INSERT INTO public.games VALUES (1276, 'Powerball', 149, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:45.805079', '2025-12-11 06:17:45.805079', NULL);
INSERT INTO public.games VALUES (1277, 'Gimme 5', 176, 'unknown', 4, 0, 9, 0, NULL, 'Gimme5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:45.829246', '2025-12-11 06:17:45.829246', NULL);
INSERT INTO public.games VALUES (1278, 'Lucky for Life', 176, 'unknown', 4, 0, 9, 0, NULL, 'LuckyforLife', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:45.848962', '2025-12-11 06:17:45.848962', NULL);
INSERT INTO public.games VALUES (1279, 'Mega Millions', 176, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:45.868476', '2025-12-11 06:17:45.868476', NULL);
INSERT INTO public.games VALUES (1280, 'Powerball', 176, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:45.906771', '2025-12-11 06:17:45.906771', NULL);
INSERT INTO public.games VALUES (1281, 'Tri-State Megabucks Plus', 176, 'unknown', 4, 0, 9, 0, NULL, 'MegabucksPlus', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:45.939773', '2025-12-11 06:17:45.939773', NULL);
INSERT INTO public.games VALUES (1282, 'Lucky for Life', 120, 'unknown', 4, 0, 9, 0, NULL, 'LuckyforLife', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:45.975374', '2025-12-11 06:17:45.975374', NULL);
INSERT INTO public.games VALUES (1283, 'Mega Millions', 120, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:46.014876', '2025-12-11 06:17:46.014876', NULL);
INSERT INTO public.games VALUES (1284, 'Powerball Double Play', 120, 'unknown', 4, 0, 9, 0, NULL, 'PowerballDoublePlay', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:46.071532', '2025-12-11 06:17:46.071532', NULL);
INSERT INTO public.games VALUES (1285, '2by2', 177, 'unknown', 4, 0, 9, 0, NULL, '2by2', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:46.138864', '2025-12-11 06:17:46.138864', NULL);
INSERT INTO public.games VALUES (1286, 'Lotto America', 177, 'unknown', 4, 0, 9, 0, NULL, 'LottoAmerica', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:46.167711', '2025-12-11 06:17:46.167711', NULL);
INSERT INTO public.games VALUES (1287, 'Lucky for Life', 177, 'unknown', 4, 0, 9, 0, NULL, 'LuckyforLife', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:46.192312', '2025-12-11 06:17:46.192312', NULL);
INSERT INTO public.games VALUES (1288, 'Mega Millions', 177, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:46.233347', '2025-12-11 06:17:46.233347', NULL);
INSERT INTO public.games VALUES (1289, 'Powerball', 177, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:46.280148', '2025-12-11 06:17:46.280148', NULL);
INSERT INTO public.games VALUES (1290, 'Lotería Tradicional', 146, 'unknown', 4, 0, 9, 0, NULL, 'LoteríaTradicional', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:46.312518', '2025-12-11 06:17:46.312518', NULL);
INSERT INTO public.games VALUES (1291, 'North 5', 158, 'unknown', 4, 0, 9, 0, NULL, 'North5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:46.353504', '2025-12-11 06:17:46.353504', NULL);
INSERT INTO public.games VALUES (1292, 'Powerball Double Play', 146, 'unknown', 4, 0, 9, 0, NULL, 'PowerballDoublePlay', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:46.407371', '2025-12-11 06:17:46.407371', NULL);
INSERT INTO public.games VALUES (1293, 'Lucky for Life', 159, 'unknown', 4, 0, 9, 0, NULL, 'LuckyforLife', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:46.4762', '2025-12-11 06:17:46.4762', NULL);
INSERT INTO public.games VALUES (1294, 'Mega Millions', 159, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:46.561142', '2025-12-11 06:17:46.561142', NULL);
INSERT INTO public.games VALUES (1295, 'Poker Lotto', 159, 'unknown', 4, 0, 9, 0, NULL, 'PokerLotto', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:46.594424', '2025-12-11 06:17:46.594424', NULL);
INSERT INTO public.games VALUES (1296, 'Powerball', 159, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:46.647577', '2025-12-11 06:17:46.647577', NULL);
INSERT INTO public.games VALUES (1297, 'Powerball Double Play', 159, 'unknown', 4, 0, 9, 0, NULL, 'PowerballDoublePlay', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:46.68962', '2025-12-11 06:17:46.68962', NULL);
INSERT INTO public.games VALUES (1298, 'Lotto America', 156, 'unknown', 4, 0, 9, 0, NULL, 'LottoAmerica', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:46.729819', '2025-12-11 06:17:46.729819', NULL);
INSERT INTO public.games VALUES (1299, 'Lucky for Life', 156, 'unknown', 4, 0, 9, 0, NULL, 'LuckyforLife', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:46.770397', '2025-12-11 06:17:46.770397', NULL);
INSERT INTO public.games VALUES (1300, 'Mega Millions', 156, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:46.80241', '2025-12-11 06:17:46.80241', NULL);
INSERT INTO public.games VALUES (1301, 'Powerball', 156, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:46.833696', '2025-12-11 06:17:46.833696', NULL);
INSERT INTO public.games VALUES (1302, 'Lotto America', 153, 'unknown', 4, 0, 9, 0, NULL, 'LottoAmerica', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:46.862021', '2025-12-11 06:17:46.862021', NULL);
INSERT INTO public.games VALUES (1303, 'Mega Millions', 153, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:46.889663', '2025-12-11 06:17:46.889663', NULL);
INSERT INTO public.games VALUES (1304, 'Powerball', 153, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:46.918069', '2025-12-11 06:17:46.918069', NULL);
INSERT INTO public.games VALUES (1305, '2by2', 164, 'unknown', 4, 0, 9, 0, NULL, '2by2', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:46.942208', '2025-12-11 06:17:46.942208', NULL);
INSERT INTO public.games VALUES (1306, 'Lucky for Life', 164, 'unknown', 4, 0, 9, 0, NULL, 'LuckyforLife', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:46.9736', '2025-12-11 06:17:46.9736', NULL);
INSERT INTO public.games VALUES (1307, 'Mega Millions', 164, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:47.004528', '2025-12-11 06:17:47.004528', NULL);
INSERT INTO public.games VALUES (1308, 'Cash4Life', 141, 'unknown', 4, 0, 9, 0, NULL, 'Cash4Life', '', '{"game_type": "pick4"}', true, '2025-12-11 06:17:47.050676', '2025-12-11 06:17:47.050676', NULL);
INSERT INTO public.games VALUES (1309, 'Lotto America', 141, 'unknown', 4, 0, 9, 0, NULL, 'LottoAmerica', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:47.085763', '2025-12-11 06:17:47.085763', NULL);
INSERT INTO public.games VALUES (1310, 'Mega Millions', 141, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:47.130438', '2025-12-11 06:17:47.130438', NULL);
INSERT INTO public.games VALUES (1311, 'Powerball', 141, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:47.180649', '2025-12-11 06:17:47.180649', NULL);
INSERT INTO public.games VALUES (1312, 'Powerball Double Play', 141, 'unknown', 4, 0, 9, 0, NULL, 'PowerballDoublePlay', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:47.235913', '2025-12-11 06:17:47.235913', NULL);
INSERT INTO public.games VALUES (1313, '5 Card Cash', 163, 'unknown', 4, 0, 9, 0, NULL, '5CardCash', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:47.289639', '2025-12-11 06:17:47.289639', NULL);
INSERT INTO public.games VALUES (1314, 'Lucky for Life', 163, 'unknown', 4, 0, 9, 0, NULL, 'LuckyforLife', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:47.325611', '2025-12-11 06:17:47.325611', NULL);
INSERT INTO public.games VALUES (1315, 'Mega Millions', 163, 'unknown', 4, 0, 9, 0, NULL, 'MegaMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:47.355255', '2025-12-11 06:17:47.355255', NULL);
INSERT INTO public.games VALUES (1316, 'Powerball', 163, 'unknown', 4, 0, 9, 0, NULL, 'Powerball', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:47.398981', '2025-12-11 06:17:47.398981', NULL);
INSERT INTO public.games VALUES (1317, 'Euro Millions', 166, 'unknown', 4, 0, 9, 0, NULL, 'EuroMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:47.438722', '2025-12-11 06:17:47.438722', NULL);
INSERT INTO public.games VALUES (1318, 'Lotto Plus Raffle', 166, 'unknown', 4, 0, 9, 0, NULL, 'LottoPlusRaffle', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:47.491792', '2025-12-11 06:17:47.491792', NULL);
INSERT INTO public.games VALUES (1319, 'Euro Millions', 139, 'unknown', 4, 0, 9, 0, NULL, 'EuroMillions', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:47.540568', '2025-12-11 06:17:47.540568', NULL);
INSERT INTO public.games VALUES (1320, 'Millionaire Raffle', 139, 'unknown', 4, 0, 9, 0, NULL, 'MillionaireRaffle', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:47.605409', '2025-12-11 06:17:47.605409', NULL);
INSERT INTO public.games VALUES (1321, 'EuroJackpot', 165, 'unknown', 4, 0, 9, 0, NULL, 'EuroJackpot', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:47.645121', '2025-12-11 06:17:47.645121', NULL);
INSERT INTO public.games VALUES (1322, 'Lotto', 165, 'unknown', 4, 0, 9, 0, NULL, 'Lotto', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:47.69692', '2025-12-11 06:17:47.69692', NULL);
INSERT INTO public.games VALUES (1323, 'EuroJackpot', 172, 'unknown', 4, 0, 9, 0, NULL, 'EuroJackpot', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:47.760774', '2025-12-11 06:17:47.760774', NULL);
INSERT INTO public.games VALUES (1324, 'GlücksSpirale', 172, 'unknown', 4, 0, 9, 0, NULL, 'GlücksSpirale', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:47.797599', '2025-12-11 06:17:47.797599', NULL);
INSERT INTO public.games VALUES (1325, 'Spiel 77', 172, 'unknown', 4, 0, 9, 0, NULL, 'Spiel77', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:47.819818', '2025-12-11 06:17:47.819818', NULL);
INSERT INTO public.games VALUES (1326, 'Toto Ergebniswette', 172, 'unknown', 4, 0, 9, 0, NULL, 'TotoErgebniswette', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:47.85654', '2025-12-11 06:17:47.85654', NULL);
INSERT INTO public.games VALUES (1327, 'Pega 2 Noche', 146, 'pick2', 2, 0, 9, 0, NULL, 'Pega2Noche', 'Noche', '{"game_type": "pick3"}', true, '2025-12-11 06:17:47.890929', '2025-12-11 06:17:47.890929', NULL);
INSERT INTO public.games VALUES (1328, 'Pega 3 Noche', 146, 'pick3', 3, 0, 9, 0, NULL, 'Pega3Noche', 'Noche', '{"game_type": "pick3"}', true, '2025-12-11 06:17:47.925867', '2025-12-11 06:17:47.925867', NULL);
INSERT INTO public.games VALUES (1329, 'Numbers Game Game Midday', 160, 'unknown', 4, 0, 9, 0, NULL, 'NumbersGameGameMidday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:47.977467', '2025-12-11 06:17:47.977467', NULL);
INSERT INTO public.games VALUES (1330, 'Numbers Game Game Evening', 160, 'unknown', 4, 0, 9, 0, NULL, 'NumbersGameGameEvening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:48.020666', '2025-12-11 06:17:48.020666', NULL);
INSERT INTO public.games VALUES (1331, 'Cash 3 Midday', 173, 'pick3', 3, 0, 9, 0, NULL, 'Cash3Midday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:48.048174', '2025-12-11 06:17:48.048174', NULL);
INSERT INTO public.games VALUES (1332, 'Cash 3 Eve', 173, 'pick3', 3, 0, 9, 0, NULL, 'Cash3Eve', 'Eve', '{"game_type": "pick3"}', true, '2025-12-11 06:17:48.076077', '2025-12-11 06:17:48.076077', NULL);
INSERT INTO public.games VALUES (1333, 'Cash 4 Midday', 173, 'pick4', 4, 0, 9, 0, NULL, 'Cash4Midday', 'Midday', '{"game_type": "pick4"}', true, '2025-12-11 06:17:48.108052', '2025-12-11 06:17:48.108052', NULL);
INSERT INTO public.games VALUES (1334, 'Cash 4 Eve', 173, 'pick4', 4, 0, 9, 0, NULL, 'Cash4Eve', 'Eve', '{"game_type": "pick4"}', true, '2025-12-11 06:17:48.137529', '2025-12-11 06:17:48.137529', NULL);
INSERT INTO public.games VALUES (1335, 'Pick 3 Midday', 175, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Midday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:48.183118', '2025-12-11 06:17:48.183118', NULL);
INSERT INTO public.games VALUES (1336, 'Pick 3 Evening', 175, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:48.231455', '2025-12-11 06:17:48.231455', NULL);
INSERT INTO public.games VALUES (1337, 'Pick 4 Midday', 175, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Midday', 'Midday', '{"game_type": "pick4"}', true, '2025-12-11 06:17:48.272298', '2025-12-11 06:17:48.272298', NULL);
INSERT INTO public.games VALUES (1338, 'Pick 4 Evening', 175, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:48.296687', '2025-12-11 06:17:48.296687', NULL);
INSERT INTO public.games VALUES (1339, 'Megabucks Plus', 175, 'unknown', 4, 0, 9, 0, NULL, 'MegabucksPlus', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:48.327076', '2025-12-11 06:17:48.327076', NULL);
INSERT INTO public.games VALUES (1340, 'Pick 3 Midday', 176, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Midday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:48.353832', '2025-12-11 06:17:48.353832', NULL);
INSERT INTO public.games VALUES (1341, 'Pick 3 Evening', 176, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:48.382759', '2025-12-11 06:17:48.382759', NULL);
INSERT INTO public.games VALUES (1342, 'Pick 4 Midday', 176, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Midday', 'Midday', '{"game_type": "pick4"}', true, '2025-12-11 06:17:48.409748', '2025-12-11 06:17:48.409748', NULL);
INSERT INTO public.games VALUES (1343, 'Pick 4 Evening', 176, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:48.429029', '2025-12-11 06:17:48.429029', NULL);
INSERT INTO public.games VALUES (1344, 'Megabucks Plus', 176, 'unknown', 4, 0, 9, 0, NULL, 'MegabucksPlus', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:48.46052', '2025-12-11 06:17:48.46052', NULL);
INSERT INTO public.games VALUES (1345, 'Pick 3 Midday', 174, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Midday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:48.489961', '2025-12-11 06:17:48.489961', NULL);
INSERT INTO public.games VALUES (1346, 'Pick 3 Evening', 174, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:48.526215', '2025-12-11 06:17:48.526215', NULL);
INSERT INTO public.games VALUES (1347, 'Pick 4 Midday', 174, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Midday', 'Midday', '{"game_type": "pick4"}', true, '2025-12-11 06:17:48.572118', '2025-12-11 06:17:48.572118', NULL);
INSERT INTO public.games VALUES (1348, 'Pick 4 Evening', 174, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:48.610496', '2025-12-11 06:17:48.610496', NULL);
INSERT INTO public.games VALUES (1349, 'Megabucks Plus', 174, 'unknown', 4, 0, 9, 0, NULL, 'MegabucksPlus', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:48.646876', '2025-12-11 06:17:48.646876', NULL);
INSERT INTO public.games VALUES (1350, 'Lotto', 125, 'unknown', 4, 0, 9, 0, NULL, 'Lotto', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:48.696189', '2025-12-11 06:17:48.696189', NULL);
INSERT INTO public.games VALUES (1351, 'Tri-State Pick 3 Midday', 174, 'pick3', 3, 0, 9, 0, NULL, 'Pick3Midday', 'Midday', '{"game_type": "pick3"}', true, '2025-12-11 06:17:48.751217', '2025-12-11 06:17:48.751217', NULL);
INSERT INTO public.games VALUES (1352, 'Tri-State Pick 4 Midday', 174, 'pick4', 4, 0, 9, 0, NULL, 'Pick4Midday', 'Midday', '{"game_type": "pick4"}', true, '2025-12-11 06:17:48.81644', '2025-12-11 06:17:48.81644', NULL);
INSERT INTO public.games VALUES (1353, 'Pick 3', 158, 'pick3', 3, 0, 9, 0, NULL, 'Pick3', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:48.844431', '2025-12-11 06:17:48.844431', NULL);
INSERT INTO public.games VALUES (1354, 'Megabucks', 175, 'unknown', 4, 0, 9, 0, NULL, 'Megabucks', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:48.896529', '2025-12-11 06:17:48.896529', NULL);
INSERT INTO public.games VALUES (1355, 'Megabucks', 176, 'unknown', 4, 0, 9, 0, NULL, 'Megabucks', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:48.922099', '2025-12-11 06:17:48.922099', NULL);
INSERT INTO public.games VALUES (1356, 'Megabucks', 174, 'unknown', 4, 0, 9, 0, NULL, 'Megabucks', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:48.945465', '2025-12-11 06:17:48.945465', NULL);
INSERT INTO public.games VALUES (1357, 'Powerball Double Play', 149, 'unknown', 4, 0, 9, 0, NULL, 'PowerballDoublePlay', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:48.966793', '2025-12-11 06:17:48.966793', NULL);
INSERT INTO public.games VALUES (1358, 'Cash Pop', 137, 'unknown', 4, 0, 9, 0, NULL, 'CashPop', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:48.990909', '2025-12-11 06:17:48.990909', NULL);
INSERT INTO public.games VALUES (1359, 'Powerball Double Play', 173, 'unknown', 4, 0, 9, 0, NULL, 'PowerballDoublePlay', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:49.008491', '2025-12-11 06:17:49.008491', NULL);
INSERT INTO public.games VALUES (1360, 'Megabucks', 160, 'unknown', 4, 0, 9, 0, NULL, 'Megabucks', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:49.052917', '2025-12-11 06:17:49.052917', NULL);
INSERT INTO public.games VALUES (1361, 'Powerball Double Play', 163, 'unknown', 4, 0, 9, 0, NULL, 'PowerballDoublePlay', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:49.082936', '2025-12-11 06:17:49.082936', NULL);
INSERT INTO public.games VALUES (1362, 'Cash 3 Day', 171, 'pick3', 3, 0, 9, 0, NULL, 'Cash3Day', 'Day', '{"game_type": "pick3"}', true, '2025-12-11 06:17:49.116824', '2025-12-11 06:17:49.116824', NULL);
INSERT INTO public.games VALUES (1363, 'Cash 3 Evening', 171, 'pick3', 3, 0, 9, 0, NULL, 'Cash3Evening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:49.158387', '2025-12-11 06:17:49.158387', NULL);
INSERT INTO public.games VALUES (1364, 'Cash 3 Night', 171, 'pick3', 3, 0, 9, 0, NULL, 'Cash3Night', 'Night', '{"game_type": "pick3"}', true, '2025-12-11 06:17:49.194945', '2025-12-11 06:17:49.194945', NULL);
INSERT INTO public.games VALUES (1365, 'Cash 4 Day', 171, 'pick4', 4, 0, 9, 0, NULL, 'Cash4Day', 'Day', '{"game_type": "pick4"}', true, '2025-12-11 06:17:49.219434', '2025-12-11 06:17:49.219434', NULL);
INSERT INTO public.games VALUES (1366, 'Cash 4 Evening', 171, 'pick4', 4, 0, 9, 0, NULL, 'Cash4Evening', 'Evening', '{"game_type": "pick4"}', true, '2025-12-11 06:17:49.295918', '2025-12-11 06:17:49.295918', NULL);
INSERT INTO public.games VALUES (1367, 'Cash 4 Night', 171, 'pick4', 4, 0, 9, 0, NULL, 'Cash4Night', 'Night', '{"game_type": "pick4"}', true, '2025-12-11 06:17:49.325892', '2025-12-11 06:17:49.325892', NULL);
INSERT INTO public.games VALUES (1368, 'Georgia Five Day', 171, 'unknown', 4, 0, 9, 0, NULL, 'GeorgiaFiveDay', 'Day', '{"game_type": "pick3"}', true, '2025-12-11 06:17:49.36405', '2025-12-11 06:17:49.36405', NULL);
INSERT INTO public.games VALUES (1369, 'Georgia Five Evening', 171, 'unknown', 4, 0, 9, 0, NULL, 'GeorgiaFiveEvening', 'Evening', '{"game_type": "pick3"}', true, '2025-12-11 06:17:49.397977', '2025-12-11 06:17:49.397977', NULL);
INSERT INTO public.games VALUES (1370, 'Cash Pop Early Bird', 171, 'unknown', 4, 0, 9, 0, NULL, 'CashPopEarlyBird', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:49.443741', '2025-12-11 06:17:49.443741', NULL);
INSERT INTO public.games VALUES (1371, 'Cash Pop Matinee', 171, 'unknown', 4, 0, 9, 0, NULL, 'CashPopMatinee', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:49.491643', '2025-12-11 06:17:49.491643', NULL);
INSERT INTO public.games VALUES (1372, 'Cash Pop Drive Time', 171, 'unknown', 4, 0, 9, 0, NULL, 'CashPopDriveTime', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:49.563057', '2025-12-11 06:17:49.563057', NULL);
INSERT INTO public.games VALUES (1373, 'Cash Pop Primetime', 171, 'unknown', 4, 0, 9, 0, NULL, 'CashPopPrimetime', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:49.587186', '2025-12-11 06:17:49.587186', NULL);
INSERT INTO public.games VALUES (1374, 'Cash Pop Night Owl', 171, 'unknown', 4, 0, 9, 0, NULL, 'CashPopNightOwl', 'Night', '{"game_type": "pick3"}', true, '2025-12-11 06:17:49.624425', '2025-12-11 06:17:49.624425', NULL);
INSERT INTO public.games VALUES (1375, 'Fantasy 5', 171, 'unknown', 4, 0, 9, 0, NULL, 'Fantasy5', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:49.662418', '2025-12-11 06:17:49.662418', NULL);
INSERT INTO public.games VALUES (1376, 'Jumbo Bucks Lotto', 171, 'unknown', 4, 0, 9, 0, NULL, 'JumboBucksLotto', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:49.706206', '2025-12-11 06:17:49.706206', NULL);
INSERT INTO public.games VALUES (1377, 'Cash4Life', 171, 'unknown', 4, 0, 9, 0, NULL, 'Cash4Life', '', '{"game_type": "pick4"}', true, '2025-12-11 06:17:49.749591', '2025-12-11 06:17:49.749591', NULL);
INSERT INTO public.games VALUES (1378, 'EuroDreams', 166, 'unknown', 4, 0, 9, 0, NULL, 'EuroDreams', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:49.797077', '2025-12-11 06:17:49.797077', NULL);
INSERT INTO public.games VALUES (1379, 'Cash Pop 9am', 161, 'unknown', 4, 0, 9, 0, NULL, 'CashPop9am', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:49.856671', '2025-12-11 06:17:49.856671', NULL);
INSERT INTO public.games VALUES (1380, 'Cash Pop 1pm', 161, 'unknown', 4, 0, 9, 0, NULL, 'CashPop1pm', '1pm', '{"game_type": "pick3"}', true, '2025-12-11 06:17:49.910625', '2025-12-11 06:17:49.910625', NULL);
INSERT INTO public.games VALUES (1381, 'Cash Pop 6pm', 161, 'unknown', 4, 0, 9, 0, NULL, 'CashPop6pm', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:49.953692', '2025-12-11 06:17:49.953692', NULL);
INSERT INTO public.games VALUES (1382, 'Cash Pop 11pm', 161, 'unknown', 4, 0, 9, 0, NULL, 'CashPop11pm', '1pm', '{"game_type": "pick3"}', true, '2025-12-11 06:17:49.998819', '2025-12-11 06:17:49.998819', NULL);
INSERT INTO public.games VALUES (1383, 'Lotto America', 173, 'unknown', 4, 0, 9, 0, NULL, 'LottoAmerica', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:50.02874', '2025-12-11 06:17:50.02874', NULL);
INSERT INTO public.games VALUES (1384, 'Lotto America', 155, 'unknown', 4, 0, 9, 0, NULL, 'LottoAmerica', '', '{"game_type": "pick5"}', true, '2025-12-11 06:17:50.071777', '2025-12-11 06:17:50.071777', NULL);
INSERT INTO public.games VALUES (1385, 'Cash Pop Early Bird', 175, 'unknown', 4, 0, 9, 0, NULL, 'CashPopEarlyBird', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:50.119326', '2025-12-11 06:17:50.119326', NULL);
INSERT INTO public.games VALUES (1386, 'Cash Pop Brunch', 175, 'unknown', 4, 0, 9, 0, NULL, 'CashPopBrunch', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:50.156903', '2025-12-11 06:17:50.156903', NULL);
INSERT INTO public.games VALUES (1387, 'Cash Pop Matinee', 175, 'unknown', 4, 0, 9, 0, NULL, 'CashPopMatinee', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:50.193322', '2025-12-11 06:17:50.193322', NULL);
INSERT INTO public.games VALUES (1388, 'Cash Pop Suppertime', 175, 'unknown', 4, 0, 9, 0, NULL, 'CashPopSuppertime', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:50.230428', '2025-12-11 06:17:50.230428', NULL);
INSERT INTO public.games VALUES (1389, 'Cash Pop Night Owl', 175, 'unknown', 4, 0, 9, 0, NULL, 'CashPopNightOwl', 'Night', '{"game_type": "pick3"}', true, '2025-12-11 06:17:50.266363', '2025-12-11 06:17:50.266363', NULL);
INSERT INTO public.games VALUES (1390, 'Powerball Double Play', 136, 'unknown', 4, 0, 9, 0, NULL, 'PowerballDoublePlay', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:50.301406', '2025-12-11 06:17:50.301406', NULL);
INSERT INTO public.games VALUES (1391, 'Play 5 Night', 129, 'pick5', 5, 0, 9, 0, NULL, 'Play5Night', 'Night', '{"game_type": "pick5"}', true, '2025-12-11 06:17:50.33472', '2025-12-11 06:17:50.33472', NULL);
INSERT INTO public.games VALUES (1392, 'Play 5 Day', 129, 'pick5', 5, 0, 9, 0, NULL, 'Play5Day', 'Day', '{"game_type": "pick5"}', true, '2025-12-11 06:17:50.375476', '2025-12-11 06:17:50.375476', NULL);
INSERT INTO public.games VALUES (1393, 'Fantasy 5 Midday', 128, 'unknown', 4, 0, 9, 0, NULL, 'Fantasy5Midday', 'Midday', '{"game_type": "pick5"}', true, '2025-12-11 06:17:50.401772', '2025-12-11 06:17:50.401772', NULL);
INSERT INTO public.games VALUES (1394, 'Fantasy 5 Evening', 128, 'unknown', 4, 0, 9, 0, NULL, 'Fantasy5Evening', 'Evening', '{"game_type": "pick5"}', true, '2025-12-11 06:17:50.440431', '2025-12-11 06:17:50.440431', NULL);
INSERT INTO public.games VALUES (1395, 'Cash Pop Morning Buzz', 151, 'unknown', 4, 0, 9, 0, NULL, 'CashPopMorningBuzz', 'Morning', '{"game_type": "pick3"}', true, '2025-12-11 06:17:50.474698', '2025-12-11 06:17:50.474698', NULL);
INSERT INTO public.games VALUES (1396, 'Cash Pop Lunch Rush', 151, 'unknown', 4, 0, 9, 0, NULL, 'CashPopLunchRush', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:50.507323', '2025-12-11 06:17:50.507323', NULL);
INSERT INTO public.games VALUES (1397, 'Cash Pop Clock Out Cash', 151, 'unknown', 4, 0, 9, 0, NULL, 'CashPopClockOutCash', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:50.545475', '2025-12-11 06:17:50.545475', NULL);
INSERT INTO public.games VALUES (1398, 'Cash Pop Primetime Pop', 151, 'unknown', 4, 0, 9, 0, NULL, 'CashPopPrimetimePop', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:50.583934', '2025-12-11 06:17:50.583934', NULL);
INSERT INTO public.games VALUES (1399, 'Cash Pop Midnight Money', 151, 'unknown', 4, 0, 9, 0, NULL, 'CashPopMidnightMoney', 'Mid', '{"game_type": "pick3"}', true, '2025-12-11 06:17:50.61475', '2025-12-11 06:17:50.61475', NULL);
INSERT INTO public.games VALUES (1400, 'Powerball Double Play', 175, 'unknown', 4, 0, 9, 0, NULL, 'PowerballDoublePlay', '', '{"game_type": "pick3"}', true, '2025-12-11 06:17:50.646434', '2025-12-11 06:17:50.646434', NULL);


--
-- Data for Name: states; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.states VALUES (119, 'Arizona');
INSERT INTO public.states VALUES (120, 'Colorado');
INSERT INTO public.states VALUES (121, 'California');
INSERT INTO public.states VALUES (122, 'British Columbia');
INSERT INTO public.states VALUES (123, 'Atlantic Canada');
INSERT INTO public.states VALUES (124, 'Multi-Province');
INSERT INTO public.states VALUES (125, 'Arkansas');
INSERT INTO public.states VALUES (126, 'Multi-State');
INSERT INTO public.states VALUES (127, 'Georgia');
INSERT INTO public.states VALUES (128, 'Florida');
INSERT INTO public.states VALUES (129, 'Delaware');
INSERT INTO public.states VALUES (130, 'Connecticut');
INSERT INTO public.states VALUES (131, 'Oregon');
INSERT INTO public.states VALUES (132, 'Wyoming');
INSERT INTO public.states VALUES (133, 'Wisconsin');
INSERT INTO public.states VALUES (134, 'Western Canada');
INSERT INTO public.states VALUES (135, 'West Virginia');
INSERT INTO public.states VALUES (136, 'Washington, D.C.');
INSERT INTO public.states VALUES (137, 'Washington');
INSERT INTO public.states VALUES (138, 'Virginia');
INSERT INTO public.states VALUES (139, 'United Kingdom');
INSERT INTO public.states VALUES (140, 'Texas');
INSERT INTO public.states VALUES (141, 'Tennessee');
INSERT INTO public.states VALUES (142, 'South Dakota');
INSERT INTO public.states VALUES (143, 'South Carolina');
INSERT INTO public.states VALUES (144, 'Rhode Island');
INSERT INTO public.states VALUES (145, 'Québec');
INSERT INTO public.states VALUES (146, 'Puerto Rico');
INSERT INTO public.states VALUES (147, 'Pennsylvania');
INSERT INTO public.states VALUES (148, 'Ontario');
INSERT INTO public.states VALUES (149, 'Oklahoma');
INSERT INTO public.states VALUES (150, 'Ohio');
INSERT INTO public.states VALUES (151, 'North Carolina');
INSERT INTO public.states VALUES (152, 'New York');
INSERT INTO public.states VALUES (153, 'New Mexico');
INSERT INTO public.states VALUES (154, 'New Jersey');
INSERT INTO public.states VALUES (155, 'Nebraska');
INSERT INTO public.states VALUES (156, 'Montana');
INSERT INTO public.states VALUES (157, 'Missouri');
INSERT INTO public.states VALUES (158, 'Minnesota');
INSERT INTO public.states VALUES (159, 'Michigan');
INSERT INTO public.states VALUES (160, 'Massachusetts');
INSERT INTO public.states VALUES (161, 'Maryland');
INSERT INTO public.states VALUES (162, 'Louisiana');
INSERT INTO public.states VALUES (163, 'Kentucky');
INSERT INTO public.states VALUES (164, 'Kansas');
INSERT INTO public.states VALUES (165, 'Italy');
INSERT INTO public.states VALUES (166, 'Ireland');
INSERT INTO public.states VALUES (167, 'Multi-Country');
INSERT INTO public.states VALUES (168, 'Iowa');
INSERT INTO public.states VALUES (169, 'Indiana');
INSERT INTO public.states VALUES (170, 'Illinois');
INSERT INTO public.states VALUES (171, 'Idaho');
INSERT INTO public.states VALUES (172, 'Germany');
INSERT INTO public.states VALUES (173, 'Mississippi');
INSERT INTO public.states VALUES (174, 'Vermont');
INSERT INTO public.states VALUES (175, 'Maine');
INSERT INTO public.states VALUES (176, 'New Hampshire');
INSERT INTO public.states VALUES (177, 'North Dakota');


--
-- Name: games_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.games_id_seq', 1400, true);


--
-- Name: states_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.states_id_seq', 177, true);


--
-- Name: games games_name_state_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_name_state_unique UNIQUE (name, state_id);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);


--
-- Name: states states_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.states
    ADD CONSTRAINT states_name_key UNIQUE (name);


--
-- Name: states states_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.states
    ADD CONSTRAINT states_pkey PRIMARY KEY (id);


--
-- Name: idx_games_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_games_active ON public.games USING btree (active) WHERE (active = true);


--
-- Name: idx_games_game_key; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_games_game_key ON public.games USING btree (game_key);


--
-- Name: idx_games_game_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_games_game_name ON public.games USING btree (game_name);


--
-- Name: idx_games_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_games_state ON public.games USING btree (state_id);


--
-- Name: idx_games_tod; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_games_tod ON public.games USING btree (tod);


--
-- Name: idx_games_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_games_type ON public.games USING btree (game_type);


--
-- Name: idx_states_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_states_name ON public.states USING btree (name);


--
-- Name: games games_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_state_id_fkey FOREIGN KEY (state_id) REFERENCES public.states(id) ON DELETE CASCADE;


--
-- Name: TABLE games; Type: ACL; Schema: public; Owner: -
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.games TO mylotto_app;


--
-- Name: TABLE states; Type: ACL; Schema: public; Owner: -
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.states TO mylotto_app;


--
-- Name: SEQUENCE games_id_seq; Type: ACL; Schema: public; Owner: -
--

GRANT SELECT,USAGE ON SEQUENCE public.games_id_seq TO mylotto_app;


--
-- Name: SEQUENCE states_id_seq; Type: ACL; Schema: public; Owner: -
--

GRANT SELECT,USAGE ON SEQUENCE public.states_id_seq TO mylotto_app;


--
-- PostgreSQL database dump complete
--

\unrestrict zzfjtASqYEgdJ8yAkkApr1pCmWnWIuNafkit4Q2OZLp56HBDp7A5KdVsXjORuRX

