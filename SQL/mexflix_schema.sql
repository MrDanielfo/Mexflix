/*  Mexflix: base de datos de películas y series */

/*DROP DATABASE IF EXISTS mexflix;*/

/* esta línea es para borrar datos */

CREATE DATABASE IF NOT EXISTS mexflix;

USE mexflix;

/* Tabla Catálogo, se debe colocar primero para que interprete bien la foreign key */

CREATE TABLE status(
    status_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    status VARCHAR(20) NOT NULL
);


/* Tabla de datos */

CREATE TABLE movieseries(
    imdb_id CHAR(9) PRIMARY KEY,
    title VARCHAR(80) NOT NULL,
    plot TEXT,
    author VARCHAR(100) DEFAULT 'Pending',
    actors VARCHAR(100) DEFAULT 'Pending',
    country VARCHAR(30) DEFAULT 'Unknown',
    premiere YEAR(4) NOT NULL,
    poster VARCHAR(150) DEFAULT 'no-poster.jpg',
    trailer VARCHAR(150) DEFAULT 'no-trailer.jpg',
    rating DECIMAL(2,1),
    genres VARCHAR(50) NOT NULL,
    status INTEGER UNSIGNED NOT NULL, /* será llave foránea */
    category ENUM('Movie', 'Serie') NOT NULL,
    FULLTEXT KEY search(title, author, actors, genres), /* llave para buscar no aplica en campo text */
    FOREIGN KEY (status) REFERENCES status(status_id) ON DELETE RESTRICT ON UPDATE CASCADE
);



/* Tabla de Datos */

CREATE TABLE users(
    user VARCHAR(15) PRIMARY KEY,
    email VARCHAR(80) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    birthday DATE NOT NULL,
    pass CHAR(32) NOT NULL,
    role ENUM('Admin', 'User') NOT NULL
);

/* 'Coming Soon', 'Released', 'In Issue', 'Finished', 'Canceled'  */

INSERT INTO status (status_id, status) VALUES
(1, 'Coming Soon'),
(2, 'Released'),
(3, 'In Issue'),
(4, 'Finished'),
(5, 'Canceled');

INSERT INTO users (user, email, name, birthday, pass, role) VALUES
('@danielfo', 'mr.danielfo@gmail.com', 'Josué Daniel Flores', '1989-04-06', MD5('danielfo'), 'Admin'),
('@beckyrewis', 'becky@rewis.com', 'Rebecca Ruiz', '1992-06-13', MD5('becky'), 'User');

INSERT INTO movieseries (imdb_id, title, plot, genres, author, actors, country, premiere, poster, trailer, rating, status, category) VALUES

('tt0467197','Max Payne', 'Three years ago, NYPD detective Max Payne\'s wife and baby were murdered. Max gets himself transferred to the cold case office where he can continue searching for the killer who got away. He\'s a loner, but two people reach out to him during a fateful week: Alex, his ex-partner who may have found a clue, and BB, the security chief at the pharmaceutical company where Max\'s wife worked. Meanwhile, bodies are piling up, some as a result of a drug on the street that is highly addictive and, for many who take it, brings hideous hallucinations. When one of the bodies is a woman Payne was the last to see alive, her sister comes looking for him armed to the teeth; Max must move fast.', 'Action, Crime, Drama' ,'John Moore', 'Mark Wahlberg, Mila Kunis, Beau Bridges, Ludacris', 'Canada, USA', '2008', 'https://images-na.ssl-images-amazon.com/images/M/MV5BNzM5OTAxYmQtODRkZC00ZGZlLTlhNzYtNzFiODVjMTY4MWU2XkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_SX300.jpg', 'https://www.youtube.com/watch?v=GklHaGfncJI', 5.4, 2, 'Movie' ),

('tt0424227', 'Turtles Can Fly', 'On the Kurdish refugee camp on the Iraqi-Turkish border, the boy Satellite is the leader of the kids. He commands them to clear and collect American undetonated minefields in the fields to sell them in the street market and he installs antennae for the villagers. He goes with the local leader to buy a parabolic antenna to learn the news about the eminent American invasion but nobody speaks English and Satellite that knows a couple of words is assigned to translate the Fox News. When the orphans Agrin and her armless brother Hengov and the blind toddler Riga come from Halabcheh to the camp, Satellite falls in an unrequited love for Egrin. But the girl is traumatized by a cruel raid in her home, when her parents were murdered and she was raped. She wants to leave Riga behind and travel with her brother Hengov to another place, but he does not agree with her intention.', 'Drama, War', 'Bahman Ghobadi', 'Soran Ebrahim, Avaz Latif, Saddam Hossein Feysal', 'Iran, France, Iraq', '2004' , 'https://images-na.ssl-images-amazon.com/images/M/MV5BMTI5NDM2NzcwOF5BMl5BanBnXkFtZTcwNTI2MDgyMQ@@._V1_SX300.jpg', 'https://www.youtube.com/watch?v=2K7Zx7RBON4', 8.1, 2, 'Movie' ),

('tt1139797', 'Let the Right One In', 'Oskar, a bullied 12-year old, dreams of revenge. He falls in love with Eli, a peculiar girl. She can\'t stand the sun or food and to come into a room she needs to be invited. Eli gives Oskar the strength to hit back but when he realizes that Eli needs to drink other people\'s blood to live he\'s faced with a choice. How much can love forgive? Set in the Stockholm suburb of Blackeberg in 1982.', 'Drama, Horror, Romance', 'John Ajvide Lindqvist', 'Kåre Hedebrant, Lina Leandersson, Per Ragnar, Henrik Dahl', 'Sweden', '2008', 'https://images-na.ssl-images-amazon.com/images/M/MV5BMjE1OTY2MTM5MF5BMl5BanBnXkFtZTcwNzQ5Mjc5MQ@@._V1_SX300.jpg', 'https://www.youtube.com/watch?v=ICp4g9p_rgo', 7.9, 2, 'Movie'),

('tt0460649', 'How I Met Your Mother', 'A father recounts to his children, through a series of flashbacks, the journey he and his four best friends took leading up to him meeting their mother.', 'Comedy, Romance', 'Carter Bays, Craig Thomas', 'Josh Radnor, Jason Segel, Cobie Smulders, Neil Patrick Harris', 'USA', '2005', 'https://images-na.ssl-images-amazon.com/images/M/MV5BMTA5MzAzNTcyNjZeQTJeQWpwZ15BbWU3MDUyMzE1MTk@._V1_SX300.jpg', 'https://www.youtube.com/watch?v=aJtVL2_fA5w', 8.4, 4, 'Serie'),

('tt2707408', 'Narcos', 'Narcos tells the true-life story of the growth and spread of cocaine drug cartels across the globe and attendant efforts of law enforcement to meet them head on in brutal, bloody conflict. It centers around the notorious Colombian cocaine kingpin Pablo Escobar and Steve Murphy, a DEA agent sent to Colombia on a U.S. mission to capture and ultimately kill him.', 'Biography, Crime, Drama', 'Carlo Bernard, Chris Brancato, Doug Miro, Paul Eckstein', 'Pedro Pascal, Wagner Moura, Boyd Holbrook, Alberto Ammann', 'Colombia, USA', '2015', 'https://ia.media-imdb.com/images/M/MV5BMTU0ODQ4NDg2OF5BMl5BanBnXkFtZTgwNzczNTE4OTE@._V1_SX300.jpg', 'https://www.youtube.com/watch?v=U7elNhHwgBU', 8.9, 3, 'Serie'),

('tt3478962', 'My King', 'Tony is admitted to a rehabilitation center after a serious ski accident. Dependent on the medical staff and pain relievers, she takes time to look back on a turbulent relationship that she experienced with Georgio. Why did they love each other? Who is this man that she loved so deeply? How did she allow herself to submit to this suffocating and destructive passion? For Tony, a difficult process of healing is in front of her, physical work which may finally set her free.', 'Drama, Romance', 'Etienne Comar, Maïwenn', 'Vincent Cassel, Emmanuelle Bercot, Louis Garrel, Isild Le Besco', 'France', '2015', 'https://images-na.ssl-images-amazon.com/images/M/MV5BMjEzOTI2NzQ1Ml5BMl5BanBnXkFtZTgwNjI0NjI4OTE@._V1_SX300.jpg', 'https://www.youtube.com/watch?v=wVkn58_wiM4', 7.1, 2, 'Movie'),

('tt2219514', 'Fill the Void', 'A devout 18-year-old Israeli is pressured to marry the husband of her late sister. Declaring her independence is not an option in Tel Aviv\'s ultra-Orthodox Hasidic community, where religious law, tradition and the rabbi\'s word are absolute.', 'Drama, Romance', 'Rama Burshtein', 'Hadas Yaron, Yiftach Klein, Irit Sheleg, Chayim Sharir', 'Israel', '2012', 'https://images-na.ssl-images-amazon.com/images/M/MV5BNzQ3ODMyMjA1MV5BMl5BanBnXkFtZTcwMTIzMzEzOQ@@._V1_SX300.jpg', 'https://www.youtube.com/watch?v=NQuWarA9KXg', 6.7, 2, 'Movie'),

('tt0468569', 'The Dark Knight', 'Set within a year after the events of Batman Begins, Batman, Lieutenant James Gordon, and new district attorney Harvey Dent successfully begin to round up the criminals that plague Gotham City until a mysterious and sadistic criminal mastermind known only as the Joker appears in Gotham, creating a new wave of chaos.', 'Action, Crime, Thriller', 'Christopher Nolan', 'Christian Bale, Heath Ledger, Aaron Eckhart, Michael Caine', 'USA, UK', '2008', 'https://images-na.ssl-images-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_SX300.jpg', 'https://www.youtube.com/watch?v=EXeTwQWrcwY', 9.0, 2, 'Movie'),

('tt1211837', 'Doctor Strange', 'Marvel\'s \"Doctor Strange\" follows the story of the talented neurosurgeon Doctor Stephen Strange who, after a tragic car accident, must put ego aside and learn the secrets of a hidden world of mysticism and alternate dimensions.', 'Action, Adventure, Fantasy', 'Scott Derrickson', 'Benedict Cumberbatch, Chiwetel Ejiofor, Rachel McAdams, Benedict Wong', 'USA', '2016', 'https://ia.media-imdb.com/images/M/MV5BNjgwNzAzNjk1Nl5BMl5BanBnXkFtZTgwMzQ2NjI1OTE@._V1_SX300.jpg', 'https://www.youtube.com/watch?v=Lt-U_t2pUHI', 7.5, 2, 'Movie'),

('tt0116282', 'Fargo', 'Jerry works in his father-in-law\'s car dealership and has gotten himself in financial problems. He tries various schemes to come up with money needed for a reason that is never really explained. It has to be assumed that his huge embezzlement of money from the dealership is about to be discovered by father-in-law. When all else falls through, plans he set in motion earlier for two men to kidnap his wife for ransom to be paid by her wealthy father (who doesn\'t seem to have the time of day for son-in-law). From the moment of the kidnapping, things go wrong and what was supposed to be a non-violent affair turns bloody with more blood added by the minute.', 'Crime, Drama, Thriller', 'Joel Coen, Ethan Coen', 'William H. Macy, Steve Buscemi, Peter Stormare, Kristin Rudrüd', 'USA, UK', '1996', 'https://ia.media-imdb.com/images/M/MV5BNDJiZDgyZjctYmRjMS00ZjdkLTkwMTEtNGU1NDg3NDQ0Yzk1XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg', 'https://www.youtube.com/watch?v=h2tY82z3xXU', 8.1, 2, 'Movie'),

('tt1340800', 'Tinker Tailor Soldier Spy', 'In the early 1970s during the Cold War, the head of British Intelligence, Control, resigns after an operation in Budapest, Hungary goes badly wrong. It transpires that Control believed one of four senior figures in the service was in fact a Russian agent - a mole - and the Hungary operation was an attempt to identify which of them it was.', 'Drama, Mystery, Thriller', 'Tomas Alfredson', 'Mark Strong, John Hurt, Zoltán Mucsi, Péter Kálloy Molnár', 'France, UK, Germany', '2011', 'https://images-na.ssl-images-amazon.com/images/M/MV5BMTU2OTkwNzMyM15BMl5BanBnXkFtZTcwOTI4ODg2Ng@@._V1_SX300.jpg', 'https://www.youtube.com/watch?v=VW-F1H-Nonk', 7.1, 2, 'Movie'),

('tt0920473', 'Shall We Kiss?', 'When Gabriel and Emilie meet by chance, he offers her a ride, and they spend the evening talking, laughing and getting along famously. At the end of the night, Emilie declines Gabriel\'s offer of \"a kiss without consequences\". Emilie admonishes him that the kiss could have unexpected consequences, and tells him a story, unfolding in flashbacks, about the impossibility of indulging your desires without affecting someone else\'s life.', 'Comedy, Romance', 'Emmanuel Mouret', 'Virginie Ledoyen, Emmanuel Mouret, Julie Gayet, Michaël Cohen', 'France', '2007', 'https://images-na.ssl-images-amazon.com/images/M/MV5BMTY0ODQ4NTYwMF5BMl5BanBnXkFtZTcwMDE5MTUzMg@@._V1_SX300.jpg', 'https://www.youtube.com/watch?v=vi3TqzWAOJw', 6.8, 2, 'Movie'),

('tt0377260', 'Shameless', 'The story of a young group of siblings pretty much abandoned by their parents, surviving by their wits - and humor - on a rough Manchester council estate. Whilst they won\'t admit it, they need help and find it in Steve, a young middle class lad who falls for Fiona, the oldest sibling, and increasingly finds himself drawn to this unconventional and unique family. Anarchic family life seen through the eyes of an exceptionally bright fifteen year old, who struggles to come of age in the context of his belligerent father, closeted brother, psychotic sister and internet porn star neighbors.', 'Comedy, Crime, Drama', 'Paul Abbott', 'David Threlfall, Rebecca Atkinson, Alice Barry, Nicky Evans', 'UK', '2004', 'https://images-na.ssl-images-amazon.com/images/M/MV5BZmIzMjAwYWUtNzliMy00MmQ0LTk0ZTItMzBiMTAzY2FjMTNiXkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_SX300.jpg', 'https://www.youtube.com/watch?v=6q650Arm8ns', 8.1, 4, 'Serie'),

('tt0387764', 'Peep Show', 'Mark and Jez are a couple of twenty-something roommates who have nothing in common - except for the fact that their lives are anything but normal. Mayhem ensues as the pair strive to cope with day-to-day life.', 'Comedy', 'Jesse Armstrong, Sam Bain, Andrew O\'Connor', 'David Mitchell, Robert Webb, Matt King, Olivia Colman', 'UK', '2003', 'https://images-na.ssl-images-amazon.com/images/M/MV5BZjYwMWJhOWMtZTc5ZC00MGY0LTg0ZjktMzFhODhhZGZhNDRjXkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_SX300.jpg', 'https://www.youtube.com/watch?v=NOJ3OiahTYI', 8.6, 4, 'Serie'),

('tt0367279', 'Arrested Development', 'Meet the wildly dysfunctional Bluth family. This family was once at the height of real estate development in Orange County, California. But when the family business - the Bluth Company - goes bust, they\'re suddenly found penniless with their assets frozen. They move into their last remaining asset - the model home left over from their latest housing tract. Their luxury vehicles are replaced with a reminder of the family\'s former wealth - the stair car that accompanied their private jet. The patriarch of the family is George Bluth - he\'s now in prison, and loving every minute of it.', 'Comedy', 'Mitchell Hurwitz', 'Jeffrey Tambor, Jason Bateman, Michael Cera, Alia Shawkat', 'USA', '2003', 'https://images-na.ssl-images-amazon.com/images/M/MV5BMTk4OTIyNzA5NF5BMl5BanBnXkFtZTcwODQxMTE1OQ@@._V1_SX300.jpg', 'https://www.youtube.com/watch?v=mNBGVKE9_5o', 8.9, 5, 'Serie'),

('tt0100405', 'Pretty Woman', 'Because of his extreme wealth and suave good looks, Edward Lewis could seemingly have any woman he wants, that committed significant other which he needs on his arm at social events to further how he makes his money as a corporate raider. However, he focuses more on his corporate raiding pursuits with his partner in crime, Philip Stuckey, his lawyer of ten years, than those women, with every significant other he\'s had in his life feeling neglected and eventually leaving him, this fact about which he is just coming to the realization. In Beverly Hills, Edward, in needing that woman on his arms as he and Philip work toward taking over the company owned by the increasingly insolvent James Morse, decides, based on a chance encounter, to hire Hollywood Boulevard hooker Vivian Ward as his escort for the week 24/7.', 'Comedy, Romance', 'Garry Marshall', 'Richard Gere, Julia Roberts, Ralph Bellamy, Jason Alexander', 'USA', '1990', 'https://images-na.ssl-images-amazon.com/images/M/MV5BNjk2ODQzNDYxNV5BMl5BanBnXkFtZTgwMTcyNDg4NjE@._V1_SX300.jpg', 'https://www.youtube.com/watch?v=Wzii8IuL8lk', 7.0, 2, 'Movie'),

('tt0810819', 'The Danish Girl', 'Copenhagen, Denmark, 1926. Einar Wegener (played by Eddie Redmayne) and his wife Gerda (Alicia Vikander) are a happily married couple. Both are artists, Einar preferring landscapes and she portraits. One day Einar poses for a portrait of Gerdas while wearing a dress. This is initially done as a lark, as is the later attendance at a party dressed as a woman. However, Einar soon discovers that she is in fact a women and over time prefers being Lili. At first she and Gerda try to have her situation \"cured\" but this leads nowhere (other than to many doctors trying to have Lili locked up as a pervert and/or lunatic).', 'Biography, Drama, History', 'Tom Hooper', 'Alicia Vikander, Eddie Redmayne, Tusse Silberg', 'UK, USA, Germany, Denmark', '2015', 'https://images-na.ssl-images-amazon.com/images/M/MV5BMjA0NjA4NjE2Nl5BMl5BanBnXkFtZTgwNzIxNTY2NjE@._V1_SX300.jpg', 'https://www.youtube.com/watch?v=d88APYIGkjk', 7.1, 2, 'Movie');
