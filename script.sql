CREATE SCHEMA corpos;
SET SCHEMA 'corpos';

-- Tabela de Usuário

CREATE TABLE Usuario (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(80),
    cpf CHAR(11) UNIQUE NOT NULL,
    telefone_1 CHAR(11),
    telefone_2 CHAR(11),
    senha VARCHAR(8) NOT NULL
);

-- Tabela unificada de Corpo Celeste com todos os atributos e uma coluna de categoria

CREATE TABLE Corpo_Celeste (
    id SERIAL PRIMARY KEY,
    id_usuario INTEGER REFERENCES Usuario(id) ON DELETE CASCADE,
    codigo_cientifico TEXT UNIQUE NOT NULL,
    nome VARCHAR(80),
    massa REAL,
    link_de_referencia TEXT,

	-- Atributos comuns a todos os corpos celestes

   categoria VARCHAR(20) CHECK (categoria IN ('Planeta', 'Estrela', 'Cometa', 'Meteoroide', 'Satelite_Natural')) NOT NULL,

    -- Atributos específicos de Planeta
	
    diametro REAL,
    periodo_orbital REAL,
    composicao_atmosferica TEXT,
    temperatura_media INTEGER,
    
    -- Atributos específicos de Estrela
	
    raio REAL,
    idade INTEGER,
    temperatura_efetiva INTEGER,
    distancia_da_terra INTEGER,
    
    -- Atributos específicos de Cometa
	
    magnitude_absoluta REAL,
    diametro_do_nucleo REAL,
    tamanho_do_coma INTEGER,
    comprimento_da_cauda INTEGER,
    
    -- Atributos específicos de Meteoroide
	
    velocidade REAL,
    tamanho REAL,
    composicao TEXT,
    continente VARCHAR(50),
    pais VARCHAR(50),
    estado VARCHAR(50),
    data DATE,
    hora TIME WITH TIME ZONE,
    
    -- Atributos específicos de Satelite Natural
	
    principal_planeta VARCHAR(100),
    distancia_orbital REAL
);

-- Tabela de Avaliação

CREATE TABLE Avaliacao (
    id SERIAL PRIMARY KEY,
    categoria VARCHAR(20),
    cpf CHAR(11) REFERENCES Usuario(cpf) ON DELETE CASCADE ON UPDATE CASCADE,
    codigo_cientifico TEXT REFERENCES Corpo_Celeste(codigo_cientifico) ON DELETE CASCADE ON UPDATE CASCADE,
    nota INTEGER,
    comentario TEXT
);

-- Tabela de Validação

CREATE TABLE Validacao (
    id SERIAL PRIMARY KEY,
    codigo_cientifico TEXT NOT NULL REFERENCES Corpo_Celeste(codigo_cientifico) ON DELETE CASCADE ON UPDATE CASCADE,
    soma_de_notas INTEGER NOT NULL,
    quantidade_de_avaliacoes INTEGER NOT NULL,
    media REAL,
    classificacao TEXT
);

INSERT INTO Usuario (nome, cpf, telefone_1, telefone_2, senha)
VALUES ('João Silva', '12345678901', '85987654321', '85987654322', 'senha123');

INSERT INTO Usuario (nome, cpf, telefone_1, telefone_2, senha) 
VALUES ('Maria Oliveira', '98765432100', '21999887766', '21988776655', 'abc12345');

INSERT INTO Usuario (nome, cpf, telefone_1, telefone_2, senha) 
VALUES ('Mariana Santos', '23456789012', '11999887766', '11988776655', 'senha123');

ALTER TABLE corpos.validacao
ADD CONSTRAINT unique_codigo_cientifico UNIQUE (codigo_cientifico);

SELECT * FROM avaliacao; 
SELECT * FROM corpo_celeste;
SELECT * FROM validacao;
SELECT * FROM usuario;


