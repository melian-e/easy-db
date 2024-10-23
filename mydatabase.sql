--
-- PostgreSQL database dump
--

-- Dumped from database version 15.5
-- Dumped by pg_dump version 15.7

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: instrument_families; Type: TYPE; Schema: public; Owner: admin123
--

CREATE TYPE public.instrument_families AS ENUM (
    'Strings',
    'Woodwinds',
    'Brass',
    'Percussions',
    'Voice',
    'Misc',
    'Keyboards'
);


ALTER TYPE public.instrument_families OWNER TO admin123;

--
-- Name: instrument_proficiency_level; Type: TYPE; Schema: public; Owner: admin123
--

CREATE TYPE public.instrument_proficiency_level AS ENUM (
    'Amateur - low level',
    'Amateur - medium',
    'Amateur - high level',
    'Student',
    'Professional',
    'High level professional'
);


ALTER TYPE public.instrument_proficiency_level OWNER TO admin123;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: composers; Type: TABLE; Schema: public; Owner: admin123
--

CREATE TABLE public.composers (
    short_name text NOT NULL,
    long_name text NOT NULL,
    born date NOT NULL,
    dead date,
    country text NOT NULL,
    main_style text,
    id integer NOT NULL
);


ALTER TABLE public.composers OWNER TO admin123;

--
-- Name: composers_id_seq; Type: SEQUENCE; Schema: public; Owner: admin123
--

CREATE SEQUENCE public.composers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.composers_id_seq OWNER TO admin123;

--
-- Name: composers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin123
--

ALTER SEQUENCE public.composers_id_seq OWNED BY public.composers.id;


--
-- Name: concerts; Type: TABLE; Schema: public; Owner: admin123
--

CREATE TABLE public.concerts (
    id integer NOT NULL,
    date date NOT NULL,
    name text,
    place text NOT NULL,
    comments text
);


ALTER TABLE public.concerts OWNER TO admin123;

--
-- Name: concerts_id_seq; Type: SEQUENCE; Schema: public; Owner: admin123
--

ALTER TABLE public.concerts ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.concerts_id_seq
    START WITH 2
    INCREMENT BY 1
    MINVALUE 2
    NO MAXVALUE
    CACHE 1
);


--
-- Name: instruments; Type: TABLE; Schema: public; Owner: admin123
--

CREATE TABLE public.instruments (
    id integer NOT NULL,
    instrument_name text NOT NULL,
    instrument_family public.instrument_families NOT NULL
);


ALTER TABLE public.instruments OWNER TO admin123;

--
-- Name: instruments_id_seq; Type: SEQUENCE; Schema: public; Owner: admin123
--

ALTER TABLE public.instruments ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.instruments_id_seq
    START WITH 6
    INCREMENT BY 1
    MINVALUE 6
    NO MAXVALUE
    CACHE 1
);


--
-- Name: mtm_musicians_concerts; Type: TABLE; Schema: public; Owner: admin123
--

CREATE TABLE public.mtm_musicians_concerts (
    musician integer NOT NULL,
    concert integer NOT NULL,
    instrument integer
);


ALTER TABLE public.mtm_musicians_concerts OWNER TO admin123;

--
-- Name: mtm_musicians_instruments; Type: TABLE; Schema: public; Owner: admin123
--

CREATE TABLE public.mtm_musicians_instruments (
    musician_id integer NOT NULL,
    instrument_id integer NOT NULL,
    proficiency_level public.instrument_proficiency_level
);


ALTER TABLE public.mtm_musicians_instruments OWNER TO admin123;

--
-- Name: mtm_programs; Type: TABLE; Schema: public; Owner: admin123
--

CREATE TABLE public.mtm_programs (
    concert_id integer NOT NULL,
    piece_id integer NOT NULL
);


ALTER TABLE public.mtm_programs OWNER TO admin123;

--
-- Name: mtm_soloists; Type: TABLE; Schema: public; Owner: admin123
--

CREATE TABLE public.mtm_soloists (
    concert_id integer NOT NULL,
    piece_id integer NOT NULL,
    soloist_id integer NOT NULL
);


ALTER TABLE public.mtm_soloists OWNER TO admin123;

--
-- Name: musicians; Type: TABLE; Schema: public; Owner: admin123
--

CREATE TABLE public.musicians (
    id integer NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    email text,
    phone text,
    messenger text,
    comments text,
    data_updated date NOT NULL
);


ALTER TABLE public.musicians OWNER TO admin123;

--
-- Name: musicians_id_seq; Type: SEQUENCE; Schema: public; Owner: admin123
--

ALTER TABLE public.musicians ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.musicians_id_seq
    START WITH 3
    INCREMENT BY 1
    MINVALUE 3
    NO MAXVALUE
    CACHE 1
);


--
-- Name: repertoire; Type: TABLE; Schema: public; Owner: admin123
--

CREATE TABLE public.repertoire (
    id integer NOT NULL,
    name text NOT NULL,
    opus text,
    composer text NOT NULL,
    year_of_composition integer NOT NULL,
    type text NOT NULL,
    arranger text
);


ALTER TABLE public.repertoire OWNER TO admin123;

--
-- Name: repertoire_id_seq; Type: SEQUENCE; Schema: public; Owner: admin123
--

ALTER TABLE public.repertoire ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.repertoire_id_seq
    START WITH 4
    INCREMENT BY 1
    MINVALUE 4
    NO MAXVALUE
    CACHE 1
);


--
-- Name: types_of_pieces; Type: TABLE; Schema: public; Owner: admin123
--

CREATE TABLE public.types_of_pieces (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.types_of_pieces OWNER TO admin123;

--
-- Name: types_of_pieces_id_seq; Type: SEQUENCE; Schema: public; Owner: admin123
--

ALTER TABLE public.types_of_pieces ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.types_of_pieces_id_seq
    START WITH 4
    INCREMENT BY 1
    MINVALUE 4
    NO MAXVALUE
    CACHE 1
);


--
-- Name: composers id; Type: DEFAULT; Schema: public; Owner: admin123
--

ALTER TABLE ONLY public.composers ALTER COLUMN id SET DEFAULT nextval('public.composers_id_seq'::regclass);


--
-- Data for Name: composers; Type: TABLE DATA; Schema: public; Owner: admin123
--

COPY public.composers (short_name, long_name, born, dead, country, main_style, id) FROM stdin;
W.A. Mozart	Wolfgang Amadeus Mozart	1756-01-27	1791-12-12	Austria	Classic	1
L.v. Beethoven	Ludwig van Beethoven	1770-12-15	1827-03-26	Germany	Early romantic	2
R. Glière	Reinhold Glière	1874-12-30	1956-06-23	Ukraine	Late romantic	3
M. Mussorgsky	Modest Mussorgsky	1839-03-09	1881-03-28	Russia	Romantic	4
P.I. Tchaikovsky	Piotr Illitch Tchaikovsky	1840-04-25	1893-11-06	Russia	Romantic	5
F. Schubert	Franz Schubert	1797-01-31	1828-11-19	Austria	Early romantic	15
S. Rachmaninov	Sergueï Rachmaninov	1873-04-01	1943-03-28	Russia	Post-romantic	16
A. Dvorak	Antonin Dvorak	1841-09-08	1904-05-01	Czechs	Romantic	17
E. Grieg	Edvard Grieg	1843-07-15	1907-09-04	Sweden	Romantic	19
E. Damaré	Eugène Damaré	1840-12-05	1919-08-15	France	Romantic, salon music	20
V. Monti	Vittorio Monti	1868-01-06	1922-06-20	Italy	Romantic	21
J. Brahms	Johannes Brahms	1833-05-07	1897-04-03	Germany	Romantica	22
J. Offenbach	Jacques Offenbach	1819-06-20	1880-10-05	Germany	Romantic	23
A. Stadtfeld	Alexandre Stadtfeld	1826-01-01	1853-01-01	Belgium	Romantic	24
E. Idle	Eric Idle	1943-03-29	\N	United Kingdom	Pop music	25
C. Debussy	Claude Achille Debussy	1862-08-22	1918-03-25	France	Impressionist	27
G. Fauré	Gabriel Fauré	1845-05-12	1924-11-04	France	Modern	28
B. Bartok	Béla Bartok	1881-03-25	1945-09-26	Hungaria	Modern	29
C. Saint-Saëns	Camille Saint-Saëns	1835-09-09	1921-12-16	France	Romantic	30
J.S. Bach	Johann Sebastian Bach	1685-03-31	1730-07-28	Germany	Baroque	31
D. Chostakovitch	Dmitri Chostakovitch	1906-09-25	1975-08-09	Russia	Modern	32
J. Haydn	Joseph Haydn	1732-03-31	1809-05-31	Austria	Classic	33
E. Elgar	Edward Elgar	1857-06-02	1934-02-23	United Kingdom	Romantic	34
G. Rossini	Gioachino Rossini	1792-02-29	1868-11-13	Italy	Romantic	35
N. Paganini	Niccolò Paganini	1782-10-27	1840-05-27	Italy	Romantic	36
G. Gimenez	Geronimo Giménez	1854-10-10	1923-02-19	Spain	Romantic	37
C. Gardel	Carlos Gardel	1890-12-11	1935-06-24	France (naturalized Argentine)	Tango	38
A. Marquez	Arturo Marquez	1950-12-20	\N	Mexico	Modern	18
C.M. von Weber	Carl Maria von Weber	1786-11-18	1826-06-05	Germany	Romantic	39
F. von Suppé	Franz von Suppé	1819-04-18	1895-05-21	Croatia (naturalized Austrian)	Romantic	40
M. Glinka	Mikhail Glinka	1804-06-01	1857-02-15	Russia	Romantic	41
E. Morricone	Ennio Morricone	1928-11-10	2020-07-06	Italy	Soundtrack	42
G. Bizet	Georges Bizet	1838-10-25	1875-06-03	France	Romantic	43
E. Bloch	Ernest Bloch	1880-07-24	1959-07-15	Switzerland	Post-romantic	44
P. de Sarasate	Pablo de Sarasate	1844-03-10	1908-09-20	Spain	Romantic	45
J. Brel	Jacques Brel	1929-04-08	1978-10-09	Belgium	Variety	46
H. Berlioz	Hector Berlioz	1803-12-11	1869-03-08	France	Romantic	47
G Mahler	Gustav Mahler	1860-07-07	1911-05-18	Austria	Late romantic	48
A. Borodine	Alexandre Borodine	1833-10-31	1887-02-15	Russia	Romantic	49
V. Kalinnikov	Vasily Kalinnikov	1866-01-13	1901-01-11	Russia	Romantic	50
J. Williams	John Williams	1932-02-08	\N	United States of America	Soundtrack	51
F. Z. Mendelssohn	Fanny Zippora Mendelssohn	1805-11-14	1847-05-14	Germany	Early Romantic	52
C. Aznavour	Charles Aznavour	1924-05-22	2018-10-01	France	French song	53
P. Mascagni	Pietro Mascagni	1863-12-07	1945-08-02	Italy	Romantic	54
A. Menken	Alan Menken	1949-07-22	\N	United States	Musical	55
F. Mendelssohn	Felix Mendelssohn	1809-02-03	1847-11-04	Germany	Early Romantic	56
\.


--
-- Data for Name: concerts; Type: TABLE DATA; Schema: public; Owner: admin123
--

COPY public.concerts (id, date, name, place, comments) FROM stdin;
13	2022-05-09	Let's dance!	Conservatoire Royal de Bruxelles	\N
15	2018-02-28	Concert inaugural	Théâtre Molière	\N
16	2018-05-24	Concert spécial solistes	Maison de quartier Malibran	\N
17	2019-05-04	Concert de mai 2019	Espace Lumen	\N
1	2022-11-30	Concert de novembre 2022	Conservatoire Royal de Bruxelles	\N
18	2019-11-22	Melomania au soleil	Espace Lumen	\N
19	2020-07-12	Prima la musica!	Eglise de l'Epiphanie	\N
20	2021-07-11	Summer Journey	Conservatoire Royal de Bruxelles	\N
21	2021-11-28	Concert de novembre 2021	Conservatoire Royal de Bruxelles	\N
22	2022-07-10	Melomania et Sylvia Huang	Cathédrale des Saints Michel et Gudule	\N
2	2023-05-12	Nouveau monde	Conservatoire Royal de Bruxelles	\N
23	2022-08-26	Melomania à Musicorum	Auditoire du Musée des Beaux-Arts	\N
24	2023-07-09	Melomania plays Mahler!	Conservatoire Royal de Bruxelles	\N
25	2023-11-28	Concert de novembre 2023 bis	Conservatoire Royal de Bruxelles	\N
26	2023-11-28	Concert de novembre 2023	Conservatoire Royal de Bruxelles	\N
27	2024-05-03	Concert de mai 2024	Conservatoire Royal de Bruxelles	\N
28	2024-04-14	Mozart Project	Koninklijke Conservatorium Brussel (Kleine zaal)	\N
29	2024-07-07	Melomania Summer Project 2024	Conservatoire Royal de Bruxelles	\N
\.


--
-- Data for Name: instruments; Type: TABLE DATA; Schema: public; Owner: admin123
--

COPY public.instruments (id, instrument_name, instrument_family) FROM stdin;
1	French horn	Brass
2	Viola	Strings
4	Cello	Strings
5	Violin	Strings
6	Flute	Woodwinds
15	Conductor	Misc
18	Trumpet	Brass
19	Accordeon	Misc
22	Trombone	Brass
30	Percussion	Percussions
33	Bassoon	Woodwinds
34	Contrabassoon	Woodwinds
16	Clarinet in Bb/A	Woodwinds
28	Clarinet in Eb	Woodwinds
3	Piano	Keyboards
31	Harspicord	Keyboards
32	Organ	Keyboards
27	Tuba	Brass
35	Piccolo	Woodwinds
36	Oboe	Woodwinds
37	Singer - soprano	Misc
38	Singer - alto	Misc
39	Singer - tenor	Misc
40	Singer - bass	Misc
41	English horn	Woodwinds
42	Bass clarinet	Woodwinds
43	Harp	Strings
44	Double bass	Strings
45	Saxophone	Woodwinds
46	Bass trombone	Brass
\.


--
-- Data for Name: mtm_musicians_concerts; Type: TABLE DATA; Schema: public; Owner: admin123
--

COPY public.mtm_musicians_concerts (musician, concert, instrument) FROM stdin;
2	1	1
2	2	1
2	13	1
3	2	5
3	13	5
3	1	5
5	2	4
5	13	4
5	1	4
7	2	5
7	13	5
7	1	5
2	15	1
6	15	15
7	15	5
2	16	1
6	16	15
7	16	5
5	16	4
8	2	4
8	13	4
8	1	4
8	15	4
8	16	4
2	17	1
6	17	15
9	17	15
8	17	4
5	17	4
7	17	5
2	18	1
6	18	15
8	18	4
5	18	4
7	18	5
2	19	1
3	19	5
8	19	4
5	19	4
7	19	5
2	20	1
3	20	5
8	20	4
5	20	4
7	20	5
2	21	1
3	21	5
8	21	4
5	21	4
7	21	5
2	22	1
3	22	5
8	22	4
5	22	4
2	23	1
3	23	5
2	24	1
3	24	5
5	24	4
23	19	15
23	20	15
23	22	15
23	23	15
23	24	15
24	22	5
26	21	4
26	22	4
27	18	22
27	19	22
27	1	22
28	17	22
28	18	22
28	19	22
30	20	22
31	20	22
31	24	22
38	21	22
38	13	22
38	2	22
39	17	22
40	22	22
41	22	22
42	15	5
42	16	5
42	17	5
42	18	5
44	15	5
44	16	5
44	18	5
44	20	5
44	13	5
45	15	5
46	15	5
46	16	5
47	15	5
47	17	5
47	2	5
48	15	5
49	15	5
49	17	5
49	1	5
49	2	5
50	15	5
51	15	2
52	15	2
52	19	2
53	15	2
54	15	4
54	17	4
54	18	4
54	13	4
55	15	4
55	19	4
56	15	44
56	17	44
56	23	44
56	2	44
56	24	44
57	15	6
57	16	45
58	15	6
58	16	6
58	17	6
58	18	6
58	19	6
58	21	6
58	13	6
58	1	6
58	2	6
59	15	36
59	20	36
59	22	36
59	23	36
60	15	16
60	16	16
60	17	16
60	18	16
61	15	16
61	19	16
61	20	16
61	13	15
61	22	16
61	23	16
61	24	16
62	15	33
62	16	33
62	18	33
62	19	33
62	20	33
62	21	33
62	13	33
62	22	33
62	23	33
62	1	33
62	2	33
63	15	33
63	16	33
63	17	33
63	18	33
63	19	33
64	15	43
64	16	43
64	1	43
65	16	5
65	19	5
66	16	5
67	16	5
67	19	5
67	20	5
67	21	5
67	13	5
67	22	5
67	1	5
67	2	5
67	24	5
68	16	5
69	16	5
70	16	5
70	18	5
70	19	5
70	20	5
70	22	5
71	16	2
71	17	2
71	18	2
72	16	2
72	17	2
73	16	2
74	16	44
74	19	44
74	20	44
74	21	44
76	16	6
76	17	6
76	18	6
77	15	36
77	16	36
78	16	16
79	16	18
80	16	18
80	18	18
81	17	5
81	18	5
82	17	5
83	17	5
83	18	5
83	19	5
83	21	5
83	13	5
83	24	5
84	17	5
84	18	5
85	17	5
85	18	5
86	17	5
86	18	5
86	20	5
86	21	5
86	13	5
86	22	5
86	24	5
87	17	5
87	18	5
87	21	5
87	1	5
88	17	5
89	17	2
89	18	2
91	17	4
92	17	44
92	18	44
92	13	44
93	17	44
93	20	44
93	13	44
93	22	44
94	17	6
94	19	6
94	20	6
95	17	36
96	17	36
97	17	16
98	17	33
99	17	1
99	19	1
99	20	1
99	21	1
99	13	1
99	1	1
99	2	1
99	24	1
100	17	1
100	18	1
100	20	1
100	21	1
100	22	1
102	17	18
103	17	18
104	17	30
105	18	5
105	19	5
105	21	5
106	18	5
106	19	5
106	21	5
106	13	5
106	1	5
106	2	5
107	18	2
108	18	2
109	18	2
109	21	2
110	18	4
112	18	4
113	18	6
113	21	6
113	13	6
113	24	6
114	19	5
114	20	5
114	21	5
114	13	5
114	22	5
114	24	5
115	18	36
115	21	36
115	13	36
115	1	36
115	2	36
116	18	36
117	18	18
118	18	30
119	18	30
119	20	30
120	19	5
121	19	5
122	19	5
123	20	5
123	21	5
123	22	5
125	19	5
126	19	5
126	20	5
126	22	5
126	23	5
126	21	15
127	19	5
127	20	5
127	21	5
127	13	5
127	22	5
127	23	5
127	1	5
127	2	5
127	24	5
128	19	5
128	20	5
128	22	5
128	24	5
129	19	5
130	19	5
131	19	5
133	19	2
134	19	2
134	20	2
135	19	2
135	20	2
136	19	2
137	19	2
137	20	2
137	13	2
137	22	2
137	23	2
138	19	2
138	20	2
139	19	4
140	19	4
141	19	4
141	20	4
141	22	4
142	19	4
143	19	44
143	20	44
144	19	44
146	19	44
147	19	36
147	20	36
148	19	36
148	20	36
149	19	16
149	20	16
149	21	16
150	19	18
151	19	18
151	20	18
151	21	18
151	13	18
151	22	18
151	23	18
152	19	30
152	20	30
153	20	5
154	20	5
155	20	5
155	22	5
156	20	5
157	20	5
157	21	5
157	1	5
158	20	5
158	22	5
158	23	5
159	20	5
160	20	5
161	20	5
162	20	5
162	21	5
163	20	5
164	20	2
164	24	2
165	20	2
166	20	2
166	21	2
166	13	2
166	22	2
166	24	2
167	20	4
168	20	4
168	22	4
168	23	4
168	24	4
169	20	4
170	20	4
170	21	4
170	13	4
170	1	4
172	20	6
173	20	6
174	20	33
174	1	33
175	20	18
175	22	18
176	20	18
177	20	27
178	20	3
178	13	3
179	21	5
179	13	5
179	1	5
179	2	5
180	21	5
181	21	5
181	13	5
181	1	5
181	2	5
182	21	5
182	13	5
182	1	5
182	2	5
183	13	5
183	2	5
184	21	2
185	21	2
185	13	2
185	23	2
185	1	2
185	2	2
185	24	2
186	21	2
186	13	2
186	1	2
186	2	2
187	21	4
187	13	4
187	22	4
187	23	4
187	1	4
187	2	4
187	24	4
188	21	4
189	21	16
189	13	16
189	22	16
189	23	16
189	1	16
189	2	16
189	24	16
190	21	16
191	21	36
191	13	36
191	1	36
191	2	36
192	21	33
192	22	33
193	21	18
194	21	22
194	13	22
195	21	30
195	13	30
196	21	30
197	21	16
199	13	5
199	1	5
200	13	5
201	13	5
202	13	5
202	1	5
203	13	4
204	13	4
204	1	4
205	13	44
207	13	6
207	22	6
207	1	6
207	2	6
208	13	33
209	13	18
209	1	18
209	2	18
209	24	18
210	13	27
210	1	27
211	13	43
212	22	5
213	22	5
213	23	5
214	22	5
214	23	5
214	1	5
215	22	5
215	23	5
216	22	5
217	22	5
217	23	2
218	22	5
218	23	5
219	23	5
220	23	5
221	23	5
222	22	5
222	23	5
223	22	2
224	22	2
225	22	2
226	22	2
227	22	2
228	22	4
229	22	4
230	22	44
231	22	44
231	23	44
232	22	6
232	23	6
232	24	6
233	22	36
234	22	30
234	23	30
234	2	30
235	23	5
236	23	5
237	23	5
238	23	5
239	23	5
240	23	5
241	23	4
242	23	4
243	23	36
244	23	33
245	23	18
246	1	5
247	1	5
247	2	5
248	1	5
248	2	5
249	1	5
250	1	2
251	1	4
253	1	44
254	1	44
255	1	6
255	2	6
256	1	16
257	1	30
257	2	30
257	24	30
258	2	5
259	2	5
260	2	5
261	2	5
262	2	5
263	2	2
265	2	4
266	2	44
267	2	16
268	2	33
269	2	3
270	24	5
271	24	5
272	24	5
273	24	5
274	24	5
275	24	5
276	24	5
277	24	5
278	24	5
279	24	5
280	24	5
281	24	5
282	24	5
283	24	5
284	24	5
285	24	5
286	24	5
287	24	2
288	24	2
289	24	2
290	24	2
291	24	2
292	24	4
293	24	4
294	24	4
295	24	4
296	24	44
297	24	44
298	24	44
299	24	6
300	24	16
301	24	28
302	24	36
303	24	36
304	24	36
305	24	36
306	24	33
308	24	33
309	24	1
310	24	1
311	24	1
312	24	1
313	24	22
314	24	22
315	24	22
316	24	18
317	24	18
318	24	18
319	24	18
320	24	27
321	24	43
322	24	30
323	24	30
324	24	30
325	2	22
325	18	22
325	19	22
326	15	1
326	16	1
326	17	1
326	18	1
326	19	1
326	20	1
326	21	1
326	13	1
326	22	1
326	23	1
326	1	1
326	2	1
326	24	1
328	19	5
328	20	5
328	21	5
329	19	4
329	20	4
329	13	4
329	24	4
330	13	5
330	2	5
331	13	1
332	13	18
333	22	1
334	2	1
1	13	2
1	1	15
1	2	2
1	15	2
1	16	2
1	17	2
1	18	2
1	19	2
1	20	2
1	21	2
1	22	2
1	23	2
1	24	2
171	20	44
171	22	44
171	24	44
90	17	2
90	1	2
90	2	2
90	25	15
336	25	3
264	2	4
420	25	5
421	25	5
422	25	5
423	25	2
424	25	4
425	25	4
427	25	44
428	25	1
431	25	33
101	17	1
101	18	1
101	19	1
101	20	1
101	21	1
101	13	1
101	22	1
101	1	1
75	16	44
75	17	44
75	18	44
420	26	5
179	26	5
49	26	5
87	26	5
421	26	5
259	26	5
260	26	5
261	26	5
3	26	5
67	26	5
183	26	5
106	26	5
44	26	5
248	26	5
422	26	5
1	26	2
185	26	2
186	26	2
423	26	2
288	26	2
223	26	2
187	26	4
5	26	4
264	26	4
424	26	4
425	26	4
55	26	4
427	26	44
58	26	6
255	26	6
207	26	6
189	26	16
267	26	16
306	26	33
431	26	33
99	26	1
428	26	1
2	26	1
326	26	1
151	26	18
209	26	18
27	26	22
257	26	30
115	26	36
303	26	36
198	26	22
336	26	3
90	26	15
29	20	22
29	13	22
29	22	22
206	13	44
426	25	44
426	26	44
145	19	44
145	21	44
124	19	5
307	24	33
252	1	44
162	27	5
49	27	5
260	27	5
179	27	5
127	27	5
271	27	5
375	27	5
343	27	5
270	27	5
111	27	5
3	27	5
106	27	5
248	27	5
183	27	5
247	27	5
1	27	2
185	27	2
90	27	2
136	27	2
187	27	4
5	27	4
264	27	4
294	27	4
426	27	44
171	27	44
207	27	6
255	27	6
189	27	16
267	27	16
174	27	33
2	27	1
100	27	1
99	27	1
151	27	18
209	27	18
198	27	22
27	27	22
313	27	22
257	27	30
3	28	5
183	28	5
87	28	5
114	28	5
339	28	5
106	28	5
248	28	5
129	28	5
166	28	2
185	28	2
109	28	2
204	28	4
5	28	4
54	28	4
75	28	44
207	28	6
115	28	36
305	28	36
308	28	33
101	28	1
179	29	5
201	29	5
277	29	5
282	29	5
128	29	5
286	29	5
3	29	5
281	29	5
168	29	4
294	29	4
264	29	4
5	29	4
189	29	16
75	29	44
56	29	44
207	29	6
94	29	6
2	29	1
326	29	1
303	29	36
322	29	30
257	29	30
315	29	22
319	29	18
166	29	2
1	29	2
90	29	2
43	15	5
43	16	5
43	18	5
43	20	5
43	21	5
43	13	5
43	22	5
43	1	5
43	2	5
43	26	5
43	27	5
43	29	2
442	29	1
451	27	5
452	27	4
453	27	44
454	27	36
455	27	36
456	27	33
457	27	1
458	27	27
459	27	15
460	27	4
461	28	5
462	28	2
463	28	4
464	28	33
465	28	1
466	28	1
467	28	1
468	28	3
469	29	22
470	29	5
471	29	18
472	29	5
473	29	5
474	27	5
474	28	5
474	29	5
475	29	5
476	29	5
477	29	33
478	29	33
479	29	4
480	27	4
480	28	4
480	29	4
481	29	16
482	29	44
483	29	1
484	29	1
485	29	36
486	29	22
487	29	2
488	29	2
489	29	2
449	29	5
491	27	4
490	29	5
450	27	5
492	29	44
\.


--
-- Data for Name: mtm_musicians_instruments; Type: TABLE DATA; Schema: public; Owner: admin123
--

COPY public.mtm_musicians_instruments (musician_id, instrument_id, proficiency_level) FROM stdin;
2	1	Student
3	5	Student
5	4	Amateur - high level
6	15	Amateur - high level
6	3	Professional
6	1	Amateur - low level
6	30	Amateur - medium
7	5	Amateur - high level
8	4	Student
8	3	Amateur - high level
9	15	Professional
9	31	High level professional
24	5	High level professional
26	4	Student
23	16	High level professional
23	15	High level professional
23	32	Professional
25	22	Professional
2	4	Amateur - low level
27	22	Professional
28	22	Professional
30	22	Student
31	22	Amateur - high level
32	22	Amateur - high level
32	33	High level professional
33	22	Student
34	22	Professional
35	22	Student
36	22	Student
37	22	Professional
38	22	Professional
39	22	Professional
40	22	Student
41	22	Student
42	5	Amateur - medium
44	5	Amateur - high level
45	5	Professional
46	5	Student
47	5	Amateur - medium
48	5	Amateur - high level
49	5	Amateur - high level
50	5	Professional
50	2	Professional
51	2	Amateur - low level
52	2	Amateur - high level
53	2	Professional
54	4	Amateur - high level
55	4	Amateur - high level
56	44	Amateur - medium
57	45	Amateur - high level
57	6	Amateur - medium
58	6	Amateur - high level
59	36	High level professional
60	16	Amateur - medium
61	16	Professional
61	15	Amateur - high level
62	33	Amateur - high level
63	33	Professional
64	43	Student
65	5	Student
66	5	Professional
67	5	Amateur - medium
68	5	Amateur - medium
69	5	Amateur - low level
70	5	Student
71	2	Amateur - low level
72	2	Professional
73	2	Professional
74	44	Student
76	6	Professional
76	35	Professional
77	36	Professional
78	16	Professional
78	15	Amateur - high level
79	18	Professional
80	18	Professional
81	5	Amateur - high level
82	5	Amateur - high level
83	5	Student
84	5	Student
85	3	Professional
85	5	Amateur - medium
86	5	Amateur - high level
87	5	High level professional
88	5	Amateur - high level
89	2	Amateur - medium
91	4	Professional
92	44	Professional
93	44	High level professional
94	6	Professional
94	35	Professional
95	36	Professional
95	41	Professional
96	36	Professional
97	16	Amateur - medium
98	33	Professional
99	1	Amateur - high level
100	1	Amateur - medium
102	18	Professional
103	18	Professional
104	30	Professional
105	5	Amateur - high level
106	5	Amateur - medium
107	2	Amateur - medium
108	2	Professional
109	2	Amateur - medium
110	4	High level professional
111	5	Professional
112	4	Professional
113	6	Professional
113	35	Professional
114	5	Professional
115	36	Amateur - medium
116	36	Amateur - high level
117	18	Professional
118	30	Professional
119	30	Amateur - high level
120	5	High level professional
121	5	Student
122	5	Professional
123	5	Student
125	5	Professional
126	5	High level professional
126	15	High level professional
127	5	Amateur - medium
128	5	Amateur - high level
129	5	Amateur - high level
130	5	Amateur - high level
131	5	Professional
132	5	Amateur - medium
133	5	Professional
133	2	High level professional
134	2	Student
135	2	Student
136	2	Student
137	2	Amateur - medium
138	2	Student
139	4	High level professional
140	4	Professional
141	4	Professional
142	4	Student
143	44	Student
144	2	Professional
144	44	Amateur - medium
146	44	Student
147	36	Student
148	36	Student
148	5	Student
149	16	Student
150	18	Professional
151	18	Student
152	30	Student
153	5	High level professional
154	5	Amateur - high level
155	5	Professional
156	5	Student
157	5	Student
158	5	Professional
159	5	Student
160	5	High level professional
161	5	Amateur - high level
162	5	Professional
163	5	Student
164	5	Professional
164	2	Professional
165	2	Student
166	2	Student
167	4	Student
168	4	Student
169	4	Student
170	4	Student
172	6	Student
172	35	Student
173	6	Student
173	35	Student
174	33	Professional
174	34	Professional
175	18	Professional
176	18	Student
177	27	Professional
178	3	Student
179	5	Student
180	5	Amateur - high level
181	5	Amateur - medium
182	5	Amateur - medium
183	5	Amateur - medium
184	5	Amateur - high level
184	2	Amateur - high level
185	2	Professional
186	2	Amateur - medium
187	3	Amateur - medium
187	4	Student
188	4	Amateur - high level
189	16	Student
190	16	Student
191	36	Amateur - high level
192	33	Professional
192	34	Professional
193	18	Student
194	22	Student
195	30	Student
196	30	Student
197	16	High level professional
198	22	Student
199	5	Amateur - medium
200	5	Amateur - high level
201	5	Student
202	2	Amateur - high level
203	4	Professional
204	4	Student
205	44	Amateur - low level
207	6	Amateur - high level
207	35	Amateur - high level
208	33	Amateur - high level
209	18	Student
210	27	Professional
211	43	Student
212	5	High level professional
213	5	Professional
214	5	Student
215	5	Student
216	5	Student
217	5	Professional
217	2	Professional
218	5	Student
219	5	Student
220	5	Professional
221	5	Student
222	5	Professional
223	2	Professional
224	2	Student
225	2	Student
226	2	Student
227	2	Student
228	4	Student
229	4	Student
230	44	Student
231	44	Student
232	6	Professional
232	35	Professional
233	36	Student
234	30	Student
235	5	Student
236	5	Student
237	5	Student
238	5	Student
239	5	Professional
240	5	Student
241	4	Student
242	4	Amateur - medium
243	36	Student
244	33	Professional
245	18	Student
246	3	Student
246	5	Amateur - high level
247	3	Amateur - medium
247	5	Amateur - medium
247	37	Amateur - high level
248	5	Amateur - medium
249	5	Amateur - high level
250	2	Amateur - medium
251	4	Amateur - medium
253	44	Amateur - medium
254	44	Professional
255	6	Amateur - medium
256	16	Student
257	30	Amateur - high level
258	5	Student
259	5	Student
260	5	Student
261	5	Amateur - medium
262	5	Professional
263	2	Amateur - low level
263	18	Student
265	4	Amateur - medium
266	44	Amateur - high level
267	16	Student
268	33	Professional
268	2	Amateur - high level
269	3	High level professional
270	5	High level professional
271	5	High level professional
272	5	Student
273	5	Student
274	5	Amateur - high level
275	5	Student
276	5	Professional
277	5	Professional
278	5	Professional
279	5	Student
280	5	Student
281	5	Amateur - medium
282	5	Student
283	5	Amateur - high level
284	5	Student
285	5	Student
286	5	Amateur - medium
287	2	Student
288	2	Student
289	2	Student
290	2	Professional
291	2	Professional
292	4	High level professional
293	4	Professional
294	4	Student
295	4	Professional
296	44	High level professional
297	44	Student
298	44	Student
299	6	Amateur - high level
299	35	Amateur - medium
300	16	Professional
301	16	Amateur - high level
301	28	Amateur - high level
302	36	Student
303	36	Student
303	41	Student
304	36	Professional
305	36	Student
306	33	Student
308	33	Student
309	1	Student
310	1	Professional
311	1	Professional
312	1	High level professional
313	22	Student
314	22	Student
315	22	Student
316	18	Student
317	18	Student
318	18	Student
319	18	Professional
320	27	Professional
321	43	Student
322	30	Student
323	30	Professional
324	30	Student
325	22	Professional
326	1	Amateur - high level
327	2	High level professional
328	3	Amateur - high level
328	5	Student
329	4	Student
330	5	Amateur - high level
331	1	Amateur - high level
332	18	Student
333	1	Amateur - high level
334	1	Amateur - high level
1	15	Amateur - medium
1	3	Professional
1	2	Amateur - high level
335	33	Professional
171	44	Student
336	3	Professional
90	2	Professional
90	15	Amateur - high level
264	4	Amateur - medium
337	5	Amateur - high level
338	5	Professional
339	5	Amateur - high level
340	5	High level professional
341	5	Professional
342	5	Amateur - high level
343	5	Professional
344	5	Amateur - high level
345	5	Professional
346	5	Professional
347	5	Professional
348	5	Amateur - high level
349	5	Amateur - high level
350	5	Professional
351	5	Professional
352	5	Professional
353	5	Amateur - high level
354	5	Professional
355	5	Professional
356	5	Professional
357	5	Professional
357	2	Professional
358	5	Professional
359	5	High level professional
360	5	Professional
361	5	Professional
362	5	Professional
363	5	Professional
364	5	Professional
365	5	Professional
366	5	Professional
367	5	Professional
368	5	Student
369	5	Professional
370	5	Professional
371	5	Professional
372	5	Amateur - high level
373	5	Student
374	5	High level professional
375	5	High level professional
376	2	Amateur - high level
377	2	Amateur - high level
378	2	Amateur - high level
379	5	High level professional
379	2	High level professional
380	2	Amateur - high level
381	2	Amateur - high level
382	2	Amateur - high level
383	2	Amateur - high level
384	2	Professional
386	2	Professional
387	2	Professional
388	2	Professional
389	2	Professional
390	2	Professional
391	2	Amateur - high level
392	2	Professional
393	2	Professional
394	2	Professional
395	2	Professional
396	2	Professional
397	2	Professional
398	2	Professional
399	2	Professional
400	2	Professional
401	2	Professional
402	2	Professional
403	2	Professional
404	2	Professional
405	2	Professional
406	2	Amateur - high level
407	2	Professional
408	2	Professional
410	2	Professional
411	2	Professional
412	2	Professional
413	2	Professional
414	2	Professional
415	2	High level professional
416	2	Professional
417	2	Professional
418	2	Professional
419	18	Student
420	5	Professional
421	5	Professional
422	5	Amateur - medium
423	2	Amateur - low level
424	4	Student
425	4	Student
427	44	Professional
428	1	Amateur - medium
429	5	Professional
430	2	Professional
431	33	High level professional
101	1	Amateur - medium
75	44	Amateur - high level
432	22	Professional
432	46	Professional
433	22	Professional
29	46	Professional
29	22	Professional
434	22	Professional
206	44	Professional
426	44	High level professional
145	44	Student
435	44	Professional
124	5	Professional
307	33	Professional
409	2	Professional
385	2	Professional
252	44	Professional
43	5	Amateur - high level
43	2	Amateur - high level
436	1	Student
437	1	Student
438	1	Student
439	1	Student
440	1	Student
441	1	Student
442	1	Student
443	1	Student
444	1	Student
445	1	Student
446	1	Amateur - high level
447	1	Student
448	1	Student
451	5	Amateur - medium
452	4	Amateur - high level
453	44	Professional
454	36	Student
455	36	Amateur - medium
456	33	Student
457	1	Amateur - medium
458	27	Amateur - high level
459	15	Professional
459	16	Professional
460	4	Student
461	5	Student
462	2	Amateur - high level
463	4	Student
464	33	Professional
465	1	Student
466	1	Amateur - high level
467	1	Amateur - medium
468	3	Student
469	22	Student
470	5	High level professional
471	18	Student
472	5	Student
473	5	Student
474	5	Student
475	5	Student
476	5	Student
477	33	Student
478	33	Student
479	4	Student
480	4	Professional
481	16	Student
482	44	Student
483	1	Amateur - high level
484	1	Amateur - high level
485	36	Student
486	22	Student
487	2	Professional
488	2	Student
488	5	Student
489	2	Amateur - high level
449	5	Student
491	4	Amateur - medium
490	5	High level professional
450	5	Professional
492	44	Student
\.


--
-- Data for Name: mtm_programs; Type: TABLE DATA; Schema: public; Owner: admin123
--

COPY public.mtm_programs (concert_id, piece_id) FROM stdin;
1	1
1	2
1	3
13	9
13	10
13	11
13	12
13	13
13	14
13	15
13	16
13	17
2	8
2	18
2	19
1	20
15	24
15	21
15	23
15	25
15	22
16	26
16	27
16	28
16	29
16	30
16	31
16	32
16	33
17	34
17	35
17	36
17	37
18	38
18	39
18	40
18	9
18	41
18	42
19	43
19	44
19	45
19	46
19	47
19	48
20	49
20	50
20	51
20	52
20	53
21	54
21	55
21	56
22	57
22	58
23	58
24	59
17	60
25	62
25	61
25	63
26	62
26	61
26	63
26	64
27	65
27	67
27	66
27	68
28	69
28	70
28	71
28	72
29	73
29	74
29	75
29	76
\.


--
-- Data for Name: mtm_soloists; Type: TABLE DATA; Schema: public; Owner: admin123
--

COPY public.mtm_soloists (concert_id, piece_id, soloist_id) FROM stdin;
1	3	2
17	35	8
15	25	7
22	58	24
13	12	7
16	31	42
16	32	58
17	60	60
16	32	64
16	31	66
13	11	113
18	39	114
13	12	114
19	48	148
20	50	160
20	51	160
20	52	160
21	55	197
23	58	235
2	18	269
16	30	326
25	61	336
26	61	336
27	67	460
28	70	468
29	74	490
\.


--
-- Data for Name: musicians; Type: TABLE DATA; Schema: public; Owner: admin123
--

COPY public.musicians (id, first_name, last_name, email, phone, messenger, comments, data_updated) FROM stdin;
81	Claudia	Lindemann	claudialin@web.de				2023-08-17
82	Cindie	Bottemans	cbottema92@gmail.com	0472230631	Cindie Btmn	Bonne violoniste mais pas fiable du tout	2023-08-17
3	Juliette	Coppens	coppens.juliette@gmail.com	0475316758	Juliette Coppens	\N	2023-08-05
5	Samy	Koudsieh	aur.koudsieh@gmail.com	0488432666	Aurélie Koudsieh	\N	2023-08-05
6	Laurent	Beeckmans	lbeeckmans@yahoo.fr	0496983185	Laurent Beeckmans	Mauvaise relation, éviter de contacter	2023-08-05
8	Margot	Demeyere	margot.demeyere@gmail.com	0473232664	Margot Demeyere	comité Melomania jusqu'à l'été 2022	2023-08-06
9	Ewald	Demeyere	ewald.demeyere@gmail.com	0488248569			2023-08-06
83	Mariel	Capilla			Mariel Capilla	Contactée via l'adresse mail de David Capilla	2023-08-17
24	Sylvia	Huang			Sylvia Huang		2023-08-09
2	Pierre	Baudhuin	pierre.baudhuin@skynet.be	0491205487	Pierre Baudhuin	\N	2023-05-29
26	Valentine	Oster	valentine.oster@gmail.com	0473196965	Valentine Oster		2023-08-11
27	Cyril	Francq	francq.cyril@gmail.com	0499632706	Cyril Francq		2023-08-17
28	Boris	Cardon	boris.kardon@outlook.fr		Boris Kardon		2023-08-17
30	Yoran	Ambroes	yoran.ambroes@hotmail.com		Yoran Ambroes		2023-08-17
31	Jorien	Jaques	jorien.jacques@gmail.com		Jorien Jacques		2023-08-17
32	Jappe	Dendievel			Jappe Dendievel		2023-08-17
33	Clément	Desruelles			Clément Desruelles	Pas bonne réputation	2023-08-17
34	Martin	Couvez	couvezm76@gmail.com		Martin Couvez		2023-08-17
35	Thomas	Monden			Thomas Monden		2023-08-17
23	Guy	Van Waas	guyvanwaas@gmail.com	0495546429	Guy Van Waas		2023-08-07
25	Nicolas	Loubaki	nicoloubaki@gmail.com				2023-08-07
7	Guillaume	Tillema	guillaume.tillema@gmail.com	0470049034			2023-08-05
36	Arne	De Clerck			Arne De Clerck		2023-08-17
37	Natanaiel	Tintas			Natanaiel Tintas	Très sympa et toujours prêt à aider à trouver du monde	2023-08-17
38	Luc	Paucot	luc.paucot@yahoo.be	0477975333			2023-08-17
39	Jessica	Gregory	jessicag@iinet.net.au		Jessica Gregory	Australienne, très sympa, mais sans doute de retour en Australie	2023-08-17
40	Stéphane	Huot	stephane.huot89@gmail.com		Stéphane Huot		2023-08-17
41	Nicolas	Tornaire	tornaire.nicolas@gmail.com		Nicolas Tornaire		2023-08-17
42	Etienne	Deckers	etiti147@gmail.com				2023-08-17
44	Isabelle	Combes	icombes1@gmail.com	0473938379			2023-08-17
45	Chloé	Phelps			Chloé Phelps		2023-08-17
46	Maxime	Daniels	didi7816@hotmail.com				2023-08-17
47	Joanie	Good	goodjoanie@hotmail.be		Joanie Good	Etudie au Luxembourg	2023-08-17
48	Samuel	Guéret	gueret.samuel@gmail.com	0476707860	Samuel Guéret	Travaille à Viennes	2023-08-17
49	Kristine	Hansen	kristinesolsikke@gmail.com		Kristine Hansen		2023-08-17
50	Héloïse	Danneels		0493141331	Héloïse Danneels	Altiste à l'orchestre national	2023-08-17
51	Amélie	Lecoeuche	alecoeuche@hotmail.co.uk	00447547902917		Aux dernières nouvelles, habite à Paris	2023-08-17
52	Raphaël	Goulet	goulet.gauer@gmail.com			Adresse partagée avec Céline Gauer (Vc)	2023-08-17
53	Coline	Meulemans	meulemans.coline@hotmail.be	0486981860	Coline Meulemans		2023-08-17
54	Anne-Laure	Pignard	alpignard@yahoo.fr	0476503793	Anne-Laure Pignard		2023-08-17
55	Céline	Gauer	goulet.gauer@gmail.com			Adresse partagée avec Raphaël Goulet (Vla)	2023-08-17
56	Anne	Good	goodvermoteanne@hotmail.com	0486395124	Anne Good		2023-08-17
57	Saskia	Loebel	saskialoebel@yahoo.be		Saskia Loebel		2023-08-17
58	Lucie	Gerard	gerard.lucie@gmail.com	0471950628	Lucie Gerard	A un piccolo	2023-08-17
59	Vinciane	Baudhuin	vinciane.baudhuin@gmail.com	0476413094	Vinciane Baudhuin		2023-08-17
60	Marie	Chauffoureaux	marie.ch.120501@gmail.com	0473370707	Marie Ch		2023-08-17
61	Alain	Baudhuin	alain.baudhuin@skynet.be	0479320062	Alain Baudhuin		2023-08-17
62	Pierre	Dubuisson	pcdubuisson@hotmail.com	0472697389	Pierre Dubuisson		2023-08-17
63	Benoît	Goovaerts	bill610510@gmail.com			Niveau assez moyen, à éviter si possible	2023-08-17
64	Siobhan	Mathiak	siobhan.mathiak@gmail.com	0475938204	Siobhan Mathiak	Excellente mais très difficile à contacter	2023-08-17
65	Emeline	Mottard	mottard.emeline@hotmail.com	0495602967	Emeline Mottard		2023-08-17
66	Isabelle	Rowland	isabelle.a.rowland@gmail.com				2023-08-17
67	Roxana	Morcov	roxana.morcov@gmail.com	0485409561	Roxana Morcov		2023-08-17
68	Yuki	Wii	yuki.whitefox@gmail.com		Yuki Wii		2023-08-17
84	Guillaume	Roux Monet	guillaume.rm@icloud.com			Ancien de la Chapelle Reine Elizabeth	2023-08-17
69	Taline	Rossignol	tal.rossignol@gmail.com		Taline Rossignol		2023-08-17
70	William	Adji	leem.2cv67@gmail.com	00352621241669	William Adji		2023-08-17
71	Claire	de Haut de Sigy	claire2hs@gmail.com	0485585767	Claire de Haut		2023-08-17
72	Taslima	Syed Bastin	taslimasyed@hotmail.com	0474936737	Taslima Syed Bastin	Aux dernières nouvelles, habite en Suède	2023-08-17
73	Rahel	Coquema			Rahel Coquema	Bonne altiste mais personne désagréable	2023-08-17
74	Virgile	Vienne	viennevirgile@gmail.com	0493348191	Virgile Vienne	Mauvaise relation, éviter de contacter	2023-08-17
76	Nora	Froger	nora.froger@yahoo.com		Nora Froger	Excellente piccoliste	2023-08-17
77	Sophie	Robert				Aucune donnée de contact retrouvée	2023-08-17
78	Amélie	Casciato	amcasciato@hotmail.com		Amélie Casciato		2023-08-17
79	Nicolas	Ledigarcher			Nicolas Ledigarcher		2023-08-17
80	Nicolas	Grau Ribes	nico.grauribes@gmail.com		Nicolas Grau Ribes	Bon trompettiste mais mauvaise attitude en répétition	2023-08-17
85	José	Borges	zeborges2000@hotmail.com		Zé Borges		2023-08-17
86	Saba	Capilla		0489317525		Contactée via l'adresse mail de David Capilla	2023-08-17
87	Claudine	Schott	claudine.schott@banksoft.be	0476981668		Retraitée de l'orchestre national	2023-08-17
88	Marcelline	Bosquillon	marcelline.bosquillon@gmail.com		Marcelline Bosquillon		2023-08-17
89	Theresa	Lindemann	theresalin2002@gmail.com		Theresa Lindemann		2023-08-17
90	Romain	Felis	felis.romain@gmail.com	0477653843	Romain Felis		2024-02-29
75	Clément	Meulemans	sitron.lle@gmail.com	0483656678	Sitron El		2024-03-29
29	Yoann	Huot	yhuot89@gmail.com		Yoann Huot		2024-04-16
43	Bénédicte	Havelange	benedicteh@hotmail.co.uk	0486032868	Bénédicte Havelange		2024-07-10
91	Ricardo	Vera	verari165@gmail.com				2023-08-17
92	Rui	Salgado	salgadorui@hotmail.com			Peu fiable, contrebassiste jazz à la base, arrive souvent en retard, non préparé et sans partitions	2023-08-17
93	Natacha	Save	natacha.save@gmail.com	0496231643			2023-08-17
94	Louise	Couteau	couteaulouise@orange.fr		Louise Couteau	Excellente flûtiste, super sympa	2023-08-17
95	Cecilia	Castro	ceciliacastr0@hotmail.com		Cecilia Castro		2023-08-17
96	Julie	Arnaud	julie.arnaud.cts@orange.fr		Julie Arnaud		2023-08-17
97	Arthur	Gontier	arthurm.gontier@gmail.com				2023-08-17
98	Marcello	Giannandrea	marcellogiannandrea@live.com			Est venu non préparé au concert de mai 2019. Donne cours à WSL	2023-08-17
99	Paul	Litterio	litterio@uwalumni.com		Paul Litterio		2023-08-17
100	Edouard	Lardin	edoulardin@gmail.com	0479224572	Edouard Lardin		2023-08-17
102	Irene	Monari	irenemonari4@gmail.com	00393469709736	Irene Monari		2023-08-17
103	Simeon	Leroux	simeonlrx@gmail.com			Contacté via Irene Monari	2023-08-17
104	Gideon	Van Canneyt			Gideon Van Canneyt		2023-08-17
105	Sylwia	Malachowksa	syl.mal44@gmail.com	0470550369		Pas toujours aussi fiable	2023-08-17
106	Héloïse	Baudhuin	baudhuinheloise@gmail.com	0474125908	Héloïse Baudhuin		2023-08-17
107	Ziska	Amilhat	ziska.amilhat@gmail.com		Ziska Amilhat		2023-08-17
108	Edelson	Orlandelli	edel.orlandeli@gmail.com			Diplômé de conservatoire, travaille en tant que biologiste	2023-08-17
109	Sara	Labidi	saralab@msn.com	0497383103		Secrétaire de l'académie de Bruxelles Ville	2023-08-17
110	Corinna	Lardin				Violoncelliste à la Monnaie, toujours contactée via Edouard Lardin	2023-08-17
111	Nicolas	Belle	nico.belle@hotmail.be				2023-08-17
112	Mariah	Larsen			Mariah Larsen	Potentiellement rentrée aux Etats-Unis (mais très sympa et excellente)	2023-08-17
113	Zoé	Beaudoin	beaudoin.zoe@gmail.com	0033602364194	Zoé Beaudoin		2023-08-17
114	David	Capilla	davcap777@hotmail.com	0488181962			2023-08-17
115	Serdane	Baudhuin	serdane@skynet.be	0492830096			2023-08-17
116	Michiko	Matsuda Hokimoto	matsuko316@gmail.com		Michiko Matsuda Hokimoto	Ne parle pas français, contacter en Anglais. Habite au Japon aux dernières nouvelles	2023-08-17
117	Quentin	Chatellier	chatellier.quentin@yahoo.fr				2023-08-17
118	Benjamin	Lambert	benjaminlambert5621@gmail.com				2023-08-17
119	Pablo	Schwilden Diaz	peschwildendiaz@hotmail.com	0499184492			2023-08-17
120	Igor	Semenoff	igorsemenoff@scarlet.be	0493138676			2023-08-17
121	Guillaume	Duby	gper10463@gmail.com		Guillaume Duby	Concertmaster du YBS en 2023-2024	2023-08-17
122	Céline	Rulens	celinerulens@hotmail.com				2023-08-17
123	Hanon	Inatomi	hanoncantabile.violin2402@gmail.com	0493647306	Hanon Inatomi	Contacter en Anglais	2023-08-17
125	Astrid	Rios	astridnrm21@gmail.com		Astrid Rios		2023-08-17
126	Thomas	Van Haeperen	thomasvanhaeperen@gmail.com	0486506854			2023-08-17
127	Judith	Van Haeperen	judithvanhaeperen@gmail.com		Judith Van Haeperen		2023-08-17
128	Laura	Toussaint	lauratoussaint2002@gmail.com	0477917672	Laura Toussaint		2023-08-17
129	Mélodie	Koudsieh	melodie.koudsieh@gmail.com		Mélodie Koudsieh		2023-08-17
130	Audrey	Hanson	audrey_hanson@hotmail.com	0495829017	Audrey Hanson		2023-08-17
131	Margaux	Andrews	margaux_andrews@hotmail.fr		Margaux Andrews		2023-08-17
132	Margaux	Constant	margaux.constant@gmail.com	0493810250			2023-08-17
133	Laure	Bellessa	laure.bellessa@gmail.com	0478776028			2023-08-17
134	Rene	Cobben	cobbenr@gmail.com		Rene Cobben		2023-08-17
135	Catharina	Depré			Catharina Depré		2023-08-17
136	Lucia	Alonso	lucalher980617@gmail.com		Lucia Alonso		2023-08-17
137	Caroline	Walcot	walcotc@gmail.com	0495205958			2023-08-17
138	Aurore	Pignoque	pignoqueaurore@gmail.com		Aurore Pignoque	Etudiante au CNSM de Lyon (depuis 2020)	2023-08-17
139	Didier	Poskin	poskin.didier@gmail.com	0477583564			2023-08-17
140	Léa	Halimi	leahal@hotmail.fr		Léa Halimi		2023-08-17
141	Catherine	Courjal	cath73.c@gmail.com				2023-08-17
142	David	Penitzka	david.penitzka@gmail.com				2023-08-17
143	Orion	Lavin Martinez	orilavmar@gmail.com	0471762925	Orion Lavin Martinez		2023-08-17
144	Stéphane	Colin	colin.stephane@skynet.be	0472692832		Ne joue presque plus d'alto	2023-08-17
146	Yves	May	louis.cambreleng@gmail.com				2023-08-17
147	Jonas	Schoups	jonas.schoups@icloud.com		Jonas Schoups	Bon hautboïste mais problèmes d'attitude	2023-08-17
148	Anouk	Vandenbussche	anouk.vandenbussche77@gmail.com		Anouk Vandenbussche		2023-08-17
149	Marie	Zborowski	mariezborowski1@gmail.com	0478726457	Marie Zborowski		2023-08-17
150	Valentin	Walbrecq	valentinwalbrecq@gmail.com			Très mauvaise performance en juillet 2020, ne pas recontacter	2023-08-17
151	Baptiste	Marchal	bptstmarchal@gmail.com	0495869697	Baptiste Marchal		2023-08-17
152	Aron	Anthonipillai	aron.anthonipillai@student.rhizo.be		Aron Anthonipillai		2023-08-17
153	Noémi	Tiercet	louno22@hotmail.com	0473412041		Cheffe d'attaque à la Monnaie	2023-08-17
154	Sofia	Donmingez	carmen_sofia_17@hotmail.com	0050765682125	Carmen Sofia Rodriguez		2023-08-17
155	Sarah	Sabahi	sarah_2610@hotmail.fr		Sarah Sabahi		2023-08-17
156	Ananda	Gulab	ananda.gulab@telenet.be		Ananda Gulab		2023-08-17
157	Lieze	Cattrysse	cattrysse.lize@gmail.com		Lieze Cattrysse		2023-08-17
158	Aurore	Nelles	aurorenelles@hotmail.com		Aurore Nelles		2023-08-17
159	Tulien	van Renterghem	2001tul13n@gmail.com		Tulien van Renterghem		2023-08-17
160	Shirly	Laub	shirlylaub@hotmail.com	0473292224			2023-08-17
161	Dries	de Haas	driesdehaas@gmail.com		Dries de Haas		2023-08-17
162	Eliana	Schuermans	eliana1511@me.com		Eliana Schuermans		2023-08-17
163	Victor	van Gorp	victor.vioolpiano@gmail.com		Victor Van Gorp		2023-08-17
164	Valentine	Lambert	lambertvalentine@gmail.com		Valentine Lambert		2023-08-17
165	Agathe	Lust	lustagathe66@gmail.com		Agathe Lust		2023-08-17
166	Lucille	Chevalier	lucille.chevalier@gmail.com	00447765026069	Lyllou C Lucille		2023-08-17
145	Nassim	Atar	attar.nass7@gmail.com	0033695912558	Alex Grant	Très bon contrebassiste mais mauvaise attitude	2024-04-16
167	Ceres	Lauwers	cereslauwers@gmail.com		Ceres Lauwers		2023-08-17
168	Aneline	Depièreux	aneline@depiereux.be		Aneline Depiereux		2023-08-17
169	Emiel	Vertongen	emiel.vertongen@hotmail.com		Emiel Vertongen		2023-08-17
170	Alejandra	Gonzalez	alejandragisselle21@gmail.com	0487752014			2023-08-17
172	Marion	Pottier	marion.pottier@hotmail.fr		Marion Pottier		2023-08-17
173	Clémence	Béal	clemence.beal6@gmail.com	0033781931050	Clémence Béal		2023-08-17
174	Bruno	Ricci	riccibruno84@gmail.com	0486166181			2023-08-17
175	Aloïs	Houdart	alois.houdart@hotmail.be		Aloïs Houdart	Trompettiste moyen, et gros problème d'attitude. Ne jamais mettre dans la même pièce que Guy Van Waas	2023-08-17
176	Warre	Dendievel	warre.dendievel@gmail.com		Warre Dendievel		2023-08-17
177	Tom	Luc	tomdescollines@gmail.com		Tom Luc		2023-08-17
178	Nina	Nemry	nina.nemry@gmail.com		Nina Nemry	Joue occasionellement aussi des percussions	2023-08-17
179	Sanae	Plumanns	sanaeplumanns@gmail.com	0479810671			2023-08-17
180	Michelle	Sun	sun.michelle@gmx.at			Peu fiable	2023-08-17
181	Ana	Ramos	aramosa@aragon.es	0034655869519		Toujours super motivée et préparée	2023-08-17
182	Miriam	Moreno	moreno.s.miriam@gmail.com	0034696847939		Toujours super motivée et préparée	2023-08-17
183	Laurent	Paucot	laurent.paucot@gmail.com		Laurent Paucot		2023-08-17
184	Hugo	Contessoto	contessotto.hugo@hotmail.com	0498238405		Habite à Bordeaux	2023-08-17
185	Samuel	Wijnbergen	samuel.wijnbergen@laposte.net	00352661882533	Samuel Wijnbergen		2023-08-17
186	Adeline	Paucot	adeline.paucot@yahoo.com	0471374015		Habite à Binches	2023-08-17
187	Maxence	Matagne	maxence.matagne@gmail.com	0497539364	Maxence Matagne		2023-08-17
188	Leonie	Anja Baumann	leo.b@gmx.net			Habite à Bonn	2023-08-17
189	Leidy	Johanna Mendez	leidymaria.17@hotmail.com		Leidy Johanna Mendez		2023-08-17
190	Kian	Janssen	kianjan02@gmail.com		Kian Janssen	Bon clarinettiste mais peu fiable	2023-08-17
191	Guillermo	Saez Gomez	guillermosaezgomez@gmail.com	0483994103			2023-08-17
192	Diedelinde	Buffel	diedelinde.linskens.buffel@skynet.be		Diede Linde		2023-08-17
193	Florian	Benoist-Foucher	benoistfoucher.florian@gmail.com		Florian Benoist-Foucher	Pas très bon, éviter de contacter pour des projets de haut niveau	2023-08-17
194	Nicolas	Berkmans	n.berkmans@outlook.com		Nicolas Berkmans	Parfois pas très fiable	2023-08-17
195	Enora	Yang	enora.yang@gmail.com		Enora Yang	Très fiable et excellente	2023-08-17
196	Marianna	Zagrodzka	zagrodzkamarianna@gmail.com		Marianna Zagrodzka		2023-08-17
197	Benjamin	Dieltjens		0497549943			2023-08-17
198	Annika	Küster		00352691588442		Français peu fluide	2023-08-17
199	Amélie	Beauville	amelie.beauville@gadz.org	0033659207898			2023-08-17
200	Luisa	Zin	zinluisa@gmail.com	00393490745598	Luisa Zin		2023-08-17
201	Eva	Puebla Chacon	evagpuebla@gmail.com		Eva Georgina Puebla Chacon		2023-08-17
202	Claude	Serwier	claudeser@gmail.com	0485035622			2023-08-17
203	Camille	Muller	camille.muller6@gmail.com		Camille Muller		2023-08-17
204	Reginald	Fromonteil	reginald.fromonteil@orange.fr		Reginald DF		2023-08-17
205	Frédéric	Dezoteux	fredericdezoteux@hotmail.com			élève de Natacha Save	2023-08-17
207	Laurence	Schubert	laurence.schubert@schubert.be	0478223624	Laurence Schubert		2023-08-17
208	Pascale	Brasseur	pasbra1106@gmail.com				2023-08-17
209	Charlotte	Miller	millercharlotte@mail.com	0468540682			2023-08-17
210	Laurent	Stordeur	laurent.stordeur@skynet.be	0479647515			2023-08-17
211	Solenn	Dadashlou	solenndadashlou@yahoo.fr				2023-08-17
212	Sophie	Causanschi	sophiecausanschi@gmail.com	0486547419		S'entend mal avec Guy Van Waas. Premier violon à l'orchestre national	2023-08-17
213	Souad	Bahbah	souad1500@hotmail.fr	0488290952			2023-08-17
214	Nathan	Quirynen	nathan.quirynen2@gmail.com		Nathan Quirynen		2023-08-17
215	Julie	Syne	julie.syne@gmail.com		Julie Syne		2023-08-17
216	Emilia	Carmona	emiliaecarmona@gmail.com				2023-08-17
217	Bo	van den Abbeelen	bovdabbeelen@hotmail.com	0031625311607	Bo van den Abbeelen		2023-08-17
218	Augustine	Parmentier	a.parmentier478@laposte.net		Augustine Parmentier		2023-08-17
219	Rei	Kimotsuki	chobisuke.8209@gmail.com				2023-08-17
220	Olga	Groppo	olghisch@gmail.com		Olga Groppo		2023-08-17
221	Andreas	Strobel	astrobel00@gmail.com				2023-08-17
222	Olivia	Tries	lili.tries@hotmail.be		Olivia Tries	Master en orchestre, très sympa et excellente	2023-08-17
223	Sophie	Gailly	sophie.gailly@hotmail.fr	0484122868	Sophie Gailly	Master en orchestre, très sympa et excellente	2023-08-17
224	Laure	Declerck	laure@luthier-nice.com		Laure Declerck	Française	2023-08-17
225	Nanxi	Dong	nanxiaile@gmail.com			Ne parle pas français	2023-08-17
226	Pauline	Gmyr	paulinealto@hotmail.fr			Française	2023-08-17
227	David	Blanco de Paz	Davidbpzviola@gmail.com		David Blanco de Paz		2023-08-17
228	Lucie	Murris	lucie.murris@gmail.com			Française (étudie au CNSM de Lyon)	2023-08-17
229	Jeanne	Burdin	jeanneburdin44@gmail.com		Jeanne Burdin		2023-08-17
230	Clément	Roger	clementroger66@gmail.com			Français (étudie au CNSM de Lyon)	2023-08-17
231	Aymeric	Passa-Cornette	ay.passa@free.fr		Aymeric Passa Cornette		2023-08-17
232	Guido	Janssens	guido.js@outlook.com	0470419469	Guido Janssens Schellekens		2023-08-17
233	Emilie	Ballinger	emilie@ballinger.lu		Emilie Ballinger	Luxembourgeoise, étudie à Namur	2023-08-17
234	Lucas	Bovy	lucasbovy02@gmail.com	0472888485	Lucas Bovy		2023-08-17
235	Emmanuel	Coppey	emmanuel.coppey@gmail.com	0033640561251		Chapelle Reine Elisabeth	2023-08-17
236	Diego	Aragon	diego.aragongonzalez@etu.artsaucarre.be				2023-08-17
237	Wakana	Hamabe	wakana.hamabe@gmail.com				2023-08-17
238	Melissa	Carñaval Lopez	melissacl0422@gmail.com				2023-08-17
239	Kristina	Howells	kristinahowells@msn.com		Kristina Violinist Howells	Eviter de contacter, vient non préparée persuadée de nous sauver la vie	2023-08-17
240	Maïté	Molinaro	molimaite@gmail.com				2023-08-17
241	Eva	Van den Broeck	eva.vandenbroeck2@gmail.com		Eva Van den Broeck		2023-08-17
242	Gabrielle	de Burbure		0479642503			2023-08-17
243	Alex	Maurice	alexmaurice584@gmail.com				2023-08-17
206	Marta	Soares	marta_soares89@hotmail.com		Marta Soares		2024-04-16
244	Emma	de Bakker	emmadebakker@hotmail.com	0487460757	Emma de Bakker		2023-08-17
245	Walter	Mena	x.trompetista@gmail.com		Walter Mena	Sud-Américain, étudie en France	2023-08-17
246	Jeanne	Pinget	jeanne.pinget@gmail.com	0033652887896			2023-08-17
247	Emma	Barton-Smith	emmagachai@live.com	0476364730	Emma Barton-Smith		2023-08-17
248	Aude	Brinckmann-Hornbogen	aude.brinkmann@gmail.com		Aude Brinckmann-Hornbogen		2023-08-17
249	Florencia	Pancitti	floripa@hotmail.it				2023-08-17
250	Samuel	Jottrand	samuel.jottrand@hotmail.be				2023-08-17
251	Emilien	Jottrand	emilien.jot@gmail.com				2023-08-17
253	Vincent	Devillez	devillez.vanmechelen@skynet.be				2023-08-17
254	Shih-Wen	Lee	s092480@gmail.com				2023-08-17
255	Julie	Delescluse	matthieudelescluse@hotmail.com			Contacter via son père	2023-08-17
256	Minhye	Jo	minhyejo.55@gmail.com				2023-08-17
257	Isabel	Delarsille	isabel.delarsille@uclouvain.be	0485662366			2023-08-17
258	Lorena	Lario	lariolorena@gmail.com	0034687294480	Lorena Lario		2023-08-17
259	Vladyslava	Haienko	vladyslava2007@gmail.com	0471299021	Vladyslava Haienko		2023-08-17
260	Sarah	Mezoudi	sarahmezoudi@gmail.com				2023-08-17
261	Célestin	Triffaux	triffc22@icloud.com				2023-08-17
262	Mario	Guierre	mario.guierre@hotmail.fr		Mario Guierre		2023-08-17
263	Jeremie	Boller	jeremie.boller@gmail.com				2023-08-17
265	Raphaël	Pagé	raphael@paph.be				2023-08-17
266	Simon	Dalferth	sdalferth@googlemail.com				2023-08-17
268	Guillaume	Donnet	gdonnet@gmail.com		Giam Donnet	Peut être assez désagréable	2023-08-17
269	Monika	Dars (Darzinkeviciute)		0496782027			2023-08-17
270	Challain	Ferret	ch.ferret@live.fr	0492880724			2023-08-17
271	Alexis	Delporte	alexis.delporte@gmail.com	0492535946		Brussels Philharmonic	2023-08-17
272	Louise	Drancourt	louise.drancourt@gmail.com	00620795057			2023-08-17
273	Solenn	Hubert	solennhubert.sh@gmail.com	0033695803454			2023-08-17
274	Marc	Mignon	marc.mignon@skynet.be	0474521547			2023-08-17
275	Ève	Koudache	evekoudache@gmail.com	0033641838243			2023-08-17
276	Pauline 	Dubois	paulinevaleriedubois@gmail.com	0033628380559			2023-08-17
277	Mélina	Wasson	melina.wasson@gmail.com	0498792762			2023-08-17
278	Emma	Downes	downesemma@gmail.com	00353876637828			2023-08-17
279	Dyana-Tawizett	Kacimi	kacimi.dyana.tawizett@gmail.com	0033782977307			2023-08-17
280	Lisa	Parmentier	parmentier.lisa@gmail.com	0476633254			2023-08-17
281	Noé	Beaujot	noe.beaujot@gmail.com	0471312065		Très motivé, très bien préparé	2023-08-17
282	Aude	Vandenputte	aude@vandenputte.be	0487662110			2023-08-17
283	Nhân	Massart	nhan.massart@gmail.com	0496375970			2023-08-17
284	Elisavet	Georgiadou	elisavetgeorgiadou@gmail.com	0485392682			2023-08-17
285	Hannah	Berly	hannah.berly@gmail.com	0033652456944			2023-08-17
286	Aurélie	Dell	aurelie.dell@outlook.com	0471801727			2023-08-17
287	Raphaël	Murphy	cegregoire@yahoo.com	003367335356		Difficile à joindre, famille fort technophobe	2023-08-17
288	Kim	Ryeongrin 	crua0104@gmail.com	0492959465			2023-08-17
289	Hang	Su	suuu.wany@gmail.com	0488125595			2023-08-17
290	Jasmien	van Houtem	jasmienvh@gmail.com	0476846900			2023-08-17
291	Charles	Lucchinacci	charleslucchinacci@hotmail.com	0033685275404			2023-08-17
292	Corentin	Fauré	corentin.faure@gmail.com	0498213793			2023-08-17
293	Yseult	Kervyn	yseult_k@yahoo.fr	0495368786			2023-08-17
294	Clara	Févelat	fevelat.clara@outlook.fr	0033644996721		Française	2023-08-17
295	Pauline 	Lambert	paulicello12@gmail.com	0033673619524			2023-08-17
296	Elias	Bartholomeus	elias.bartholomeus@mac.com	0477661511			2023-08-17
297	Thibaut	Vallet-estano	thibaut.vallet-estano@outlook.fr	0033783454488		Ne pas mettre dans la même pièce qu'Elias Bartholomeus	2023-08-17
298	Noémie	Malo	n.malo22@ejm.org	0033633822063		Française	2023-08-17
299	Célestin 	Garnier 	celestinpiccolo@gmail.com	0033646852533		Française	2023-08-17
300	Hanne	Beyens	b.hanne@hotmail.com	0475293612			2023-08-17
301	Abby	Tress	ajtress@gmail.com	0491295787			2023-08-17
302	Germain 	Bonnard 	germain80420@gmail.com	0033652375392		S'est montré fort collant avec sa voisine de pupitre en juillet 2023	2023-08-17
303	Coline	Buisset	coline.buisset@gmail.com	0033604515682			2023-08-17
304	Christophe 	Warembourg 	chriswarembourg@gmail.com	0033662175774			2023-08-17
305	Tempels	Sylvain	sylvain@tempels.be	0477700963			2023-08-17
306	Pieter	Opsteyn	pieter.opsteyn@telenet.be	0495155776			2023-08-17
308	Gérard 	Degrez	gerard.degrez@yahoo.fr	486304723			2023-08-17
309	Reindert	Geirnaert	reindertgeirnaert@gmail.com	0475603301			2023-08-17
310	Jason	Enuset	jason_enuset@hotmail.com	0477866915			2023-08-17
311	Urmin	Majstorović 	urminm@gmail.com	0483298270			2023-08-17
312	Anthony 	Blondeau 	anthony.blondeau59400@gmail.com	0033645696232		Français	2023-08-17
313	Pepijn	Bessemans	pepijn.bessemans9@gmail.com	0476771540			2023-08-17
314	Léane	Berthaud	leane.berthaud07@gmail.com	0033667797128		Française	2023-08-17
315	Mjolnir	Pauwels	mjolnir.pauwels@gmail.com	0468175130			2023-08-17
316	Siebren	Vanbrabant	siebren.vanbrabant@hotmail.com	0496252770			2023-08-17
317	Pirola	Damien	damien-pirola@hotmail.fr	0033660350993		Français	2023-08-17
318	Tuur	Verstaen	tuurverstaen@gmail.com	0484651256			2023-08-17
319	Mathieu 	Devaux dit Lalande	mathieu.ddl@gmail.com	0476019071			2023-08-17
320	Bart	Van Neyghem	bart.van.neyghem@gmail.com	0496864322		Retraité	2023-08-17
321	Marie-Laure	Casier	marielaure.casier@gmail.com	0033695927062			2023-08-17
322	Ivan	Iagodzinschi	ivaniagodzinschi7792@gmail.com	0485962639			2023-08-17
323	Mathijs	Everts	mathijseverts123@gmail.com	0470090606			2023-08-17
324	Karel	Opsteyn	karel.opsteyn@gmail.com				2023-08-17
325	Jean-Baptiste	Chenot	jeanbaptiste.chenot@gmail.com		Jean-Baptiste Chenot		2023-08-17
326	Jean-Pierre	Faucon	jeanpierre.faucon@gmail.com		Jean-Pierre Faucon		2023-08-17
267	Valentin	Vander Putten	vanderputtenvalentin@gmail.com				2023-08-17
307	Félix	Lesourd		0033651517478		Français	2024-05-25
327	Dominique	Lardin	domlardin@scarlet.be	32489229031		Altiste à la Monnaie	2023-08-17
328	Noémie	Nemry	noemie.nemry@yahoo.be	484804478	Noémie Nemry		2023-08-17
329	Ophélie	Giovani	giovani.ophelie@gmail.com		Ophélie Giovani		2023-08-17
330	Stephanie	Miu	miuhoch@gmail.com				2023-08-17
331	Clare	Roberts	clare.laurent@telenet.be				2023-08-17
332	Sylvestre	Moreau					2023-08-17
333	Léa	Diodori	leadiadori@gmail.com		Lea Diodori		2023-08-17
334	Alexis	Marguerite	alexis1marguerite@gmail.com				2023-08-17
384	Francesca	Manocchio			Francesca Manocchio	Recommandée par Héloïse Danneels en 2021	2024-03-06
1	Aurian	Baudhuin	naur@skynet.be	0494708042	Aurian Baudhuin	None	2023-08-19
335	Valérie	Trangez		0475681163	Valérie Trangez	Jeunie pro, très sympa, donne beaucoup de contacts	2023-11-12
171	Emile	Van der Stichelen Rogier	milou.link@gmail.com	0491500702	Emile Van der Stichelen		2023-11-14
336	Salvatore	Sclafani			Salvatore Sclafani	Toujours contacté via Romain Félis. \nPas un très bon pianiste, ne pas prendre en soliste.	2024-02-29
264	Esther	Le Bot Gautier	esther.lebotgautier@gmail.com	0470097573			2024-03-06
337	Ella	Adler	ella.adler@hotmail.com			Recommandée par Marc Mignon en 2020	2024-03-06
338	Sylvie	Bagara		474555401		Recommandée par Isabelle Bonesire et contactée pour juillet 2020, pas libre mais enthousiaste	2024-03-06
339	Isabelle	Baudewyns	isabellebaudewyns@yahoo.fr			Recommandée par Marc Mignon en 2020	2024-03-06
340	Isabelle	Bonesire	isabellebonesire1@gmail.com	485443986		Partante mais pas libre pour juillet 2020	2024-03-06
341	Gaëlle	Boqué			Gaëlle Boqué	Recommandée par Héloïse Danneels en 2021	2024-03-06
342	Silke	Brehm	silke.brehm@gmx.de			Recommandée par Marc Mignon en 2020	2024-03-06
343	Paula	Carmona			Paula Carmona	Recommandée par Héloïse Danneels en 2021	2024-03-06
344	Philippe	De Clerck	ph.de.clerck@skynet.be			Recommandée par Marc Mignon en 2020	2024-03-06
345	Merlijn	de Coorde			Merlijn de Coorde	Recommandée par Héloïse Danneels en 2021	2024-03-06
346	Aymeric	de Villoutreys		472896057		Recommandée par Isabelle Bonesire	2024-03-06
347	Alison	Denayer	alisonviolin@gmail.com	477206779		Recommandée par Isabelle Bonesire et contactée pour juillet 2020, pas libre mais enthousiaste	2024-03-06
348	Karen	Downie	karendownie@hotmail.com			Recommandée par Marc Mignon en 2020	2024-03-06
349	Simon	Dresse	simon.dresse@skynet.be			Recommandée par Marc Mignon en 2020	2024-03-06
350	Margot	Gillet			Margot Gillet	Recommandée par Héloïse Danneels en 2021	2024-03-06
351	Françoise	Hendrix	francoise.hendrix@icloud.com		Françoise Hendrix	Heure de musique	2024-03-06
352	Aline	Janacek		486293241		Recommandée par Isabelle Bonesire et contactée pour juillet 2020, pas libre mais enthousiaste	2024-03-06
353	Petra	Keil	p.keil@aiic.net			Recommandée par Marc Mignon en 2020	2024-03-06
354	Dahud	le Meur			Dahud le Meur	Recommandée par Héloïse Danneels en 2021	2024-03-06
355	Claire	Lechien		474839996		Antwerp Symphonic, recommandée par Isabelle Bonesire	2024-03-06
356	Clara	Levy		497151090		Recommandée par Vinciane Simon pour session 2020	2024-03-06
357	Ana	Marjanovic		497551664		Recommandée par Vinciane Simon pour session 2020	2024-03-06
358	Sophie	Naïsseh			Sophie Naïsseh	Recommandée par Héloïse Danneels en 2021	2024-03-06
359	Nana	Kawamura	nana_kawamura@hotmail.com	478384498		Orchestre de la Monnaie	2024-03-06
360	Maria Luisa	Rico Panadero	violin_lisa@hotmail.com	471478450		Recommandée par Isabelle Bonesire	2024-03-06
361	Lisa	Rybenzeva		486524557		Recommandée par Isabelle Bonesire. Parle essentiellement russe	2024-03-06
362	Ingrid	Schang			Ingrid Schang	Recommandée par Héloïse Danneels en 2021	2024-03-06
363	Pascal	Schmidt		479631361		OCRW, recommandé par Isabelle Bonesire	2024-03-06
364	Isabelle	Scoubeau	isabellescoubeau@gmail.com	479207318		Recommandée par Isabelle Bonesire	2024-03-06
365	Vinciane	Simon		479354669		Recommandée par Isabelle Bonesire	2024-03-06
366	Sayana	Tchankova	sayana-tchankova@ya.ru	485535703		Recommandée par Isabelle Bonesire et contactée pour juillet 2020, pas libre mais enthousiaste	2024-03-06
367	Orlane	Tissier	orlane8@wanadoo.fr	479810078		Recommandée par Isabelle Bonesire	2024-03-06
368	Anton	Van Durme			Anton Van Durme		2024-03-06
369	Gergely	Kota	kotagergely@gmail.com	485962933		Recommandé comme CM par Guy Van Waas	2024-03-06
370	Sapir	Chmelkin			Sapir Schmelkin		2024-03-06
371	Rachel	Bonfond			Rachel Bonfond		2024-03-06
372	Danielle	Pulinx		471631396		Recommandée par Fanny Roosels	2024-03-06
373	Théo	Hubert			Théo Hubert		2024-03-06
374	Anne	Leonardo		475891458		Orchestre National, souvent contactée pour CM pour les sessions, jamais libre mais toujours prête à aider	2024-03-06
375	Pierre	Vopat		493639313		Orchestre de la Monnaie	2024-03-06
376	Laure	Bonnemaison	laure.bonnemaison@outlook.fr				2024-03-06
377	Cécile	Dresse	simon.dresse@skynet.be			Recommandée par Marc Mignon en 2020	2024-03-06
378	Christine	Graeber	christine@graeber.be			Recommandée par Marc Mignon en 2020	2024-03-06
379	Vincent	Hepp	vincenthepp@gmail.com	478921160			2024-03-06
380	Catherine	Maerten	cath_maerten@hotmail.com			Contactée via Pierre Dubuisson	2024-03-06
381	Pascale	Nagels	pascale.nagels@solvay.com	475591561			2024-03-06
382	Alba	Ocampo		479888785			2024-03-06
383	Fanny	Roosels	fanny.roosels@skynet.be			Recommandée par Marc Mignon en 2020	2024-03-06
386	Saray	Barrera Reyes			Saray Barrera Reyes	Recommandée par Héloïse Danneels en 2021	2024-03-06
387	Jonny	Viloria			Jonny Villoria	Recommandée par Héloïse Danneels en 2021	2024-03-06
388	Emeline	de Belder			Emeline de Belder	Recommandée par Héloïse Danneels en 2021	2024-03-06
389	Laura	Marchetti			Laura Marchetti	Recommandée par Héloïse Danneels en 2021	2024-03-06
390	Elise	Rens			Elise Rens	Recommandée par Héloïse Danneels en 2021	2024-03-06
391	Tony	de Vuyst			Tony de Vuyst	Recommandée par Héloïse Danneels en 2021	2024-03-06
392	Irène	Leroy			Irène Leroy	Recommandée par Héloïse Danneels en 2021	2024-03-06
393	Emilien	Stocker			Emilien Stocker	Recommandée par Héloïse Danneels en 2021	2024-03-06
394	Maxime	Devynck			Maxime Devynck	Recommandée par Héloïse Danneels en 2021	2024-03-06
395	Armelle	Krings			Armelle Krings	Recommandée par Héloïse Danneels en 2021	2024-03-06
396	Paula	Cirmi			Paula Cirmi	Recommandée par Héloïse Danneels en 2021	2024-03-06
397	Cristina	Flueras			Cristina Flueras		2024-03-06
398	Jose	Maria Azavedo			Jose Maria Azavedo		2024-03-06
399	Alice	Sinacori			Alice Sinacori		2024-03-06
400	Francisca	Barata Feyo			Francisca Barata Feyo		2024-03-06
401	Lucia	Gil			Lucia Gil		2024-03-06
402	Abraham	Nogueira			Abraham Nogueira		2024-03-06
403	Ana Sofia	Sousa			Ana Sofia Sousa		2024-03-06
404	Christian	Ivan Lpz Bailon			Christian Ivan Lpz Bailon		2024-03-06
405	Paloma	Pérez Garcia			Paloma Pérez Garcia		2024-03-06
406	Ursula	Wieser				Demander coordonnées à Marc Mignon	2024-03-06
407	Roman	Borkovsky		477898707		Ne prend pas de projets non payés	2024-03-06
408	Manon	Vervaet		476584227		Recommandée par Anne Leonardo pour 2023	2024-03-06
410	Hélène	Petit		487510205		Recommandée par Anne Leonardo pour 2023	2024-03-06
411	Amaryllis	Bartholomeus	ama.bartholomeus@me.com	473326459		Recommandée par Anne Leonardo pour 2023	2024-03-06
412	Fayçal	Cheboub	fcheboub@gmail.com	483145961		Recommandé par Anne Leonardo pour 2023	2024-03-06
413	Varvara	Jitcov	varvara1982@gmail.com	499182718		Recommandée par Amaryllis Bartholomeus en 2023	2024-03-06
414	Liesbeth	Lannie	lisbeth_lannie@hotmail.com			Recommandée par Amaryllis Bartholomeus en 2023	2024-03-06
415	Maxime	de Petter	maxime.de.petter@gmail.com	498562386		Recommandé par Amaryllis Bartholomeus en 2023	2024-03-06
416	Romain	Monfort	romainmontfort@yahoo.fr			Recommandé par Amaryllis Bartholomeus en 2023	2024-03-06
417	Katelijne	Onsia		485829553		Recommandée par Amaryllis Bartholomeus en 2023	2024-03-06
418	Diede	Verpoest	diede.verpoest@hotmail.com	496343033		Recommandée par Amaryllis Bartholomeus en 2023	2024-03-06
419	Salomé	Dumas	dumassalome@gmail.com	470350728		Nous a contactés par mail pour rejoindre Melomania l'année	2024-03-06
420	Yulika	Deprez	yulikadeprez@yahoo.fr	492678333	Yulika Deprez	CM pour le concert de novembre 2023, diplomée en violon, étudie l'architecture	2024-03-06
421	Debora	Travaini		393457993152		Joignable sur Whatsapp	2024-03-06
422	Guilhem	Verstraeten	guilhem@beauregard.be	494643334		Très bon niveau, fiable	2024-03-06
423	Ayla	Tant	ayla.tant@gmail.com	468340977		Très sympa, mais niveau faible	2024-03-06
424	Hélène	Trottier	helenetrottier@outlook.fr				2024-03-06
425	Mario	Vanderlinden	mavdl57@gmail.com	33669159472			2024-03-06
427	Alexandre	Omelianenko	alexandreomel@gmail.com	479474990		Travaille super bien en pupitre avec Alexandre Omelianenko	2024-03-06
428	Clément	Cuypers			Clement Cuypers		2024-03-06
429	Julien	Poli	julien.poli@student.ehb.be	498593546		Recommandée par Isabelle Bonesire	2024-03-06
430	Nina	Poskin	ninaposkin@gmail.com			Recommandée par Amaryllis Bartholomeus en 2023	2024-03-06
431	Rémy	Roux	remy.roux25@gmail.com	479208114		Génial bassonniste, nécessite un cachet conséquent	2024-03-06
101	Florence	Bellière	floche.belliere@gmail.com	0476318401	Florence Bellière	Mauvaise relation avec Pierre Baudhuin	2024-03-25
432	David	Rampelberg		0474208754		Contact obtenu par Luc Paucot. Pro au ténor, joue du basse de temps en temps.	2024-04-16
433	Lander	Geens		0498857905		Neerlandophone, très sympa, habite Mol	2024-04-16
434	Raphaël	Robyns		0496062695		FR, très sympa, ne se déplace pas pour des petits cachets, ne joue pas de trombone basse.	2024-04-16
452	Géry	Timmermans	gerytimmermans@gmail.com				2024-07-10
426	Charlotte	Barbier	barbier.ch@hotmail.com			Travaille super bien en pupitre avec Alexandre Omelianenko	2024-04-16
435	Matthieu	Garnavault		0498591758	Matthieu Garnavault	Contact obtenu de Mariana Fernandes	2024-04-16
124	Angela	Hernandez	angeela.hdz14@hotmail.com		Angela Hernandez	Habite maintenant en Allemagne (update mai 2024)	2024-05-22
453	Magali	Hotton	hottonmagali@gmail.com				2024-07-10
409	Hélène	Koerver			Hélène Koerver	Recommandée par Anne Leonardo pour 2023	2024-05-25
385	Marta	Polcaro			Ma Rta	Recommandée par Héloïse Danneels en 2021. Habite en France depuis 2024	2024-06-03
252	Liesa	Deville	liesadeville@gmail.com	0032477069633	Liesa Deville		2024-06-24
436	Théa	Lima			Théa Lima		2024-07-10
437	Fien	Smets			Fien Smets		2024-07-10
438	Gema	Jiménez			Gema Jiménez		2024-07-10
439	Pablo	Quintas Soriano			Pablo Quintas Soriano	N'accepte pas les projets non payés	2024-07-10
440	Justine	Vercruysse			Justine Vercruysse		2024-07-10
441	Louis	de Maeght			Louis de Maeght		2024-07-10
442	Margot	Vermaut	margot.vermaut@live.be	494034066	Margot Vermaut		2024-07-10
443	Ruben	Van Steirteghem			Ruben Van Steirteghem		2024-07-10
444	Hanne	Melckebeke			Hanne Melckebeke		2024-07-10
445	Karla	Bellon Velez			Karla A. Bellón Velez	Francophone	2024-07-10
446	Clare	Morley			Clare Morley	Mauvaise relation avec Florence Bellière	2024-07-10
447	Kato	Van Echelpoel			Kato Van Echelpoel		2024-07-10
448	Line	Klenke			Line Klenke		2024-07-10
451	Rachel	Mahij	rachel.mahij@gmail.com	491195139			2024-07-10
454	Raphaelle	Nenert	raphaelle.nenert@gmail.com	3344022882	Raphaëlle Nenert	Excellente et super sympa	2024-07-10
455	Damien	Bernard	damshege@gmail.com				2024-07-10
456	Victor	Cariou			Victor Cariou		2024-07-10
457	Delfina	Asensi	delasfu@gmail.com	34657312560	Delfina AF		2024-07-10
458	Mitschi	Pierre	pierre.mitschi@gmail.com		Pierre Mtsh		2024-07-10
459	Hoviv	Hayrabedian	hayrabedian.hoviv@gmail.com	33671560736	Hoviv Hayrabedian		2024-07-10
460	Thaïs	Defoort		494684424	Thaïs Defoort		2024-07-10
461	Maureen	Kellendonk	maureen.kellendonk@gmail.com	33643759875		Etudiante en violon jazz	2024-07-10
462	Claude	Serwiez	claudeser@gmail.com	485035622			2024-07-10
463	Nora	Jacobs	nora.jacobs2004@gmail.com		Nora Jacobs		2024-07-10
464	Kamil	Sulcz			Kamil Sulcz		2024-07-10
465	Katelijn	Verstappen	katelijn.verstappen@gmail.com		Katelijn Verstappen		2024-07-10
466	Christophe	Monnier	cmonnier104@gmail.com				2024-07-10
467	David	Jackson	philip57@gmail.com	477899260			2024-07-10
468	Pascal	Tribel	pascal.tribel@gmail.com	479547410	Pascal Tribel		2024-07-10
469	Vivien	Delaisse	vivien.del@live.be	494713870			2024-07-10
470	Marc	Tillema	marc.tillema@gmail.com	478657296		BLACKLIST ne jamais contacter. Attitude déplacée vis-à-vis de ses partenaires de pupitre et gestion désastreuse des coups d'archet.	2024-07-10
471	Jens	Bergen	jensbergen1811@gmail.com	468314151			2024-07-10
472	Mats	Florczak	mats1florczak@gmail.com	484345572			2024-07-10
473	Katharina	Steenkiste	katharinasteenkiste@gmail.com	493455439			2024-07-10
474	Sebastiaan	Kulwanowski	s.kulwanowski@gmail.com	477081137	Sebastiaan Kulwanowski		2024-07-10
475	Zowy	Bahnen	zowy@secretforest.nl	31640249105			2024-07-10
476	Sumer	Sanah Ullah	remus.mats@gmail.com	456081706			2024-07-10
477	Zoia	Smirnova	zoia.smirnova@conservatoire-bruxelles.be	33751459479			2024-07-10
478	Andreu	Pla Forcadell	andreubassoon@gmail.com	34650267893	Andreu Pla Forcadell		2024-07-10
479	Valentin	Wiener	valentin.wiener1453@gmail.com	33760890128	Valentin Wiener		2024-07-10
480	Elisabeth	Lefèbvre	elikocello@hotmail.com	498105005	Elisabeth Lefèbvre		2024-07-10
481	Yeosong	Chang	duthd981104@gmail.com	783642587			2024-07-10
482	Tina	Zhao	iris_ztn@hotmail.com	496210696	Tina Zhao		2024-07-10
483	Cécile	Bricout-Basquin	cecilebricoutbasquin@gmail.com	33606414550			2024-07-10
484	Maxime	Tardif	maxime.tardif.2003@gmail.com	782878401			2024-07-10
485	Zoë	Loxley Slump	zoeloxleyslump@gmail.com	31658815939		Australienne, compte y retourner après ses études	2024-07-10
486	Adrien	Jeanson	adrends@hotmail.fr	33684937670			2024-07-10
487	Florine	Halleux	halleux.florine@gmail.com	479830406	Florine Halleux		2024-07-10
488	Britt	Leyseele	britt.leyseele@ugent.be	470293268			2024-07-10
489	Arne	De Brabandere	arne.de.brabandere@telenet.be	32472589018			2024-07-10
449	Adrien	Van Sull	vansulladrien@gmail.com	483689572	Adrien Van Sull	Toujours partant pour des projets	2024-07-10
491	François	Simoens	simoens.francois@gmail.com				2024-07-10
490	Samuel	Nemtanu				Contacté via Juliette Coppens	2024-07-10
450	Alma	Defoort	almadefoort@hotmail.com			Soeur de Thaïs Defoort	2024-07-11
492	Robin	Troquet	robin.troquet@gmail.com	0471411809	Robin Troquet	Formé en classique et en jazz	2024-07-12
\.


--
-- Data for Name: repertoire; Type: TABLE DATA; Schema: public; Owner: admin123
--

COPY public.repertoire (id, name, opus, composer, year_of_composition, type, arranger) FROM stdin;
1	Symphony n°7	Op. 92	Ludwig van Beethoven	1812	Symphony	\N
3	Horn concerto	Op. 91	Reinhold Glière	1951	Concerto	\N
4	Symphony n°5	Op.67	Ludwig van Beethoven	1807	Symphony	\N
6	Symphony n°5	Op. 64	Piotr Illitch Tchaikovsky	1888	Symphony	\N
7	Symphony n°40	KV. 550	Wolfgang Amadeus Mozart	1788	Symphony	\N
8	Symphony n°9	Op. 95	Antonin Dvorak	1893	Symphony	\N
9	Danzon n°2		Arturo Marquez	1994	Dance	\N
10	Symphonic dances	Op. 64	Edvard Grieg	1896	Symphonic dances	\N
13	Hungarian dance n°5	WoO. 1	Johannes Brahms	1879	Dance	\N
14	Hungarian dance n°1	WoO. 1	Johannes Brahms	1879	Dance	\N
15	Hungarian dance n°6	WoO. 1	Johannes Brahms	1879	Dance	\N
16	Waltz from Eugène Onegin	Op. 24	Piotr Illitch Tchaikovsky	1878	Waltz	\N
17	French can-can (from Orphée aux Enfers)		Jacques Offenbach	1868	Opera	\N
18	Piano concerto n°2	Op. 18	Sergueï Rachmaninov	1901	Concerto	\N
2	Khovanschina - prelude	Op. Posth.	Modest Mussorgsky	1880	Opera	Nikolaï Rimsky-Korsakov
11	Le merle blanc	Op. 161	Eugène Damaré	1890	Polka	Aurian Baudhuin
12	Czardas (for 2 violins and orchestra)		Vittorio Monti	1904	Dance	\N
20	Always look on the bright side of life		Eric Idle	1979	Variety	Aurian Baudhuin
21	Petite suite	L. 65	Claude Achille Debussy	1886	Suite	Henri Büsser
22	Sicilienne	Op. 68	Gabriel Fauré	1893	Scenic music	
23	Romanian folk dances	BB 68	Béla Bartok	1918	Dances	Béla Bartok
24	Scene (from Swan Lake, Act 3)	Op. 20	Piotr Illitch Tchaikovsky	1876	Ballet	
25	Vocalise (for violin and orchestra)	Op. 34 n°14	Sergueï Rachmaninov	1912	Misc	Sergueï Rachmaninov
26	March (from Nutcracker)	Op. 71	Piotr Illitch Tchaikovsky	1892	Ballet	
27	Flower Waltz (from Nutcracker)	Op. 71	Piotr Illitch Tchaikovsky	1892	Ballet	
28	Dance of the mirlitons (from Nutcracker)	Op. 71	Piotr Illitch Tchaikovsky	1892	Ballet	
29	Divertimento - coffee (from Nutcracker)	Op. 71	Piotr Illitch Tchaikovsky	1892	Ballet	
30	Petite romance	Op. 36	Camille Saint-Saëns	1871	Misc	
31	Double concerto in D minor	BWV 1043	Johann Sebastian Bach	1730	Concerto	
33	Waltz n°2 (from Jazz Suite n°2)	Op. 50b	Dmitri Chostakovitch	1938	Suite	
35	Cello concerto n°1	Hob. VIIb:1	Joseph Haydn	1765	Concerto	
36	Enigma variations	Op. 36	Edward Elgar	1899	Variations	
37	Pomp and circumstances - March n°2	Op. 39 n°2	Edward Elgar	1905	March	
32	Concerto for flute and harp	K. 299	Wolfgang Amadeus Mozart	1778	Concerto	
19	Overture (from Hamlet)		Alexandre Stadtfeld	1844	Ouverture	\N
34	Egmont overture	Op. 84	Ludwig van Beethoven	1810	Ouverture	
38	Overture of The Barber of Seville		Gioachino Rossini	1816	Ouverture	
39	Violin concerto n°1	Op. 6	Niccolò Paganini	1817	Concerto	
40	La boda de Luis Alonso		Geronimo Giménez	1897	Zarzuela	
41	Por una cabeza		Carlos Gardel	1935	Tango	Aurian Baudhuin
42	La conga del Fuego Nuevo		Arturo Marquez	1998	Dance	
43	Overture of La gazza ladra		Gioachino Rossini	1817	Ouverture	
44	Overture of Oberon	Op. 60	Carl Maria von Weber	1826	Ouverture	
45	Overture of the Light Cavalry		Franz von Suppé	1866	Ouverture	
46	Overture from Ruslan and Ludmilla	G. 5	Mikhail Glinka	1842	Ouverture	
47	Cello concerto in B minor	Op. 104	Antonin Dvorak	1895	Concerto	
48	Gabriel's Oboe (from (The Mission)		Ennio Morricone	1986	Soundtrack	Aurian Baudhuin
49	Overture of Carmen	WD 31	Georges Bizet	1872	Ouverture	
50	Violin rhapsody n°1	BB 94	Béla Bartok	1923	Rhapsody	
51	Baal Shem		Ernest Bloch	1923	Misc	Aurian Baudhuin
52	Zigeunerweisen	Op. 20	Pablo de Sarasate	1878	Misc	
53	Bruxelles (for orchestra)		Jacques Brel	1962	Variety	Aurian Baudhuin
54	Hungarian March from The Damnation of Faust	Op. 24	Hector Berlioz	1846	March	
55	Clarinet concerto	K. 622	Wolfgang Amadeus Mozart	1791	Concerto	
56	Symphony n°8	Op. 88	Antonin Dvorak	1889	Symphony	
57	Symphony n°4	Op. 98	Johannes Brahms	1885	Symphony	
58	Violin concerto	Op. 61	Ludwig van Beethoven	1806	Concerto	
59	Symphony n°1, "Titan"	MH 34	Gustav Mahler	1888	Symphony	
60	Clarinet concerto (2nd mvt)	K. 622	Wolfgang Amadeus Mozart	1791	Concerto	\N
61	Piano concerto in A minor	Op. 16	Edvard Grieg	1868	Concerto	
62	Dans les steppes de l'Asie centrale		Alexandre Borodine	1880	Symphonic poem	
63	Symphony n°1 in G minor		Vasily Kalinnikov	1900	Symphony	
64	Across the Stars (from "Star Wars")		John Williams	2002	Soundtrack	Aurian Baudhuin
65	Overture in C		Fanny Zippora Mendelssohn	1832	Ouverture	
66	Symphony n°2 in D major	Op. 73	Johannes Brahms	1877	Symphony	
67	Cello concerto in E minor	Op. 85	Edward Elgar	1919	Concerto	
68	Emmenez-moi (for orchestra)		Charles Aznavour	1967	Variety	Aurian Baudhuin
69	Overture from 'La finta giardiniera'	K. 196	Wolfgang Amadeus Mozart	1775	Ouverture	
70	Piano concerto n°19	K. 459	Wolfgang Amadeus Mozart	1784	Concerto	
71	Symphony n°25 in G minor	K. 183	Wolfgang Amadeus Mozart	1773	Symphony	
72	Intermezzo (from "La cavaleria rusticana")		Pietro Mascagni	1890	Opera	Aurian Baudhuin
73	Hebrides Overture (Fingal's Cave)	Op. 26	Felix Mendelssohn	1830	Ouverture	
74	Violin concerto in D major	Op. 35	Piotr Illitch Tchaikovsky	1878	Concerto	
75	Symphony n°3 in F major	Op. 90	Johannes Brahms	1883	Symphony	
76	Be our guest (for orchestra)		Alan Menken	1991	Misc	Aurian Baudhuin
\.


--
-- Data for Name: types_of_pieces; Type: TABLE DATA; Schema: public; Owner: admin123
--

COPY public.types_of_pieces (id, name) FROM stdin;
1	Symphony
2	Concerto
3	Opera
4	Variations
5	Dance
6	Symphonic dances
7	Polka
8	Waltz
9	Variety
10	Suite
11	Scenic music
12	Dances
13	Ballet
14	Misc
15	Ouverture
16	March
17	Zarzuela
18	Tango
19	Soundtrack
20	Rhapsody
21	Symphonic poem
\.


--
-- Name: composers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin123
--

SELECT pg_catalog.setval('public.composers_id_seq', 53, true);


--
-- Name: concerts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin123
--

SELECT pg_catalog.setval('public.concerts_id_seq', 29, true);


--
-- Name: instruments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin123
--

SELECT pg_catalog.setval('public.instruments_id_seq', 46, true);


--
-- Name: musicians_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin123
--

SELECT pg_catalog.setval('public.musicians_id_seq', 492, true);


--
-- Name: repertoire_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin123
--

SELECT pg_catalog.setval('public.repertoire_id_seq', 76, true);


--
-- Name: types_of_pieces_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin123
--

SELECT pg_catalog.setval('public.types_of_pieces_id_seq', 21, true);


--
-- Name: concerts Concerts_pkey; Type: CONSTRAINT; Schema: public; Owner: admin123
--

ALTER TABLE ONLY public.concerts
    ADD CONSTRAINT "Concerts_pkey" PRIMARY KEY (id);


--
-- Name: musicians Contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: admin123
--

ALTER TABLE ONLY public.musicians
    ADD CONSTRAINT "Contacts_pkey" PRIMARY KEY (id);


--
-- Name: instruments Instruments_PK; Type: CONSTRAINT; Schema: public; Owner: admin123
--

ALTER TABLE ONLY public.instruments
    ADD CONSTRAINT "Instruments_PK" PRIMARY KEY (id);


--
-- Name: mtm_musicians_concerts Musicians-concerts_pkey; Type: CONSTRAINT; Schema: public; Owner: admin123
--

ALTER TABLE ONLY public.mtm_musicians_concerts
    ADD CONSTRAINT "Musicians-concerts_pkey" PRIMARY KEY (concert, musician);


--
-- Name: composers Name; Type: CONSTRAINT; Schema: public; Owner: admin123
--

ALTER TABLE ONLY public.composers
    ADD CONSTRAINT "Name" UNIQUE (long_name) INCLUDE (short_name);


--
-- Name: mtm_programs Programs_pkey; Type: CONSTRAINT; Schema: public; Owner: admin123
--

ALTER TABLE ONLY public.mtm_programs
    ADD CONSTRAINT "Programs_pkey" PRIMARY KEY (concert_id, piece_id);


--
-- Name: repertoire Repertoire_pkey; Type: CONSTRAINT; Schema: public; Owner: admin123
--

ALTER TABLE ONLY public.repertoire
    ADD CONSTRAINT "Repertoire_pkey" PRIMARY KEY (id);


--
-- Name: types_of_pieces Types of pieces_pkey; Type: CONSTRAINT; Schema: public; Owner: admin123
--

ALTER TABLE ONLY public.types_of_pieces
    ADD CONSTRAINT "Types of pieces_pkey" PRIMARY KEY (id);


--
-- Name: composers composers_pkey; Type: CONSTRAINT; Schema: public; Owner: admin123
--

ALTER TABLE ONLY public.composers
    ADD CONSTRAINT composers_pkey PRIMARY KEY (id);


--
-- Name: musicians full_name; Type: CONSTRAINT; Schema: public; Owner: admin123
--

ALTER TABLE ONLY public.musicians
    ADD CONSTRAINT full_name UNIQUE (first_name, last_name);


--
-- Name: types_of_pieces name; Type: CONSTRAINT; Schema: public; Owner: admin123
--

ALTER TABLE ONLY public.types_of_pieces
    ADD CONSTRAINT name UNIQUE (name) INCLUDE (name);


--
-- Name: mtm_soloists pk_soloists; Type: CONSTRAINT; Schema: public; Owner: admin123
--

ALTER TABLE ONLY public.mtm_soloists
    ADD CONSTRAINT pk_soloists PRIMARY KEY (concert_id, piece_id, soloist_id);


--
-- Name: mtm_musicians_instruments primary_key; Type: CONSTRAINT; Schema: public; Owner: admin123
--

ALTER TABLE ONLY public.mtm_musicians_instruments
    ADD CONSTRAINT primary_key PRIMARY KEY (musician_id, instrument_id);


--
-- Name: unique_name; Type: INDEX; Schema: public; Owner: admin123
--

CREATE UNIQUE INDEX unique_name ON public.instruments USING btree (instrument_name);


--
-- Name: repertoire Type; Type: FK CONSTRAINT; Schema: public; Owner: admin123
--

ALTER TABLE ONLY public.repertoire
    ADD CONSTRAINT "Type" FOREIGN KEY (type) REFERENCES public.types_of_pieces(name) NOT VALID;


--
-- Name: repertoire composer; Type: FK CONSTRAINT; Schema: public; Owner: admin123
--

ALTER TABLE ONLY public.repertoire
    ADD CONSTRAINT composer FOREIGN KEY (composer) REFERENCES public.composers(long_name) NOT VALID;


--
-- Name: mtm_programs concert; Type: FK CONSTRAINT; Schema: public; Owner: admin123
--

ALTER TABLE ONLY public.mtm_programs
    ADD CONSTRAINT concert FOREIGN KEY (concert_id) REFERENCES public.concerts(id) ON DELETE CASCADE NOT VALID;


--
-- Name: mtm_soloists concert; Type: FK CONSTRAINT; Schema: public; Owner: admin123
--

ALTER TABLE ONLY public.mtm_soloists
    ADD CONSTRAINT concert FOREIGN KEY (concert_id) REFERENCES public.concerts(id);


--
-- Name: mtm_musicians_concerts concerts; Type: FK CONSTRAINT; Schema: public; Owner: admin123
--

ALTER TABLE ONLY public.mtm_musicians_concerts
    ADD CONSTRAINT concerts FOREIGN KEY (concert) REFERENCES public.concerts(id) ON DELETE CASCADE NOT VALID;


--
-- Name: mtm_musicians_instruments instrument; Type: FK CONSTRAINT; Schema: public; Owner: admin123
--

ALTER TABLE ONLY public.mtm_musicians_instruments
    ADD CONSTRAINT instrument FOREIGN KEY (instrument_id) REFERENCES public.instruments(id) ON DELETE CASCADE NOT VALID;


--
-- Name: mtm_musicians_concerts instruments; Type: FK CONSTRAINT; Schema: public; Owner: admin123
--

ALTER TABLE ONLY public.mtm_musicians_concerts
    ADD CONSTRAINT instruments FOREIGN KEY (instrument) REFERENCES public.instruments(id) ON DELETE CASCADE NOT VALID;


--
-- Name: mtm_soloists musician; Type: FK CONSTRAINT; Schema: public; Owner: admin123
--

ALTER TABLE ONLY public.mtm_soloists
    ADD CONSTRAINT musician FOREIGN KEY (soloist_id) REFERENCES public.musicians(id);


--
-- Name: mtm_musicians_instruments musicians; Type: FK CONSTRAINT; Schema: public; Owner: admin123
--

ALTER TABLE ONLY public.mtm_musicians_instruments
    ADD CONSTRAINT musicians FOREIGN KEY (musician_id) REFERENCES public.musicians(id) ON DELETE CASCADE NOT VALID;


--
-- Name: mtm_musicians_concerts musicians; Type: FK CONSTRAINT; Schema: public; Owner: admin123
--

ALTER TABLE ONLY public.mtm_musicians_concerts
    ADD CONSTRAINT musicians FOREIGN KEY (musician) REFERENCES public.musicians(id) ON DELETE CASCADE NOT VALID;


--
-- Name: mtm_programs piece; Type: FK CONSTRAINT; Schema: public; Owner: admin123
--

ALTER TABLE ONLY public.mtm_programs
    ADD CONSTRAINT piece FOREIGN KEY (piece_id) REFERENCES public.repertoire(id) ON DELETE CASCADE NOT VALID;


--
-- Name: mtm_soloists piece; Type: FK CONSTRAINT; Schema: public; Owner: admin123
--

ALTER TABLE ONLY public.mtm_soloists
    ADD CONSTRAINT piece FOREIGN KEY (piece_id) REFERENCES public.repertoire(id);


--
-- PostgreSQL database dump complete
--

