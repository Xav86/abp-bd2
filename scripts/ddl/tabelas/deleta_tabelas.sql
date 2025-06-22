/* Drop Constraint */
DECLARE @sql NVARCHAR(MAX) = '';

SELECT @sql += 'ALTER TABLE [' + OBJECT_SCHEMA_NAME(parent_object_id) + '].[' + OBJECT_NAME(parent_object_id) + '] DROP CONSTRAINT [' + name + '];' + CHAR(13)
FROM sys.foreign_keys
WHERE name IN (
    SELECT fk.name
    FROM sys.foreign_keys fk
    JOIN sys.tables t ON fk.parent_object_id = t.object_id    WHERE t.name IN (
        'Pessoas',
        'Enderecos',
        'Clientes_Fisicos',
        'Clientes_Juridicos',
        'Funcionarios',
        'Historico_Ordens',
        'Servicos',
        'Pecas_Estoque',
        'Status',
        'Veiculos',
        'Ordens_de_Servico',
        'Funcionarios_OS',
        'Itens_Servico_OS',
        'Pecas_OS'
    )
);

EXEC sp_executesql @sql;




DROP TABLE IF EXISTS [Historico_Ordens];
DROP TABLE IF EXISTS [Pecas_OS];
DROP TABLE IF EXISTS [Itens_Servico_OS];
DROP TABLE IF EXISTS [Funcionarios_OS];
DROP TABLE IF EXISTS [Ordens_de_Servico];
DROP TABLE IF EXISTS [Veiculos];
DROP TABLE IF EXISTS [Servicos];
DROP TABLE IF EXISTS [Pecas_Estoque];
DROP TABLE IF EXISTS [Funcionarios];
DROP TABLE IF EXISTS [Clientes_Juridicos];
DROP TABLE IF EXISTS [Clientes_Fisicos];
DROP TABLE IF EXISTS [Enderecos];
DROP TABLE IF EXISTS [Pessoas];
DROP TABLE IF EXISTS [Status];
PRINT 'Limpeza do banco de dados concluída com sucesso!';