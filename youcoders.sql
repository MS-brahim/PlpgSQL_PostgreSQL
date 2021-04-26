CREATE TABLE youcoders (
    matricule VARCHAR(4) PRIMARY KEY, 
	full_name VARCHAR(15) NOT NULL,
	campus VARCHAR(15) NOT NULL, 
	classe VARCHAR(15) NOT NULL, 
	referentiel VARCHAR(15) NOT NULL, 
	nbr_competence NUMERIC(5) DEFAULT 0, 
	is_accepted boolean
);
INSERT INTO youcoders VALUES ('P400','KAMAL BHF','Youssoufia','FEBE','CDA',14,true);
INSERT INTO youcoders VALUES ('P765','Mohammed ahmed','Safi','JEE','DWWM',8,true);
INSERT INTO youcoders VALUES ('P122','Amine amine','Safi','C#','CDA',14,false);
INSERT INTO youcoders VALUES ('P202','Yassine yassine','Youssoufia','PHP','CDA',14,true);
INSERT INTO youcoders VALUES ('P980','Don Reda','Safi','JEE','DWWM',8,false);
INSERT INTO youcoders VALUES ('P543','Salma Salma','Youssoufia','C#','AI',10,true);
INSERT INTO youcoders VALUES ('P307','Zakaria zakaria','Safi','FEBE','CDA',14,false);
INSERT INTO youcoders VALUES ('P199','Omar omar','Safi','JEE','AI',10,false);
INSERT INTO youcoders VALUES ('P387','Houssam houssam','Safi','FEBE','CDA',14,true);
INSERT INTO youcoders VALUES ('P566','Imane imane','Youssoufia','FEBE','CDA',14,true);

select * from youcoders

CREATE OR REPLACE FUNCTION nbYoucoders(ville VARCHAR,status Boolean,seuil INT) RETURNS INTEGER AS $$
DECLARE
n INTEGER;
BEGIN
	SELECT COUNT(*) INTO n FROM youcoders where is_accepted=status and campus = ville;
		IF n < seuil THEN
		RAISE EXCEPTION 'Trop de rattrapage (%) !', n;
		ELSE
		RETURN n;
	END IF;
END
$$ LANGUAGE plpgsql;

SELECT nbYoucoders('Safi',true,1);


CREATE OR REPLACE FUNCTION calculPercentage(total INT) RETURNS INTEGER AS $$
DECLARE
n INTEGER;
percentage NUMERIC;
BEGIN
	SELECT COUNT(*) INTO n FROM youcoders where campus='Safi' and classe = 'FEBE';

	percentage = (total * n)/100;

	return percentage;

END
$$ LANGUAGE plpgsql;

select public.calculPercentage(50)

CREATE OR REPLACE FUNCTION referentielEven(student VARCHAR) RETURNS INTEGER AS $$
DECLARE
b VARCHAR;
n INTEGER;

BEGIN
	SELECT classe INTO b FROM youcoders where full_name=student;

	SELECT COUNT(*) INTO n FROM youcoders where classe=b;

	return n;

END
$$ LANGUAGE plpgsql;

select public.referentielEven('Amine amine')

CREATE OR REPLACE PROCEDURE changeStatus() 
 LANGUAGE SQL 
AS $$
   UPDATE youcoders
	SET is_accepted  = true
	WHERE campus  = 'Youssoufia'
$$;
Call changeStatus()



CREATE OR REPLACE FUNCTION update_false() RETURNS trigger AS $update_false$
    BEGIN
       UPDATE youcoders SET is_accepted = false;
       RETURN NEW;
    END;
$update_false$ LANGUAGE plpgsql;

CREATE TRIGGER update_false AFTER INSERT ON youcoders
    FOR EACH ROW EXECUTE FUNCTION public.update_false()
	
	
	INSERT INTO youcoders VALUES ('P470','brahim moussi','Youssoufia','FEBE','CDA',14,true);

CREATE OR REPLACE PROCEDURE  updateClasse() 
LANGUAGE SQL
AS $$
	UPDATE youcoders
	SET classe  = 'DATA BI'
	WHERE nbr_competence=14 AND matricule LIKE '%2%'
$$;
 CALL updateClasse()

CREATE OR REPLACE FUNCTION AddColumn() RETURNS trigger AS $AddColumn$
BEGIN 
ALTER TABLE youcoders 
RENAME COLUMN campus TO City;
RETURN NEW ;
END 
$AddColumn$ LANGUAGE plpgsql;
CREATE TRIGGER AddColumn AFTER INSERT ON youcoders 
FOR EACH ROW EXECUTE FUNCTION  AddColumn();
CREATE OR REPLACE FUNCTION Referentiel() RETURNS trigger AS $Referentiel$
BEGIN 
 UPDATE youcoders SET  nbr_competence = nbr_competence + 3 where referentiel = 'AI' ;
RETURN NEW ;
END 
$Referentiel$ LANGUAGE plpgsql;
 CREATE TRIGGER Referentiel AFTER INSERT ON youcoders 
 FOR EACH ROW EXECUTE FUNCTION  Referentiel();
INSERT INTO youcoders VALUES ('P777','jhon doe','Safi','AI','DWWM',8,true);
 select * from youcoders