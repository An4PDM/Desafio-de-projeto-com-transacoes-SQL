SELECT @@autocommit;
SET @@autocommit = 0;

SHOW SESSION VARIABLES LIKE '%isolation';
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Exemplo: Conta bancária
USE teste;

CREATE TABLE conta_bancaria (
	id_c INT PRIMARY KEY,
    nome_cliente VARCHAR(45),
    saldo DECIMAL(10,2)
);

CREATE TABLE transacao_bancaria (
	id_t INT,
    id_c INT,
    PRIMARY KEY (id_t, id_c),
    tipo ENUM ('gasto','deposito'),
    valor DECIMAL (10,2),
    data_transacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_conta_transacao FOREIGN KEY (id_c) REFERENCES conta_bancaria(id_c)
);

DELIMITER //
CREATE PROCEDURE insere_conta (id INT, n VARCHAR(45), s DECIMAL(10,2))
BEGIN
	INSERT INTO conta_bancaria VALUES (id, n, s);
    SELECT * FROM conta_bancaria;
END //
DELIMITER ;

CALL insere_conta (1,'Laura J',2900);
CALL insere_conta (2,'Joana',6708);
CALL insere_conta (3,'Ricardo',270);
CALL insere_conta (4,'Mirela',987);
CALL insere_conta (5,'Maria',6480);

-- Parte 1: Transação simples
START TRANSACTION;
CALL insere_conta (7,'Geraldo',5000);
ROLLBACK;

-- estrutura condicional para realizar commit ou rollback
-- fazer a transacao bancaria só se o saldo for suficiente, caso contrário o rollback ocorre;
-- É preciso usar procedure armazenada

DELIMITER //
CREATE PROCEDURE insere_transacao 
(id INT, id_conta INT, t ENUM('gasto','deposito'), v DECIMAL (10,2))
BEGIN
	DECLARE saldo_atual DECIMAL(10,2);
	START TRANSACTION; -- inicia a transação

    -- Condicional que verifica se o saldo é suficiente
    IF t = 'gasto' THEN
		SELECT saldo INTO saldo_atual FROM conta_bancaria WHERE id_c=id_conta LIMIT 1;
		IF saldo_atual >= v THEN
			INSERT INTO transacao_bancaria (id_t,id_c,tipo,valor) VALUES (id,id_conta,t,v);
            UPDATE conta_bancaria SET saldo = saldo - v WHERE id_c = id_conta;
			COMMIT; -- Confirmação
            SELECT 'Transação efetuada com sucesso.' AS mensagem;
        ELSE    
            ROLLBACK;
            SELECT 'Saldo insuficiente.' AS mensagem;
		END IF;
	ELSE
		-- Caso seja apenas deposito
        INSERT INTO transacao_bancaria (id_t,id_c,tipo,valor) VALUES (id,id_conta,t,v);
        UPDATE conta_bancaria SET saldo = saldo + v WHERE id_c=id_conta;
        COMMIT;
        SELECT 'Depósito efetuado com sucesso.' AS mensagem;
    END IF;
END //
DELIMITER ;

DROP PROCEDURE insere_transacao;

-- Testes de execução
CALL insere_transacao (3,3,'gasto',300);
CALL insere_transacao (4,3,'deposito',300);
CALL insere_transacao (5,1,'gasto',900);

SELECT * FROM conta_bancaria;
SELECT * FROM transacao_bancaria;








