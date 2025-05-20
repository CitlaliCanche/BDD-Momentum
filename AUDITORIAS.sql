-- ========================================
-- SECUENCIA PARA ID_AUD_DETALLE_CURSO
-- ========================================
CREATE SEQUENCE ADJSS.SEQ_AUD_DETALLE_CURSO_ID
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 9999999999
    NOCYCLE
    NOCACHE
    ORDER;

-- ========================================
-- TABLA DE AUDITORÍA: AUD_DETALLE_CURSO
-- ========================================
CREATE TABLE ADJSS.AUD_DETALLE_CURSO (
    ID_AUD_DETALLE_CURSO     NUMBER(10) NOT NULL,
    ID_DETALLE_CURSO         NUMBER(10) NOT NULL,
    ACCION                  VARCHAR2(10 CHAR) NOT NULL,
    USUARIO_MODIFICACION    VARCHAR2(100 CHAR),
    FECHA_MODIFICACION      TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    VALORES_ANTERIORES      CLOB,
    VALORES_NUEVOS          CLOB,
    
    CONSTRAINT PK_AUD_DETALLE_CURSO PRIMARY KEY (ID_AUD_DETALLE_CURSO)
)
TABLESPACE APP_MOMEMTUM_DATA01_DAT
LOGGING;

-- ========================================
-- COMENTARIOS AUDITORÍA
-- ========================================
COMMENT ON TABLE ADJSS.AUD_DETALLE_CURSO IS 'Tabla de auditoría para cambios en TA_DETALLE_CURSO.';
COMMENT ON COLUMN ADJSS.AUD_DETALLE_CURSO.ID_AUD_DETALLE_CURSO IS 'Identificador único de auditoría.';
COMMENT ON COLUMN ADJSS.AUD_DETALLE_CURSO.ID_DETALLE_CURSO IS 'ID del detalle curso auditado.';
COMMENT ON COLUMN ADJSS.AUD_DETALLE_CURSO.ACCION IS 'Acción realizada (INSERT, UPDATE, DELETE).';
COMMENT ON COLUMN ADJSS.AUD_DETALLE_CURSO.USUARIO_MODIFICACION IS 'Usuario que realizó el cambio.';
COMMENT ON COLUMN ADJSS.AUD_DETALLE_CURSO.FECHA_MODIFICACION IS 'Fecha y hora del cambio.';
COMMENT ON COLUMN ADJSS.AUD_DETALLE_CURSO.VALORES_ANTERIORES IS 'JSON con los valores anteriores.';
COMMENT ON COLUMN ADJSS.AUD_DETALLE_CURSO.VALORES_NUEVOS IS 'JSON con los valores nuevos.';

-- ========================================
-- TRIGGER PARA LLENAR AUDITORÍA AUTOMÁTICAMENTE
-- ========================================
CREATE OR REPLACE TRIGGER ADJSS.TRG_AUD_TA_DETALLE_CURSO
AFTER INSERT OR UPDATE OR DELETE ON ADJSS.TA_DETALLE_CURSO
FOR EACH ROW
DECLARE
    v_usuario VARCHAR2(100);
    v_accion VARCHAR2(10);
    v_old_clob CLOB;
    v_new_clob CLOB;

    FUNCTION escape_json(p_text VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        -- Escapa caracteres especiales para JSON: comillas y barras invertidas
        RETURN REPLACE(REPLACE(p_text, '\', '\\'), '"', '\"');
    END;
BEGIN
    v_usuario := NVL(SYS_CONTEXT('USERENV', 'CLIENT_IDENTIFIER'), USER);

    IF INSERTING THEN
        v_accion := 'INSERT';
        v_old_clob := NULL;

        v_new_clob := '{"ID_TA_DETALLE_CURSO":' || :NEW.ID_TA_DETALLE_CURSO ||
                      ',"ID_TA_CURSO":' || :NEW.ID_TA_CURSO ||
                      ',"ID_CAT_IDIOMA":' || NVL(TO_CHAR(:NEW.ID_CAT_IDIOMA), 'null') ||
                      ',"ID_CAT_NIVEL":' || NVL(TO_CHAR(:NEW.ID_CAT_NIVEL), 'null') ||
                      ',"KEY_MINIATURA":"' || escape_json(NVL(:NEW.KEY_MINIATURA, '')) || '"' ||
                      ',"URL_MINIATURA":"' || escape_json(NVL(:NEW.URL_MINIATURA, '')) || '"' ||
                      ',"KEY_VIDEO_PROMO":"' || escape_json(NVL(:NEW.KEY_VIDEO_PROMO, '')) || '"' ||
                      ',"URL_VIDEO_PROMO":"' || escape_json(NVL(:NEW.URL_VIDEO_PROMO, '')) || '"' ||
                      ',"DESCRIPCION_CORTA":"' || escape_json(NVL(:NEW.DESCRIPCION_CORTA, '')) || '"' ||
                      ',"DESCRIPCION":"' || escape_json(DBMS_LOB.SUBSTR(:NEW.DESCRIPCION, 4000, 1)) || '"}';

    ELSIF UPDATING THEN
        v_accion := 'UPDATE';

        v_old_clob := '{"ID_TA_DETALLE_CURSO":' || :OLD.ID_TA_DETALLE_CURSO ||
                      ',"ID_TA_CURSO":' || :OLD.ID_TA_CURSO ||
                      ',"ID_CAT_IDIOMA":' || NVL(TO_CHAR(:OLD.ID_CAT_IDIOMA), 'null') ||
                      ',"ID_CAT_NIVEL":' || NVL(TO_CHAR(:OLD.ID_CAT_NIVEL), 'null') ||
                      ',"KEY_MINIATURA":"' || escape_json(NVL(:OLD.KEY_MINIATURA, '')) || '"' ||
                      ',"URL_MINIATURA":"' || escape_json(NVL(:OLD.URL_MINIATURA, '')) || '"' ||
                      ',"KEY_VIDEO_PROMO":"' || escape_json(NVL(:OLD.KEY_VIDEO_PROMO, '')) || '"' ||
                      ',"URL_VIDEO_PROMO":"' || escape_json(NVL(:OLD.URL_VIDEO_PROMO, '')) || '"' ||
                      ',"DESCRIPCION_CORTA":"' || escape_json(NVL(:OLD.DESCRIPCION_CORTA, '')) || '"' ||
                      ',"DESCRIPCION":"' || escape_json(DBMS_LOB.SUBSTR(:OLD.DESCRIPCION, 4000, 1)) || '"}';

        v_new_clob := '{"ID_TA_DETALLE_CURSO":' || :NEW.ID_TA_DETALLE_CURSO ||
                      ',"ID_TA_CURSO":' || :NEW.ID_TA_CURSO ||
                      ',"ID_CAT_IDIOMA":' || NVL(TO_CHAR(:NEW.ID_CAT_IDIOMA), 'null') ||
                      ',"ID_CAT_NIVEL":' || NVL(TO_CHAR(:NEW.ID_CAT_NIVEL), 'null') ||
                      ',"KEY_MINIATURA":"' || escape_json(NVL(:NEW.KEY_MINIATURA, '')) || '"' ||
                      ',"URL_MINIATURA":"' || escape_json(NVL(:NEW.URL_MINIATURA, '')) || '"' ||
                      ',"KEY_VIDEO_PROMO":"' || escape_json(NVL(:NEW.KEY_VIDEO_PROMO, '')) || '"' ||
                      ',"URL_VIDEO_PROMO":"' || escape_json(NVL(:NEW.URL_VIDEO_PROMO, '')) || '"' ||
                      ',"DESCRIPCION_CORTA":"' || escape_json(NVL(:NEW.DESCRIPCION_CORTA, '')) || '"' ||
                      ',"DESCRIPCION":"' || escape_json(DBMS_LOB.SUBSTR(:NEW.DESCRIPCION, 4000, 1)) || '"}';

    ELSIF DELETING THEN
        v_accion := 'DELETE';
        v_new_clob := NULL;

        v_old_clob := '{"ID_TA_DETALLE_CURSO":' || :OLD.ID_TA_DETALLE_CURSO ||
                      ',"ID_TA_CURSO":' || :OLD.ID_TA_CURSO ||
                      ',"ID_CAT_IDIOMA":' || NVL(TO_CHAR(:OLD.ID_CAT_IDIOMA), 'null') ||
                      ',"ID_CAT_NIVEL":' || NVL(TO_CHAR(:OLD.ID_CAT_NIVEL), 'null') ||
                      ',"KEY_MINIATURA":"' || escape_json(NVL(:OLD.KEY_MINIATURA, '')) || '"' ||
                      ',"URL_MINIATURA":"' || escape_json(NVL(:OLD.URL_MINIATURA, '')) || '"' ||
                      ',"KEY_VIDEO_PROMO":"' || escape_json(NVL(:OLD.KEY_VIDEO_PROMO, '')) || '"' ||
                      ',"URL_VIDEO_PROMO":"' || escape_json(NVL(:OLD.URL_VIDEO_PROMO, '')) || '"' ||
                      ',"DESCRIPCION_CORTA":"' || escape_json(NVL(:OLD.DESCRIPCION_CORTA, '')) || '"' ||
                      ',"DESCRIPCION":"' || escape_json(DBMS_LOB.SUBSTR(:OLD.DESCRIPCION, 4000, 1)) || '"}';
    END IF;

    INSERT INTO ADJSS.AUD_DETALLE_CURSO (
        ID_AUD_DETALLE_CURSO,
        ID_DETALLE_CURSO,
        ACCION,
        USUARIO_MODIFICACION,
        FECHA_MODIFICACION,
        VALORES_ANTERIORES,
        VALORES_NUEVOS
    )
    VALUES (
        ADJSS.SEQ_AUD_DETALLE_CURSO_ID.NEXTVAL,
        NVL(:OLD.ID_TA_DETALLE_CURSO, :NEW.ID_TA_DETALLE_CURSO),
        v_accion,
        v_usuario,
        CURRENT_TIMESTAMP,
        v_old_clob,
        v_new_clob
    );
END;
/