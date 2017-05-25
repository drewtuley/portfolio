PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE deal (
 google_cid int,
 iso_date int,
 tx_type text,
 shares int,
 price float
);
CREATE INDEX deal_idx on deal(google_cid, iso_date);
COMMIT;
