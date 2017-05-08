package com.flame.constant;

public class FileType {

	private static final String[] DOCUMENT = new String[] { "text/plain",
			"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet","application/msword","application/pdf" };
	private static final String[] MUSIC = new String[] {"audio/mp3"};
	private static final String[] VIDEO = new String[] {"video/mp4","video/avi","application/vnd.rn-realmedia-vbr"};
	private static final String[] PICTURE = new String[] {"image/jpeg","image/png","image/gif"};

	public static String[] getFileType(String fileTyp) {

		if ("DOCUMENT".equalsIgnoreCase(fileTyp)) {
			return DOCUMENT;
		} else if ("MUSIC".equalsIgnoreCase(fileTyp)) {
			return MUSIC;
		} else if ("VIDEO".equalsIgnoreCase(fileTyp)) {
			return VIDEO;
		} else if ("PICTURE".equalsIgnoreCase(fileTyp)) {
			return PICTURE;
		}
		return new String[] {""};
	}

}
