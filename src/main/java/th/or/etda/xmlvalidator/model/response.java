package th.or.etda.xmlvalidator.model;

import org.json.simple.JSONObject;

public  class response {
	
	public response() {
		this.message=null;
		this.code=null;
	}
	
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	
	private String message;
	private String code;
	
	public JSONObject getJSONResponseObj() {
		JSONObject obj = new JSONObject();
		obj.put("code", this.code);
		obj.put("message",this.getReturnMessage(code));		
		return obj;
	}
	
	private String getReturnMessage(String code) {
		String message;
		switch(code) {
		case "0": message ="valid XML for etax invoice";
			break;
		case "-1": message ="invalid XML for etax invoice";
			break;
		case "-2": message ="inapplicable XML for etax invoice";
			break;
		case "-3": message ="cannot parse XML";
			break;
		case "-99": message ="unknown error";
			break;
		default : message ="no message found";
			break;
		}
		
		return message;
	}
	
}
