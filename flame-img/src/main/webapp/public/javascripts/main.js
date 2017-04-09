$(function() {
    window.fileManager = $('#fileManager').fileManager({
        //配置服务
        Service: [{
            // 本地服务
            serviceName: '阿里云OSS',
            server: '',

            listBuckets: {
                method: 'GET',
                endpoint: '/file/public/buckets'
            },

            listFolders: {
                method: 'GET',
                endpoint: '/file/public/folders'
            },

            listObjects: {
                method: 'GET',
                endpoint: '/file/public/objects'
            },

            createFolder: {
                method: 'POST',
                endpoint: '/file/public/createFolder'
                // post newFolderName
            },
            shareFolder: {
            	method: 'POST',
            	endpoint: '/file/public/shareFolder'
            		// post newFolderName
            },

            // keys的删除均以队列的形式一一删除，
            deleteObject: {
                method: 'POST',
                endpoint: '/file/public/deleteObject'
                // post deleteObjects;
            },
            reNameObject: {
                method: 'PUT',
                endpoint: '/file/public/object'
            },

            moveObject: {
                method: 'POST',
                endpoint: '/file/public/object'
            },

            createObject: {
                method: 'POST',
                endpoint: '/file/public/upload'
            },
            downloadObject: {
              method: 'GET',
              endpoint: '/file/public/download'
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
