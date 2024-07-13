module HttpUtils {
	public type HeaderField = (Text, Text);

	public type StreamingCallbackHttpResponse = {
		body : Blob;
		token : ?Token;
	};

	public type Token = {
		// Add whatever fields you'd like
		arbitrary_data : Text;
	};

	public type CallbackStrategy = {
		callback : shared query (Token) -> async StreamingCallbackHttpResponse;
		token : Token;
	};

	public type StreamingStrategy = {
		#Callback : CallbackStrategy;
	};

	public type HttpRequest = {
		method : Text;
		url : Text;
		headers : [HeaderField];
		body : Blob;
	};

	public type HttpResponse = {
		status_code : Nat16;
		headers : [HeaderField];
		body : Blob;
		streaming_strategy : ?StreamingStrategy;
		upgrade : ?Bool;
	};

	public type JSONObject = {
		distance: Text;
		capacity: Text;
	}
};
