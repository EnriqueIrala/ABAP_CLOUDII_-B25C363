CLASS zcl_02_log_c363 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES:
      zif_01_log_c363,
      zif_02_log_c363.

    ALIASES:
     get_conn_id FOR zif_01_log_c363~get_conn_id,
     set_conn_id FOR zif_01_log_c363~set_conn_id,
     get_customer FOR zif_02_log_c363~get_cust_name.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_02_log_c363 IMPLEMENTATION.

  METHOD get_conn_id.
    rv_conn_id = me->zif_01_log_c363~conn_id.
  ENDMETHOD.

  METHOD set_conn_id.
    me->zif_01_log_c363~conn_id = iv_conn_id.
  ENDMETHOD.

  METHOD get_customer.

    IF iv_cust_id = '001'.
      rs_cust_name = VALUE #( first_name = 'Juan'
                              last_name = 'Lopez' ).
    ENDIF.

  ENDMETHOD.

  METHOD zif_03_log_c363~get_airports.

    SELECT SINGLE FROM /dmo/airport
    FIELDS *
    WHERE airport_id = @iv_airport_id
    INTO @rs_airport.

  ENDMETHOD.

ENDCLASS.
