CLASS zcl_23_manage_res_log_c363 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS:
      check_user IMPORTING iv_user TYPE syuname
                 RAISING   zcx_01_auth_log_c363.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_23_manage_res_log_c363 IMPLEMENTATION.

  METHOD check_user.

    IF sy-uname = 'CB9980007474'.

      RAISE EXCEPTION TYPE zcx_01_auth_log_c363
        EXPORTING
          textid = zcx_01_auth_log_c363=>no_auth
*         previous =
          msgv1  = |{ sy-uname }|
          msgv2  = 'Update SO'
*         msgv3  =
*         msgv4  =
        .

    ENDIF.

  ENDMETHOD.

ENDCLASS.
