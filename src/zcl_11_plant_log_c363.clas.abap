CLASS zcl_11_plant_log_c363 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      assign_company IMPORTING io_company      TYPE REF TO zif_04_lgl_c363
                     RETURNING VALUE(rv_plant) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_11_plant_log_c363 IMPLEMENTATION.

  METHOD assign_company.
    rv_plant = |PLant was assigned to...{ io_company->define_company( ) }|.
  ENDMETHOD.

ENDCLASS.
