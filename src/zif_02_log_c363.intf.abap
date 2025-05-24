INTERFACE zif_02_log_c363
  PUBLIC .

  TYPES: BEGIN OF ty_cust_name,
           first_name TYPE string,
           last_name  TYPE string,
         END OF ty_cust_name.

  METHODS:
    get_cust_name
      IMPORTING
                iv_cust_id          TYPE string
      RETURNING VALUE(rs_cust_name) TYPE ty_cust_name.

ENDINTERFACE.
