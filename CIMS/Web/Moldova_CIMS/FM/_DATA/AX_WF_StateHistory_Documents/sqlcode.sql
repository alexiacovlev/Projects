select M.Name as DocumentName, N1.* from AX_WF_StateHistory N1
INNER JOIN MY_WorkDocuments M ON N1.KeyValue=M.ID
WHERE N1.TableName='MY_WorkDocuments'