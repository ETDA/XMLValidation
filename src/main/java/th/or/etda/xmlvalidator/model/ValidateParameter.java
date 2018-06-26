package th.or.etda.xmlvalidator.model;

public class ValidateParameter {
	
	public String getSchemaPath() {
		return schemaPath;
	}
	public void setSchemaPath(String schemaPath) {
		this.schemaPath = schemaPath;
	}
	public String getSchematronPath() {
		return schematronPath;
	}
	public void setSchematronPath(String schematronPath) {
		this.schematronPath = schematronPath;
	}


	String schemaPath = null;
	String schematronPath = null;
	public Boolean getSchemaValidateFlag() {
		return schemaValidateFlag;
	}
	public void setSchemaValidateFlag(Boolean schemaValidateFlag) {
		this.schemaValidateFlag = schemaValidateFlag;
	}
	public Boolean getSchematronValidateFlag() {
		return schematronValidateFlag;
	}
	public void setSchematronValidateFlag(Boolean schematronValidateFlag) {
		this.schematronValidateFlag = schematronValidateFlag;
	}


	Boolean schemaValidateFlag = false;
	Boolean schematronValidateFlag = false;


}
