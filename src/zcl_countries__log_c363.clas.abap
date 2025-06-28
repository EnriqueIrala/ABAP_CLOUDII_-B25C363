CLASS zcl_countries__log_c363 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_countries__log_c363 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DELETE FROM zcountry_lgl.
    MODIFY zcountry_lgl FROM ( SELECT Country                   AS land1,
                                      CountryThreeLetterISOCode AS intca3,
                                      CountryThreeDigitISOCode  AS intcn3,
                                      CountryISOCode            AS intca,
                                      IsEuropeanUnionMember     AS xegld FROM I_Country  ).

    out->write( |Countries....{ sy-dbcnt } rows inserted.| ).

    DELETE FROM zcountry_t_lgl.
    MODIFY zcountry_t_lgl FROM ( SELECT Language            AS spras,
                                        Country             AS land1,
                                        CountryShortName    AS landx,
                                        NationalityName     AS natio,
                                        NationalityLongName AS natio50,
                                        CountryName         AS landx50 FROM I_CountryText ).

    out->write( |Texts....{ sy-dbcnt } rows inserted.| ).

  ENDMETHOD.

ENDCLASS.
