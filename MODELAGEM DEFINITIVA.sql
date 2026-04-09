CREATE TABLE sla(
idSLA INT PRIMARY KEY AUTO_INCREMENT,
nomeSLA VARCHAR(75) NOT NULL,
tempoResposta DATETIME NOT NULL,
tempoResolucao DATETIME NOT NULL,
descricao VARCHAR(100) NOT NULL
);


CREATE TABLE tecnico(
idTecnico INT PRIMARY KEY AUTO_INCREMENT,
nomeTecnico VARCHAR(75) NOT NULL,
emailTecnico VARCHAR(55) NOT NULL,
especialidade VARCHAR(155) NOT NULL
)


CREATE TABLE Categoria(
idCategoria INT PRIMARY KEY AUTO_INCREMENT,
nomeCategoria VARCHAR(55) NOT NULL,
descricao VARCHAR(45) NOT NULL
)


CREATE TABLE empresa (
    idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
    CNPJ VARCHAR(18) NOT NULL UNIQUE,
    dominioEmail VARCHAR(75) NOT NULL UNIQUE,
    nome VARCHAR(255) NOT NULL,
    nomeFantasia VARCHAR(90) NOT NULL,
    tipologradouro VARCHAR(20) NOT NULL,
    nomelogradouro VARCHAR(50) NOT NULL,
    bairro VARCHAR(50) NOT NULL,
    cep VARCHAR(8) NOT NULL,
    complemento VARCHAR(50),
    cidade VARCHAR(50) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    ddd VARCHAR(3) NOT NULL,
    ddi VARCHAR(2) NOT NULL,
    plano VARCHAR(10) NOT NULL,
    CONSTRAINT ck_plano CHECK (plano IN ('Mensal', 'Anual'))
) ENGINE=InnoDB;


CREATE TABLE usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    idEmpresa INT NOT NULL,
    nome VARCHAR(85) NOT NULL,
    email VARCHAR(100) NOT NULL,
    login VARCHAR(100) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    cargo VARCHAR(55) NOT NULL,
    setor VARCHAR(55) NOT NULL,
    tipoUsuario VARCHAR(55) NOT NULL,
    CONSTRAINT fk_usuario_empresa
        FOREIGN KEY (idEmpresa) REFERENCES empresa(idEmpresa)
) ENGINE=InnoDB;


CREATE TABLE ticket (
    idTicket INT AUTO_INCREMENT PRIMARY KEY,
    idTecnico INT NOT NULL,
    idUsuario INT NOT NULL,
    idCategoria INT NOT NULL,
    idSLA INT NOT NULL,
    titulo VARCHAR(75) NOT NULL,
    statusTicket VARCHAR(45) NOT NULL,
    prioridade VARCHAR(10) NOT NULL,
    dataAbertura DATETIME NOT NULL,
    dataFechamento DATETIME,
    CONSTRAINT ck_prioridade CHECK (prioridade IN ('Alta', 'Média', 'Baixa')),
    CONSTRAINT fk_ticket_tecnico
        FOREIGN KEY (idTecnico) REFERENCES tecnico(idTecnico),
    CONSTRAINT fk_ticket_usuario
        FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario),
    CONSTRAINT fk_ticket_categoria
        FOREIGN KEY (idCategoria) REFERENCES categoria(idCategoria),
    CONSTRAINT fk_ticket_sla
        FOREIGN KEY (idSLA) REFERENCES sla(idSLA)
) ENGINE=InnoDB;


CREATE TABLE respostaTicket (
    idRespostaTicket INT AUTO_INCREMENT PRIMARY KEY,
    idUsuario INT NOT NULL,
    idTicket INT NOT NULL,
    msgTicket VARCHAR(755),
    dataResposta DATETIME,
    CONSTRAINT fk_resposta_usuario
        FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario),
    CONSTRAINT fk_resposta_ticket
        FOREIGN KEY (idTicket) REFERENCES ticket(idTicket)
) ENGINE=InnoDB;


CREATE TABLE anexo (
    idAnexo INT AUTO_INCREMENT PRIMARY KEY,
    idTicket INT NOT NULL,
    nomeArquivo VARCHAR(55),
    caminhoArquivo VARCHAR(255),
    CONSTRAINT fk_anexo_ticket
        FOREIGN KEY (idTicket) REFERENCES ticket(idTicket)
) ENGINE=InnoDB;



CREATE TABLE avaliacaoTicket (
    idAvaliacaoTicket INT AUTO_INCREMENT PRIMARY KEY,
    idTicket INT NOT NULL,
    idUsuario INT NOT NULL,
    nota INT NOT NULL,
    comentario TEXT,
    dataAvaliacao DATETIME NOT NULL,
    CONSTRAINT ck_nota CHECK (nota BETWEEN 1 AND 5),
    CONSTRAINT fk_avaliacao_ticket
        FOREIGN KEY (idTicket) REFERENCES ticket(idTicket),
    CONSTRAINT fk_avaliacao_usuario
        FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario)
) ENGINE=InnoDB;



