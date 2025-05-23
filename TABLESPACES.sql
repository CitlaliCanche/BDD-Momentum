-- Tablas funcionales
CREATE TABLESPACE APP_MOMEMTUM_DATA01_DAT
LOGGING ONLINE PERMANENT
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

-- Índices funcionales
CREATE TABLESPACE APP_MOMEMTUM_DATA01_IDX
LOGGING ONLINE PERMANENT
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

-- Catálogos
CREATE TABLESPACE APP_MOMEMTUM_CAT01_DAT
LOGGING ONLINE PERMANENT
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

-- Índices de catálogos
CREATE TABLESPACE APP_MOMEMTUM_CAT01_IDX
LOGGING ONLINE PERMANENT
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

-- Auditoría
CREATE TABLESPACE APP_MOMEMTUM_AUD01_DAT
LOGGING ONLINE PERMANENT
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

-- LOB
CREATE TABLESPACE APP_MOMEMTUM_LOB01_DAT
LOGGING ONLINE PERMANENT
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

SELECT * FROM DBA_TABLESPACES ORDER BY TABLESPACE_NAME;