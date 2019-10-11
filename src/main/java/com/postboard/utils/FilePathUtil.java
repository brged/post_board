package com.postboard.utils;

import java.io.File;

public class FilePathUtil {
	/**
	 * 生成文件的保存路径
	 * @param savePath
	 * @param fileName
	 * @return
	 */
	public static File createFilePath(String savePath,String fileName){
		// 从完整路径中获取文件名称
		int lastIndex = fileName.lastIndexOf("\\");
		if(lastIndex != -1) {
			fileName = fileName.substring(lastIndex + 1);
		}
		// 通过文件名称生成一级、二级目录
		int hCode = fileName.hashCode();
		String dir1 = Integer.toHexString(hCode & 0xF);//一级目录
		String dir2 = Integer.toHexString(hCode >>> 4 & 0xF);//二级目录
		savePath = savePath + "/" + dir1 + "/" + dir2;
		// 创建目录
		new File(savePath).mkdirs();
		
		// 给文件名称添加uuid前缀
		String uuid = CommonUtils.uuid();
		fileName = uuid + "_" + fileName;
		
		// 创建文件完成路径
		return new File(savePath, fileName);

	}
}
