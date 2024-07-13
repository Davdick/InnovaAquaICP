CANISTER_ID=bkyz2-fmaaa-aaaaa-qaaaq-cai

# Test GET to /read endpoint
curl -X GET "$CANISTER_ID.localhost:4943/read" \
	-H "content-encoding: gzip; content-type: plain/text; charset=UTF-8"
	# --resolve "$CANISTER_ID.localhost:4943:127.0.0.1"
echo -e "\n"

# Test GET to no endpoint
curl -X GET "$CANISTER_ID.localhost:4943" \
	-H "content-encoding: gzip; content-type: plain/text; charset=UTF-8"
	# --resolve "$CANISTER_ID.localhost:4943:127.0.0.1"
echo -e "\n"

# Test POST to no endpoint with JSON body
curl -X POST "$CANISTER_ID.localhost:4943" \
	-d '{ "distance": "test", "capacity": "test" }' \
	-H "content-encoding: gzip; content-type: appication/json; charset=UTF-8"
	# --resolve "$CANISTER_ID.localhost:4943:127.0.0.1"
echo -e "\n"