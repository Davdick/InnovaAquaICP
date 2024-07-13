CANISTER_ID=bkyz2-fmaaa-aaaaa-qaaaq-cai

# Test GET to /read endpoint
curl -X GET "$CANISTER_ID.localhost:4943/read" \
	-H "content-encoding: gzip; content-type: plain/text; charset=UTF-8"
echo -e "\n"

# Test POST to no endpoint with JSON body
curl -X POST "$CANISTER_ID.localhost:4943/update" \
	-d '{ "distance": "1.0", "capacity": "1.0" }' \
	-H "content-encoding: gzip; content-type: appication/json; charset=UTF-8"
echo -e "\n"

# Test GET after POST request
curl -X GET "$CANISTER_ID.localhost:4943/read" \
	-H "content-encoding: gzip; content-type: plain/text; charset=UTF-8"
echo -e "\n"

# Test POST to no endpoint with JSON body
curl -X POST "$CANISTER_ID.localhost:4943/update" \
	-d '{ "distance": "2.0", "capacity": "2.0" }' \
	-H "content-encoding: gzip; content-type: appication/json; charset=UTF-8"
echo -e "\n"

# Test GET after POST request
curl -X GET "$CANISTER_ID.localhost:4943/read" \
	-H "content-encoding: gzip; content-type: plain/text; charset=UTF-8"
echo -e "\n"

# Test GET to no endpoint
curl -X GET "$CANISTER_ID.localhost:4943/reset" \
	-H "content-encoding: gzip; content-type: plain/text; charset=UTF-8"
echo -e "\n"