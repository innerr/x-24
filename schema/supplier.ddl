CREATE TABLE IF NOT EXISTS supplier (
S_SUPPKEY     INTEGER NOT NULL,
S_NAME        CHAR(25) NOT NULL,
S_ADDRESS     VARCHAR(40) NOT NULL,
S_NATIONKEY   INTEGER NOT NULL,
S_PHONE       CHAR(15) NOT NULL,
S_ACCTBAL     DOUBLE NOT NULL,
S_COMMENT     VARCHAR(101) NOT NULL);
