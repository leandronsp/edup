// in addUploadFeature.js
/**
 * Convert a `File` object returned by the upload input into a base 64 string.
 * That's not the most optimized way to store images in production, but it's
 * enough to illustrate the idea of data provider decoration.
 */
const convertFileToBase64 = file => new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.readAsDataURL(file.rawFile);

    reader.onload = () => resolve(reader.result);
    reader.onerror = reject;
});

/**
 * For lessons update only, convert uploaded image in base 64 and attach it to
 * the `upload` sent property, with `src` and `title` attributes.
 */
const addUploadFeature = requestHandler => (type, resource, params) => {
    if (type === 'UPDATE' && resource === 'lessons') {
        if (params.data.upload && params.data.upload.rawFile instanceof File) {
            // only freshly dropped uploads are instance of File

            return Promise.resolve(convertFileToBase64(params.data.upload))
                .then(base64Upload => ({
                    src: base64Upload,
                    title: `${params.data.upload.title}`,
                }))
                .then(transformedNewUpload => requestHandler(type, resource, {
                    ...params,
                    data: {
                        ...params.data,
                        upload: transformedNewUpload,
                    },
                }));
        }
    }
    // for other request types and reources, fall back to the defautl request handler
    return requestHandler(type, resource, params);
};

export default addUploadFeature;
