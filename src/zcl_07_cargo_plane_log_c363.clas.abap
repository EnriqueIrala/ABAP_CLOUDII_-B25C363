CLASS zcl_07_cargo_plane_log_c363 DEFINITION INHERITING FROM zcl_06_airplane_log_c363
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS: airplane_type REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_07_cargo_plane_log_c363 IMPLEMENTATION.

  METHOD airplane_type.
    rv_airplane_type = 'Cargo Plane'.
  ENDMETHOD.

ENDCLASS.
