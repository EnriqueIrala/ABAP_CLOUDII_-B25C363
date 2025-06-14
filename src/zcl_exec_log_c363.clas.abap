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
*
* EVENT
*    DATA(lo_timer) = NEW zcl_18_timer_log_c363( ).
*    DATA(lo_conexion) = NEW zcl_19_conexion_log_c363( ).
*
*    SET HANDLER lo_conexion->on_time_out FOR lo_timer.
*
*    DO.
*
*      WAIT UP TO 1 SECONDS.
*      lo_timer->increment_counter( 1 ).
*
*      IF lo_conexion->hour IS INITIAL.
*        out->write( |Event not yet executed:{ cl_abap_context_info=>get_system_time( ) }| ).
*      ELSE.
*        out->write( |Event was raised at:{ lo_conexion->hour }-{ lo_conexion->sender_user }| ).
*        EXIT.
*      ENDIF.
*
*    ENDDO.
*
* Event from Interface
*    DATA(lo_bank) = NEW zcl_20_bank_log_c363( ).
*    DATA(lo_client) = NEW zcl_21_client_log_c363( ).
*
*    SET HANDLER lo_client->on_new_transfer FOR lo_bank ACTIVATION abap_true.
*
*    DO 5 TIMES.
*      WAIT UP TO 1 SECONDS.
*      out->write( lo_bank->create_notification( ) ).
*      out->write( lo_client->notification ).
*      IF sy-index = 3.
*        SET HANDLER lo_client->on_new_transfer FOR lo_bank ACTIVATION abap_false.
*        lo_client->notification = 'No handler for event new transfer'.
*      ENDIF.
*    ENDDO.
*
*    TRY.
*        DATA(lv_result) = 100 / 0.
*      CATCH cx_root INTO DATA(lx_excep).
*        out->write( lx_excep->get_text( ) ).
*    ENDTRY.
*
*---> Exceptions
*Clase padre CX_ROOT
*   CX_NO_CHECK
*   CX_DYNAMIC_CHECK
*   CX_STATIC_CHECK
*
*    DATA: lv_num1 TYPE i VALUE 100,
*          lv_num2 TYPE i.
*    DATA(lo_manage) = NEW zcl_23_manage_res_log_c363( ).
*
*    TRY.
*
*        DATA(lv_result) = lv_num1 / lv_num2.
*
*        lo_manage->check_user( sy-uname ).
*
*      CATCH zcx_01_auth_log_c363 INTO DATA(lx_auth).
*        "CATCH cx_root INTO DATA(lx_auth).
*        out->write( lx_auth->get_text( ) ).
*
*      CATCH cx_sy_zerodivide INTO DATA(lx_excep).
*        out->write( lx_excep->get_text( ) ).
*
*        lv_num2 = 20.
*
*        RETRY.
*
*    ENDTRY.
*
*    out->write( lv_result ).
*
* Singleton Pattern
*
*  data: lo_singleton1 type ref to zcl_24_singleton_log_c363,
*        lo_singleton2 type ref to zcl_24_singleton_log_c363.
*
*        lo_singleton1 = zcl_24_singleton_log_c363=>get_instance( ).
*
*        wait up to 2 seconds.
*
*        lo_singleton2 = zcl_24_singleton_log_c363=>get_instance( ).
*
*        out->write( lo_singleton1->time ).
*        out->write( lo_singleton2->time ).
*
** Factory Method
*    DATA: lo_shape   TYPE REF TO zif_06_geo_figure_log_c367,
*          lo_factory TYPE REF TO zcl_33_factory_lgl_c367.
*
*          lo_factory = new #( ).
*
*          lo_shape = lo_factory->get_shape( 'Circle' ).
*
*          out->write( lo_shape->draw_figure( ) ).

* Model - View - Controller
    DATA: lv_name TYPE string VALUE 'Juan Lopez',
          lv_role TYPE string VALUE 'ABAP Developer'.

    DATA(lo_model) = NEW zcl_34_model_lgl_c367(
      iv_name = lv_name
      iv_role = lv_role ).

    DATA(lo_view) = NEW zcl_35_view_lgl_c367( ).

    DATA(lo_controller) = NEW zcl_36_controller_lgl_c367( ).

    lo_controller->set_model( lo_model ).
    lo_controller->set_view( lo_view ).

    lo_controller->get_view( )->display_employee(
      iv_name = lo_model->get_name( )
      iv_role = lo_model->get_role( )
      io_out  = out ).

























  ENDMETHOD.
ENDCLASS.
