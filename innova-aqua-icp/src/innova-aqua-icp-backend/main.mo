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

	// Handles GET requests
	public query func http_request(req : HttpUtils.HttpRequest) : async HttpUtils.HttpResponse {
		Debug.print("main - http_request()");
		Debug.print("req.method: " # req.method);
		for (header in req.headers.vals()) { Debug.print("header: " # header.0 # ": " # header.1); };
		Debug.print("req.url: " # req.url);
		switch (req.method, req.url) {
			case ("GET", "/read") {
				Debug.print("http_request - case (GET, /read)");
				let data_arr = Buffer.toArray(data);
				let response = "[" # Text.join(",", data_arr.vals()) # "]";
				{
					status_code = 200;
					headers = [("content-type", "application/json")];
					body = Text.encodeUtf8(response);
					upgrade = ?false;
				};
			};
			case ("GET", "/reset") {
				Debug.print("http_request - case (POST, /reset)");
				let data_arr = Buffer.toArray(data);
				let response = "[" # Text.join(",", data_arr.vals()) # "]";
				data.clear();
				{
					status_code = 200;
					headers = [];
					body = Text.encodeUtf8(response);
					upgrade = ?false;
				};
			};
			case ("POST", "/update") {
				Debug.print("http_request - case (POST, /update)");
				{
					status_code = 204;
					headers = [];
					body = "";
					upgrade = ?true;
				};
			};
			case _ {
				Debug.print("http_request - case (_)");
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
		Debug.print("main - http_request_update()");
		Debug.print("req.method: " # req.method);
		for (header in req.headers.vals()) { Debug.print("header: " # header.0 # ": " # header.1); };
		Debug.print("req.url: " # req.url);
		switch (req.method, req.url) {
			case ("POST", "/update") {
				Debug.print("http_request_update - case (POST, false)");
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
			case _ {
				Debug.print("http_request_update - case (_)");
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
