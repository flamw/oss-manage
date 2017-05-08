package com.flame.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.aliyun.oss.OSSClient;
import com.aliyun.oss.model.Bucket;
import com.aliyun.oss.model.CannedAccessControlList;
import com.aliyun.oss.model.CreateBucketRequest;
import com.aliyun.oss.model.GetObjectRequest;
import com.aliyun.oss.model.OSSObject;
import com.aliyun.oss.model.ObjectMetadata;
import com.aliyun.oss.model.PutObjectRequest;

@Service
public class AliyunOssService {
	
	@Value("${endpoint}")
	private  String endpoint;
	
	@Value("${accessKeyId}")
	private  String accessKeyId ;
	
	@Value("${accessKeySecret}")
	private  String accessKeySecret;
//	private static String bucketName = "flame-img";
	
	private static  List<Bucket>  buckets;

	private static OSSClient ossClient;


	public  OSSClient getOSSClient() {

		if (AliyunOssService.ossClient == null) {
			AliyunOssService.ossClient = new OSSClient(endpoint, accessKeyId, accessKeySecret);
		}
		return AliyunOssService.ossClient;
	}

	/**
	 * @param bucketName
	 * @return
	 */
	public Bucket createBucket(String bucketName) {
		if (!getOSSClient().doesBucketExist(bucketName)) {
			/*
			 * Create a new OSS bucket
			 */
			System.out.println("Creating bucket " + bucketName + "\n");
			getOSSClient().createBucket(bucketName);
			CreateBucketRequest createBucketRequest = new CreateBucketRequest(bucketName);
			createBucketRequest.setCannedACL(CannedAccessControlList.PublicReadWrite);
			return ossClient.createBucket(createBucketRequest);
		}
		return null;

	}

	/**
	 * @return
	 */
	public List<Bucket> listBuckets() {
		if(buckets==null){
			buckets=getOSSClient().listBuckets();
		}
		return buckets;
	}

	/**
	 * @param bucketName
	 * @param file
	 * @param key
	 */
	public void upload(String bucketName, File file, String key) {
		getOSSClient().putObject(new PutObjectRequest(bucketName, key, file));
	}
	
	/**
	 * @param bucketName
	 * @param key
	 */
	public OSSObject downLoad(String bucketName, String key) {
		// 新建GetObjectRequest
		GetObjectRequest getObjectRequest = new GetObjectRequest(bucketName, key);
		// 下载Object到文件
		OSSObject object = getOSSClient().getObject(getObjectRequest);

		return object;
	}

	/**
	 * @param bucketName
	 * @param inputStream
	 * @param key
	 */
	public void upload(String bucketName, InputStream inputStream, String key) {
		getOSSClient().putObject(bucketName, key, inputStream);
	}

	/**
	 * @param bucketName
	 * @param key
	 */
	public void delete(String bucketName, String key) {
		getOSSClient().deleteObject(bucketName, key);
	}

	/**
	 * 获得url链接
	 *
	 * @param key
	 * @return
	 */
	public String generateUrl(String bucketName,String key) {
		// 设置URL过期时间为10年 3600l* 1000*24*365*10
		Date expiration = new Date(new Date().getTime() + 3600l * 1000 * 24 * 365 * 10);
		// 生成URL
		URL url = getOSSClient().generatePresignedUrl(bucketName, key, expiration);
		if (url != null) {
			return url.toString();
		}
		return null;
	}
	/**
	 * 获得url链接
	 *
	 * @param key
	 * @return
	 */
	public String getUrl(String bucket,String key) {
		
		return "http://"+bucket+"."+endpoint+"/"+key;
	}
	
	public static void main(String[] args) throws IOException {
//		AliyunOssService as=new AliyunOssService();
		/*String urlString = "http://sports.dzwww.com/basketball/nba/201602/W020160227118264829508.jpg";
		URL url;
		InputStream input = null;
		url = new URL(urlString);
		URLConnection con = url.openConnection();
		String key =UUID.randomUUID().toString();
		as.upload(bucketName, con.getInputStream(), key);
		
		String urlStr=as.getUrl(bucketName,key);
		System.out.println(urlStr);*/
//		http://flame-img.oss-cn-shenzhen.aliyuncs.com/508095da-a58a-4d57-8c39-140edd7e59f4?Expires=1806933982&OSSAccessKeyId=LTAIm4Un8O7ikDOE&Signature=2P2jDE4qa35VMNtXGqpNh5gFlJQ%3D


//		String urlStr1=as.getObjectUrl(AliyunOssService.bucketName,key);
//		System.out.println(urlStr1);
//		as.delete(bucketName, "508095da-a58a-4d57-8c39-140edd7e59f4");
//		OSSObject object=as.downLoad("flame-img", "89e37652-4995-46a7-83a0-f8259780554c");
//		System.out.println(object);
//		as.createBucket("flame-file");
//		as.createBucket("flame-file");
	}

}
