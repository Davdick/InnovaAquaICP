CANISTER_ID=bkyz2-fmaaa-aaaaa-qaaaq-cai

# Get the counter
curl "$CANISTER_ID.localhost:4943/" --resolve "$CANISTER_ID.localhost:4943:127.0.0.1"
echo -e "\n"

# Get the static gzipped query content
curl --compressed "$CANISTER_ID.localhost:4943/" --resolve "$CANISTER_ID.localhost:4943:127.0.0.1"
echo -e "\n"

# Increment the counter
curl -X POST "$CANISTER_ID.localhost:4943/" --resolve "$CANISTER_ID.localhost:4943:127.0.0.1"
echo -e "\n"

# Increment the counter and get the static gzipped update content
curl --compressed -X POST "$CANISTER_ID.localhost:4943/" --resolve "$CANISTER_ID.localhost:4943:127.0.0.1"
echo -e "\n"

# Increment the counter and get the static gzipped update content
curl -X POST "$CANISTER_ID.localhost:4943/read" \
	-d '{ "distance": "test", "capacity": "test" }' \
	-H "content-encoding: gzip; content-type: application/json; charset=UTF-8"
	# --resolve "$CANISTER_ID.localhost:4943:127.0.0.1"
echo -e "\n"