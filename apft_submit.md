# BD: Trabalho Prático APF-T

**Grupo**: P5G5
- Bárbara Nóbrega Galiza, MEC: 105937
- Miguel da Silva Pinto, MEC: 107449

# Instructions - TO REMOVE

The files should be organized with the following nomenclature:

- sql\01_ddl.sql: mandatory for DDL
- sql\02_sp_functions.sql: mandatory for Store Procedure, Functions,... 
- sql\03_triggers.sql: mandatory for triggers
- sql\04_db_init.sql: scripts to init the database (i.e. inserts etc.)
- sql\05_any_other_matter.sql: any other scripts.

Por favor remova esta secção antes de submeter.

## Introdução / Introduction
 
O tema do nosso trabalho é a gestão de uma empresa de calçado à qual demos o nome 'Passo Firme'.
Criamos este projeto para que do lado da empresa seja possível gerir entidades como: produtos, funcionários, fornecedores e revendedores.
É possível obter várias estatísticas acerca de cada entidade com foco nas que pertececem à empresa (com visualização extensa de cada secção e processamento de cada produto).
De notar que 'Produto' refere-se a 1 item (exemplo: par de sapatos), mas a visualização de estatísticas é feita por 'Tipo de Produto' (exemplo: Bota Timber Branca).


## ​Análise de Requisitos / Requirements


### APFE - melhorias no DER / ER

A quantidade em armazém de um produto é agora um atributo calculado (faz mais sentido dada a abordagem descrita de 'produto').
O ato de processar um está agora ligado à entidade 'Operário' em vez de 'Funcionário' (faz mais sentido dado que o processamento é feito por operários e a entidade 'Gerente' pode apenas coordenar se não for o único 'Funcionário' na secção).
A relação 'is-a' deixou de ser disjunta, ou seja, um 'Funcionário' pode ser um 'Gerente' e um 'Operário' ao mesmo tempo (faz mais sentido dado que um 'Gerente' pode ser um 'Operário' caso seja o único 'Funcionário' na secção).

## DER - Diagrama Entidade Relacionamento / Entity Relationship Diagram

### Versão final/Final version

![DER Diagram!](der.jpg "AnImage")

## ER - Esquema Relacional / Relational Schema

### Versão final/Final Version

![ER Diagram!](er.jpg "AnImage")

## ​SQL DDL - Data Definition Language

[SQL DDL File](sql/01_ddl.sql "SQLFileQuestion")

## SQL DML - Data Manipulation Language

Uma secção por formulário.
A section for each form.

### Formulario exemplo / Example Form

![Exemplo Screenshot!](screenshots/screenshot_1.jpg "AnImage")

```sql
-- Show data on the form
SELECT * FROM MY_TABLE ....;

-- Insert new element
INSERT INTO MY_TABLE ....;
```

...

## Normalização / Normalization

Descreva os passos utilizados para minimizar a duplicação de dados / redução de espaço.
Justifique as opções tomadas.
Describe the steps used to minimize data duplication / space reduction.
Justify the choices made.

## Índices / Indexes

Descreva os indices criados. Junte uma cópia do SQL de criação do indice.
Describe the indexes created. Attach a copy of the SQL to create the index.

```sql
-- Create an index to speed
CREATE INDEX index_name ON table_name (column1, column2, ...);
```

## SQL Programming: Stored Procedures, Triggers, UDF, Insertion Data, Indexes

[SQL SPs and Functions File](sql/02_sp_functions.sql "SQLFileQuestion")

[SQL Triggers File](sql/03_triggers.sql "SQLFileQuestion")

[SQL DB Init File](sql/04_db_init.sql "SQLFileQuestion")

[Indexes File](sql/05_idx.sql "SQLFileQuestion")

## ​Outras Notas / Other Notes
 