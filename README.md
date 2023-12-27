# DOCKER
```
docker build --build-arg UID_GID="35002:35002" --build-arg TIKA_VERSION="2.9.1" -t apache/tika:2.9.1-full .
```
```
docker run -p 9998:9998 apache/tika:2.9.1-full
```
# JS
```js
const tikaServerUrl = "http://localhost:9998/tika";
async function toTika(filePath) {
  const fileData = await fs.promises.readFile(filePath);
  const response = await axios.put(tikaServerUrl, fileData, {
    headers: {
      "Content-Type": "application/octet-stream",
      Accept: "text/plain",
    },
  });

  return response;
}

toTika('./tika.png')
```
