$(function() {
    window.fileManager = $('#fileManager').fileManager({
        //配置服务
        Service: [{
            // 本地服务
            serviceName: '阿里云OSS共享文件',
            server: '',

            listBuckets: {
                method: 'GET',
                endpoint: '/shareFile/public/buckets'
            },

            listFolders: {
                method: 'GET',
                endpoint: '/shareFile/public/folders'
            },

            listObjects: {
                method: 'GET',
                endpoint: '/shareFile/public/objects'
            },

            createFolder: {
                method: 'POST',
                endpoint: '/shareFile/public/createFolder'
                // post newFolderName
            },
            shareFolder: {
            	method: 'POST',
            	endpoint: '/shareFile/public/shareFolder'
            		// post newFolderName
            },

            // keys的删除均以队列的形式一一删除，
            deleteObject: {
                method: 'POST',
                endpoint: '/shareFile/public/deleteObject'
                // post deleteObjects;
            },
            reNameObject: {
                method: 'PUT',
                endpoint: '/shareFile/public/object'
            },

            moveObject: {
                method: 'POST',
                endpoint: '/shareFile/public/object'
            },

            createObject: {
                method: 'POST',
                endpoint: '/shareFile/public/upload'
            },
            downloadObject: {
              method: 'GET',
              endpoint: '/shareFile/public/download'
            },
            searchFile: {
            	method: 'POST',
            	endpoint: '/shareFile/public/searchFile'
            }

//        }
//        ,
//        {
//          serviceName: '阿里云OSS',
//          server: 'http://localhost:3001',
//          listBuckets: {
//              method: 'GET',
//              endpoint: '/file/aliyunOss/buckets'
//          },
//          listObjects: {
//              method: 'GET',
//              endpoint: '/file/aliyunOss/objects'
//          },createObject: {
//                method: 'POST',
//                endpoint: '/file/aliyunOss/file'
//            },
        }],

        //
        // Title: 'Great File Manager',
        Title: '',
        debug: true
    });
});
