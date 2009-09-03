Begin  
  execute immediate 'Drop table C_TEMP_SELECTION';
  Exception when others then null;
End;
/-- END

Begin  
  execute immediate 'Drop table C_TEMP_SELECTION2';
  Exception when others then null;
End;
/-- END

Begin  
  execute immediate 'Drop table AD_ENABLE_TRIGGERS';
  Exception when others then null;
End;
/-- END

 -- create temporary tables


 CREATE GLOBAL TEMPORARY TABLE C_TEMP_SELECTION
 (
   C_TEMP_SELECTION_ID  VARCHAR2(32 BYTE)             NOT NULL,
   CONSTRAINT C_TEMP_SELECTION_key PRIMARY KEY (C_TEMP_SELECTION_ID)
  )
  ON COMMIT DELETE ROWS
/-- END 

 CREATE GLOBAL TEMPORARY TABLE C_TEMP_SELECTION2
  (
  QUERY_ID        VARCHAR2(32 BYTE)             NOT NULL,
  C_TEMP_SELECTION_ID  VARCHAR2(32 BYTE)             NOT NULL,
   CONSTRAINT C_TEMP_SELECTION2_key PRIMARY KEY (QUERY_ID, C_TEMP_SELECTION_ID)	
   )
   ON COMMIT PRESERVE ROWS
/-- END 



CREATE OR REPLACE FUNCTION C_CREATE_TEMPORARY_TABLES RETURN VARCHAR2
AS
/*************************************************************************
* The contents of this file are subject to the Openbravo  Public  License
* Version  1.0  (the  "License"),  being   the  Mozilla   Public  License
* Version 1.1  with a permitted attribution clause; you may not  use this
* file except in compliance with the License. You  may  obtain  a copy of
* the License at http://www.openbravo.com/legal/license.html
* Software distributed under the License  is  distributed  on  an "AS IS"
* basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
* License for the specific  language  governing  rights  and  limitations
* under the License.
* The Original Code is Openbravo ERP.
* The Initial Developer of the Original Code is Openbravo SL
* All portions are Copyright (C) 2001-2006 Openbravo SL
* All Rights Reserved.
* Contributor(s):  ______________________________________.
************************************************************************/
BEGIN
RETURN null;
END C_CREATE_TEMPORARY_TABLES;
/-- END 

create or replace FUNCTION GET_UUID RETURN VARCHAR2
AS
/*************************************************************************
* The contents of this file are subject to the Openbravo  Public  License
* Version  1.0  (the  "License"),  being   the  Mozilla   Public  License
* Version 1.1  with a permitted attribution clause; you may not  use this
* file except in compliance with the License. You  may  obtain  a copy of
* the License at http://www.openbravo.com/legal/license.html
* Software distributed under the License  is  distributed  on  an "AS IS"
* basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
* License for the specific  language  governing  rights  and  limitations
* under the License.
* The Original Code is Openbravo ERP.
* The Initial Developer of the Original Code is Openbravo SL
* All portions are Copyright (C) 2008 Openbravo SL
* All Rights Reserved.
* Contributor(s):  ______________________________________.
************************************************************************/
BEGIN
 return rawtohex(sys_guid());
END GET_UUID;
/-- END

create or replace
FUNCTION AD_DB_MODIFIED(p_Update CHAR) RETURN CHAR

AS
/*************************************************************************
* The contents of this file are subject to the Openbravo  Public  License
* Version  1.0  (the  "License"),  being   the  Mozilla   Public  License
* Version 1.1  with a permitted attribution clause; you may not  use this
* file except in compliance with the License. You  may  obtain  a copy of
* the License at http://www.openbravo.com/legal/license.html
* Software distributed under the License  is  distributed  on  an "AS IS"
* basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
* License for the specific  language  governing  rights  and  limitations
* under the License.
* The Original Code is Openbravo ERP.
* The Initial Developer of the Original Code is Openbravo SL
* All portions are Copyright (C) 2009 Openbravo SL
* All Rights Reserved.
* Contributor(s):  ______________________________________.
************************************************************************/

  v_md5 varchar(32);
  aux varchar(32);
  v_Modified char(1);
  TYPE RECORD IS REF CURSOR;
  c1 RECORD;
  PRAGMA AUTONOMOUS_TRANSACTION; --To allow DML within a function in a select        
BEGIN
v_md5:='';
for c1 in (select text from user_source order by name,line) loop
     v_md5 := dbms_obfuscation_toolkit.md5(input_string => v_md5||c1.text);
end loop;
for c1 in (select * from user_tab_cols order by table_name, column_id) loop
     v_md5 := dbms_obfuscation_toolkit.md5(input_string => v_md5||c1.column_name||c1.data_type||c1.data_length||c1.nullable);
end loop;
for c1 in (select * from user_views order by view_name) loop
     v_md5 := dbms_obfuscation_toolkit.md5(input_string => v_md5||c1.view_name||c1.text);
end loop;


  select db_checksum
    into aux
    from ad_system_info;
                                

  if aux = v_md5 then
    v_Modified := 'N';
  else
    v_Modified := 'Y';
  end if;     
   BEGIN
   IF p_Update = 'Y' THEN
     UPDATE AD_SYSTEM_INFO
       SET LAST_DBUPDATE = NOW(),
           DB_CHECKSUM = v_md5;
   END IF;
   END;
   COMMIT;
   RETURN v_Modified;
   EXCEPTION 
     WHEN OTHERS THEN
       RETURN 'N';
END AD_DB_MODIFIED
;

/-- END

create or replace FUNCTION AD_GET_RDBMS RETURN VARCHAR2
AS
/*************************************************************************
* The contents of this file are subject to the Openbravo  Public  License
* Version  1.0  (the  "License"),  being   the  Mozilla   Public  License
* Version 1.1  with a permitted attribution clause; you may not  use this
* file except in compliance with the License. You  may  obtain  a copy of
* the License at http://www.openbravo.com/legal/license.html
* Software distributed under the License  is  distributed  on  an "AS IS"
* basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
* License for the specific  language  governing  rights  and  limitations
* under the License.
* The Original Code is Openbravo ERP.
* The Initial Developer of the Original Code is Openbravo SL
* All portions are Copyright (C) 2009 Openbravo SL
* All Rights Reserved.
* Contributor(s):  ______________________________________.
************************************************************************/
BEGIN
 return 'ORACLE';
END AD_GET_RDBMS;
/-- END

BEGIN
EXECUTE IMMEDIATE 'UPDATE C_ACCTSCHEMA_DEFAULT SET CB_CASHTRANSFER_ACCT=CB_ASSET_ACCT WHERE CB_CASHTRANSFER_ACCT IS NULL';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/-- END
