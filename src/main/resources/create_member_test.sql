CREATE TABLE member (
	id CHARACTER VARYING (1073741823) NOT NULL,
	pw CHARACTER VARYING (1073741823),
	nm CHARACTER VARYING (1073741823),
	CONSTRAINT pk_member_id PRIMARY KEY(id)
)
COLLATE iso88591_bin
REUSE_OID;