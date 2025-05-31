CLASS zcl_19_conexion_log_c363 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA: hour        TYPE zsyst_uzeit,
          sender_user TYPE string.

    METHODS:
      on_time_out FOR EVENT time_out OF zcl_18_timer_log_c363 IMPORTING ev_hour
                                                                        sender.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_19_conexion_log_c363 IMPLEMENTATION.

  METHOD on_time_out.
    me->hour = ev_hour.
    me->sender_user = sender->user.
  ENDMETHOD.

ENDCLASS.
