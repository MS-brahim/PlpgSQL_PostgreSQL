PGDMP     !    8                y            Yc_DB    13.2    13.2     ?           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ?           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            ?           1262    16491    Yc_DB    DATABASE     d   CREATE DATABASE "Yc_DB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'French_Morocco.1252';
    DROP DATABASE "Yc_DB";
                postgres    false            ?            1255    16499    calculpercentage(integer)    FUNCTION     !  CREATE FUNCTION public.calculpercentage(total integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
n INTEGER;
percentage NUMERIC;
BEGIN
	SELECT COUNT(*) INTO n FROM youcoders where campus='Safi' and classe = 'FEBE';

	percentage = (total * n)/100;

	return percentage;

END
$$;
 6   DROP FUNCTION public.calculpercentage(total integer);
       public          postgres    false            ?            1255    16501    changestatus() 	   PROCEDURE     ?   CREATE PROCEDURE public.changestatus()
    LANGUAGE sql
    AS $$
   UPDATE youcoders
	SET is_accepted  = true
	WHERE campus  = 'Youssoufia'
$$;
 &   DROP PROCEDURE public.changestatus();
       public          postgres    false            ?            1255    16498 0   nbyoucoders(character varying, boolean, integer)    FUNCTION     `  CREATE FUNCTION public.nbyoucoders(ville character varying, status boolean, seuil integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
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
$$;
 Z   DROP FUNCTION public.nbyoucoders(ville character varying, status boolean, seuil integer);
       public          postgres    false            ?            1255    16505    referentiel()    FUNCTION     ?   CREATE FUNCTION public.referentiel() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
 UPDATE youcoders SET  nbr_competence = nbr_competence + 3 where referentiel = 'AI' ;
RETURN NEW ;
END 
$$;
 $   DROP FUNCTION public.referentiel();
       public          postgres    false            ?            1255    16500 "   referentieleven(character varying)    FUNCTION     !  CREATE FUNCTION public.referentieleven(student character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
b VARCHAR;
n INTEGER;

BEGIN
	SELECT classe INTO b FROM youcoders where full_name=student;

	SELECT COUNT(*) INTO n FROM youcoders where classe=b;

	return n;

END
$$;
 A   DROP FUNCTION public.referentieleven(student character varying);
       public          postgres    false            ?            1255    16502    update_false()    FUNCTION     ?   CREATE FUNCTION public.update_false() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
       UPDATE youcoders SET is_accepted = false;
       RETURN NEW;
    END;
$$;
 %   DROP FUNCTION public.update_false();
       public          postgres    false            ?            1255    16504    updateclasse() 	   PROCEDURE     ?   CREATE PROCEDURE public.updateclasse()
    LANGUAGE sql
    AS $$
	UPDATE youcoders
	SET classe  = 'DATA BI'
	WHERE nbr_competence=14 AND matricule LIKE '%2%'
$$;
 &   DROP PROCEDURE public.updateclasse();
       public          postgres    false            ?            1259    16492 	   youcoders    TABLE     G  CREATE TABLE public.youcoders (
    matricule character varying(4) NOT NULL,
    full_name character varying(15) NOT NULL,
    campus character varying(15) NOT NULL,
    classe character varying(15) NOT NULL,
    referentiel character varying(15) NOT NULL,
    nbr_competence numeric(5,0) DEFAULT 0,
    is_accepted boolean
);
    DROP TABLE public.youcoders;
       public         heap    postgres    false            ?          0    16492 	   youcoders 
   TABLE DATA           s   COPY public.youcoders (matricule, full_name, campus, classe, referentiel, nbr_competence, is_accepted) FROM stdin;
    public          postgres    false    200   ?       )           2606    16497    youcoders youcoders_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.youcoders
    ADD CONSTRAINT youcoders_pkey PRIMARY KEY (matricule);
 B   ALTER TABLE ONLY public.youcoders DROP CONSTRAINT youcoders_pkey;
       public            postgres    false    200            *           2620    16506    youcoders referentiel    TRIGGER     p   CREATE TRIGGER referentiel AFTER INSERT ON public.youcoders FOR EACH ROW EXECUTE FUNCTION public.referentiel();
 .   DROP TRIGGER referentiel ON public.youcoders;
       public          postgres    false    207    200            +           2620    16503    youcoders update_false    TRIGGER     r   CREATE TRIGGER update_false AFTER INSERT ON public.youcoders FOR EACH ROW EXECUTE FUNCTION public.update_false();
 /   DROP TRIGGER update_false ON public.youcoders;
       public          postgres    false    200    205            ?   ?   x?}??N?0?ϛ?X?;r~'G?I?  UE\%???R? O?&FѪ???y읍L?8M?v-?f?G??T??m??&??n?]K?汐?L?4?/?[UE?RA?L\&a펇Y???r?p?u??z??tǞC?q?4??ҾC3?2?^?Ƣ!s???5?J????IaQϰHD?#?b???<?????4?غ?PU?J??-?X?Zf&??e??O?,?????W???u????     