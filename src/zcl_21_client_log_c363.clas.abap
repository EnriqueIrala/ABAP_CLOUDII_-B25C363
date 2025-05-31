CLASS zcl_21_client_log_c363 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA: notification TYPE string.

    METHODS:
      on_new_transfer FOR EVENT new_transfer OF zif_05_log_c363 IMPORTING sender.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_21_client_log_c363 IMPLEMENTATION.

  METHOD on_new_transfer.
     me->notification = |{ sender->office }-{ cl_abap_context_info=>get_system_time( ) }|.
  ENDMETHOD.

ENDCLASS.
