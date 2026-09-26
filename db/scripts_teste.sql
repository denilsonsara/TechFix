PRAGMA foreign_keys=1;

PRAGMA foreign_keys;

CREATE TABLE cargo (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_cargo TEXT NOT NULL COLLATE NOCASE UNIQUE,
    status INTEGER NOT NULL DEFAULT 1
) STRICT;

CREATE TABLE funcionario (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_funcionario TEXT NOT NULL COLLATE NOCASE,
    id_cargo INTEGER NOT NULL,
    status INTEGER NOT NULL DEFAULT 1,
    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
    FOREIGN KEY (id_cargo) REFERENCES cargo(id) ON UPDATE CASCADE ON DELETE CASCADE,
    UNIQUE(id, id_cargo)
) STRICT;

INSERT INTO cargo (nome_cargo) VALUES ('GERENTE'), ('ATENDENTE'), ('TÉCNICO');

-- Inserts para 3 Técnicos (id_cargo = 3)
INSERT INTO funcionario (nome_funcionario, id_cargo) VALUES ('Carlos Silva', 1);
INSERT INTO funcionario (nome_funcionario, id_cargo) VALUES ('Mariana Oliveira', 1);
INSERT INTO funcionario (nome_funcionario, id_cargo) VALUES ('Lucas Santos', 1);

-- Inserts para 2 Atendentes (id_cargo = 2)
INSERT INTO funcionario (nome_funcionario, id_cargo) VALUES ('Beatriz Souza', 2);
INSERT INTO funcionario (nome_funcionario, id_cargo) VALUES ('Gabriel Costa', 2);

-- Insert para 1 Gerente (id_cargo = 3)
INSERT INTO funcionario (nome_funcionario, id_cargo) VALUES ('Ana Paula Ferreira', 3);

DROP TABLE cliente;

CREATE TABLE cliente (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_cliente TEXT NOT NULL COLLATE NOCASE,
    email TEXT NOT NULL COLLATE NOCASE UNIQUE,
    status INTEGER NOT NULL DEFAULT 1,
    id_funcionario INTEGER NOT NULL,
    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1 OR id_funcionario_cargo = 2),
    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
    FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)
) STRICT;

INSERT INTO cliente (nome_cliente, email, id_funcionario, id_funcionario_cargo)
VALUES ('Ana Beatriz Souza', 'ana.souza@email.com', 1, (SELECT id_cargo FROM funcionario WHERE id = 1));

INSERT INTO cliente (nome_cliente, email, id_funcionario, id_funcionario_cargo)
VALUES ('Carlos Eduardo Lima', 'carlos.lima@email.com', 2, (SELECT id_cargo FROM funcionario WHERE id = 2));

INSERT INTO cliente (nome_cliente, email, id_funcionario, id_funcionario_cargo)
VALUES ('Fernanda Ribeiro Alves', 'fernanda.alves@email.com', 1, (SELECT id_cargo FROM funcionario WHERE id = 1));

INSERT INTO cliente (nome_cliente, email, id_funcionario, id_funcionario_cargo)
VALUES ('João Pedro Martins', 'joao.martins@email.com', 3, (SELECT id_cargo FROM funcionario WHERE id = 3));

INSERT INTO cliente (nome_cliente, email, id_funcionario, id_funcionario_cargo)
VALUES ('Mariana Costa Oliveira', 'mariana.oliveira@email.com', 2, (SELECT id_cargo FROM funcionario WHERE id = 2));