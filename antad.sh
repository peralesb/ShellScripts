

CURRENT_DATE=`date -Ru | sed 's/+0000/GMT/'`

#CURRENT_DATE="Fri, 05 Apr 2019 18:58:07 GMT"


echo HEADERS
echo "POST /WSAntad.asmx HTTP/1.1" 
echo "Host: 192.168.172.11:9074" 
echo "Content-Type: text/xml; charset=utf-8" 
echo "SOAPAction: \"http://tempuri.org/Autorizacion\"" 

echo BODY
cat $1
echo ""


echo RESPONSE
curl  --tlsv1.2 -k -X POST "https://192.168.172.11:9074/WSANTAD.asmx" \
  -H "POST: /WSAntad.asmx HTTP/1.1" \
  -H "Host: 192.168.172.11:9074" \
  -H "Content-Type: text/xml; charset=utf-8" \
  -H "SOAPAction: \"http://tempuri.org/Autorizacion\"" \
  --data "@$1"

echo ""
echo ""

