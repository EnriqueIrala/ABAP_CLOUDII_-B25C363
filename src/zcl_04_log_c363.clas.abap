CLASS zcl_04_log_c363 DEFINITION ABSTRACT
  PUBLIC
*  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS:
      merchandise_output ABSTRACT
        RETURNING VALUE(rv_merchandise) TYPE string,

      production_line  ABSTRACT
        RETURNING VALUE(rv_production) TYPE string,

      input_products
        RETURNING VALUE(rv_input) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_04_log_c363 IMPLEMENTATION.

  METHOD input_products.
    rv_input = 'Input products'.
  ENDMETHOD.

ENDCLASS.
