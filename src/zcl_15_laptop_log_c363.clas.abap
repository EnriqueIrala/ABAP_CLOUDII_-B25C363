CLASS zcl_15_laptop_log_c363 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA: keyboard TYPE REF TO zcl_14_keyboard_log_c363.

    METHODS:
      constructor IMPORTING io_keyboard TYPE REF TO zcl_14_keyboard_log_c363.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_15_laptop_log_c363 IMPLEMENTATION.

  METHOD constructor.
    me->keyboard = io_keyboard.
  ENDMETHOD.

ENDCLASS.
