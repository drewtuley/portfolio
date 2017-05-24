PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE price (
 google_cid int,
 iso_date int,
 open float,
 high float,
 low float,
 clsoe float,
 volume int
);
CREATE UNIQUE INDEX price_idx on price(google_cid, iso_date);
COMMIT;
