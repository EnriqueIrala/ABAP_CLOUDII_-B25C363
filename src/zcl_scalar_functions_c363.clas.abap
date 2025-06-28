CLASS zcl_scalar_functions_c363 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_amdp_marker_hdb.

    CLASS-METHODS: vat_by_airline FOR SCALAR FUNCTION zsf_vat_by_airline_c363.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_scalar_functions_c363 IMPLEMENTATION.

  METHOD vat_by_airline BY DATABASE FUNCTION
                        FOR HDB
                        LANGUAGE SQLSCRIPT
                        OPTIONS READ-ONLY.
    IF pAirline = 'AA' then
      result = 21.00;
    else
      result = 23.00;
    end if;

  endmethod.

ENDCLASS.
