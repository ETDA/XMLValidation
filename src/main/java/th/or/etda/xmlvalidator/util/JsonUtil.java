package th.or.etda.xmlvalidator.util;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;


import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class JsonUtil {
	private JSONObject jsonObj;
	private JSONObject currentJSONObj;
	
	public JSONObject getCurrentJSONObj() {
		return currentJSONObj;
	}

	private JSONArray jsonArray;
	
	public JSONArray getJsonArray() {
		return jsonArray;
	}

	public void setJsonArray(JSONArray jsonArray) {
		this.jsonArray = jsonArray;
	}

	public void setJsonObj(JSONObject jsonObj) {
		this.jsonObj = jsonObj;
	}

	public JSONObject getJsonObj() {
		return jsonObj;
	}
	
	public JsonUtil(){		
		this.jsonObj = null;
	}	
	
	public void writeJSON(String path) {
		
        try (FileWriter file = new FileWriter(path)) {

            file.write(jsonObj.toJSONString());
            file.flush();

        } catch (IOException e) {
            e.printStackTrace();
        }
	}
	
	public void readJSON(String path) {
		
		JSONParser parser = new JSONParser();
		
		try {
			Object obj = parser.parse(new FileReader(path));
			jsonObj = (JSONObject) obj;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void readJSONArray(String path) {
		
		JSONParser parser = new JSONParser();
		
		try {
			Object obj = parser.parse(new FileReader(path));			
			jsonArray = (JSONArray) obj;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public List<String> find(String key) {
		List<String> root = new ArrayList<String>();    	
		for(Object obj : jsonArray) {
    		JSONObject jsonObj = (JSONObject) obj;    		
    		String e = (String) jsonObj.get(key);
    		root.add(e);
    	}
    	return root;
	}
	
	public boolean isExistInArray(String key,String Value) {
		boolean value = false;	
		for(Object obj : jsonArray) {
    		JSONObject jsonObj = (JSONObject) obj;    		
    		String e = (String) jsonObj.get(key);
    		if (e == Value) 
    		{
    			updateChosenJSON(jsonObj);
    			value = true;
        		break;
    		}
    	}
    	return value;
	}
	
	public void updateChosenJSON(JSONObject jsonObj2) {
		// TODO Auto-generated method stub
		currentJSONObj = jsonObj2;
	}

	public String find(String key ,JSONArray array ) {
		String root = null;
    	for(Object obj : array) {
    		JSONObject jsonObj = (JSONObject) obj;    		
    		root = (String) jsonObj.get(key);
    		break;
    	}
    	return root;
	}
	
	public String getStringValue(String key) {
		return (String) jsonObj.get(key);
	}
	
	public String getCurrentObjestStringValue(String key) {
		return (String) currentJSONObj.get(key);
	}
	
	public Long getLongValue(String key) {
		return (Long) jsonObj.get(key);
	}

	public void UpdateCurrentNode(String rootTag, String Value) {
		// TODO Auto-generated method stub
		for(Object obj : jsonArray) {
    		JSONObject jsonObj = (JSONObject) obj;    		
    		String e = (String) jsonObj.get(rootTag);
    		if (e.equals(Value)) 
    		{
    			updateChosenJSON(jsonObj);
        		break;
    		}
    	}
	}
}
