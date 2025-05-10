CLASS zcl_exec_log_c363 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_exec_log_c363 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*    out->write( 'Hola Logali' ).

* Fundamentals
    DATA(lo_instance) = NEW zcl_01_log_c363( ).

*    DATA: lo_ins TYPE REF TO zcl_01_log_c363.
*    CREATE OBJECT lo_ins.

    lo_instance->set_attr1( 'Attribute 1' ).

*    lo_instance->get_attr1(
*      IMPORTING
*        ev_attr = DATA(lv_attribute) ).
*
*    out->write( lv_attribute ).

    out->write( lo_instance->get_attr1( ) ).

    zcl_01_log_c363=>set_attr2( 'Attribute 2' ).

    zcl_01_log_c363=>get_attr2(
      IMPORTING
        ev_attr = data(lv_attribute2) ).

    out->write( lv_attribute2 ).

    out->write( lo_instance->get_flight( 'AA' ) ).

    out->write( | { zcl_01_log_c363=>constantes-c2 } { zcl_01_log_c363=>constantes-c1 } { zcl_01_log_c363=>c3 } | ).


  ENDMETHOD.

ENDCLASS.
