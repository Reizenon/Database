--
-- PostgreSQL database dump
--

\restrict HHaiRl2qAcpLfSvccfkC2w9EyoCJjFWcV4uQf1G3aTeblzXmXHePQWbR99D9aUb

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-05-21 15:57:46

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
-- TOC entry 225 (class 1259 OID 16575)
-- Name: soldier_vehicle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.soldier_vehicle (
    soldier_id integer NOT NULL,
    vehicle_id character varying(15) NOT NULL,
    permission_type character varying(30)
);


ALTER TABLE public.soldier_vehicle OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16537)
-- Name: soldiers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.soldiers (
    soldier_id integer NOT NULL,
    full_name character varying(100) NOT NULL,
    rank character varying(30),
    "position" character varying(50),
    unit_id integer NOT NULL
);


ALTER TABLE public.soldiers OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16536)
-- Name: soldiers_soldier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.soldiers_soldier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.soldiers_soldier_id_seq OWNER TO postgres;

--
-- TOC entry 4953 (class 0 OID 0)
-- Dependencies: 221
-- Name: soldiers_soldier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.soldiers_soldier_id_seq OWNED BY public.soldiers.soldier_id;


--
-- TOC entry 220 (class 1259 OID 16446)
-- Name: units; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.units (
    unit_id integer NOT NULL,
    name character varying(100) NOT NULL,
    type character varying(20) NOT NULL,
    parent_unit_id integer,
    CONSTRAINT units_type_check CHECK (((type)::text = ANY ((ARRAY['Бригада'::character varying, 'Батальон'::character varying, 'Рота'::character varying])::text[])))
);


ALTER TABLE public.units OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16445)
-- Name: units_unit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.units_unit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.units_unit_id_seq OWNER TO postgres;

--
-- TOC entry 4954 (class 0 OID 0)
-- Dependencies: 219
-- Name: units_unit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.units_unit_id_seq OWNED BY public.units.unit_id;


--
-- TOC entry 224 (class 1259 OID 16565)
-- Name: vehicles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehicles (
    vehicle_id character varying(15) NOT NULL,
    name character varying(100) NOT NULL,
    equipment_type character varying(30),
    status character varying(20) DEFAULT 'Исправна'::character varying NOT NULL,
    CONSTRAINT vehicles_status_check CHECK (((status)::text = ANY ((ARRAY['Исправна'::character varying, 'Ремонт'::character varying, 'Списана'::character varying])::text[])))
);


ALTER TABLE public.vehicles OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16551)
-- Name: weapons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.weapons (
    serial_number character varying(20) NOT NULL,
    model character varying(30) NOT NULL,
    year integer,
    owner_id integer
);


ALTER TABLE public.weapons OWNER TO postgres;

--
-- TOC entry 4773 (class 2604 OID 16540)
-- Name: soldiers soldier_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.soldiers ALTER COLUMN soldier_id SET DEFAULT nextval('public.soldiers_soldier_id_seq'::regclass);


--
-- TOC entry 4772 (class 2604 OID 16449)
-- Name: units unit_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.units ALTER COLUMN unit_id SET DEFAULT nextval('public.units_unit_id_seq'::regclass);


--
-- TOC entry 4947 (class 0 OID 16575)
-- Dependencies: 225
-- Data for Name: soldier_vehicle; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.soldier_vehicle (soldier_id, vehicle_id, permission_type) FROM stdin;
5	А123ВС	Водитель
6	А123ВС	Член экипажа
5	В789КМ	Водитель
6	В789КМ	Оператор связи
2	Б456ОР	Водитель
\.


--
-- TOC entry 4944 (class 0 OID 16537)
-- Dependencies: 222
-- Data for Name: soldiers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.soldiers (soldier_id, full_name, rank, "position", unit_id) FROM stdin;
1	Иванов Иван Иванович	Капитан	Командир роты	5
2	Петров Пётр Петрович	Старший лейтенант	Заместитель командира роты	5
3	Сидоров Сидор Сидорович	Сержант	Командир отделения	5
4	Кузнецов Алексей Викторович	Рядовой	Связист	6
5	Смирнов Дмитрий Николаевич	Рядовой	Водитель	7
6	Васильев Андрей Сергеевич	Лейтенант	Начальник связи	7
9	Коваленко Владими Михайлович	Капитан	Начальник штаба	1
10	Михайлов Николай Владимирович	Сержант	Механик	2
\.


--
-- TOC entry 4942 (class 0 OID 16446)
-- Dependencies: 220
-- Data for Name: units; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.units (unit_id, name, type, parent_unit_id) FROM stdin;
1	Штаб бригады связи	Бригада	\N
2	1-й батальон связи	Батальон	1
3	2-й батальон связи	Батальон	1
4	3-й батальон связи	Батальон	1
5	1-я рота связи	Рота	2
6	2-я рота связи	Рота	2
7	Рота управления	Рота	3
8	Рота материального обеспечения	Рота	4
\.


--
-- TOC entry 4946 (class 0 OID 16565)
-- Dependencies: 224
-- Data for Name: vehicles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vehicles (vehicle_id, name, equipment_type, status) FROM stdin;
А123ВС	КамАЗ-5350	Транспортная	Исправна
Б456ОР	БТР-80	Боевая	Исправна
В789КМ	Р-145БМ	Связная	Исправна
Г012ЕН	УАЗ-3151	Транспортная	Ремонт
\.


--
-- TOC entry 4945 (class 0 OID 16551)
-- Dependencies: 223
-- Data for Name: weapons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.weapons (serial_number, model, year, owner_id) FROM stdin;
АК-123456	АК-74М	2018	1
АК-654321	АК-12	2020	2
ПМ-987654	ПМ	2015	3
АК-111222	АК-74	2019	4
РПГ-333444	РПГ-7В	2021	5
\.


--
-- TOC entry 4955 (class 0 OID 0)
-- Dependencies: 221
-- Name: soldiers_soldier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.soldiers_soldier_id_seq', 10, true);


--
-- TOC entry 4956 (class 0 OID 0)
-- Dependencies: 219
-- Name: units_unit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.units_unit_id_seq', 8, true);


--
-- TOC entry 4788 (class 2606 OID 16581)
-- Name: soldier_vehicle soldier_vehicle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.soldier_vehicle
    ADD CONSTRAINT soldier_vehicle_pkey PRIMARY KEY (soldier_id, vehicle_id);


--
-- TOC entry 4780 (class 2606 OID 16545)
-- Name: soldiers soldiers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.soldiers
    ADD CONSTRAINT soldiers_pkey PRIMARY KEY (soldier_id);


--
-- TOC entry 4778 (class 2606 OID 16455)
-- Name: units units_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_pkey PRIMARY KEY (unit_id);


--
-- TOC entry 4786 (class 2606 OID 16574)
-- Name: vehicles vehicles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicles
    ADD CONSTRAINT vehicles_pkey PRIMARY KEY (vehicle_id);


--
-- TOC entry 4782 (class 2606 OID 16559)
-- Name: weapons weapons_owner_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weapons
    ADD CONSTRAINT weapons_owner_id_key UNIQUE (owner_id);


--
-- TOC entry 4784 (class 2606 OID 16557)
-- Name: weapons weapons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weapons
    ADD CONSTRAINT weapons_pkey PRIMARY KEY (serial_number);


--
-- TOC entry 4792 (class 2606 OID 16582)
-- Name: soldier_vehicle soldier_vehicle_soldier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.soldier_vehicle
    ADD CONSTRAINT soldier_vehicle_soldier_id_fkey FOREIGN KEY (soldier_id) REFERENCES public.soldiers(soldier_id) ON DELETE CASCADE;


--
-- TOC entry 4793 (class 2606 OID 16587)
-- Name: soldier_vehicle soldier_vehicle_vehicle_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.soldier_vehicle
    ADD CONSTRAINT soldier_vehicle_vehicle_id_fkey FOREIGN KEY (vehicle_id) REFERENCES public.vehicles(vehicle_id) ON DELETE CASCADE;


--
-- TOC entry 4790 (class 2606 OID 16546)
-- Name: soldiers soldiers_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.soldiers
    ADD CONSTRAINT soldiers_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES public.units(unit_id) ON DELETE RESTRICT;


--
-- TOC entry 4789 (class 2606 OID 16456)
-- Name: units units_parent_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_parent_unit_id_fkey FOREIGN KEY (parent_unit_id) REFERENCES public.units(unit_id) ON DELETE RESTRICT;


--
-- TOC entry 4791 (class 2606 OID 16560)
-- Name: weapons weapons_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weapons
    ADD CONSTRAINT weapons_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES public.soldiers(soldier_id) ON DELETE SET NULL;


-- Completed on 2026-05-21 15:57:47

--
-- PostgreSQL database dump complete
--

\unrestrict HHaiRl2qAcpLfSvccfkC2w9EyoCJjFWcV4uQf1G3aTeblzXmXHePQWbR99D9aUb

