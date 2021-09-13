

CURRENT_DATE=`date -Ru | sed 's/+0000/GMT/'`

#CURRENT_DATE="Fri, 05 Apr 2019 18:58:07 GMT"

CHECKSUM=$(echo -n "application/json,,/bill/$1,$CURRENT_DATE" \
  | openssl dgst -sha1 -binary -hmac "HFDdwTN5tYeZ3WA5ioBxpU8+V7bnRybXSLnrwYRvmwUMICbMnk4XvHXzc3/PJhawLCGqxeaeLD2nHFcstx5mwQ==" \
  | base64)



echo ""
echo HEADERS
echo "Accept: application/vnd.regalii.v1.6+json"
echo "Content-Type: application/json"
echo "Date: $CURRENT_DATE"
echo "Authorization: APIAuth a4bd4d15bace9725c4c9a6267d479151:$CHECKSUM"
echo ""
echo BODY
cat $2
echo ""


echo RESPONSE
#curl -X POST "https://api.casiregalii.com/bill/$1/" \
curl -X POST "https://api.arcusapi.com/bill/$1/" \
  -H "Accept: application/vnd.regalii.v1.6+json" \
  -H "Date: $CURRENT_DATE" \
  -H "AUTHORIZATION: APIAuth a4bd4d15bace9725c4c9a6267d479151:$CHECKSUM" \
  -H "Content-MD5:" \
  -H "MULE_ENCODING: windows-1252" \
  -H "Host: api.staging.arcusapi.com:443" \
  -H "User-Agent: AHC/1.0" \
  -H "Connection: keep-alive" \
  -H "Content-Type: application/json" \
  -H "Transfer-Encoding: chunked" \
  --data "@$2"

echo ""
echo ""

