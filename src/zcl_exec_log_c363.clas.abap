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

** Fundamentals
*    DATA(lo_instance) = NEW zcl_01_log_c363( ).
*
**    DATA: lo_ins TYPE REF TO zcl_01_log_c363.
**    CREATE OBJECT lo_ins.
*
*    lo_instance->set_attr1( 'Attribute 1' ).
*
**    lo_instance->get_attr1(
**      IMPORTING
**        ev_attr = DATA(lv_attribute) ).
**
**    out->write( lv_attribute ).
*
*    out->write( lo_instance->get_attr1( ) ).
*
*    zcl_01_log_c363=>set_attr2( 'Attribute 2' ).
*
*    zcl_01_log_c363=>get_attr2(
*      IMPORTING
*        ev_attr = data(lv_attribute2) ).
*
*    out->write( lv_attribute2 ).
*
*    out->write( lo_instance->get_flight( 'AA' ) ).
*
*    out->write( | { zcl_01_log_c363=>constantes-c2 } { zcl_01_log_c363=>constantes-c1 } { zcl_01_log_c363=>c3 } | ).
*
** Interfaces
*    DATA(lo_interface) = NEW zcl_02_log_c363( ).
*
*    "lo_interface->zif_01_log_c363~set_conn_id( 'Conn01' ).
*    lo_interface->set_conn_id( 'Conn01' ).
*
*    "out->write( lo_interface->zif_01_log_c363~get_conn_id( ) ).
*    out->write( lo_interface->get_conn_id( ) ).
*
*    "out->write( lo_interface->zif_02_log_c363~get_cust_name( '001' ) ).
*    out->write( lo_interface->get_customer( '001' ) ).
*
*    out->write( lo_interface->zif_03_log_c363~get_airports( 'FRA' ) ).
*
*    DATA(lo_interface2) = NEW zcl_03_log_c363( ).
*
*    out->write( | { lo_interface2->get_customer( '' )-last_name }-{ lo_interface2->get_customer( '' )-first_name } | ).
*
** Abstract Class
*    DATA(lo_abastract) = NEW zcl_05_log_c363( ).
*
*    out->write( lo_abastract->input_products( ) ).
*    out->write( lo_abastract->merchandise_output( ) ).
*    out->write( lo_abastract->production_line( ) ).
*
* Polymorphism
*    DATA: lt_airplanes TYPE STANDARD TABLE OF REF TO zcl_06_airplane_log_c363,
*          lo_airplane  TYPE REF TO zcl_06_airplane_log_c363,
*          lo_cargo_p   TYPE REF TO zcl_07_cargo_plane_log_c363,
*          lo_passenger TYPE REF TO zcl_08_pass_plane_log_c363.
*
*    lo_cargo_p = NEW #( ).
*    APPEND lo_cargo_p TO lt_airplanes.
*
*    lo_passenger = NEW #( ).
*    APPEND lo_passenger TO lt_airplanes.
*
*    LOOP AT lt_airplanes INTO lo_airplane.
*      out->write( lo_airplane->airplane_type( ) ).
*    ENDLOOP.
*
** Polymorphism interface
*    DATA: lt_companies TYPE STANDARD TABLE OF REF TO zif_04_lgl_c363,
*          lo_company   TYPE REF TO zif_04_lgl_c363,
*          lo_comp_eu   TYPE REF TO zcl_09_company_eu_log_c363,
*          lo_comp_usa  TYPE REF TO zcl_10_company_usa_log_c363,
*          lo_plant     TYPE REF TO zcl_11_plant_log_c363.
*
*    lo_comp_eu = NEW #( ).
*    APPEND lo_comp_eu TO lt_companies.
*
*    lo_comp_usa = NEW #( ).
*    APPEND lo_comp_usa TO lt_companies.
*
*    lo_plant = NEW #( ).
*
*    LOOP AT lt_companies INTO lo_company.
*      out->write( lo_company->define_company( ) ).
*      out->write( lo_plant->assign_company( lo_company ) ).
*    ENDLOOP.
*
* Association
*    DATA(lo_credit_card) = NEW zcl_12_credit_card_log_c363( ).
*    DATA(lo_client) = NEW zcl_13_client_log_c363( ).
*
*    lo_credit_card->set_card_num( '8888 9999 6666 4444' ).
*
*    lo_client->set_credit_card( lo_credit_card ).
*
*    out->write( lo_client->get_credit_card( )->get_card_num( ) ).
*
** Composition
*    DATA(lo_keyboard) = NEW zcl_14_keyboard_log_c363( ).
*    DATA(lo_laptop) = NEW zcl_15_laptop_log_c363( lo_keyboard ).
*
*    lo_keyboard->keyboard = 'ES'.
*
*    out->write( lo_laptop->keyboard->keyboard ).
*
** References
*    DATA: lo_inst1 TYPE REF TO zcl_16_references_log_c363,
*          lo_inst2 TYPE REF TO zcl_16_references_log_c363,
*          lo_inst3 TYPE REF TO zcl_16_references_log_c363.
*
*    lo_inst1 = NEW #( ).
**    lo_inst2 = NEW #( ).
**    lo_inst3 = NEW #( ).
*
*    lo_inst2 = lo_inst1.
*    lo_inst3 = lo_inst1.
*
*    lo_inst1->attr1 = 'A1'.
*    lo_inst2->attr1 = 'A2'.
*    lo_inst3->attr1 = 'A3'.
*
*    out->write( lo_inst1->attr1 ).
*    out->write( lo_inst2->attr1 ).
*    out->write( lo_inst3->attr1 ).
*
** Class Object
*    DATA: lo_object TYPE REF TO object.
*
*    lo_object = NEW zcl_17_product_log_c363( ).
*
*    DATA(lv_method) = 'RETURN_CATEGORY'.
*
*    DATA lv_category TYPE string.
*
*    CALL METHOD lo_object->(lv_method) RECEIVING rv_category = lv_category.
*
*    out->write( lv_category ).

* EVENT
    DATA(lo_timer) = NEW zcl_18_timer_log_c363( ).
    DATA(lo_conexion) = NEW zcl_19_conexion_log_c363( ).

    SET HANDLER lo_conexion->on_time_out FOR lo_timer.

    DO.

      WAIT UP TO 1 SECONDS.
      lo_timer->increment_counter( 1 ).

      IF lo_conexion->hour IS INITIAL.
        out->write( |Event not yet executed:{ cl_abap_context_info=>get_system_time( ) }| ).
      ELSE.
        out->write( |Event was raised at:{ lo_conexion->hour }| ).
        EXIT.
      ENDIF.

    ENDDO.




























  ENDMETHOD.
ENDCLASS.
