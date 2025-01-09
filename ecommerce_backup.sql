-- MySQL dump 10.13  Distrib 8.0.40, for Linux (x86_64)
--
-- Host: localhost    Database: ecommerce
-- ------------------------------------------------------
-- Server version	8.0.40-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `idCliente` int NOT NULL AUTO_INCREMENT,
  `Fname` varchar(20) DEFAULT NULL,
  `Minit` varchar(3) DEFAULT NULL,
  `LName` varchar(20) DEFAULT NULL,
  `Birth` date NOT NULL,
  `Address` varchar(45) DEFAULT NULL,
  `Identity` char(11) NOT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE KEY `unique_ident_client` (`Identity`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Julia','L','Souza','1989-05-30','Rua B, n 2, bairro y, RJ','98765432101'),(2,'Cristian','M','Nunes','2000-08-12','Rua C, n 3, bairro A, MG','89674523101'),(3,'Luis','O','Peter','1998-06-26','Rua D, n 4, bairro Z, SP','12378934533'),(4,'Paula','A','Martins','1899-10-30','Rua E, n 5, bairro W, MG','45678912322'),(6,'Luiza','K','Jane','2000-09-25','rua 1','11334556778');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estoque`
--

DROP TABLE IF EXISTS `estoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estoque` (
  `idEstoque` int NOT NULL AUTO_INCREMENT,
  `local_estoque` varchar(200) NOT NULL,
  `quantidade` int DEFAULT '0',
  PRIMARY KEY (`idEstoque`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estoque`
--

LOCK TABLES `estoque` WRITE;
/*!40000 ALTER TABLE `estoque` DISABLE KEYS */;
INSERT INTO `estoque` VALUES (1,'SP',10200),(2,'MG',20350),(3,'RJ',45159);
/*!40000 ALTER TABLE `estoque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fornecedor`
--

DROP TABLE IF EXISTS `fornecedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fornecedor` (
  `idFornecedor` int NOT NULL AUTO_INCREMENT,
  `razão_social` varchar(45) NOT NULL,
  `CNPJ` char(15) NOT NULL,
  `contato` char(11) NOT NULL,
  PRIMARY KEY (`idFornecedor`),
  UNIQUE KEY `unique_CNPJ_fornecedor` (`CNPJ`),
  KEY `index_contato` (`contato`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornecedor`
--

LOCK TABLES `fornecedor` WRITE;
/*!40000 ALTER TABLE `fornecedor` DISABLE KEYS */;
INSERT INTO `fornecedor` VALUES (1,'Electrolux','123456789101234','11988877777'),(2,'Mobly','127222766543250','31912344515'),(3,'Italac','456789123876098','12954555566'),(4,'Kappesberg','999234765891245','21987684434'),(5,'Doritos','938456712409475','11923447312');
/*!40000 ALTER TABLE `fornecedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `local_estoque`
--

DROP TABLE IF EXISTS `local_estoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `local_estoque` (
  `idLProduto` int NOT NULL,
  `idLEstoque` int NOT NULL,
  `Elocal` varchar(255) NOT NULL,
  PRIMARY KEY (`idLProduto`,`idLEstoque`),
  KEY `fk_local_estoque_estoque` (`idLEstoque`),
  CONSTRAINT `fk_local_estoque_estoque` FOREIGN KEY (`idLEstoque`) REFERENCES `estoque` (`idEstoque`),
  CONSTRAINT `fk_local_estoque_produto` FOREIGN KEY (`idLProduto`) REFERENCES `produto` (`idProduto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `local_estoque`
--

LOCK TABLES `local_estoque` WRITE;
/*!40000 ALTER TABLE `local_estoque` DISABLE KEYS */;
INSERT INTO `local_estoque` VALUES (1,1,'SP'),(1,3,'RJ'),(2,2,'MG'),(3,3,'RJ'),(4,3,'SP'),(5,2,'MG'),(6,1,'SP'),(7,1,'SP'),(8,2,'MG'),(9,3,'RJ');
/*!40000 ALTER TABLE `local_estoque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `idPedido` int NOT NULL AUTO_INCREMENT,
  `idPedidoCliente` int DEFAULT NULL,
  `stts` enum('Em andamento','Processando','Enviado','Entregue') DEFAULT 'Processando',
  `Address` varchar(45) DEFAULT NULL,
  `Descricao` varchar(200) DEFAULT NULL,
  `Frete` float DEFAULT '0',
  `Code_frete` float DEFAULT NULL,
  `pagamento_dinheiro` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`idPedido`),
  KEY `fk_pedido_cliente` (`idPedidoCliente`),
  CONSTRAINT `fk_pedido_cliente` FOREIGN KEY (`idPedidoCliente`) REFERENCES `cliente` (`idCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (1,1,'Em andamento','Rua B, n 2, bairro y, RJ','Duas camisetas P',0,NULL,0),(2,2,'Enviado','Rua C, n 3, bairro A, MG','Brinquedo My Little Pony, cinco unidades',30.9,23456,0),(3,3,'Em andamento','Rua D, n 4, bairro Z, SP','Colchão Kappesberg',0,NULL,0);
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_fornecedor`
--

DROP TABLE IF EXISTS `prod_fornecedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_fornecedor` (
  `idPFornecedor` int NOT NULL,
  `idFProduto` int NOT NULL,
  `quantidade` int NOT NULL,
  PRIMARY KEY (`idPFornecedor`,`idFProduto`),
  KEY `fk_fproduto_produto` (`idFProduto`),
  CONSTRAINT `fk_fproduto_produto` FOREIGN KEY (`idFProduto`) REFERENCES `produto` (`idProduto`),
  CONSTRAINT `fk_pfornecedor_fornecedor` FOREIGN KEY (`idPFornecedor`) REFERENCES `fornecedor` (`idFornecedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_fornecedor`
--

LOCK TABLES `prod_fornecedor` WRITE;
/*!40000 ALTER TABLE `prod_fornecedor` DISABLE KEYS */;
INSERT INTO `prod_fornecedor` VALUES (1,4,3400),(2,8,4500),(3,9,300),(4,1,4300),(5,7,870);
/*!40000 ALTER TABLE `prod_fornecedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto` (
  `idProduto` int NOT NULL AUTO_INCREMENT,
  `ProdNome` varchar(20) DEFAULT NULL,
  `categoria` enum('Alimento','Roupa','Brinquedo','Móveis','Eletrônicos') NOT NULL,
  `classification_kids` tinyint(1) DEFAULT '0',
  `avaliacao` float DEFAULT NULL,
  `size` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idProduto`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` VALUES (1,'Colchão','Móveis',0,4,NULL),(2,'Boneca','Brinquedo',1,5,NULL),(3,'Liquidificador','Eletrônicos',0,4.5,NULL),(4,'Geladeira','Eletrônicos',0,5,'590 litros'),(5,'Blusa','Roupa',0,NULL,'M'),(6,'Carrinho','Brinquedo',1,NULL,NULL),(7,'Salgadinho','Alimento',0,5,NULL),(8,'Mesa','Móveis',0,3.8,'60x90x75 cm'),(9,'Achocolatado','Alimento',0,3,NULL);
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto_pedido`
--

DROP TABLE IF EXISTS `produto_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto_pedido` (
  `idPProduto` int NOT NULL,
  `idPPedido` int NOT NULL,
  `pp_quantidade` int NOT NULL,
  `pp_stts` enum('Sem estoque','Disponível') DEFAULT 'Disponível',
  PRIMARY KEY (`idPProduto`,`idPPedido`),
  KEY `fk_produto_pedido` (`idPPedido`),
  CONSTRAINT `fk_pproduto_produto` FOREIGN KEY (`idPProduto`) REFERENCES `produto` (`idProduto`),
  CONSTRAINT `fk_produto_pedido` FOREIGN KEY (`idPPedido`) REFERENCES `pedido` (`idPedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto_pedido`
--

LOCK TABLES `produto_pedido` WRITE;
/*!40000 ALTER TABLE `produto_pedido` DISABLE KEYS */;
INSERT INTO `produto_pedido` VALUES (1,1,2,'Disponível'),(2,2,5,'Disponível'),(3,3,1,'Sem estoque');
/*!40000 ALTER TABLE `produto_pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto_vendedor`
--

DROP TABLE IF EXISTS `produto_vendedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto_vendedor` (
  `idVProduto` int NOT NULL,
  `idPVendedor` int NOT NULL,
  `quantidade` int NOT NULL,
  PRIMARY KEY (`idVProduto`,`idPVendedor`),
  KEY `fk_produto_vendedor` (`idPVendedor`),
  CONSTRAINT `fk_produto_produto` FOREIGN KEY (`idVProduto`) REFERENCES `produto` (`idProduto`),
  CONSTRAINT `fk_produto_vendedor` FOREIGN KEY (`idPVendedor`) REFERENCES `vendedor` (`idVendedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto_vendedor`
--

LOCK TABLES `produto_vendedor` WRITE;
/*!40000 ALTER TABLE `produto_vendedor` DISABLE KEYS */;
INSERT INTO `produto_vendedor` VALUES (1,5,400),(2,2,550),(3,5,1760),(4,3,302),(5,2,590),(6,2,860);
/*!40000 ALTER TABLE `produto_vendedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendedor`
--

DROP TABLE IF EXISTS `vendedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendedor` (
  `idVendedor` int NOT NULL AUTO_INCREMENT,
  `razão_social` varchar(45) NOT NULL,
  `tipo_identificação` enum('CPF','CNPJ') NOT NULL,
  `identificação` varchar(15) DEFAULT NULL,
  `contato` char(11) NOT NULL,
  PRIMARY KEY (`idVendedor`),
  UNIQUE KEY `unique_identificação_vendedor` (`identificação`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendedor`
--

LOCK TABLES `vendedor` WRITE;
/*!40000 ALTER TABLE `vendedor` DISABLE KEYS */;
INSERT INTO `vendedor` VALUES (1,'Electrolux','CNPJ','123456789101234','11988877777'),(2,'Mattel','CNPJ','123456789123350','31914444555'),(3,'Renner','CNPJ','98765432145678','21956236677'),(4,'Italac','CNPJ','456789123876098','12954555566'),(5,'Alana R.Roupas','CPF','91867854322','11957656544');
/*!40000 ALTER TABLE `vendedor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-09 14:11:18
