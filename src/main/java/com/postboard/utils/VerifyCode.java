package com.postboard.utils;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

import javax.imageio.ImageIO;

public class VerifyCode {
	private int w = 100;
	private int h = 40;
 	private Random r = new Random();
	private String[] fontNames  = {"宋体", "华文楷体", "黑体", "华文新魏", "华文隶书", "微软雅黑", "楷体_GB2312"};
	private String codes  = "23456789abcdefghijkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ";
	private Color bgColor  = new Color(240, 240, 240);
	private String text ;
	
	private Color randomColor () {
		int red = r.nextInt(200);
		int green = r.nextInt(200);
		int blue = r.nextInt(200);
		return new Color(red, green, blue);
	}
	
	private Font randomFont () {
		int index = r.nextInt(fontNames.length);
		String fontName = fontNames[index];
		int style = r.nextInt(4);
		int size = r.nextInt(5) + 26; 
		return new Font(fontName, style, size);
	}
	
	//干扰线
	private void drawLine (BufferedImage image) {
		int num  = 4;
		Graphics2D g2 = (Graphics2D)image.getGraphics();
		for(int i = 0; i < num; i++) {
			int x1 = r.nextInt(w);
			int y1 = r.nextInt(h);
			int x2 = r.nextInt(w);
			int y2 = r.nextInt(h); 
			g2.setStroke(new BasicStroke(1.5F)); 
			g2.setColor(this.randomColor()); 
			g2.drawLine(x1, y1, x2, y2);
		}
	}
	
	private char randomChar () {
		int index = r.nextInt(codes.length());
		return codes.charAt(index);
	}
	//图片背景
	private BufferedImage createImage () {
		BufferedImage image = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB); 
		Graphics2D g2 = (Graphics2D)image.getGraphics(); 
		g2.setColor(this.bgColor);
		g2.fillRect(0, 0, w, h);
 		return image;
	}
	/**
	 * 生成图片
	 */
	public BufferedImage getImage () {
		BufferedImage image = createImage(); 
		Graphics2D g2 = (Graphics2D)image.getGraphics();
		StringBuilder sb = new StringBuilder();
		// 向图片中画4个字符
		int chars=4;
		for(int i = 0; i < chars; i++)  {
			String s = randomChar() + ""; 
			sb.append(s); 
			float x = i * 1.0F * w / chars; 
			g2.setFont(randomFont()); 
			g2.setColor(randomColor()); 
			g2.drawString(s, x+2, h-10); 
		}
		this.text = sb.toString(); 
		drawLine(image); 
		return image;		
	}
	/**
	 * 获取图片上的文本(需先生成图片)
	 * @return
	 */
	public String getText () {
		return text;
	}
	
	/**
	 * 将图片写入到输入流中
	 * @param image
	 * @param out
	 * @throws IOException
	 */
	public static void output (BufferedImage image, OutputStream out) 
				throws IOException {
		ImageIO.write(image, "PNG", out);
	}
}

