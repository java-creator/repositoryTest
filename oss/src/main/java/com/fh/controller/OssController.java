package com.fh.controller;

import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;

import java.io.File;

public class OssController {
    public static final String endpoint = "oss-cn-beijing.aliyuncs.com";
    public static final String accessKeyId = "LTAI4Feu8mZ3UZNXsH2JnRu9";
    public static final String accessKeySecret = "TNaDBavtpOZhsDL5bZHXmieeymGNeq";
    public static final String bucketName = "liulintao";

    public static OSS ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);

    public static void main(String[] args) {
        ossClient.putObject(bucketName, "llt.jpg", new File("a.jpg"));
        ossClient.shutdown();
        System.out.println("上传图片完成！");
    }

}
