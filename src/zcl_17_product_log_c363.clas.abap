CLASS zcl_17_product_log_c363 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS: return_category RETURNING VALUE(rv_category) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: category TYPE string VALUE 'A4'.
ENDCLASS.



CLASS zcl_17_product_log_c363 IMPLEMENTATION.

  METHOD return_category.
    rv_category = me->category.
  ENDMETHOD.

ENDCLASS.
