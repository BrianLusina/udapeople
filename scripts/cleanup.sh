if [[ "$CurrentWorkflowID" != "$OldWorkflowID" ]]
then
    echo "$OldWorkflowID!=$CurrentWorkflowID => will delete old version"
    aws s3 rm "s3://udapeople-${OldWorkflowID}" --recursive
    aws cloudformation delete-stack --stack-name "udapeople-frontend-${OldWorkflowID}"
    aws cloudformation delete-stack --stack-name "udapeople-backend-${OldWorkflowID}"
else
    echo "$OldWorkflowID==$CurrentWorkflowID => nothing needs to be done..."
fi