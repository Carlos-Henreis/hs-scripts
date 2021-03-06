/****** Script for SelectTopNRows command from SSMS  ******/

SELECT distinct CLNMAS.Client_ID,  CLNMAS.CompanyName, POLMAS.POLICY_NUM
FROM CLNMAS INNER JOIN POLMAS ON CLNMAS.Client_ID = POLMAS.CLIENT_ID
WHERE POLMAS.POLICY_NUM in
(
	SELECT [POLICY_NUM]
	FROM
	(
		SELECT distinct CLIENT_ID, [POLICY_NUM]
		FROM [QFWinData_QQ010047].[dbo].[POLMAS]
		WHERE [POLICY_NUM] <> 'Pending'
	) P
	Group by [POLICY_NUM]
	HAVING COUNT([POLICY_NUM]) > 1
)
order by POLMAS.POLICY_NUM