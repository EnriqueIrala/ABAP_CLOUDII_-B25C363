CLASS zcl_22_local_comp_log_c363 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  PROTECTED SECTION.
  PRIVATE SECTION.

    data: my_fisrt type ty_first.

    METHODS:
      my_method IMPORTING iv_attr type ty_first.

ENDCLASS.



CLASS zcl_22_local_comp_log_c363 IMPLEMENTATION.

  METHOD my_method.

    data(lo_local) = new lcl_helper( ).

  ENDMETHOD.

ENDCLASS.
