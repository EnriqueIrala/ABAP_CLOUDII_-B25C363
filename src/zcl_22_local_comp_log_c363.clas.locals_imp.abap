*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

" CCIMP
TYPES: BEGIN OF ty_first2,
         comp1 TYPE string,
         comp2 TYPE string,
         comp3 TYPE string,
       END OF ty_first2.

CLASS lcl_helper2 DEFINITION.

  PUBLIC SECTION.
    DATA: first TYPE ty_first.

    METHODS:
      get_first RETURNING VALUE(rv_first) TYPE ty_first.

ENDCLASS.

CLASS lcl_helper2 IMPLEMENTATION.

  METHOD get_first.

  ENDMETHOD.

ENDCLASS.


CLASS lcl_helper IMPLEMENTATION.

  METHOD get_first.

  ENDMETHOD.

ENDCLASS.
