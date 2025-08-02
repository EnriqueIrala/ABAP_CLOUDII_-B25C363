CLASS zcl_abap_cloud_c363 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abap_cloud_c363 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

  out->write( 'Hello Cloud' ).

  ENDMETHOD.

ENDCLASS.
