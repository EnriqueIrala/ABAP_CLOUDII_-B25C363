CLASS zcl_24_singleton_log_c363 DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.

    DATA: time TYPE zsyst_uzeit.

    METHODS: constructor.

    CLASS-METHODS:
      get_instance
        RETURNING VALUE(ro_instance) TYPE REF TO zcl_24_singleton_log_c363.

  PROTECTED SECTION.
  PRIVATE SECTION.

    CLASS-DATA: lo_instance TYPE REF TO zcl_24_singleton_log_c363.

ENDCLASS.



CLASS zcl_24_singleton_log_c363 IMPLEMENTATION.

  METHOD get_instance.

    IF lo_instance IS NOT BOUND.
      lo_instance = NEW #( ).
    ENDIF.

    ro_instance = lo_instance.

  ENDMETHOD.

  METHOD constructor.

    me->time = cl_abap_context_info=>get_system_time( ).

  ENDMETHOD.

ENDCLASS.
