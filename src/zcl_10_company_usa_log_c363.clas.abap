CLASS zcl_10_company_usa_log_c363 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES:
      zif_04_lgl_c363.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_10_company_usa_log_c363 IMPLEMENTATION.

  METHOD zif_04_lgl_c363~define_company.
    rv_company = 'Company USA...'.
  ENDMETHOD.

ENDCLASS.
