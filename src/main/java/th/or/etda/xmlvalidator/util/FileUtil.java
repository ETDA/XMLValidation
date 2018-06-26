package th.or.etda.xmlvalidator.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Random;

public class FileUtil {

		public FileUtil() {
			
		}
		
		public void  deleteFile(String path) {
			File file = new File(path);
			if(file.exists()) {
				file.delete();
			}
		}
								
		public byte[] getByteFromFile(String filePath) {			
			
			File file = new File(filePath);
			String encoddedfile = null;
			byte[] bytes = new byte[(int)file.length()];
			try {				
				FileInputStream fis;  fis = new FileInputStream(file);
				 fis.read(bytes);
				 fis.close();
				 
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	      
			
			return bytes;
		}
		
		public String getStringFromFile(String filepath) {
			byte[] filebyte = getByteFromFile(filepath);
			String fileString = new String(filebyte, StandardCharsets.UTF_8);
			return fileString;
		}
		
}
