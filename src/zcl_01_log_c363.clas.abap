CLASS zcl_01_log_c363 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF ty_flight,
             carrier_id    TYPE /dmo/carrier_id,
             connection_id TYPE /dmo/connection_id,
             flight_date   TYPE /dmo/flight_date,
           END OF ty_flight.

    CONSTANTS: BEGIN OF constantes,
                 c1 TYPE c LENGTH 6 VALUE 'Logali',
                 c2 TYPE c LENGTH 4 VALUE 'Hola',
               END OF constantes,

               c3 TYPE c LENGTH 13 VALUE 'ABAP CLOUD II'.

*    DATA: attr1 TYPE string.
*
*    CLASS-DATA: attr2 TYPE string.

    METHODS:
      set_attr1
        IMPORTING
          iv_attr TYPE string,
*      get_attr1
*        EXPORTING
*          ev_attr TYPE string.
      get_attr1
        RETURNING VALUE(rv_attr) TYPE string,

      get_flight
        IMPORTING iv_carrier_id    TYPE /dmo/carrier_id
        RETURNING VALUE(rs_flight) TYPE ty_flight.

    CLASS-METHODS:
      set_attr2
        IMPORTING
          iv_attr TYPE string,
      get_attr2
        EXPORTING
          ev_attr TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA: attr1 TYPE string.

    CLASS-DATA: attr2 TYPE string.


ENDCLASS.



CLASS ZCL_01_LOG_C363 IMPLEMENTATION.


  METHOD get_attr1.

*    ev_attr = attr1.
    rv_attr = attr1.

  ENDMETHOD.


  METHOD get_attr2.

    ev_attr = attr2.

  ENDMETHOD.


  METHOD get_flight.

    SELECT SINGLE FROM /dmo/flight
    FIELDS carrier_id,
           connection_id,
           flight_date
     WHERE carrier_id = @iv_carrier_id
      INTO @rs_flight.

  ENDMETHOD.


  METHOD set_attr1.

    attr1 = iv_attr.

  ENDMETHOD.


  METHOD set_attr2.

    attr2 = iv_attr.

  ENDMETHOD.
ENDCLASS.
