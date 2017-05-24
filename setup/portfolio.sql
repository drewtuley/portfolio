PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE portfolio (
name text primary key,
ticker name,
google_cid int
);
INSERT INTO "portfolio" VALUES('Castings','LON:CGS',668559);
INSERT INTO "portfolio" VALUES('Wincanton','LON:WIN',669878);
INSERT INTO "portfolio" VALUES('GVC Holdings','LON:GVC',697406);
INSERT INTO "portfolio" VALUES('IMI PLC','LON:IMI',5320278);
INSERT INTO "portfolio" VALUES('Burberry','LON:BRBY',9601095);
INSERT INTO "portfolio" VALUES('Britvic','LON:BVIC',703400);
INSERT INTO "portfolio" VALUES('Rotork','LON:ROR',15669503);
INSERT INTO "portfolio" VALUES('Auto Trader','LON:AUTO',882492039568036);
INSERT INTO "portfolio" VALUES('Renishaw','LON:RSW',2041626);
INSERT INTO "portfolio" VALUES('Halma','LON:HLMA',8759388);
INSERT INTO "portfolio" VALUES('Northgate','LON:NTG',10020596);
INSERT INTO "portfolio" VALUES('Boohoo','LON:BOO',815280817732572);
INSERT INTO "portfolio" VALUES('Provident','LON:PFG',16056250);
INSERT INTO "portfolio" VALUES('Polar Capital','LON:POLR',714574);
INSERT INTO "portfolio" VALUES('Clinigen','LON:CLIN',74455295304781);
INSERT INTO "portfolio" VALUES('Unilever','LON:ULVR',11262480);
INSERT INTO "portfolio" VALUES('Portmeirion','LON:PMP',668534);
INSERT INTO "portfolio" VALUES('Norcros','LON:NXR',691274);
INSERT INTO "portfolio" VALUES('Tasty','LON:TAST',706910);
INSERT INTO "portfolio" VALUES('Hansteen','LON:HSTN',702596);
INSERT INTO "portfolio" VALUES('Pendragon','LON:PDG',16521567);
INSERT INTO "portfolio" VALUES('Moneysupermarket','LON:MONY',717877);
INSERT INTO "portfolio" VALUES('Tesco','LON:TSCO',4116076);
INSERT INTO "portfolio" VALUES('WH Smiths','LON:SMWH',15784556);
INSERT INTO "portfolio" VALUES('Judges Scientific','LON:JDG',685593);
INSERT INTO "portfolio" VALUES('Worldpay','LON:WPG',617524107181569);
INSERT INTO "portfolio" VALUES('Saga','LON:SAGA',750567582656750);
INSERT INTO "portfolio" VALUES('RPC','LON:RPC',669520);
INSERT INTO "portfolio" VALUES('ITV','LON:ITV',15640152);
INSERT INTO "portfolio" VALUES('Barclays','LON:BARC',11248216);
INSERT INTO "portfolio" VALUES('BBA Aviation','LON:BBA',13399015);
INSERT INTO "portfolio" VALUES('Dominos','LON:DOM',668921);
CREATE INDEX portfolio_idx on portfolio(name)
;
CREATE UNIQUE INDEX portfolio_cid_idx on portfolio(google_cid);
COMMIT;
