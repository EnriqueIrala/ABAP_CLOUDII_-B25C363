CLASS zcl_05_log_c363 DEFINITION INHERITING FROM zcl_04_log_c363
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      merchandise_output REDEFINITION,
      production_line REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_05_log_c363 IMPLEMENTATION.

  METHOD merchandise_output.
    rv_merchandise = 'Merchandise output'.
  ENDMETHOD.

  METHOD production_line.
    rv_production = 'Production line'.
  ENDMETHOD.

ENDCLASS.
