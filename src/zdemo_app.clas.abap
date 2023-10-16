" comment here
CLASS zdemo_app DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.

    CLASS-METHODS: get_timestamp RETURNING VALUE(rv_smstl) TYPE timestampl.
*    class:         get_data      RETURNING VALUE(RT``)

  PRIVATE SECTION.
ENDCLASS.

CLASS zdemo_app IMPLEMENTATION.


  METHOD get_timestamp.
    GET TIME STAMP FIELD rv_smstl.
" Demo
    try.
    cl_abap_tstmp=>add(
    tstmp = rv_smstl
    secs  = 1 ).
    CATCH cx_root INTO DATA(e_text).
    ENDTRY.

  ENDMETHOD.




  METHOD if_oo_adt_classrun~main.

  " Tipo di dati build-in
   data: lv_time type t,
         lv_data type d.


    DATA: itab1 TYPE STANDARD TABLE OF i WITH DEFAULT KEY,
          itab2 TYPE SORTED TABLE OF ztv_test_table WITH UNIQUE KEY timeload.


    itab2 = VALUE #(
         FOR i = 1 THEN i + 1 UNTIL i >= 10
         (
            timeload = zdemo_app=>get_timestamp( )
            id_user  = sy-uname
          ) ).

" I have added this comment
    out->write( itab2 ).

    INSERT ztv_test_table FROM TABLE @itab2.
    IF sy-subrc IS INITIAL.
      COMMIT WORK.
      out->write( | user: { sy-uname } System: { cl_abap_context_info=>get_system_time( ) } | ).
    ELSE.
      ROLLBACK WORK.
      out->write( 'No').
    ENDIF.

  ENDMETHOD.
ENDCLASS.
