CLASS zcl_03_log_c363 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES:
      zif_02_log_c363.

    ALIASES:
     get_customer FOR zif_02_log_c363~get_cust_name.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_03_log_c363 IMPLEMENTATION.

  METHOD get_customer.
    rs_cust_name = VALUE #( first_name = 'Pepe'
                            last_name = 'Perez' ).
  ENDMETHOD.

ENDCLASS.
