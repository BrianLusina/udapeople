if grep -q "has been executed successfully" ./backend/migration_status
then
    echo "DB migration was successful, will update memstash..."
    curl -H "Content-Type: text/plain" -H "token: ${MEMSTASH_TOKEN}" --request PUT --data "success" https://api.memstash.io/values/DB_MIGRATION_${CIRCLE_WORKFLOW_ID:0:7}
else
    echo "DB migration failed, please verify setup! Probably the database already exists. Verify setup!"
    curl -H "Content-Type: text/plain" -H "token: ${MEMSTASH_TOKEN}" --request PUT --data "failure" https://api.memstash.io/values/DB_MIGRATION_${CIRCLE_WORKFLOW_ID:0:7}
fi
echo "WorkflowID=${CIRCLE_WORKFLOW_ID:0:7}"