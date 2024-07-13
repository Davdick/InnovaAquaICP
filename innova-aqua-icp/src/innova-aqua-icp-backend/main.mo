import Prim "mo:⛔";
import Array "mo:base/Array";
import Bool "mo:base/Bool";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Option "mo:base/Option";
import Prelude "mo:base/Prelude";
import Text "mo:base/Text";
import Blob "mo:base/Blob";

import HttpUtils "utils/http-utils";

actor AquaInnovaBackend {
	// stable var data : [HttpUtils.JSONObject] = [];

	func isJSON(x : HttpUtils.HeaderField) : Bool {
		Text.map(x.0, Prim.charToLower) == "content-type" and Text.contains(Text.map(x.1, Prim.charToLower), #text "application/json");
	};

	// Handles GET requests
	public query func http_request(req : HttpUtils.HttpRequest) : async HttpUtils.HttpResponse {
		switch (req.method, not Option.isNull(Array.find(req.headers, isJSON)), req.url) {
			case ("GET", false, "/read") {
				{
					status_code = 200;
					headers = [("content-type", "application/json")];
					// body = Text.encodeUtf8("1");
					body = Text.encodeUtf8("{ \"distance1\": \"" # Nat.toText(1) # "\", \"capacity\": \"" # Nat.toText(1) # "\" }");
					streaming_strategy = ? #Callback({
						callback = http_streaming;
						token = {
							arbitrary_data = "start";
						};
					});
					upgrade = ?false;
				};
			};
			case ("GET", false, _) {
				Debug.print("htt_request - case (GET, false, _)");
				Debug.print("req.headers[0].0: " # req.headers[0].0);
				Debug.print("req.headers[0].1: " # req.headers[0].1);
				let body_arr = Blob.toArray(req.body);
				Debug.print("\niterating over body_arr\n");
				for (e in body_arr.keys()) {
					Debug.print("e: " # Nat.toText(e));
				};
				{
					status_code = 200;
					headers = [("content-type", "application/json")];
					// body = Text.encodeUtf8("1 is " # Nat.toText(1) # "\n" # req.url # "\n");
					body = Text.encodeUtf8("{ \"distance2\": \"" # Nat.toText(1) # "\", \"capacity\": \"" # Nat.toText(1) # "\" }");
					streaming_strategy = null;
					upgrade = null;
				};
			};
			case ("GET", true, _) {
				{
					status_code = 200;
					headers = [("content-type", "application/json"), ("content-encoding", "utf-8")];
					body = "{ \"distance3\": \"test distance\", \"capacity\": \"test capacity\" }";
					streaming_strategy = null;
					upgrade = null;
				};
			};

			case ("POST", _, _) {
				{
					status_code = 204;
					headers = [];
					body = "";
					streaming_strategy = null;
					upgrade = ?true;
				};
			};
			case _ {
				{
					status_code = 400;
					headers = [];
					body = "Invalid request";
					streaming_strategy = null;
					upgrade = null;
				};
			};
		};
	};

	// Handles POST requests
	public func http_request_update(req : HttpUtils.HttpRequest) : async HttpUtils.HttpResponse {
		switch (req.method, not Option.isNull(Array.find(req.headers, isJSON))) {
			case ("POST", false) {
				{
					status_code = 201;
					headers = [("content-type", "application/json")];
					// body = Text.encodeUtf8("1 updated to " # Nat.toText(1) # "\n");
					body = Text.encodeUtf8("{ \"distance4\": \"" # Nat.toText(1) # "\", \"capacity\": \"" # Nat.toText(1) # "\" }");
					streaming_strategy = null;
					upgrade = null;
				};
			};
			case ("POST", true) {
				{
					status_code = 201;
					headers = [("content-type", "application/json"), ("content-encoding", "utf-8")];
					body = "{ \"distance5\": \"test distance\", \"capacity\": \"test capacity\" }";

					streaming_strategy = null;
					upgrade = null;
				};
			};
			case _ {
				{
					status_code = 400;
					headers = [];
					body = "Invalid request";
					streaming_strategy = null;
					upgrade = null;
				};
			};
		};
	};

	public query func http_streaming(token : HttpUtils.Token) : async HttpUtils.StreamingCallbackHttpResponse {
		switch (token.arbitrary_data) {
			case "start" {
				{
					body = Text.encodeUtf8(" is ");
					token = ?{ arbitrary_data = "next" };
				};
			};
			case "next" {
				{
					body = Text.encodeUtf8(Nat.toText(1));
					token = ?{ arbitrary_data = "last" };
				};
			};
			case "last" {
				{
					body = Text.encodeUtf8(" streaming\n");
					token = null;
				};
			};
			case _ { Prelude.unreachable() };
		};
	};
};
