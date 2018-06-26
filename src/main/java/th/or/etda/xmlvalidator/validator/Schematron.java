package th.or.etda.xmlvalidator.validator;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

import edu.ucar.ral.crux.*;
import net.sf.saxon.s9api.SaxonApiException;

public class Schematron {
	
	public boolean validate(String XMLString ,String schematronPath) throws ValidationException, IOException, SaxonApiException {
		boolean value = false;
		SchematronValidatorETDA validator = new SchematronValidatorETDA();
		File schematronFile = new File(schematronPath);
		if(schematronFile.exists()) {			
			
			File xslFile = validator.compileSchematronRulesToXSLIfNeeded( new File( schematronPath ) );
			InputStream IS = new ByteArrayInputStream(XMLString.getBytes(StandardCharsets.UTF_8));
			String result = validator.transformIS(xslFile, IS);		
			if (result.length() == 0 || result.isEmpty()) {
				value = true;
			}
		}
		else {
			throw new IOException();
		}
		return value;		
	}
}
