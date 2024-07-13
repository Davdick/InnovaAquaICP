import Prim "mo:⛔";
import Array "mo:base/Array";
import Bool "mo:base/Bool";
import Buffer "mo:base/Buffer";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Option "mo:base/Option";
import Text "mo:base/Text";

import HttpUtils "utils/http-utils";

actor AquaInnovaBackend {
	let data = Buffer.Buffer<Text>(0);

	func isJSON(x : HttpUtils.HeaderField) : Bool {
		Text.map(x.0, Prim.charToLower) == "content-type" and Text.contains(Text.map(x.1, Prim.charToLower), #text "application/json");
	};

	// Handles GET requests
	public query func http_request(req : HttpUtils.HttpRequest) : async HttpUtils.HttpResponse {
		Debug.print("req.method: " # req.method);
		for (header in req.headers.vals()) {
			Debug.print("header: " # header.0 # ": " # header.1);
		};
		Debug.print("req.url: " # req.url);
		switch (req.method, not Option.isNull(Array.find(req.headers, isJSON)), req.url) {
			case ("GET", false, "/read") {
				Debug.print("htt_request - case (GET, false, /read)");
				{
					status_code = 200;
					headers = [("content-type", "application/json")];
					body = Text.encodeUtf8("{ \"distance\": \"" # Nat.toText(1) # "\", \"capacity\": \"" # Nat.toText(1) # "\" }");
					upgrade = ?false;
				};
			};
			case ("GET", false, _) {
				Debug.print("htt_request - case (GET, false, _)");
				{
					status_code = 200;
					headers = [("content-type", "application/json")];
					body = Text.encodeUtf8("{ \"distance\": \"" # Nat.toText(1) # "\", \"capacity\": \"" # Nat.toText(1) # "\" }");
					upgrade = null;
				};
			};
			case ("GET", true, _) {
				Debug.print("htt_request - case (GET, true, _)");
				{
					status_code = 200;
					headers = [("content-type", "application/json"), ("content-encoding", "utf-8")];
					body = "{ \"distance\": \"test distance\", \"capacity\": \"test capacity\" }";
					upgrade = null;
				};
			};

			case ("POST", _, _) {
				Debug.print("htt_request - case (POST, _, _)");
				{
					status_code = 204;
					headers = [];
					body = "";
					upgrade = ?true;
				};
			};
			case _ {
				Debug.print("htt_request - case (_)");
				{
					status_code = 400;
					headers = [];
					body = "Invalid request";
					upgrade = null;
				};
			};
		};
	};

	// Handles POST requests
	public func http_request_update(req : HttpUtils.HttpRequest) : async HttpUtils.HttpResponse {
		switch (req.method, not Option.isNull(Array.find(req.headers, isJSON))) {
			case ("POST", false) {
				Debug.print("htt_request - case (POST, false)");
				var req_body = "";
				switch (Text.decodeUtf8(req.body)) {
					case null Debug.print("req.body is null");
					case (?body) req_body := body;
				};
				Debug.print("req_body: " # req_body);
				data.add(req_body);
				{
					status_code = 201;
					headers = [("content-type", "application/json")];
					body = Text.encodeUtf8("{ \"distance\": \"" # Nat.toText(1) # "\", \"capacity\": \"" # Nat.toText(1) # "\" }");
					upgrade = null;
				};
			};
			case ("POST", true) {
				Debug.print("htt_request - case (POST, true)");
				{
					status_code = 201;
					headers = [("content-type", "application/json"), ("content-encoding", "utf-8")];
					body = "{ \"distance\": \"test distance\", \"capacity\": \"test capacity\" }";
					upgrade = null;
				};
			};
			case _ {
				Debug.print("htt_request - case (_)");
				{
					status_code = 400;
					headers = [];
					body = "Invalid request";
					upgrade = null;
				};
			};
		};
	};
};
